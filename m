Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E017C3F6B0
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiHUOAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiHUN7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D25237E2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6447618wmc.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oWT9DEINhZAfPDN3z0lfujcDdOyfgNIqg/Mmmbh/ZSk=;
        b=pEYAcPpxvAgUWx7weeNXkNx1gAT8esX3tWwlYS0Ua/u04LgDtfPiPcKa+QQFodvXGu
         uuCc49Mw8xElpjo2Pv658MCIIifx2tzcL431V1qxSsG0F0eTvDbhDREYoWcXGC4S8iCk
         og/quT3CWKtwOOZoAcFzPYgFAWAAfirKcwLYT0+/obVBoKtDVeId0q5UCvUjLQNZDS0q
         kWJk6Vn0oit6i3GxDpAR3JBrj3gRqPr6TlanvkIB4zVYD3A025OX0ICFU8OF60A9i5NO
         Vx6Q2HaP/Vyzjhx34I4voCYT81wc/szDAPCcW/wgiy1q709pZkpxMsycspujt2Bz/aX/
         NJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oWT9DEINhZAfPDN3z0lfujcDdOyfgNIqg/Mmmbh/ZSk=;
        b=X2oib3SPDOAe5Y+knRlmaSP6rnSxNRcKUU85h/VjbbUccCh0XwGdugF34jVChTWFGQ
         wDtKBZOKJdq1YDg5YCtrP7Rbn55Z/uGLkeDbuv040YFCHXpg4fiQMXhlqri6BB/CG5jK
         v1v0uifL8dF6IsN1IIhGF0W1cs9BH4tUyVqlgZxEg2N7xeuJSyJ8CiuyjVXKhiG6YG2X
         oXMcKTARGyGQmDNhjf12vUvO0HihVEAIb6CPcIiZ0bMZ3Sqw0rNt4ncITH+3VYfAd6xO
         2Cc7f8ILBxZgLWhe9kuF2eq1Fn8SwL3VX+P9I7CLtPw28AzDbWf8SwUW7UiV5XULueUF
         8YAg==
X-Gm-Message-State: ACgBeo1GMZOL+LGZgrPE1X5ZSUCff8+RanSY86gLYsCWh/idPXcabMv5
        YFPOH49Ws43vH3pEQtbBxChlA1sxxb1KL7ep
X-Google-Smtp-Source: AA6agR50vrht3lyiUCGXZIenG5/ft9Bfo6CLhS3bQcgIbHJb462amb7WEmyy0ilUU1Wig3ixWEzlig==
X-Received: by 2002:a05:600c:1ca5:b0:3a6:c8d:f2f9 with SMTP id k37-20020a05600c1ca500b003a60c8df2f9mr12951172wms.54.1661090330277;
        Sun, 21 Aug 2022 06:58:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/32] submodule--helper: don't exit() on failure, return
Date:   Sun, 21 Aug 2022 15:57:33 +0200
Message-Id: <patch-v3-24.32-6d56f671c7a-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code downstream of module_update() to short-circuit and return
to the top-level on failure, rather than calling exit().

To do so we need to diligently check whether we "must_die_on_failure",
which is a pattern started in c51f8f94e5b (submodule--helper: run
update procedures from C, 2021-08-24), but which hadn't been completed
to the point where we could avoid calling exit() here.

This introduces no functional changes, but makes it easier to both
call these routines as a library in the future, and to eventually
avoid leaking memory.

This and similar control flow in submodule--helper.c could be made
simpler by properly "libifying" it, i.e. to have it consistently
return -1 on failures, and to early return on any non-success.

But let's leave that larger project for now, and (mostly) emulate what
were doing with the "exit(128)" before this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 44b08a01c54..84e5e3beeb5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2125,7 +2125,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce,
+			      int *must_die_on_failure)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2189,7 +2190,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 		}
 
 		if (ret == 128)
-			exit(ret);
+			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2221,7 +2222,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2248,7 +2250,7 @@ static int run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2384,7 +2386,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	ensure_core_worktree(update_data->sm_path);
 
@@ -2420,9 +2423,15 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (run_update_procedure(update_data))
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
+		int ret;
+
+		ret = run_update_procedure(update_data, must_die_on_failure);
+		if (*must_die_on_failure)
+			return ret;
+		if (ret)
 			return 1;
+	}
 
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -2438,14 +2447,13 @@ static int update_submodule(struct update_data *update_data)
 		prepare_submodule_repo_env(&cp.env);
 		update_data_to_args(&next, &cp.args);
 
-		/* die() if child process die()'d */
 		ret = run_command(&cp);
 		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
 		if (ret == 128)
-			exit(ret);
+			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2478,12 +2486,19 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
+		int must_die_on_failure = 0;
+		int code;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		if (update_submodule(update_data))
+		code = update_submodule(update_data, &must_die_on_failure);
+		if (code)
+			ret = code;
+		if (must_die_on_failure)
+			goto cleanup;
+		else if (code)
 			ret = 1;
 	}
 
-- 
2.37.2.1279.g64dec4e13cf

