Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FEC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3246D233A2
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLSLPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:15:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60357 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLSLPK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 06:15:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8F25113F87;
        Sat, 19 Dec 2020 06:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5FnuOOeDrx1yYR74ryFFcuzQYaU=; b=GmAO7CBDvtxjI5+t5lVs
        WrnLGGuOJBKEtOE+unnR1jAtOQoTYpa75cB+PpAd4WejDG5cZMkCtlxax/cS1h+G
        nq7avzkGKZoANjC/HR0UHx/qvwuz8IA/WmpQp+D55/K6rbhKBOBqaVc/bfBLXcBp
        wJLQIgfnAEtU6u5nV4ZRW70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=sznIMRRPWKLyX5A3xSf2GT+KW+cEIxFGEV204q1DCoVCa9
        r6xoj9YesTmFmBYbb+rdSQ8wgNEK23dzPMADXIqXXguosbw+aAv1r+rl3EKZsX4X
        BciYPLs0yTjgw2tc1Fw/w8AKjwR51nF87RROVGIbyORKcQ2VjK3F5HsetTOyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 951F5113F86;
        Sat, 19 Dec 2020 06:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAD6B113F85;
        Sat, 19 Dec 2020 06:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
        <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
        <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
        <20201217175037.GA80608@ellen>
        <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
        <20201218023534.GA117762@ellen>
        <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
Date:   Sat, 19 Dec 2020 03:14:23 -0800
Message-ID: <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A9F50A0-41EB-11EB-B9EB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> I think where we're not seeing eye-to-eye is that you're focusing on
> potential "negative" consequences whereas I'm talking about having more
> information about the merge rather than less.
>
> There is very likely no negative consequences for most, if not all,
> mergetools. I wrote the initial version of diffconflicts ten years ago
> and I've been using it nearly every day since. I'm fairly confident in
> the end result. What is a fact is there is undisputedly less information
> about the merge if we overwrite LOCAL and REMOTE; as I've written,
> I think the tradeoff is worthwhile for most tools but a per-tool
> configuration will allow people that feel differently to choose
> differently.

Thanks for stressing this point.

When a user or developer asks for a reasonable feature (e.g.
configurability to suit personal taste), especially when there is no
obvious downside for adding it, the burden of proof is on the party
who refuses to add it---they are the ones who have to adequately
explain why adding it is actively harmful, not just the proposed
addition is not necessary [*1*].

There is no need for any "evidence" of "negative consequence" at all
to ask for a way to selectively enable or disable a new feature.  A
new feature tends to trigger unexpected bugs in unseen corner cases
more than an older feature, even without any concrete numbers, and
that is good enough reason to insist an escape hatch that is easy to
access by users to exist.

This is especially true for a software with wide userbase, most of
which do not run the bleeding edge version.  That is how we get
users unstuck after releasing our software with a new feature with
unforeseen consequences, before we can deliver fixed version in
their hands.

> This is where I will part this particular debate. If you are not arguing
> for the sake of arguing and if you are genuinely willing to have your
> mind changed then I invite you to reread my blog post, rewatch my
> YouTube video, and reread parts this thread -- watch out for where
> I talk about why LOCAL and REMOTE (and BASE) are useful.

Thanks for your contribution so far.


[Footnote]

*1* They are, however, not obligated to add the feature themselves.
They can just honestly say "I did not understand the help offered to
make use of it", or "I am too busy, so I am not doing it", or give
any other reason or excuse for not doing so.  And the rest of us can
take it from there by building on top.
