Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BCC433FE
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358664AbiAaPBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiAaPBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:01:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD0C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so4605474wmb.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=BnsTyVAkCegZZQW5r96Ysr4vCPa+6u8mXMlEOmOVESVWeF96ahHi/rVAXQMJw5h7Ui
         hoohDeCOwWyWVranslguYfaY96z/07qYMYoIbgmAmkY21jSQoMsy2phdCs9zZ3SmVj2J
         ohCMn58iKXdjn8kr+GcIa2TILaixa46toNxe3vTEWN6cjxHPAQSk7pFY35qkRhQtyWSo
         ryY8qj7zZNS6WRelFMo+mH+Ybugn/KxZAxa0arwiuqKchpyypPXUpXlxSvVHc5Tumt1q
         125kZabAuejaTT4ELMejfwJDGcPP2OuWw2KMVOlXoiNgNjkG163AdjM+elMY8wV/vCg/
         DqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=ONMZqb2qJx85pkkFalHbRoKtpoRkntC06tmcpHAQUGbJE54N1PlaB9sMocG3DINdrj
         nwVlkTLEBLPzJzMIwtKJFkr1tCcljOiohdgRej9respBm5afYEcVVymfgiNt4ohhQb5x
         cTlDhVBDLbJBlwJq8aelGDT9qBfxzqO9W0USrSzkvaxtDVUIeEf82P5p5H+aKYAboehe
         m5DqWLNDz0HcfkGNErW8wxLBlNw393dbeWry7TJzWowuQ4Mn3wp7OnUUDpt7pw/Kt+/v
         YTlCnU7Ct6DhsBTA25H0o9w7on57spatYzCZ68QSPDH+hzJrjb6j3qV171jtivM70cg7
         gVhA==
X-Gm-Message-State: AOAM533RhX9pbEeDkzRWqZMZwXQ2567XdJYO5tngrO4YnioWuahMzMx2
        6KIijc1BVFfnrbtyTAmANAWSPBJ9Yz8=
X-Google-Smtp-Source: ABdhPJwgnrXRK5BhwzpQSRg9BPGMjT49YMg6tASDtnWt2PbuRR/IJbif4E+aJ4sFrPb8IEUp/k+a0g==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr19223940wmh.65.1643641263317;
        Mon, 31 Jan 2022 07:01:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm11952756wrx.79.2022.01.31.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:01:02 -0800 (PST)
Message-Id: <802b28a95103396d305eaf62ea98b492b4f21871.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
        <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 15:00:57 +0000
Subject: [PATCH v5 3/5] config: add repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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

