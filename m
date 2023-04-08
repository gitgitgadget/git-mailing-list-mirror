Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C36C7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 11:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDHLX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDHLX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 07:23:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105E7ECB
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 04:23:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2465835cf6fso147433a91.1
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680953034; x=1683545034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0Rpfdl9K0efA4r4pZx+W6QIlM2xuyPn5FcVtVP0aQs=;
        b=Go2nlAGsJe6TH+D4DjA71d7qfFv1deC2zesM8p/sYyM4307ZPlLbBVITEBxlG+YRRv
         ww0xPiyQeZORhjnrT3+Rhc5R14u2/uP7/XfNtkdO49ZelbMeuPA2CeldMHWauVOtuigI
         08z6m69r7l3dSk3LIpShFwbwraERRQ4lrwW6wWJjydH1WVVJMl2zVZvKwMtLA7M587El
         iNum0mru1D61HnjU7IiyTWh6dD1F9vhSIFa9PfJ44EHx+apMIAFPSSouBna9qU2b2IWZ
         0CoT+fgsTRukR3OHz6YEWzCDMpSfO+3D75+rc/yznS505B//GNgwdPmMfZ+X/7hpQ2S3
         n1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680953034; x=1683545034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0Rpfdl9K0efA4r4pZx+W6QIlM2xuyPn5FcVtVP0aQs=;
        b=KTwOGyqG3921JcfvmkS76x/AX73yPHMaH9A4BH8SWHXWEAmF9Ok09kXc+xgn36I9JH
         7c0xD0C39RGpLvBWUQIIsI72JC97oNQxbEf8Ir1EfxdQEzGcyfQmn9wWZ230g3kZbXcj
         eOI/EC2g1aVVZ2F4M2ezzJ0kdMKjOaPOINx2HaoUKHtpMfe8q3c+s6vxx9lxuB0yjK1U
         TPkrapVReylGku1d2V7nFsJrlDJr/cT3X2afY1q0EWCFAu8mLJzzgpm2QpGLwyvn1khE
         MyLhqKGoJC3d2fJ1qsP/YnrI7pwza76ztbV+cobT1rqp7XkQQ+VWbkhWBzNlSKUHU3TZ
         Shhw==
X-Gm-Message-State: AAQBX9eOuKk0O5gmOnCztorrK6U4DddPXkF7ojhrLGAVcrZIXsZqBusL
        Y8qSEzw70ZDy2sWkoXlIUtMuG0o5bDaaEg==
X-Google-Smtp-Source: AKy350YGGgSs4U3FXbw2WGDIhbRxuYaF1EBFLbamBquzp76GGYyU5A9qVxMENLYJr1HS2Wn3S4ljAg==
X-Received: by 2002:a05:6a20:440d:b0:d9:3de:541e with SMTP id ce13-20020a056a20440d00b000d903de541emr6627326pzb.6.1680953033792;
        Sat, 08 Apr 2023 04:23:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:619a:603b:d674:da27:2092:5368])
        by smtp.gmail.com with ESMTPSA id s5-20020a63f045000000b005038291e5cbsm4079909pgj.35.2023.04.08.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 04:23:53 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, nanth.raghul@gmail.com
Subject: [GSOC][PATCH v2] diff-index: enable sparse index
Date:   Sat,  8 Apr 2023 16:53:42 +0530
Message-Id: <20230408112342.404318-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403190538.361840-1-nanth.raghul@gmail.com>
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff-index uses the run_diff_index() function to generate its diff. This
function has been made sparse-index aware in the series that led to
8d2c3732 (Merge branch 'ld/sparse-diff-blame', 2021-12-21). Hence we can
just set the requires-full-index to false for "diff-index".

