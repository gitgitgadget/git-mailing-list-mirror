Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC1FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiFMSkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343595AbiFMSjz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 14:39:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1250B4EF78
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:00:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id fu17so4061769qtb.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KrMpKvDQtuaeEWDoBtYEom4UAj5jNioDlT49pbVzUFI=;
        b=fvJrwU4fOh20SwZBt277/ZQlglYQkfaCwFI6tFCBIxq2iW0LVGXMnXvY9H96bC6Fj6
         TctW6c92UaFTJ/BriUFx+0S3mBJJGMPv0OdZcSt3PgiXThzgvLjnmTDRd3D1SvPTL/cx
         x8XztrYwZ1X4ZXVumm1qvx4FlsxWO69yZ7V7/pD3ypeZaNysXBJr92sIHCGz7jXL66Tt
         0+okCPPJk4AUhDn2Lz6lb1ab+J+2pH6zZj55tezK3w39+lR8rWfC7aXhXBqqCqal3SU1
         0vCeeeWVWZI7tisDSHZ290A0dpfUBu81w/x+JXWnAILhCPtHUiUJPYVKkcrVZQusTvow
         t3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KrMpKvDQtuaeEWDoBtYEom4UAj5jNioDlT49pbVzUFI=;
        b=U9d/4V+lMWwy0G0ByKrqCl2vWqadkJQWB3RC9JTPr+gidpmdYixmsB8IjXt8/qztjs
         jYx6/cYzmfPOVfpYqVAhyBVbe0XY3ff6CpmZXUsR4oK3Qo81Tmxil66xqK92OKOwdHyb
         z1/krrjeBE3lWzBJa6MEUtNcWK9C/i09p8RFolzvvdf4isWQ8TfXu6Uw7Pr1CQsVJQL6
         XF/0dF2rD/KZwShmfM5+/SleEnCcZ53aWSVZJUQiGwevERVY6YRbjNSRc7++UkTKUOCn
         RUZt1Kjg2DAEKyHvV+BuTPY0Oj9/psAwwdLb5LROUxgW/2DwbNcc+saOGrD8xiriZc61
         YBBA==
X-Gm-Message-State: AOAM533f0r3TWK3kj9X5dsSb5bnPJSGGbXR/lTgzRokwORlhTEKikdxd
        IIYnVATDDSerLbL2/l7eX9ot
X-Google-Smtp-Source: ABdhPJyLtZk/twNdUaxrZRJFomMTBxgiIh4U/Nexo8Ht4UW1dDPHbkm9lmIMZGh1scWdDF0I2k6nYg==
X-Received: by 2002:a05:622a:1794:b0:304:cb20:5195 with SMTP id s20-20020a05622a179400b00304cb205195mr97753qtk.266.1655132399169;
        Mon, 13 Jun 2022 07:59:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:170:45d1:1083:f688? ([2600:1700:e72:80a0:170:45d1:1083:f688])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b003050bd1f7c9sm5272754qta.76.2022.06.13.07.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 07:59:58 -0700 (PDT)
Message-ID: <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
Date:   Mon, 13 Jun 2022 10:59:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 5/5] branch: fix branch_checked_out() leaks
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 4:08 PM, Derrick Stolee via GitGitGadget wrote:
> This is a replacement for some patches from v2 of my 'git rebase
> --update-refs' topic [1]. After some feedback from Philip, I've decided to
> pull that topic while I rework how I track the refs to rewrite [2]. This
> series moves forward with the branch_checked_out() helper that was a bit
> more complicated than expected at first glance. This series is a culmination
> of the discussion started by Junio at [3].
> 

Junio pointed out that patch 1 introduced a memory leak when a ref
is checked out in multiple places. Here is a patch to fix that
scenario. It applies cleanly on top of patch 4, so I include it as
a new "patch 5". I will include it in any v2 of the full series, if
needed.

Thanks,
-Stolee

---- >8 ----

From c3842b36ebb4053ac49b0306154b840431f9bf6f Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Mon, 13 Jun 2022 10:33:20 -0400
Subject: [PATCH 5/5] branch: fix branch_checked_out() leaks

