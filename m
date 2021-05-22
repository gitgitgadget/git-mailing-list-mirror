Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91AFC2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F0261244
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhEVN6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhEVN6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1CC06138C
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b7so11957184wmh.5
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+6vypO9YNjV56bGEeDxuv/2CtEcB8b9KfQqp5m+Aabk=;
        b=RBCzG4u80jlFFFDiohN+tkbBOp0jVaY5dG2IrnR4P8UIxy+ML+UvdAqBmF+2R6++BU
         NTzOqsuvt/YoRpekHS6RrUEQ/e80v5LkPtpJSqUsO6vz5MvzYhjyGFGCyvSjSaCqHsHJ
         Pp0sbEilnaDhKFDcED6ulxOVxZgaHeAdg2q63tlC+MmFGfLB9vAV4Ohxl5AY1u5vIAL5
         lzCCfW/uxIuMB5QRw7PRnxoHWVSeOFsDTkKn7ndRrB8Z86aS0AIAQZsClX5UU77mPiAU
         lqUdVWbTT2QzF/gJzEihnXXnNIgT1AZxdrIPlSUOq1lZtuD8WfgDjQx0VtFt2T8GDwk8
         3HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+6vypO9YNjV56bGEeDxuv/2CtEcB8b9KfQqp5m+Aabk=;
        b=eCs07GRyizTbNGf99wKpKnQjAtHPgPVECWJgnkXuu5ncoq5+9OzYybXGe4jCzCosDj
         oaHeK5JkdxTKEB/TcgGiS3TPogqO+cosFC+096xbTmkwW+wEobZhMA1nL01ebCx3x6c9
         +CXqt9PEuCvq/s4N0rfUJsM8Fsv5aqHR9xdOS8XV0J2tJFEo7HjP85z0GY9yvMYONLt9
         70R1H8ifZxbE9hPlzJ91a8Dh/Gl0NdLKZxIso/pvuWl034T0QGQLf1cn92oCJBfsxNkV
         cul2xkgYJZqs19LqdmXrqinAIcQS8w8XPsMBbLExdpQLvGb9WhtlGxPT4wuJaSxs5tTU
         450Q==
X-Gm-Message-State: AOAM533v+vy5nkEMy2E78+N5Sn0PnownGa6EepHb8VioDWrYquJ1yw6O
        aqo2SLqC7IjKO8ObuWZU4VNJpwpkeNQ=
X-Google-Smtp-Source: ABdhPJw4MsbnOEMQv65E0mYkz+WZMibOAqwUvi+8/t8O2WfLTuwOTurffQthh/wK7FFjQkUvP4USsg==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr13730418wmn.82.1621691834447;
        Sat, 22 May 2021 06:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm5596618wrp.46.2021.05.22.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:14 -0700 (PDT)
Message-Id: <67bcf57f5948038a86c7aa99a6f56655a33eb045.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:45 +0000
Subject: [PATCH v2 06/28] config: FSMonitor is repository-specific
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit refactors `git_config_get_fsmonitor()` into the `repo_*()`
form that takes a parameter `struct repository *r`.

That change prepares for the upcoming `core.useBuiltinFSMonitor` flag which
will be stored in the `repo_settings` struct.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/update-index.c | 4 ++--
 config.c               | 4 ++--
 config.h               | 2 +-
 fsmonitor.c            | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4b..84793df8b2b6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1214,14 +1214,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fsmonitor > 0) {
-		if (git_config_get_fsmonitor() == 0)
+		if (repo_config_get_fsmonitor(r) == 0)
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
 				"enable fsmonitor"));
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
-		if (git_config_get_fsmonitor() == 1)
+		if (repo_config_get_fsmonitor(r) == 1)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
diff --git a/config.c b/config.c
index 870d9534defc..a896f44cba1f 100644
--- a/config.c
+++ b/config.c
@@ -2499,9 +2499,9 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
-int git_config_get_fsmonitor(void)
+int repo_config_get_fsmonitor(struct repository *r)
 {
-	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
+	if (repo_config_get_pathname(r, "core.fsmonitor", &core_fsmonitor))
 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
 
 	if (core_fsmonitor && !*core_fsmonitor)
diff --git a/config.h b/config.h
index 19a9adbaa9a3..3139de81d986 100644
--- a/config.h
+++ b/config.h
@@ -607,7 +607,7 @@ int git_config_get_index_threads(int *dest);
 int git_config_get_untracked_cache(void);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
-int git_config_get_fsmonitor(void);
+int repo_config_get_fsmonitor(struct repository *r);
 
 /* This dies if the configured or default date is in the future */
 int git_config_get_expiry(const char *key, const char **output);
diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34e..9c9b2abc9414 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -411,7 +411,7 @@ void remove_fsmonitor(struct index_state *istate)
 void tweak_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
-	int fsmonitor_enabled = git_config_get_fsmonitor();
+	int fsmonitor_enabled = repo_config_get_fsmonitor(istate->repo ? istate->repo : the_repository);
 
 	if (istate->fsmonitor_dirty) {
 		if (fsmonitor_enabled) {
-- 
gitgitgadget

