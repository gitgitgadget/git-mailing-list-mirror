Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BAC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718F22251F
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgLXAdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:33:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50260 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgLXAdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:33:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4C0911A1FE;
        Wed, 23 Dec 2020 19:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3i12qQKl1TfpYjD69UfJ1qIBWs=; b=eEmQfI
        2UnTCGHKmDR9X15ES5DAhjXGapUTEsSkcu8HRB8ZpYg+FjR7j4/losLqryt84ebw
        9YKcI59x8p3dhd5ziVCL6mdYySs66jszpr6tnUKU0e8TEilCl7Iz2TZ1iZsqXYrp
        fmFeqNjOhtMDfpf37FyPQ2bdZGgxbArRBEgTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ti1CVfc11m5AzKh1KWfpCbcqYQtJ7zFJ
        JKEVpPAnw7PGcRqDL3ppjyGU7SJddU7DoYGKof0iqT3eMnWi89GLeW38ip6+x/pY
        a8/+xefdrukazEFKQSg2l9WfzP8zXmOr4uTVg6iiMZExvsNmmiOUgDP4T0Cy8d1Z
        unKhHdI2TQs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD25111A1FD;
        Wed, 23 Dec 2020 19:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 272AE11A1FC;
        Wed, 23 Dec 2020 19:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201223045358.100754-2-felipe.contreras@gmail.com>
        <xmqqblekabof.fsf@gitster.c.googlers.com>
        <5fe352e3968f6_198be2083@natae.notmuch>
        <xmqqblek8e94.fsf@gitster.c.googlers.com>
        <5fe3dd62e12f8_7855a2081f@natae.notmuch>
Date:   Wed, 23 Dec 2020 16:32:35 -0800
In-Reply-To: <5fe3dd62e12f8_7855a2081f@natae.notmuch> (Felipe Contreras's
        message of "Wed, 23 Dec 2020 18:14:26 -0600")
Message-ID: <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85BB7966-457F-11EB-B98C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Ah, I forgot about that one.  I think "the number of conflicts" was
>> a UI mistake (the original that it mimics is "merge" from RCS suite,
>> which uses 1 and 2 for "conflicts" and "trouble") but we know we
>> will get conflicts, so it is wrong to expect success from the
>> command.  Deliberately ignoring the return status is the right thing
>> to do.
>
> I agree. My bet is that nobody is checking the return status of "git
> merge-file" to find out the number of conflicts. Plus, how can you check
> the difference between 255 conflicts and error -1?

Yup, I already mentioned UI mistake so you do not have to repeat it
to consume more bandwidth.  We're in agreement already.

> We could do something like --marker-size=13 to minimize the chances of
> that happening.
>
> In that case I would prefer '/^<\{13\} /' (to avoid too many
> characters). I see those regexes used elsewhere in git, but I don't know
> how portable that is.

If it is used elsewhere with "sed", then that would be OK, but if it
is not with "sed" but with "grep", that's quite a different story.

> So, do we want those three things?
>
>  1. A non-standard marker-size
>  2. Check beforehand the existence of those markers and disable
>     automerge
>  3. Check afterwards the existence of those markers and disable
>     automerge

I do not think 3 is needed if we do 2 and I do not think 1 would
particularly be useful *UNLESS* the code consults with the attribute
system to see what marker size the path uses to avoid crashing with
the non-standard marker-size the path already uses.

So the easiest would be not to do anything for now, with a note
about known limitations in the doc.  The second easiest would be to
do 2. alone.  We could do 1. to be more complete but I tend to think
that it is better to leave it as #leftoverbits.



