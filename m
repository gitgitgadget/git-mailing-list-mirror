Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0CC433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbiBCUrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356614AbiBCUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CF5C0619C5
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 12:44:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v13so7313175wrv.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=heX4qALiT45t3JbfS1UYxcFgfkLMaYzqA1vXLiDAO0A=;
        b=KPdymaaPnrFTQonX3T3KhXFCI/xm1S2YVjH8YKnZrE0swgmettfMUgiutOhTU9vTrD
         sMTqvTU5aNZJscvMNimqW+3i6GgEVbDKa950fTHAC32EJvq+UjqLs4KBD8CQCJ9KiAyd
         J27y6MjnUgjA64acI1ha3xi2S2yUVyPTaLsq2Sd1JsWmQtOyX9Q+Oh9nmDc0mXn+sD1e
         t2j/RqVQutU4Q3GjU39aorX3lfHdxKZuZLSPL9eBSSFdZB66si7XpayuSDN4bgaLrDTy
         FZIFHnN50FSltVyTUszA5CEJEjQrUkQgHByk2Uoojdj0lwum2Du9dxHyYYL354wo79ND
         IKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=heX4qALiT45t3JbfS1UYxcFgfkLMaYzqA1vXLiDAO0A=;
        b=zmgkjBqWpdKJocrxupWAjrXo4vpOtJ7kp6BaJPbql8MUETzqPDkNdDvO6FVKPvjM9L
         jVU+kY8Ztqc57MTl7Kjs7K9vVCxHVZfVF3za8DuaUyOW1FfcS/OhFMALNahoeOTl9GlG
         c85Kda0tWDD3mOieC945V3BFyRYdl4U7VwR+KLpf4gFKfwCmPKgbzyK0Kp4D9liYBhlZ
         T9OjNKREeGPFAmIC/nepIQAw65JwAHR9I4K+GguSyic/leFKpXyXmzlWP0VV9eapjm5R
         Slrjt5ASBbmO7pdJDxHwBGnYE/lSXBKU5rLYZk2H1ONtXOIWJioNFihglansbz6mTOBA
         4oVw==
X-Gm-Message-State: AOAM530lKFV5zerlgI1lZZljHedlH9ENL1h+x49Dl/0rH/P3egH33QTB
        zud6HCtUYWKtPnadceEjfK+t5HfTUHY=
X-Google-Smtp-Source: ABdhPJwa/wmU7UCu96HMzwSHsIScXApjx6LWmo/3zLK2dB98kGAe9+VOaidpabdl9QdyFHeITUjmCw==
X-Received: by 2002:adf:f144:: with SMTP id y4mr21020478wro.310.1643921094029;
        Thu, 03 Feb 2022 12:44:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm17290930wrg.60.2022.02.03.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:44:53 -0800 (PST)
Message-Id: <5b8d53402ae68e5d66898b3517f3a950e6117765.1643921091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 20:44:50 +0000
Subject: [PATCH v5 2/3] completion: improve sparse-checkout cone mode
 directory completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Use new __gitcomp_directories method to complete directory names in cone
mode sparse-checkouts. This method addresses the caveat of poor
performance in monorepos from the previous commit (by completing only one
level of directories).

The unusual character caveat from the previous commit will be fixed by the
final commit in this series.

Co-authored-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 32 +++++++++++++++++++++-
 t/t9902-completion.sh                  | 38 +++++++++++++++-----------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2976f63747f..c5c8df6b6e5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,6 +2986,36 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+__gitcomp_directories ()
+{
+     local _tmp_dir _tmp_completions
+
+     # Get the directory of the current token; this differs from dirname
+     # in that it keeps up to the final trailing slash.  If no slash found
+     # that's fine too.
+     [[ "$cur" =~ .*/ ]]
+     _tmp_dir=$BASH_REMATCH
+
+     # Find possible directory completions, adding trailing '/' characters
+     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
+         sed -e s%$%/%)"
+
+     if [[ -n "$_tmp_completions" ]]; then
+         # There were some directory completions, so find ones that
+         # start with "$cur", the current token, and put those in COMPREPLY
+         local i=0 c IFS=$' \t\n'
+         for c in $_tmp_completions; do
+             if [[ $c == "$cur"* ]]; then
+                 COMPREPLY+=("$c")
+             fi
+         done
+     elif [[ "$cur" =~ /$ ]]; then
+         # No possible further completions any deeper, so assume we're at
+         # a leaf directory and just consider it complete
+         __gitcomp_direct_append "$cur "
+     fi
+}
+
 _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
@@ -3002,7 +3032,7 @@ _git_sparse_checkout ()
 	set,*|add,*)
 		if [ $(__git config core.sparseCheckoutCone) ] ||
 		[ "$(__git_find_on_cmdline --cone)" ]; then
-			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			__gitcomp_directories
 		fi
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f6eeb9aa035..b38a7302249 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1480,21 +1480,30 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set f" <<-\EOF
-		folder1 Z
-		folder1/0 Z
-		folder1/0/1 Z
-		folder2 Z
-		folder2/0 Z
-		folder3 Z
+		folder1/
+		folder2/
+		folder3/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/" <<-\EOF
+		folder1/0/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
+		folder1/0/1/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout/folder1 &&
-		test_completion "git sparse-checkout add " <<-\EOF
-		./ Z
-		0 Z
-		0/1 Z
+		test_completion "git sparse-checkout add 0" <<-\EOF
+		0/
 		EOF
 	)
 '
@@ -1520,12 +1529,9 @@ test_expect_success 'git sparse-checkout set --cone completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set --cone f" <<-\EOF
-		folder1 Z
-		folder1/0 Z
-		folder1/0/1 Z
-		folder2 Z
-		folder2/0 Z
-		folder3 Z
+		folder1/
+		folder2/
+		folder3/
 		EOF
 	)
 '
-- 
gitgitgadget

