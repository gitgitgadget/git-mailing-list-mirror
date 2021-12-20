Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7687C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhLTP5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbhLTP53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387E5C06173E
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b188-20020a1c80c5000000b00345afe7e3c0so364623wmd.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/YKiBTM++2zocP5Q85EYLwm92iPXHqkV2co9AUgPvfY=;
        b=EcB0dKvPlX1l5uqY13Kp8YVkjAht+lzjOTzKFW3hMTVAayO8G5R/qyvoKDJ1ULeq5x
         DfxxhXVJA6rIXLaER+uMxv0BVYKxWvehOmCyDdZ018X90NO5W2Cv6S28capEi+iOmNxb
         48UQ/Kj3jesTexlebWjZn638A+KYQnuLGH9dTjL19KPITXDlEd/iFw09BlHB0X0pv+s2
         rtsf+04BX2ut6Q/SYx0D0s7LrRagRc1hgOiO5ACx/JVLPFySz9p2nUKyOcCqNJrQjwGT
         hh4mBEmE4Woe7M0ZWm8zBYZ7TLSe67UAjFglGocSIR9MmNb4CMCoq4fuBMt2okDtaQ+e
         YEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/YKiBTM++2zocP5Q85EYLwm92iPXHqkV2co9AUgPvfY=;
        b=ArA71a0DZH65meSVrLc7PjusRreCI93EXg0lo5VtB1xscvceMnN/9j+zS/WBXHNb/v
         zsZNwcXlUAxKtJ5ooSbzOAP45Q0ETCZIjfa3BX7HHhFaCUjbAleqGFIRuB8YQvHJ1j1A
         Hjvb3HqM9NMu161S5LEaOByKzg0LkLLkl3kUXNRpo5O21pax1kVlth2GdErBTOdhR9Og
         a6r3ag7luUktLhYBvXkXbAhJhZglXZXmW8tkXREz1rjSM+ld8u4zJJ/TJuOVQxFtXSJf
         uV9NMigNcsETHWKCFaa4xFgH1xKuPN8F/F3YuslwSyEIbVYB1neldam0VAam5AdKV+jN
         BnJA==
X-Gm-Message-State: AOAM531NOpilCHlFdnlyB+0MWtq+2PpuFq1xAdzyuMFg7bmB0j1CmXJ+
        a84avFle//YzY3r+6jn/xBaTPpT0WjM=
X-Google-Smtp-Source: ABdhPJz+KJS/WeaDBl+0+WCxu/Ss2LdvrlCTwuPA6Zc4I0NX/kB5pxayfmaCA+LOO+EryBDE+5SOnw==
X-Received: by 2002:a05:600c:3c9b:: with SMTP id bg27mr14443986wmb.163.1640015847681;
        Mon, 20 Dec 2021 07:57:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm5009639wru.99.2021.12.20.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:57:27 -0800 (PST)
Message-Id: <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:57:23 +0000
Subject: [PATCH 3/4] config: add repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When adding config values to the worktree config, we might enable the
extensions.worktreeConfig setting and create the config.worktree file
for the first time. When the base repository is bare, this creates a
change of behavior for determining if the worktree is bare or not. A
worktree off of a bare repository is assumed to be non-bare when
extensions.worktreeConfig is disabled. When extensions.worktreeConfig is
enabled but config.worktree is empty, the worktree is considered bare
because the base repo's core.bare=true setting is used.

To avoid issues like this, create a helper that initializes all the
right settings in the correct order. A caller will be added in the next
change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 27 +++++++++++++++++++++++++++
 config.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/config.c b/config.c
index 9c9eef16018..67f3d5015ef 100644
--- a/config.c
+++ b/config.c
@@ -2880,6 +2880,33 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	int res;
+	const char *config_filename = repo_git_path(r, "config.worktree");
+
+	/*
+	 * Ensure that core.bare reflects the current worktree, since the
+	 * logic for is_bare_repository() changes if extensions.worktreeConfig
+	 * is disabled.
+	 */
+	if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
+							  r->worktree ? "false" : "true",
+							  NULL, 0))) {
+		error(_("unable to set core.bare setting in worktree config"));
+		return res;
+	}
+	if (upgrade_repository_format(r, 1) < 0)
+		return error(_("unable to upgrade repository format to enable worktreeConfig"));
+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		return res;
+	}
+
+	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
+}
+
 void git_config_set(const char *key, const char *value)
 {
 	repo_config_set(the_repository, key, value);
diff --git a/config.h b/config.h
index 5531fc018e3..d8db420849e 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,12 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/**
+ * Write a config value into the config.worktree file for the current
+ * worktree. This will initialize extensions.worktreeConfig if necessary.
+ */
+int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
-- 
gitgitgadget

