Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B11C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F521744
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P4qgtG5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAGRNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:13:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59398 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGRNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 12:13:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABBD232429;
        Tue,  7 Jan 2020 12:13:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2kZ/orWuIbXoR+GfIitoPvKmEHI=; b=P4qgtG
        5HVNMTh9by6gKetnhmpbf7LOhcLoUarRuACdwfrBmvSY84pBS7JbSichyITetzv0
        YDxFk2sOgg3D2ghrKQgXaawYeyVsqPVfTASBX9wM66KyhTndij6lksDoUA+gsrwk
        a3BPA17zZVl8OM/YNT0sTz1AJy0/et0vElV6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=foQ3knJ+itXkvt3sRPabZgm+iyJ/pjDT
        VEwwXNm4m+QwK0MvNBJ67RHR17g9p8jJxpmlgjWX3RfODgq1AFSkTdCULUS+6jm8
        8XaMTPgoXTse2g/uXlzvG28jAxY99f42UmOm6qMEVNwhH5ziRTU/dq5yIOUCo8Wr
        bkEtEb8FFFc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A344932428;
        Tue,  7 Jan 2020 12:13:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECCF032426;
        Tue,  7 Jan 2020 12:13:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/3] Fix two bugs in graph.c
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 09:13:05 -0800
In-Reply-To: <pull.517.git.1578408947.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 07 Jan 2020 14:55:44 +0000")
Message-ID: <xmqqk1635gwu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8E25C58-3170-11EA-BA88-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a possible fix for the bug reported in [1].
>
> The first commit fixes the runtime failure due to the assert() statement.
>
> The second commit replaces the assert() statements with a macro that
> triggers a BUG().
>
> The third commit adds another test that shows a more complicated example and
> how the new code in v2.25.0-rc1 has a behavior change that is not
> necessarily wanted.
>
> Thanks, -Stolee

Thanks, all, for so quickly resolving the issue.

Will queue.

>
> [1] 
> https://lore.kernel.org/git/CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com/



>
> Derrick Stolee (3):
>   graph: fix case that hit assert()
>   graph: replace assert() with graph_assert() macro
>   t4215: add bigger graph collapse test
>
>  graph.c                      |  39 +++++++------
>  t/t4215-log-skewed-merges.sh | 105 +++++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+), 18 deletions(-)
>
>
> base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-517%2Fderrickstolee%2Fgraph-assert-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-517/derrickstolee/graph-assert-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/517
