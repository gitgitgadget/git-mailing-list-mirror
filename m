Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62407C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B9622261
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YkZigmO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbgJIUdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:33:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57024 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJIUdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 16:33:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9524100AD3;
        Fri,  9 Oct 2020 16:33:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EJu+JnBcyzXr+jiNLcacnVe1uWk=; b=YkZigm
        O14a669yRgkBDyGSgnZ58Ua6qguEOryhDOHXV8/T3Pqsa5iZsjG1E+Yu/NQ9kRlA
        6BWdb9wrMDXtdtCiAmhgYIk6HrVT3EpoOk9a17bHaP+XnSndar+G0xMYsHAyRlRM
        cfwYZePEqVqtBPAdqeBLizQsumoFvoOKI59zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uisJMSx/add0nxvu3+We9C2xFJWPaDif
        asFSR9g3YH+Dyj57HfoOTUzTa90vyEnaefUyhTLNkV/N1CMHxDxLRCHIHTwEHclT
        +IlQZJ6AEKO3fbe5sA5wUWutRnU1erx0ORBnLAPZJeXaw4N3sLmJuj4bgK3HREFd
        ODUzUCgULBE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2193100AD2;
        Fri,  9 Oct 2020 16:33:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 242C8100AD1;
        Fri,  9 Oct 2020 16:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
        <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
        <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
        <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
        <20201009195701.GA967869@coredump.intra.peff.net>
Date:   Fri, 09 Oct 2020 13:33:39 -0700
In-Reply-To: <20201009195701.GA967869@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 9 Oct 2020 15:57:01 -0400")
Message-ID: <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7D23832-0A6E-11EB-8508-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The argument for including it is less clear to me. You say below:
>
>> [...]By doing so, we would also prevent a
>> mistake of not writing "extern" when we need to (i.e. decls of data
>> items, that are not functions) when less experienced developers try
>> to mimic how the existing surrounding declarations are written.
>
> but to my recollection that has not been a big problem. And it's one
> that's usually easily caught by the compiler. A missing "extern" on a
> variable will usually get you a multiple-definition warning at
> link-time (if you manage to also omit the actual definition you won't
> see that, though "make sparse" will warn that your variable ought to be
> static).

Not really, that is where the "common" extension comes in, to help
us with it hurt others without it, unknowingly X-<.

        $ cat >a.c <<\EOF
        #include <stdio.h>
        #include "c.h"

        int common = 47;

        int main(int ac, char **av)
        {
            printf("%d\n", common + other);
            return 0;
        }
        EOF
        $ cat >b.c <<\EOF
        #include "c.h"

        int other = 22;
        EOF
        $ cat >c.h <<\EOF
        int common;
        int other;
        EOF
        $ gcc -Wall -o c a.c b.c; ./c
        59

And I have a strong preference, after thinking about it, to have
"extern" in front in the declarations.  It gives another clue for
patterns I feed to "git grep" to latch onto, and help my eyes to
scan and tell decls and defns apart in the output.  The benefit
alone is worth the extra 7 columns in front spent, which you call
"clutter".

> IMHO the real problem here is that C's syntax for returning a function
> pointer is so horrendous. How about this (on top of your earlier patch
> to drop the extern from that declaration)?

In general, I like a typedef for callback function that shortens the
decl of a function that takes such a callback, so I think

> +void set_error_routine(report_fn routine);
> +void set_warn_routine(report_fn routine);
> +report_fn get_error_routine(void);
> +report_fn get_warn_routine(void);

these are good, but they are better with "extern" in front in a
header file to make it clear they are declarations and not
definitions when they appear in "git grep" output.
