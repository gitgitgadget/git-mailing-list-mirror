Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABACC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923CC60725
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhGWPRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:17:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhGWPRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:17:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26389154B20;
        Fri, 23 Jul 2021 11:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4rXE4n6GNxn7BbqV/hWwu80atDoMTVyVkELVur
        nP9x0=; b=bPo3Y6TTWNikxHv5zNcsb7QSTRH09A6Wlk+LdbuZHba+YV+EIoBK5u
        ajNVB8jBbPWGmPbQ43MI/kfOCr+7oFK2//r3zNuTOfnbNH8N2Kwtkbs1z49ULw5G
        CiuPVJKl/L1dnrSd+QYcM+tqnoxZTHABgvSkSSYvyGzIM4TDIbViM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E500154B1F;
        Fri, 23 Jul 2021 11:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62F37154B1E;
        Fri, 23 Jul 2021 11:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
        <xmqqy29z9r94.fsf@gitster.g> <xmqqtukn9p0g.fsf@gitster.g>
        <60f8c8c92a215_1d0abb20859@natae.notmuch>
        <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
Date:   Fri, 23 Jul 2021 08:58:02 -0700
In-Reply-To: <YPpwIazVxL4GoLbC@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Jul 2021 03:30:41 -0400")
Message-ID: <xmqqwnphowdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3B65696-EBCE-11EB-9F2E-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I feel compelled to say now that I do not think that changing the
> order of parents for "git pull" is the obviously correct thing to do.
> And likewise, in the one thread I do remember participating in, I
> expressed something similar:
>
>   https://lore.kernel.org/git/20140502214817.GA10801@sigill.intra.peff.net/

Thanks for the link.  Many articles in the thread are repeating the
same opinion over and over (and later even descend into ad-hominem
attacks) and it is not worth anybody's time to read all of them, but
I found that there still were some gems.

In an worldview where the first-parent chain is the trunk history,
merging in the upstream where you push back to into your working
repository where your new work is happening as the second parent
before pushing it back would obviously make the history that used to
be trunk to lose the first-parent-ness at that point.  And if you
ask if I just said is correct, everybody would say it is.  So there
is a concensus that the result of "git pull upstream main" becomes
a wrong shape for people in one workflow.

But that does not necessarily mean swapping the parent order would
produce the history of a right shape, either, even for those with
the "first-parent chain is the trunk" worldview.
