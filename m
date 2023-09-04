Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10079C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 06:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352323AbjIDGVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352321AbjIDGVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 02:21:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE0E6
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 23:21:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c73c21113so875314f8f.1
        for <git@vger.kernel.org>; Sun, 03 Sep 2023 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693808488; x=1694413288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zmnYuxUULsEPf81ZsbIk/cY9hO4zMMB2s+0buZyRiKM=;
        b=mN0ZodrPlYtlFxJg6kiRAeRM8Alsom1raXVPj/zZ0B7+5nl8TB1fd+DvP1tgvIdzIm
         Vlqq69Rs86toEIj8+Rves+zhwH9aSQ8zhNTHwPgtfjPTZnZiB9JSmuKFKl/qnMeFaTyq
         3GjYsd5X8fWI5wL69KWE2MWfunXlWf/8HICMFVS4RcKo49PQxGkl12LJCWlNL7IrYJJ4
         KX2nVcGGVTmQtpRvnPIW77zJn9y925gKee+d0YC5I1eBbX5WO+NZq9eheWkvUstZg6+x
         lJz+XllYI+SjVrOVXZORQAjsy0KrGo4GpNlmbQI5oL25IhqWt0kvbyjBjyrnwTs2WkUl
         86fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693808488; x=1694413288;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmnYuxUULsEPf81ZsbIk/cY9hO4zMMB2s+0buZyRiKM=;
        b=JBSumFxV19RTKg8HzYf4RaFb5m/JBm9UvrnaWqTZ39/YUoQ+CHsJFKpDnYfNFXeZLo
         VrLTP4wc5jSfzoEXk0SHms2Ux2CF2eSMnWp6kelIqjlLh0DkyJPuyK6WdLyF3BCh0ivZ
         qTTvt3tGsE2fwy11LFnQr/jrlAhlfD6YCkW5RM4dyvUsxR5IPt+BSqV/LNX2sDqUBS+n
         5TyatoyCemN59Gq22Lwk3/UxxIbgjcLKgC6/nmBbva//1hpD/7HAD8yLmlCtRe3zaqK4
         7N+iJDcjonTQpJIjA0Whz+YagYo4HbqXIvpsdfEwh3Q02vP+hGX3KKCfUOSSZsIjZxC4
         RcCA==
X-Gm-Message-State: AOJu0Yz+7J+LWO3Xg5yjt+Uz1V01w+RDt8zP2TxpQBgmP87q3qcXtZ1b
        zCATUa0DdnOjwz/zg4Pu4cf9UYA2mBM=
X-Google-Smtp-Source: AGHT+IGpwP1lKLSqiF4xALgA19tifZxiZuSe1q4uqdWuDNgI0bjVBMRxuCorfnRTjXkVrLa2jXZfMg==
X-Received: by 2002:adf:ed50:0:b0:318:1535:34fb with SMTP id u16-20020adfed50000000b00318153534fbmr6615521wro.13.1693808488278;
        Sun, 03 Sep 2023 23:21:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm13482994wrq.59.2023.09.03.23.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 23:21:27 -0700 (PDT)
Message-ID: <pull.1580.git.1693808487058.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Sep 2023 06:21:26 +0000
Subject: [PATCH] var: avoid a segmentation fault when `HOME` is unset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code introduced in 576a37fccbf (var: add attributes files locations,
2023-06-27) paid careful attention to use `xstrdup()` for pointers known
never to be `NULL`, and `xstrdup_or_null()` otherwise.

One spot was missed, though: `git_attr_global_file()` can return `NULL`,
when the `HOME` variable is not set (and neither `XDG_CONFIG_HOME`), a
scenario not too uncommon in certain server scenarios.

Fix this, and add a test case to avoid future regressions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    var: avoid a segmentation fault when HOME is unset

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1580%2Fdscho%2Favoid-segfault-in-git-var-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1580/dscho/avoid-segfault-in-git-var-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1580

 builtin/var.c      | 2 +-
 t/t0007-git-var.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/var.c b/builtin/var.c
index 74161bdf1c6..8cf7dd9e2e5 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -66,7 +66,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
 
 static char *git_attr_val_global(int ident_flag UNUSED)
 {
-	char *file = xstrdup(git_attr_global_file());
+	char *file = xstrdup_or_null(git_attr_global_file());
 	if (file) {
 		normalize_path_copy(file, file);
 		return file;
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 8cb597f99c4..ff4fd9348cc 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -268,4 +268,13 @@ test_expect_success 'listing and asking for variables are exclusive' '
 	test_must_fail git var -l GIT_COMMITTER_IDENT
 '
 
+test_expect_success '`git var -l` works even without HOME' '
+	(
+		XDG_CONFIG_HOME= &&
+		export XDG_CONFIG_HOME &&
+		unset HOME &&
+		git var -l
+	)
+'
+
 test_done

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
gitgitgadget
