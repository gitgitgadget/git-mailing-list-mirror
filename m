Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA6C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 23:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCOX2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCOX2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 19:28:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C44265B4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:28:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so22159777ybw.13
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678922917;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tS8hVXXxfri+PV/jzhkYkPOPl7bV6ATKg6GGdB7VYbE=;
        b=TxXPgZzB2YHmEc4n8Nm2dkjgLomIBveOVUXhA/7b8cSnM00OFC4TUmGKanGbcO4/9M
         Qwv8kS/v8/QPVo6DYL6kxLx8mlu3T4LFF9ksUgmfMaQT1TD9hdhU4WW/uZacgTNMBm2T
         aXNRsZaUBgy/zgaVaBsCg1ingWd7P6yvGsknJcw79sYufPKgSzOIsLxaZnAmNq8m7dig
         mgu8c6Dh4YXC2iZ20A+1t3UdiqoaXhYGwUntZpAuZDZFL49kEtQrXm0zpecZ+uQQX4yZ
         Ztm1pPw3AOT+hVQpNZrSnVfG/Nb4j59RvYZUZ1E34Kop6glIK4vaO4WyWvTK7XykbX/H
         d3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678922917;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS8hVXXxfri+PV/jzhkYkPOPl7bV6ATKg6GGdB7VYbE=;
        b=V5tMMhf+2EQsVvq8tgCKo++Ek8LSmIqgcXkKoAcMcLy2jHF3N6dmXMB9c/cBFzYdvV
         k8mlAnPEO7cbaRzpVThg1ZEDPrpByaTbUfwrybei1ayiGK+ozLDCA3TWi91l/6EMgVgU
         AXV+S107RaXYg+38Uwe34VbXUKnbiZo2E/N91P/IIx/UKXNdeFObwlBKd7gIB14r1cgb
         bzAEbohEqCtbBX8nLIjvNVyp7gqj6x1i3ATxfcuFeihE/W/xRS/XL9SDbG9ieYBrEvFd
         OAnc+e5+WNGTB35gezr93/6+F9ZngU0rLJowqqLls/mupG3mJqr7PHbyIeH+QFSD43OK
         Y5fw==
X-Gm-Message-State: AO0yUKWGCec3sGLfy90cJbYVh3jIrUAiIIQ9K9ovsbXc7Ps0fFhFij1f
        XkhjN52AG80tNG0f3e/5W9+IJSYOnOVSPDAmt+X9
X-Google-Smtp-Source: AK7set98e2Ab6YbUGK8e/tyAgGOCi4VvW+GcNUkZlkUVq34jxTVK/fQpEzzYzsXWsj1ZvDVlbiu2h7wyK/CL8w6qJjgG
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:524e:ff9a:ee19:127f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:188:b0:a99:de9d:d504 with
 SMTP id t8-20020a056902018800b00a99de9dd504mr26725263ybh.12.1678922917488;
 Wed, 15 Mar 2023 16:28:37 -0700 (PDT)
Date:   Wed, 15 Mar 2023 16:28:35 -0700
In-Reply-To: <0fb3913810b7d4731707a0129df7f5d57c8ab39f.1678902343.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315232835.173584-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 6/8] commit-reach: implement ahead_behind() logic
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thanks to Taylor and Stolee for this algorithm and code
- it is straightforwardly written and looks correct to me. I have some
commit message and code comment suggestions that if taken, would have
helped me on my first reading, but these are subjective so feel free
to ignore them if you think they would add unnecessary detail (I did
understand the algorithm in the end, after all).

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> The second array, using the
> new ahead_behind_count struct, indicates which commits from that initial
> array form the base/tip pair for the ahead/behind count it will store.

I would have preferred: The second array contains base/tip pairs
designating pairs of commits for which ahead/behind counts need to be
computed, each pair being a pair of indexes into the first array.

> Each commit in the input commit list is associated with a bit position
> indicating "the ith commit can reach this commit". Each of these commits
> is associated with a bitmap with its position flipped on and then
> placed in a queue for walking commit history. 

"this commit" is not necessarily a commit in the input commit list (it
is actually the commit that we're currently at in our iteration) and I
think that the association of bitmaps with commits in the input commit
list could be more clearly described. So I would have preferred: Each
commit in the priority queue is associated with a bitmap of width N
(N being the count of commits in the first array), in which a bit is
set iff the commit can be reached by the corresponding commit in the
first array. This is different from packfile or MIDX bitmaps in that
a commit's bitmap stores what can reach it, not what it can reach.
The priority queue is initialized with N commits, each commit being
associated with a bitmap in which a single bit is set (indicating that
the commit can be reached by itself).

> +void ahead_behind(struct repository *r,
> +		  struct commit **commits, size_t commits_nr,
> +		  struct ahead_behind_count *counts, size_t counts_nr)
> +{
> +	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
> +	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;

As we discussed in our Review Club, DIV_ROUND_UP can be used for this.

(For those reading who do not know what Review Club is, search the
archives and/or look out for future announcements!)

> +			if (bitmap_popcount(bitmap_p) == commits_nr)
> +				p->item->object.flags |= STALE;

Might be worth adding a comment above the STALE line: this parent commit
and all its ancestors can be reached by every commit in the commits
list and thus can never be "ahead" or "behind" in any pair; mark this
STALE so that, as an optimization, we can stop iteration if only STALE
commits remain (since further iteration would never change any "ahead"
or "behind" value).

