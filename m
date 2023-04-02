Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38DCC6FD1D
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 00:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDBABb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 20:01:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93B1880E
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 17:01:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hf2so25138902qtb.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680393686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0jj5SfYj0KQ7q95bk6Kvy1JWaboJnJaPfr+Bzj+GyQ=;
        b=fi+EkTzYge5v3x/vgVVAskdo4AneLTgS1TdqzHkQ/exmvc0mdxuYZ7w9QI2FgOZw4q
         uVhF+vkZyTfUAZkQnRmyw1veqgTbbs2422O/E2xClUl5/AU4B+ddPgKbiwEltvkYvXan
         gxmaimj6tF8XB9tq7/9KRZOLUHf9a+g67nzWNJfFWkppbp3/wkshrpNztyoKs5FYJwZ8
         4rh9R/HWZqllAueW0qD649QzamPTSgg9qUx0CRN6iaKIXzdNcsivUUVHDNlTjuI9En6o
         4NIZemh1faguHo0jL7Ix2yCTK/kkEO1bC0WkR8sCwrTjtKRe6crdxgmGDnhlkltVBYVy
         r+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680393686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0jj5SfYj0KQ7q95bk6Kvy1JWaboJnJaPfr+Bzj+GyQ=;
        b=yvh96lcGbJUrqCm0G8NYMBROrbTTcC3H7Q7vrupwWPZn8fmag49B4KDcQNEpzbN2z8
         8yQ2h4pQC7bhR5mLOoLwC8PDURIqY5V1rzKV0AMgjs7CP+FRXQbSy63/GldPDijn/49X
         it3Rwxiup6xJD11IZF0hSNveUbXB3iExtRfCeDqOmrBhvb38Pf1ArC962WOJ4ShxzCuD
         sF4ZcHfAIg/aDvK0iiK4eeZT8pQO7vPDma3Tk17QtEdEN6ulOyKevhmg9w+GGlt5SUlN
         nq4k8ovRBduGB88X2UMrCZFGInEoLYyiZMwmC742Y+yCt5jwYKEdJiUB9qQvUNVL6aRY
         SsyA==
X-Gm-Message-State: AAQBX9edKyEMXP6/NHoNYvN0F++gNAfrumRkw9Djqd7JaI8KCCwfAFSH
        4hC4je2GLY5I/pvyJ10e74NqMHoir4vYRg==
X-Google-Smtp-Source: AKy350YwU1EZ/OdfrBbwWKzbDwLhJVY2surULxyORC/9jBlzUYfRK5KMXsaNxynXxZTIBzITfzLmnQ==
X-Received: by 2002:ac8:7dd5:0:b0:3e4:635b:1644 with SMTP id c21-20020ac87dd5000000b003e4635b1644mr25147367qte.18.1680393686470;
        Sat, 01 Apr 2023 17:01:26 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id m10-20020a05620a214a00b00748613be2adsm1705355qkm.70.2023.04.01.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 17:01:26 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [RFC][PATCH v1] write-tree: integrate with sparse index
Date:   Sat,  1 Apr 2023 20:01:17 -0400
Message-Id: <20230402000117.313171-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update 'git write-tree' to allow using the sparse-index in memory
without expanding to a full one.

The recursive algorithm for update_one() was already updated in 2de37c5
(cache-tree: integrate with sparse directory entries, 2021-03-03) to
handle sparse directory entries in the index. Hence we can just set the
requires-full-index to false for "write-tree".

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
write-tree' using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/write-tree.c                     |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 45d61707e7..28c45b4301 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -35,6 +35,10 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..9924adfc26 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,6 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git write-tree 
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..3b8191b390 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,32 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'write-tree on all' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+	run_on_all git update-index deep/a &&
+	test_all_match git write-tree &&
+
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+	run_on_all ../edit-contents folder1/a &&
+	run_on_all git update-index folder1/a &&
+	test_all_match git write-tree
+'
+
+test_expect_success 'sparse-index is not expanded: write-tree' '
+	init_repos &&
+
+	ensure_not_expanded write-tree &&
+
+	echo "test1" >>sparse-index/a &&
+	git -C sparse-index update-index a &&
+	ensure_not_expanded write-tree 
+'
+
 test_done
-- 
2.39.0