Performance metrics

  Test                                                  HEAD~1            HEAD
  ----------------------------------------------------------------------------------------------
  2000.2: echo >>a && git diff-index HEAD (full-v3)     0.09(0.06+0.04)   0.09(0.07+0.03) +0.0%
  2000.3: echo >>a && git diff-index HEAD (full-v4)     0.09(0.06+0.04)   0.09(0.05+0.05) +0.0%
  2000.4: echo >>a && git diff-index HEAD (sparse-v3)   0.37(0.31+0.06)   0.01(0.02+0.03) -97.3%
  2000.5: echo >>a && git diff-index HEAD (sparse-v4)   0.30(0.26+0.05)   0.01(0.01+0.04) -96.7%
  2000.6: git diff-index HEAD **a (full-v3)             0.06(0.05+0.01)   0.06(0.06+0.01) +0.0%
  2000.7: git diff-index HEAD **a (full-v4)             0.06(0.05+0.01)   0.06(0.04+0.02) +0.0%
  2000.8: git diff-index HEAD **a (sparse-v3)           0.29(0.25+0.03)   0.01(0.01+0.00) -96.6%
  2000.9: git diff-index HEAD **a (sparse-v4)           0.37(0.34+0.02)   0.01(0.01+0.00) -97.3%
  2000.10: git diff-index --cached HEAD (full-v3)       0.05(0.03+0.01)   0.05(0.03+0.02) +0.0%
  2000.11: git diff-index --cached HEAD (full-v4)       0.05(0.03+0.01)   0.05(0.02+0.02) +0.0%
  2000.12: git diff-index --cached HEAD (sparse-v3)     0.35(0.33+0.01)   0.01(0.00+0.00) -97.1%
  2000.13: git diff-index --cached HEAD (sparse-v4)     0.35(0.32+0.02)   0.01(0.00+0.00) -97.1%
---

Sorry for the late reply. Got caught up in school work
  * Fixed commit message
  * Added check to expand index if needed (based on diff-files)
  * Added pathspec based tests

 builtin/diff-index.c                     |  9 +++++
 t/perf/p2000-sparse-operations.sh        |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 44 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 35dc9b23ee..e67cf5a1db 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -24,6 +24,14 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	if (pathspec_needs_expanded_index(the_repository->index,
+					  &rev.diffopt.pathspec))
+		ensure_full_index(the_repository->index);
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	prefix = precompose_argv_prefix(argc, argv, prefix);
@@ -69,6 +77,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		perror("repo_read_index");
 		return -1;
 	}
+
 	result = run_diff_index(&rev, option);
 	result = diff_result_code(&rev.diffopt, result);
 	release_revisions(&rev);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..62499d3aa8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,8 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all 'echo >>a && git diff-index HEAD'
+test_perf_on_all git diff-index HEAD "**a"
+test_perf_on_all git diff-index --cached HEAD
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..24bc716c48 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1996,6 +1996,50 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'sparse index is not expanded: diff-index' '
+	init_repos &&
+
+	echo "new" >>sparse-index/g &&
+	git -C sparse-index add g &&
+	git -C sparse-index commit -m "dummy" &&
+	ensure_not_expanded diff-index HEAD~1 &&
+
+	echo "text" >>sparse-index/deep/a &&
+
+	ensure_not_expanded diff-index HEAD deep/a &&
+	ensure_not_expanded diff-index HEAD deep/*
+'
+test_expect_success 'diff-index pathspec expands index when necessary' '
+	init_repos &&
+
+	echo "text" >>sparse-index/deep/a &&
+
+	# pathspec that should expand index
+	! ensure_not_expanded diff-index "*/a" &&
+	! ensure_not_expanded diff-index "**a"
+'
+
+test_expect_success 'diff-index with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_sparse_match test_must_fail git diff-index HEAD folder2/a
+'
+
+test_expect_success 'match all: diff-index' '
+	init_repos &&
+
+	test_all_match git diff-index HEAD &&
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+	run_on_all ../edit-contents g &&
+	run_on_all git add g &&
+	run_on_all git commit -m "two" &&
+	run_on_all rm g &&
+	test_all_match git diff-index HEAD &&
+	test_all_match git diff-index --cached HEAD~1
+'
+
 test_expect_success 'grep with and --cached' '
 	init_repos &&
 
-- 
2.40.0

