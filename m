Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91CC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E273761165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhDIWhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:37:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52424 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhDIWhk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:37:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3645EAF037;
        Fri,  9 Apr 2021 18:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AW0vKekYiZj/b9iYYfM7pwydG58=; b=k7QcNf
        01ZeOq0dZJGOW5Tbjp0o/FSgE9OMPPAnf4TfFDBzxH0nRBEJg5PID4m9U8WyOY9S
        ooieRbGx9KYiQaxh6QMhtfqV4Ge9XRXuN2MYPCjqe+Zh2o8lPlF2iwL9ip11wAjt
        z9MDU859zOJsaG3qK6eme3cbnHKVCAYoEdR0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A/vpBoIsAkDx3fn5PqE2nKqn4s0R5eA/
        WNRRcOzHb1WxOSU//jgfQM5THymHlZBR2yvl2pwyYvRvmGqG+MWc8+6ftKfLiQ4H
        R9mBh0j2qMl2yE1Ze1RwZ2VmhIbtOUPKuFOmqCvR5Vg7idb14W6wZYS1ALEHzenm
        FEwIgYTF26A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A8B1AF035;
        Fri,  9 Apr 2021 18:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A70FBAF033;
        Fri,  9 Apr 2021 18:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
        <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
        <87im5gp2ze.fsf@evledraar.gmail.com>
        <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
        <87czvoowg2.fsf@evledraar.gmail.com>
        <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
        <87czv3gs3q.fsf@evledraar.gmail.com>
        <YHC1CZoOBJFwQIx8@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 15:37:25 -0700
In-Reply-To: <YHC1CZoOBJFwQIx8@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 16:11:53 -0400")
Message-ID: <xmqq5z0vm6e2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28605170-9984-11EB-B4BE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> That plan involves an "git rm -r compat/regex" and a compat/pcre
>> instead, I have some long-left-over patches for that.
>
> OK. I was more worried about platforms where it was cumbersome to
> install pcre. If we are shipping it as a vendored library, then at least
> the dependency management is on us, and not the user. I do worry a
> little about running into complications with building or debugging it.

Please don't.  I prefer not shipping compat/pcre ourselves; having
to worry about version skew and picking up upstream security fixes
in time, etc. for an external library that is well maintained is not
what we need.


