Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383FC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 21:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiBXVnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXVnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 16:43:13 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9A1B45C3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 13:42:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D6B11837DD;
        Thu, 24 Feb 2022 16:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fMcLZHGQyLi5HAndn9judg/nRuE9VQO88BpZLn
        9FyPM=; b=aK+S2DfaSRupAtyY6yWySKk8+aRLJJnHS6BOo6rpe/h+qIKyhRs3Lg
        b8sUmQZVlGOSmcCnUupSzqTPwy70cYU5uNTSR3g4FmzjO2rC/ZqFr5P5QsqhVuGG
        p75Frc/8R1uF9JUxR0HbybSnCvk19KTOxX5ePtl5aOmcMB3xR4rdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25A861837DC;
        Thu, 24 Feb 2022 16:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 977D11837DA;
        Thu, 24 Feb 2022 16:42:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] Commit-graph: Generation Number v2 Fixes, v3
 implementation
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 13:42:39 -0800
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Thu, 24 Feb 2022 20:38:29 +0000")
Message-ID: <xmqqsfs8j60g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0EC2496-95BA-11EC-A8EC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series includes two distinct, but similarly-motivated parts:
>
>  * Patches 1-4 fix some bugs in the commit-graph generation number v2.
>  * Patches 5-7 add a new generation number v3 by incrementing the
>    commit-graph file format.
>
> I had been thinking about generation number v3, which is the same corrected
> commit date as generation number v2, but it is stored in the Commit Data
> chunk, requiring a new commit-graph file format version. This breaks
> compatibility with older versions of Git, so it requires opt-in via the
> commitGraph.generationVersion config value. The only improvement over
> version 2 is that the commit-graph file is smaller, so I/O time is reduced.

Sounds exciting.  Locality of on-disk data does matter.

> However, while exploring this idea I found bugs in generation number v2. In
> particular, Git has been ignoring them since shortly after they were
> introduced. This is due to a bug I introduced when trying to make split
> commit-graphs safer with mixed generation number versions. I also noticed an
> issue with the offset overflows that I only noticed after writing generation
> number v3 using a smaller offset size, actually triggering the bug in the
> test suite.
>
> I'm submitting these two things together so we can see them all at once, but
> I'd be happy to split this into two series. The first four patches are
> important bug fixes, so we can consider them as higher-priority.
>
> Thanks, -Stolee

Thanks, will take a look.

