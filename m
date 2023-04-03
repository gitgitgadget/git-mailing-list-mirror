Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A1C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDCTGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDCTGB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:06:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CD1FFB
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:06:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id iw3so29034918plb.6
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680548759; x=1683140759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooOMJlLMoQn9b06xGF5ioLaljDr85qEnxVC1dK9SUIU=;
        b=U+v9zlJOGNmLXoR7r36IAeAXxH6V66lzS3k1CWcz+hn7cAnC3Idp6RYtDQRGfEB8y/
         QXa42/7QX1Sipy2zVCks9wfnuCw3kI+pKbeHoDnBalVKfIlq8sWbsP4PJkdznuq9Xmcr
         dFCADDuHBDpsJVRScrRDxSXtIeJ74cTjsLdO7XPeoKUo5VmHAZT9UvZbmhDaIlYT5d5l
         EIU5Twd5OdrE18lcxTfHBya6dtpC2hUw4J7JtWS0+laYod2K2+kAaaiiTdi5fM10s7Zh
         REnpRgeTwn+k2fcm43hcYTdK9TFlFBX7VXkC9rOnPO2QoC4kLbpQEkVSc3C+flIKUcou
         O5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680548759; x=1683140759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooOMJlLMoQn9b06xGF5ioLaljDr85qEnxVC1dK9SUIU=;
        b=3jhnyUw9tgfHjxnx1sNMizkqnPaPqeW0zvcom2t5bOXoDyxAKcgWn10U8x2rsvmbdj
         wigWJbt2eCO20ryfXtCewJoxeWjtggDw4JWt3pV3zLfmHut5KA3MnI7/mC5LA74U92wK
         P5cbisvVqaXtdO6spsdbHmCpQk3/5huhJvECWZMXHxRE66ThrbEdyar7RkXOrr8zV6kh
         i1KQBFug0C72l70uCumsHpOfK15PeDJ0uw8gJ5Jzy3OID57LnfUX4R6ILV7EhhdbVaL/
         x5l+19fA7tB956Gr6tGjH5Ueysy5tpdpipS3LilqrwIwKHxM7za+0y0y9sN5XausqeXJ
         DJvA==
X-Gm-Message-State: AAQBX9dq8TK+MfSDk+KWfdSJ52yfhXXqbWJrZqqS1s0s9rSvJ5FmtC5p
        PfYNVhdEQXOKOtJVVa8HQoaaL1A/rhRnlH3pAsw=
X-Google-Smtp-Source: AKy350bKt3lE2avF2Tl+QuEbZcBzYZ+zhk+55NQRcGreE3IzCWEkObT7c0DOw7pvHHOT01V/+uck8A==
X-Received: by 2002:a17:902:d70c:b0:19e:94ff:6780 with SMTP id w12-20020a170902d70c00b0019e94ff6780mr52690ply.6.1680548759299;
        Mon, 03 Apr 2023 12:05:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e020:20ea:fb6f:c0b4:a709:2d74])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001a1d41d1b8asm6926920plt.194.2023.04.03.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 12:05:58 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, nanth.raghul@gmail.com
Subject: [GSOC][PATCH v1] diff-index: enable diff-index
Date:   Tue,  4 Apr 2023 00:35:38 +0530
Message-Id: <20230403190538.361840-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uses the run_diff_index() function to generate its diff. This function
has been made sparse-index aware in the series that led to 8d2c3732
(Merge branch 'ld/sparse-diff-blame', 2021-12-21). Hence we can just
set the requires-full-index to false for "diff-index".

Performance metrics

  Test                                        HEAD~1            HEAD
  ------------------------------------------------------------------------------------
  2000.2: git diff-index HEAD (full-v3)       0.09(0.05+0.05)   0.09(0.06+0.04) +0.0%
  2000.3: git diff-index HEAD (full-v4)       0.09(0.05+0.05)   0.09(0.06+0.03) +0.0%
  2000.4: git diff-index HEAD (sparse-v3)     0.32(0.28+0.05)   0.01(0.01+0.04) -96.9%
  2000.5: git diff-index HEAD (sparse-v4)     0.34(0.29+0.06)   0.01(0.02+0.03) -97.1%
  2000.6: git diff-index HEAD~1 (full-v3)     3.77(3.62+0.14)   3.37(3.27+0.09) -10.6%
  2000.7: git diff-index HEAD~1 (full-v4)     3.18(3.07+0.11)   3.20(3.10+0.09) +0.6%
  2000.8: git diff-index HEAD~1 (sparse-v3)   3.78(3.65+0.12)   0.22(0.20+0.06) -94.2%
  2000.9: git diff-index HEAD~1 (sparse-v4)   3.86(3.74+0.12)   0.28(0.28+0.04) -92.7%

Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
---
 builtin/diff-index.c                     |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 35dc9b23ee..8b9871d611 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -24,6 +24,10 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	prefix = precompose_argv_prefix(argc, argv, prefix);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..9e74cb22b9 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git diff-index HEAD
+test_perf_on_all git diff-index HEAD~1
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..13801f327d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1996,6 +1996,24 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'sparse index is not expanded: diff-index' '
+	init_repos &&
+
+	echo "new" >>sparse-index/g &&
+	git -C sparse-index add g &&
+	git -C sparse-index commit -m "dummy" &&
+	ensure_not_expanded diff-index HEAD~1
+'
+
+test_expect_success 'match all: diff-index' '
+	init_repos &&
+
+	test_all_match git diff-index HEAD &&
+	run_on_all rm g &&
+	test_all_match git diff-index HEAD &&
+	test_all_match git diff-index HEAD --cached
+'
+
 test_expect_success 'grep with and --cached' '
 	init_repos &&
 
-- 
2.40.0

