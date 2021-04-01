Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E10C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B06D60551
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhDASWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbhDASNz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAAFC0225B9
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so2273658wrn.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y2ml9Lzj9xQznH9AZ+zVhuRkUtNwq1khjP+NPlMkncA=;
        b=XoQgyQIeMosi0Lja/PgYdjvKemiftIOIxqRTblP2nCGoRQsWjpY6V/3PMSPwA79W/o
         40c6jAj7s/ekbhI/zn7Us/B4pe8ulIChI1KQi0Fm1ANdLnZRivznC9kpXlI9sasaCEC+
         lvSu4MHzCh8NoVH8ehwKHC87ZwlwCDLxN1vVeVYV9CYpnFQH24dde9+cB+Cf7QJYPF80
         1+T9spTRRb/wymHn1VqYLw0TkAMAaGcyXGP4bZSYfIZiIulBQDzp3QlsHXWloMQhMGgI
         PETBoremLx4OSOxgXBZ3UN98Nzu0lcoBm33AjLTEKhoWgTzn3V1X6zPfODP1DsIn3iHe
         wUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y2ml9Lzj9xQznH9AZ+zVhuRkUtNwq1khjP+NPlMkncA=;
        b=rozU3gBeljvjyhlkgT4rnbzUQnRRNP4TGsOilfISAjR4mi1J9NHwHRkyoMyJukPIAX
         WI3l/Fj+CZk1w/L5PTSrNoi5QuMGMmk0bWpzEcBxfaG/BGc8EjYI1EVkrBpDRLwY4E8O
         ZHHO00/uxsdr5+hahkhWGzO55zGF/iP+48nwgLK5bsNDOnjSI8sLg54/Hl/SKr1DIJMT
         xc2R42tUvSF7iNPV2rDl6HeZXt8/8Mkci7kuaTqCUjx+CkiMWYsZQ7o4fRxcDLc4CskO
         ohQzXp03Kfu7qOeBZL/YOYmDjKFOaavHkgQKfe/zqmN//dd4zmepcFtbvVUiRc5ujynI
         //vA==
X-Gm-Message-State: AOAM531SFv6VDIsttMIeiYj2OYeL1AmhyDay5kgRAHlhk+Qbm3+16AuZ
        C/siyxuroSx42yQrP1sqarjdP8wGWNc=
X-Google-Smtp-Source: ABdhPJw4UYUdoozRV6fCV01s03ZKXH4Et7e9QthE8zCBfN2rWq6VTXeVSysCI2Vfq6NlY6j0ym32wQ==
X-Received: by 2002:a05:6000:221:: with SMTP id l1mr10437688wrz.370.1617291669964;
        Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u63sm9016862wmg.24.2021.04.01.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
Message-Id: <18c125ec73dc9c23725d7c4688fdc1e753e14780.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:45 +0000
Subject: [PATCH 03/23] config: FSMonitor is repository-specific
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit refactors `git_config_get_fsmonitor()` into the `repo_*()`
form that takes a parameter `struct repository *r`.

That change prepares for the upcoming `core.useFSMonitorDaemon` flag which
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
index 6428393a4143..955ff4f9461d 100644
--- a/config.c
+++ b/config.c
@@ -2513,9 +2513,9 @@ int git_config_get_max_percent_split_change(void)
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

