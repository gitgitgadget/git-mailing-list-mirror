Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B210C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiBGVdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbiBGVdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF7AC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i15so4768479wrb.3
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=otauxVbNhdpRSbB2iGrJwCh+O74dZOFGyR27yFTt++VGRhRRW80+pYt97kfat9oxbG
         r3+mWYw9KXNt9xpAB6yJycdaae+MemsDvlSfkK8c6KKhnlNf0b4mj6LJyI5ki+pURfs8
         SUTOelorQFGUddbrFg+JFWEgkUV8g8xeGurz5ogjU0q1PQw9t3yVj3SarH7pWWn93byW
         1ljEwLNmyot0RG3yy7ncEyRdTo/aqkEkXg9+rl8Nw4ZBEmwR5Oo/jMdcohfjEnEJtY0k
         5hzDAdxJ3c/oHEMiWwpH+zO7jfJXILnCGN6neOuKUIkyW+p3i0nLHrI+SdJSnuSqVcAw
         GzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=4MIMrD/7AKN1P/Ykjvmz9+XY4npgXLXmAIwIXVRtPmahv4mTIGm9GvdoiSJcJCKOYe
         fZVsbPReBpYN1QMJ/63URIBfmbtFC4jW3Qr5rV5aXfEp3DDR0WJYFA744qqomNoW7EKH
         i6bKdhAWGWk204it94pmJNaYI2iDyNe7R0cGwO0j1U9ryMPDIRCaHMzFaWHI8nZ20cIK
         cruAcR0XABv0VJvKFAzGAfFyY03UjBKFcqTBvjSMYQUJixtQB6oNklUB0KoUXVuM4XbN
         TwzWBqkLvMMtRIAzjOewpoui+b8NuiuwvtBFWHrCgaGYE7ZCL+hZcKRm80ugU73IRpq5
         in2g==
X-Gm-Message-State: AOAM533tE1TrEVTRR7aUO4YuwzUpXunZiJOOAR1TJ775m+FDDflaMZPx
        EX+wRXTYFl+cJSHgmONY+/p6sm7EwVI=
X-Google-Smtp-Source: ABdhPJyV3wF+DB93WOIAQawhLsK3038oBxMBdVMcmaeglOhmm86geUmY2+L8z6PWja62fsGqhItG4A==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1048131wrz.700.1644269588020;
        Mon, 07 Feb 2022 13:33:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm12480388wrw.54.2022.02.07.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:07 -0800 (PST)
Message-Id: <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:33:00 +0000
Subject: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some config settings, such as those for sparse-checkout, are likely
intended to only apply to one worktree at a time. To make this write
easier, add a new config API method, repo_config_set_worktree_gently().

This method will attempt to write to the worktree-specific config, but
will instead write to the common config file if worktree config is not
enabled.  The next change will introduce a consumer of this method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 35 ++++++++++++++++++++++++++++++++---
 config.h |  8 ++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 2bffa8d4a01..1a03ced1a54 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "worktree.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2884,6 +2885,20 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	/* Only use worktree-specific config if it is is already enabled. */
+	if (repository_format_worktree_config) {
+		char *file = repo_git_path(r, "config.worktree");
+		int ret = git_config_set_multivar_in_file_gently(
+					file, key, value, NULL, 0);
+		free(file);
+		return ret;
+	}
+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
+}
+
 void git_config_set(const char *key, const char *value)
 {
 	git_config_set_multivar(key, value, NULL, 0);
@@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
 int git_config_set_multivar_gently(const char *key, const char *value,
 				   const char *value_pattern, unsigned flags)
 {
-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
-						      flags);
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+int repo_config_set_multivar_gently(struct repository *r, const char *key,
+				    const char *value,
+				    const char *value_pattern, unsigned flags)
+{
+	char *file = repo_git_path(r, "config");
+	int res = git_config_set_multivar_in_file_gently(file,
+							 key, value,
+							 value_pattern,
+							 flags);
+	free(file);
+	return res;
 }
 
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
+	git_config_set_multivar_in_file(git_path("config"),
+					key, value, value_pattern,
 					flags);
 }
 
diff --git a/config.h b/config.h
index f119de01309..1d98ad269bd 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/**
+ * Write a config value that should apply to the current worktree. If
+ * extensions.worktreeConfig is enabled, then the write will happen in the
+ * current worktree's config. Otherwise, write to the common config file.
+ */
+int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
@@ -281,6 +288,7 @@ int git_config_parse_key(const char *, char **, size_t *);
 
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
-- 
gitgitgadget

