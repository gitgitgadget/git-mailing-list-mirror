Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C86C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiBQGzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:55:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiBQGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:55:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD127F295
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:52 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c192so2523010wma.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=34QtwBPJizz90tW1GyQMBqwnqxgeaf8OuLkr7C0a/Aw=;
        b=FtKP+jJ/hAFFcdVoFp+KroinjBw2x+rkQyykPfysnR2cccKfD9epHkYfqpGjW+VVjW
         SSDRivBO5lyb6mFzB13E8ND4G5TP2bhEKU7juA2H3qqnKONAHGDmSER+eVO+hwSx0hiD
         nepnHujCGYwuxQzdXCk8ImY90/UymLn5ROqH9FE1nySyCRaWzLjjTDTes6bwTYki/H21
         +7hbIiZZup4mmN5IdqwsT+OJ4hTyZnqYbcY4REhmOfyt01TWpdy3nQcwKzFMCDtTzJH3
         r9RGauFjxChcYCJ+w/ztuXbCMhOnqcCICEplNz1UNqFci5alsD/UYgWwVltRACWwxPhz
         EZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=34QtwBPJizz90tW1GyQMBqwnqxgeaf8OuLkr7C0a/Aw=;
        b=XMSSfFz6SZl4csc/WNIKTi6nQzxRk+tUML4vJTQjVL+/sYjVEieJFpKuj3OfdMDjM0
         N3JmWQ7caVPaE5zPP0lW83ms+dTMUwarvrWSW6crUdhbjN02k8mcxVd3T9l0nCf2yMc4
         GGwhMG3jHZs6L1EDLO9QudiVTRl1iA5fJRBWt+DiV3jl9ftzBMj020qKqnjKuQvFy7fO
         X0QquCmXFlx5xE9PI85ZjEdiAPfUl7e3sGDViJ8BgbSFltGUMyxDsA0EXpNERfWEMQaR
         /yfRvcYUPSJnIfkwacjZWIQMdlt9Y+csIC4nFUixvcv+0vCS/M+D1PrrPVA5FaA8unlj
         rpyA==
X-Gm-Message-State: AOAM532Topnhoz15MrmpHwoKYC3Mq2KcRJUxw+ueXmlDAyULqEA4V+lp
        BRMfrLvU74gA/U7tQE2Dla7cDOTKN8c=
X-Google-Smtp-Source: ABdhPJxuIquadvGx4K9/0php0swwf3ploIVFcMbbGW7qlAm8tUnlL7c8107xZVmLKQbxIQmkOYo+JQ==
X-Received: by 2002:a05:600c:1e22:b0:37c:3653:d471 with SMTP id ay34-20020a05600c1e2200b0037c3653d471mr4747075wmb.175.1645080891225;
        Wed, 16 Feb 2022 22:54:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm31293300wrz.40.2022.02.16.22.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:54:50 -0800 (PST)
Message-Id: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:54:44 +0000
Subject: [PATCH v4 0/5] sparse checkout: fix a few bugs and check argument validity for set/add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Maintainer notes ==

Note: There is a small textual and small semantic conflict with
ds/sparse-checkout-requires-per-worktree-config in seen. I included the diff
with the correct resolution near the end of this cover letter. If you'd
prefer I rebased on top of ds/sparse-chckout-requires-per-worktree-config,
let me know.

== Overview ==

This series continues attempts to make sparse-checkouts more user friendly.
A quick overview:

 * Patches 1-2 fix existing bugs from en/sparse-checkout-set (i.e. in
   v2.35.0)
 * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
   https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
   in cone mode. Since we'll get nasty surprises whether we use or don't use
   "prefix" for non-cone mode, simply throw an error if set/add subcommands
   of sparse-checkout are run from a subdirectory.
 * Patches 4-5 check positional arguments to set/add and provide
   errors/warnings for very likely mistakes. It also adds a --skip-checks
   flag for overridding in case you have a very unusual situation.

== Update history ==

Changes since v3:

 * Use strpbrk() instead of multiple strchr(), fix commit message relative
   to backslashes.