The branch_checked_out() method populates a strmap linking a refname to
a worktree that has that branch checked out. While unlikely, it is
possible that a bug or filesystem manipulation could create a scenario
where the same ref is checked out in multiple places. Further, there are
some states in an interactive rebase where HEAD and REBASE_HEAD point to
the same ref, leading to multiple insertions into the strmap. In either
case, the strmap_put() method returns the old value which is leaked.

Update branch_checked_out() to consume that pointer and free it.

Add a test in t2407 that checks this erroneous case. The test "checks
itself" by first confirming that the filesystem manipulations it makes
trigger the branch_checked_out() logic, and then sets up similar
manipulations to make it look like there are multiple worktrees pointing
to the same ref.

While TEST_PASSES_SANITIZE_LEAK would be helpful to demonstrate the
leakage and prevent it in the future, t2407 uses helpers such as 'git
clone' that cause the test to fail under that mode.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 25 +++++++++++++++----------
 t/t2407-worktree-heads.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/branch.c b/branch.c
index c0fe6ea0b65..390c092a18f 100644
--- a/branch.c
+++ b/branch.c
@@ -385,25 +385,29 @@ static void prepare_checked_out_branches(void)
 	worktrees = get_worktrees();
 
 	while (worktrees[i]) {
+		char *old;
 		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
 
 		if (wt->is_bare)
 			continue;
 
-		if (wt->head_ref)
-			strmap_put(&current_checked_out_branches,
-				   wt->head_ref,
-				   xstrdup(wt->path));
+		if (wt->head_ref) {
+			old = strmap_put(&current_checked_out_branches,
+					 wt->head_ref,
+					 xstrdup(wt->path));
+			free(old);
+		}
 
 		if (wt_status_check_rebase(wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			strmap_put(&current_checked_out_branches,
-				   ref.buf,
-				   xstrdup(wt->path));
+			old = strmap_put(&current_checked_out_branches,
+					 ref.buf,
+					 xstrdup(wt->path));
+			free(old);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
@@ -412,9 +416,10 @@ static void prepare_checked_out_branches(void)
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			strmap_put(&current_checked_out_branches,
-				   ref.buf,
-				   xstrdup(wt->path));
+			old = strmap_put(&current_checked_out_branches,
+					 ref.buf,
+					 xstrdup(wt->path));
+			free(old);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 6dcc0d39a2d..0760595337b 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -78,4 +78,43 @@ test_expect_success 'refuse to overwrite: worktree in rebase' '
 	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
 '
 
+test_expect_success 'refuse to overwrite when in error states' '
+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+
+	git branch -f fake1 &&
+	mkdir -p .git/worktrees/wt-3/rebase-merge &&
+	touch .git/worktrees/wt-3/rebase-merge/interactive &&
+	echo refs/heads/fake1 >.git/worktrees/wt-3/rebase-merge/head-name &&
+	echo refs/heads/fake2 >.git/worktrees/wt-3/rebase-merge/onto &&
+
+	git branch -f fake2 &&
+	touch .git/worktrees/wt-4/BISECT_LOG &&
+	echo refs/heads/fake2 >.git/worktrees/wt-4/BISECT_START &&
+
+	# First, ensure we prevent writing when only one reason to fail.
+	for i in 1 2
+	do
+		test_must_fail git branch -f fake$i HEAD 2>err &&
+		grep "cannot force update the branch '\''fake$i'\'' checked out at" err ||
+			return 1
+	done &&
+
+	# Second, set up duplicate values.
+	mkdir -p .git/worktrees/wt-4/rebase-merge &&
+	touch .git/worktrees/wt-4/rebase-merge/interactive &&
+	echo refs/heads/fake2 >.git/worktrees/wt-4/rebase-merge/head-name &&
+	echo refs/heads/fake1 >.git/worktrees/wt-4/rebase-merge/onto &&
+
+	touch .git/worktrees/wt-1/BISECT_LOG &&
+	echo refs/heads/fake1 >.git/worktrees/wt-1/BISECT_START &&
+
+	for i in 1 2
+	do
+		test_must_fail git branch -f fake$i HEAD 2>err &&
+		grep "cannot force update the branch '\''fake$i'\'' checked out at" err ||
+			return 1
+	done
+'
+
 test_done
-- 
2.36.1.220.g1fae7daf425


