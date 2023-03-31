Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C5C77B62
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjCaO2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjCaO2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 10:28:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5220339
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:28:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s19so13535986pgi.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680272865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iy7rFsyFGSuV21M2ANIDCBJ2HInd04X0eIKBpCpmouQ=;
        b=dgsIHKq6Zwp4XgSJnHWSFy/OSfMvJ2luQS2JCHZKOk0wLTgLPdTRZsPrliOFP653Ao
         ixuj4T/amg7Z1ip2HxUfWk5mMm5X3AseWOIeakP0JcmBquw2kmoZ0BPNaLmDcpl3D8M4
         GqfnVHvwRD+QsQV2cCQhkTRugf/xtUELAtsN+mDEnWb9af922MNae54f25XVVLQGu/iF
         sku+OSStJLrVh+mBDfXvUhlVGr+W0CFIaYNpmSJ29Dt6eKu6zxYgkd4sI1trQByWkzqU
         B5ir286pFJ07dhCOuuWVKKcgt3uB/zS7LwesFSsaESROC+JYIWmiQnHyv6CdnD/5mnF+
         Xazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iy7rFsyFGSuV21M2ANIDCBJ2HInd04X0eIKBpCpmouQ=;
        b=0sfwrp9oBMgI9c29Hwlwjs8+/YVVvLXYZW7nNkEuP4e4uTW1heOOkDMkdcwQtcpBgN
         PYHr4BsUpDPafRKs/Nx8rP7UK+TYyZHxdW7oOVp/OPNpH5goLaqS53CiEO1kTySmLMdT
         8gqbXtaCSxkijPq5icG2jejE0QZX1ino6ZfbCdSlx9AMXsxZZ/UHl+DtnxQVgZRTHzOB
         ULAYOAtWRwJd4ognOJcbgnnEBGo0+Gscp8X94T8Z1UODaBPpLXUwVe8bdlYGjaHICw3n
         mo7CgOA/OvHk6PYzvuBTHlnHIrIdkshNyKm//ZYjX0UmaBiwVoBCJYyD+BFxEPEmX6s9
         0VGg==
X-Gm-Message-State: AAQBX9fIoCV5D9osnmHBy0aKvAgRy1+211myIt6Q26W04+wDlKX2VLgc
        93IAUbUhRsFUk0U+/NUHGXXlmMZgqb/yWUM7
X-Google-Smtp-Source: AKy350btWD+R9g5hCMKoIYefvm8UF2DvQm02QyEODElVC70yf3ooBB3ueFqRm3hw7QKH7MiSbgi1gw==
X-Received: by 2002:a05:6a00:1c91:b0:5e4:f141:568b with SMTP id y17-20020a056a001c9100b005e4f141568bmr6338364pfw.3.1680272865511;
        Fri, 31 Mar 2023 07:27:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e020:20ea:fb6f:c0b4:a709:2d74])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b006260526cf0csm1885954pfa.116.2023.03.31.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:27:45 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     git@vger.kernel.org
Cc:     Raghul Nanth A <nanth.raghul@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Subject: [GSOC][PATCH] describe: enable sparse index for describe
Date:   Fri, 31 Mar 2023 19:57:38 +0530
Message-Id: <20230331142738.52824-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add usage and performance tests for describe

git describe compares the index with the working tree when (and only
when) it is run with the "--dirty" flag. This is done by the
run_diff_index() function. The function has been made aware of the
sparse-index in the series that led to 8d2c3732 (Merge branch
'ld/sparse-diff-blame', 2021-12-21). Hence we can just set the
requires-full-index to false for "describe".

Performance metrics

  Test                                                     HEAD~1            HEAD
  -------------------------------------------------------------------------------------------------
  2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
  2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
  2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
  2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
  2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
  2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
  2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
  2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%

Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
---
 builtin/describe.c                       |  2 ++
 t/perf/p2000-sparse-operations.sh        |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8..7ff9b5e4b2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
+			prepare_repo_settings(the_repository);
+			the_repository->settings.command_requires_full_index = 0;
 			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..db7887470f 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
 	done &&
 
 	git sparse-checkout init --cone &&
+	git tag -a v1.0 -m "Final" &&
 	git sparse-checkout set $SPARSE_CONE &&
 	git checkout -b wide $OLD_COMMIT &&
 
@@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git describe --dirty
+test_perf_on_all 'echo >>new && git describe --dirty'
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..2b46fb2a48 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1514,6 +1514,36 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash pop
 '
 
+test_expect_success 'describe tested on all' '
+	init_repos &&
+
+	# Add tag to be read by describe
+
+	run_on_all git tag -a v1.0 -m "Version 1" &&
+	test_all_match git describe --dirty &&
+	run_on_all rm g &&
+	test_all_match git describe --dirty
+'
+
+
+test_expect_success 'sparse-index is not expanded: describe' '
+	init_repos &&
+
+	# Add tag to be read by describe
+
+	git -C sparse-index tag -a v1.0 -m "Version 1" &&
+
+	ensure_not_expanded describe --dirty &&
+	echo "test" >>sparse-index/g &&
+	ensure_not_expanded describe --dirty &&
+	echo "v1.0-dirty" >actual &&
+
+	# Check describe on dirty work tree
+
+	test_cmp sparse-index-out actual &&
+	ensure_not_expanded describe
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
-- 
2.40.0

As for the previous questions, yes I am intereseted in GSOC. I had
missed the part regarding the micro projects when I was going through
the requirements. Sorry about that. Would I be required to make one now?