Changes since v2:

 * Dropped patch 5
 * Added Stolee's Reviewed-by

Changes since v1:

 * Dropped the commit changing cone-mode to default (patch 7, which will be
   split into multiple patches and submitted as a separate series)
 * Removed the RFC label
 * Decided to error out when running set/add with paths from a subdirectory
   in non-cone mode, and added tests
 * Changed the warning for non-cone mode with individual files to point out
   that the user is likely trying to select an individual file, but should
   likely add a leading slash to ensure that is what happens
 * Fixed typos, removed unnecessary condition checks

== Conflict resolution ==

Patch to resolve textual and semantic conflict with
ds/sparse-checkout-requires-per-worktree-config:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
remerge CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
index 3c6adeb885..3a95d2996d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -275,24 +275,8 @@ test_expect_success 'sparse-index enabled and disabled' '
     diff -u sparse full | tail -n +3 >actual &&
     test_cmp expect actual &&
 
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 286c22e5ec (sparse-checkout: reject arguments in cone-mode that look like patterns)
     git -C repo config --list >config &&
-    ! grep index.sparse config
-|||||||||||||||||||||||||||||||| 89bece5c8c
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        ! grep index.sparse config
-    )
-================================
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        test_cmp_config -C repo false index.sparse
-    )
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3ce1138272 (config: make git_configset_get_string_tmp() private)
+    test_cmp_config -C repo false index.sparse
 '
 
 test_expect_success 'cone mode: init and set' '
@@ -532,6 +516,7 @@ test_expect_success 'reapply can handle config options' '
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
     core.sparsecheckoutcone=true
+    index.sparse=false
     EOF
     test_cmp expect actual &&
 
@@ -539,6 +524,8 @@ test_expect_success 'reapply can handle config options' '
     git -C repo config --worktree --list >actual &&
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
+    core.sparsecheckoutcone=false
+    index.sparse=false
     EOF
     test_cmp expect actual &&


== CCs ==

Elijah Newren (5):
  sparse-checkout: correct reapply's handling of options
  sparse-checkout: correctly set non-cone mode when expected
  sparse-checkout: pay attention to prefix for {set, add}
  sparse-checkout: error or warn when given individual files
  sparse-checkout: reject arguments in cone-mode that look like patterns

 builtin/sparse-checkout.c          | 78 +++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 87 +++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 7 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1118%2Fnewren%2Fsparse-checkout-default-and-arg-validity-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1118/newren/sparse-checkout-default-and-arg-validity-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1118

Range-diff vs v3:

 1:  5215b7f7179 = 1:  5215b7f7179 sparse-checkout: correct reapply's handling of options
 2:  0c2ab523e74 = 2:  0c2ab523e74 sparse-checkout: correctly set non-cone mode when expected
 3:  e68b0a37ff3 = 3:  e68b0a37ff3 sparse-checkout: pay attention to prefix for {set, add}
 4:  1fdebc1953f = 4:  1fdebc1953f sparse-checkout: error or warn when given individual files
 5:  2008542d0c7 ! 5:  d68682c25c4 sparse-checkout: reject arguments in cone-mode that look like patterns
     @@ Commit message
          To help catch such mistakes, throw an error if any of the positional
          arguments:
            * starts with any of '/!'
     -      * contains any of '*\?[]'
     +      * contains any of '*?[]'
      
          Inform users they can pass --skip-checks if they have a directory that
     -    really does have such special characters in its name.
     +    really does have such special characters in its name.  (We exclude '\'
     +    because of sparse-checkout's special handling of backslashes; see
     +    the MINGW test in t1091.46.)
      
          Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      +				die(_("specify directories rather than patterns (no leading slash)"));
      +			if (argv[i][0] == '!')
      +				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
     -+			if (strchr(argv[i], '*') ||
     -+			    strchr(argv[i], '?') ||
     -+			    strchr(argv[i], '[') ||
     -+			    strchr(argv[i], ']'))
     -+				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
     ++			if (strpbrk(argv[i], "*?[]"))
     ++				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]\\' in it, pass --skip-checks"));
      +		}
      +	}
      +

-- 
gitgitgadget
