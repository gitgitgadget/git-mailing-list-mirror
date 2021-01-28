Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12094C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A0464DCE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhA1FYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:24:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53941 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1FYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:24:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EA311247C0;
        Thu, 28 Jan 2021 00:23:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eV/iUtrxFBT/0ODaEbLBzslcibM=; b=Yduvrq
        gulle9K1o2n8NM+UMQDoKtl2sIUZ+6WUyMgvNxnmLQm2slGCYy8yoER9i3s/X5Jb
        e+gRA9UH0HY5fL6fWOnc1FPRUHz1RNmPqaEnnrREj29zIjgCRf8hVOkEvHK8Sdk9
        V4vM+1rfZ1ejGM39myiTukrt5bJPtsr83imWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G/hcxlz5ZgucOm5A+QOnIBba/X4YK8Gq
        W1GR6o/vE0pj+jQdXNNxNdaY2PnpFdUgoVKbtdXWYAt6usLuGS6IX7WNe/tJ5yLj
        z8PWRMkqHPGZPAabWr1/kkcKoP3ECPSyol4VYSPe3Vctl44oyBbRFW7ow64uc4Y0
        7cEydKgLPp4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 828A11247BF;
        Thu, 28 Jan 2021 00:23:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE7E31247BE;
        Thu, 28 Jan 2021 00:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
        <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
        <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
        <YBHnV80bBQOxZH1O@coredump.intra.peff.net>
Date:   Wed, 27 Jan 2021 21:23:10 -0800
In-Reply-To: <YBHnV80bBQOxZH1O@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 27 Jan 2021 17:21:11 -0500")
Message-ID: <xmqqr1m5y6rl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA96F576-6128-11EB-B840-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The downside, of course, is that a failure that will happen on every
> platform will mean wasted CPU to trigger the same failure over and over.
> But:
>
>   - I rarely see that myself, because I wouldn't bother pushing up to CI
>     until "make test" passed locally. So usually I'm finding portability
>     issues via CI. Other people might be different, though.

This is the same for me.

>   - we already have the Windows tests in a separate matrix anyway, so a
>     failure on Linux would run the whole Windows suite (which is an
>     order of magnitude more expensive)

But they tend to finish earlier than OSX and Ubuntu jobs; their
sharding of the tests into 10 jobs may probably have something to do
with this. 

>   - even within the Windows matrix, I think running the rest of the
>     tests after a failure is still valuable. If there's a second
>     failure, you save a round-trip to CI (so it doesn't reduce CPU, but
>     it may help latency to reach a passing state).

