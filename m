Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C87C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A5C206CD
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FgaAQTh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgECQqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 12:46:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51312 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgECQqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 12:46:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 815E6403BA;
        Sun,  3 May 2020 12:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9vV3a43h80oh0FP46QSJL8b1ShY=; b=FgaAQT
        h2uZ3XzGKcyG0SoUuHaBbPXluuWHZ/dyQJD/9NnOU5L9mCmqkQ0o+cH67kIglTOM
        7ytQshPSsqezo0JSI1IcCXYnRx6/U6mXzbOmuibe297jOytRUjoner+qpwCay2yA
        Sr1JtTPHZ5CI7trDN6QM78tC+AQAnFN4qIMbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x6nwGqzAcCHg0vj4iYTktpH5QMjiiwLR
        RcdquHWPMA7RQK5Je4VsbATwU5EzzF6ZFBrB0BL2/RYDonDfSoeN4nffn12b46w0
        fbNAemife9EwuUrEDkWNcmJlupaHB1OBXyuIPZFUmoKvNbM9/DzlIMxSUTTbiw0K
        FPoTCJvW8cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78E0C403B9;
        Sun,  3 May 2020 12:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB2B3403AE;
        Sun,  3 May 2020 12:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: respect the [skip ci] convention in our GitHub workflow "CI/PR"
References: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
        <20200503093646.GC170902@coredump.intra.peff.net>
Date:   Sun, 03 May 2020 09:46:15 -0700
In-Reply-To: <20200503093646.GC170902@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 3 May 2020 05:36:46 -0400")
Message-ID: <xmqqa72pj7ag.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AFA8680-8D5D-11EA-A206-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure whether we want to be building all of the individual topics
> in gitster/git or not. In theory that provides more information, but I'm
> not sure if anybody is looking at them (and all of the notifications
> would go to Junio anyway).

I do not think I am letting GitHub notifications for gitster/* come
to my mailbox, so it is quite possible that many have piled up there
without anybody (not even me) seeing them.

I won't be locally able to notice breakages introduced by an
individual topic to an environment I do not have access to, and
building these topics with GitHub Actions may reveal which ones
break, say, vsbuild, but I won't be debugging and fixing such issues
myself anyway, so at least to me it is useless to run build there.

I think I agree with your outline, i.e. build pull requests to help
contributors, and build public integration branches to help the
project as a whole.

Thanks.
