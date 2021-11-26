Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6992DC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbhKZWs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbhKZWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD9C061748
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so21597864wrb.3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iLfozNvzEqSfgZL5/jMo0s6aE1pIL4U5OLH2XtwZZdM=;
        b=UoMmCKqZOEl1qsx56LFrguPfcKQZM9eRa0oe7XIXmGeXRbFLM8FybGZXrftoBx5135
         C22GTDufEEon1rxGZQQe6faeuzNg/IKXtHA2zqvGWiFERpxrcf225qfvu4Vy+FzPFgJh
         2zVKzhjyYA+012pgI5CDNX/fhyAunxvYWUF/K7rYy/JJG49BOgV0r27FffQ6OVzBAlYX
         gKwpidIhGfU/K3CPPz/XKMn/OmerAP+Y4IqiUWOJn1RVEjqKF+Ade33u+0LKqsVNHg0e
         j0o2OmgVhJPmH/BwJ+MA3uwpycj1IfArbaHYbznkjYq5RzddSBc6L3cynr0YkvIHHOQ4
         Ey9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iLfozNvzEqSfgZL5/jMo0s6aE1pIL4U5OLH2XtwZZdM=;
        b=nIqJyjVFGCsyWtjQTjdlRW0myBls0Oft3EEOUojA8Htznc/VpX5wo2u+M+Lt3+mRlH
         LXJ7ebAnuJNa7+Ic4AmOMVAFIGnv4MnFZGz8WQ22OpNqucYWzspxolvX3yGBpEiK5BB1
         nDOfBd8tEU+1Vyj4QRjPMXo0NOYudLH7VGzs41YNcw2Rl/R1oCRrTsn8P6pJyUfw4Wsw
         LLtuD3p3SenBw27Qd9MOSeUDSHiIq3SKNsIg3hEPAvUIyhPjblxdsNagrE4E05nAd1wS
         JHvVZpLY/ZJmCQrWxTImLy4yTwEy4caAF89iM3msV+koqbMgFUtrp0Vz5eWLPjnxw/ts
         LKWQ==
X-Gm-Message-State: AOAM532VRMLMO8SctPeornpobIbhUHpsDoJTXEGSLFhcH2wyCaqMs5OC
        +xfTIZnaFyt6W+byI6WQL6FWDuRIFoA=
X-Google-Smtp-Source: ABdhPJxdoljyGltbD3Zj4VgTbKX0h/uhqhviTbYayGvr5VWh5CKdHA4hyrZr4xZQWFQ4N8DW9u5MFg==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr17113584wrr.444.1637966468840;
        Fri, 26 Nov 2021 14:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm11824519wmi.33.2021.11.26.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:08 -0800 (PST)
Message-Id: <11e4ec881bb8c23f981054902d5bac09cadaad4d.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:57 +0000
Subject: [PATCH v3 06/11] clean: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 44 +++++++++++++++++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  5 +++--
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..3ff02bbbffe 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -36,6 +36,8 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
+static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
+static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -153,6 +155,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf realpath = STRBUF_INIT;
+	struct strbuf real_ocwd = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
@@ -231,16 +235,36 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	strbuf_setlen(path, original_len);
 
 	if (*dir_gone) {
-		res = dry_run ? 0 : rmdir(path->buf);
-		if (!res)
-			*dir_gone = 1;
-		else {
-			int saved_errno = errno;
-			quote_path(path->buf, prefix, &quoted, 0);
-			errno = saved_errno;
-			warning_errno(_(msg_warn_remove_failed), quoted.buf);
+		/*
+		 * Normalize path components in path->buf, e.g. change '\' to
+		 * '/' on Windows.
+		 */
+		strbuf_realpath(&realpath, path->buf, 1);
+
+		/*
+		 * path and realpath are absolute; for comparison, we would
+		 * like to transform startup_info->original_cwd to an absolute
+		 * path too.
+		 */
+		 if (startup_info->original_cwd)
+			 strbuf_realpath(&real_ocwd,
+					 startup_info->original_cwd, 1);
+
+		if (!strbuf_cmp(&realpath, &real_ocwd)) {
+			printf("%s", dry_run ? _(msg_would_skip_cwd) : _(msg_skip_cwd));
 			*dir_gone = 0;
-			ret = 1;
+		} else {
+			res = dry_run ? 0 : rmdir(path->buf);
+			if (!res)
+				*dir_gone = 1;
+			else {
+				int saved_errno = errno;
+				quote_path(path->buf, prefix, &quoted, 0);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
+				*dir_gone = 0;
+				ret = 1;
+			}
 		}
 	}
 
@@ -250,6 +274,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
+	strbuf_release(&realpath);
+	strbuf_release(&real_ocwd);
 	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 496f4c6a6e9..be04b673f6a 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -221,8 +221,9 @@ test_incidental_untracked_dir_removal () {
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
-		git -C .. clean -fd -e warnings . >warnings
+	test_incidental_untracked_dir_removal success \
+		git -C .. clean -fd -e warnings . >warnings &&
+	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-- 
gitgitgadget

