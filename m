Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A6ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiHaXTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiHaXSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120639F1B8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2391311wmk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pKB2GxjzCuPjNcbC+icEYbJm5RAPkXe+Q+iQKWq9cQ0=;
        b=G31kE3ZSHCtU9X15kiHW0r7/sj0cdgCHzYkEOy6h2Jbq2FtV99r0lJX+k3N9PGAYDm
         lbbCS6G0aMD3YMLCwBihczDPFh3wa4TTP9jNH/ThBro7wa6inDd/rl/6DlW5rT7NIUuf
         QZ1IOtm9zUi/NSwe27bV5kZ+Wz1iNLTvoutUXZNX1TLQrHOrG9DuNeHXhp6mIsKRETXC
         uqshqEmImCd2NRIQwQ16OCX4GerMCVX8TN1LW+fzdM5gIfceT11pDhTDhxXPOR6OD40X
         JteB/7z5pp4H2is25wXkBEesi96BYaG0A1uBbMBgYS760zVTc0U+72xYyfPTgT38/ktY
         IzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pKB2GxjzCuPjNcbC+icEYbJm5RAPkXe+Q+iQKWq9cQ0=;
        b=0eT/9ncYY5vPM6ad4A0HkCOAl66ImbuvABvok679OhFj9+GKENwJi4nwSfL/jmBF+8
         ORboZrkzoCt0LHsbnb8aX4rSViPUVC9Dh+eeAbJV0DOU+RdA5PIAoAqFmtRCcUz+r3l7
         cllZDmnT9sU3I3xx9DXQ+bslIyvJnboqvyhBR/60z8/JgeicASvQ9xmjDhzm27ZhvuyQ
         X69x/tw5Mqqpe4Baua6sLHkDdUwXDsJY+dHm/mdLE82HhvzKWvH7+xTVOzejdOWVxYwT
         tijOW/tI+wiZTzjjEpo0L16YecyAaTy14kxYme3PS9SOOvLGQ1FwlSGvFAO7zyYwarDM
         f3dA==
X-Gm-Message-State: ACgBeo3Z3LR/SJIQbAcbyRA2LfCtHXcLsij1XCbpvcyT0MKvJPUi82BC
        I2AeeNASXs4yY1f9r6mLu2n6zoyFNXZEKQ==
X-Google-Smtp-Source: AA6agR4nQawlV8vocaCOaFMVizsFU31XHxEJpyK8NtBcFTyZOPSlamZMczzVXN5MCcJPBAr0FhqbyQ==
X-Received: by 2002:a05:600c:3ac3:b0:3a5:e1de:5994 with SMTP id d3-20020a05600c3ac300b003a5e1de5994mr3353335wms.133.1661987920368;
        Wed, 31 Aug 2022 16:18:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 25/33] submodule--helper: don't exit() on failure, return
Date:   Thu,  1 Sep 2022 01:18:07 +0200
Message-Id: <patch-v4-25.33-99717171578-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index 234f1f993e1..166c6aaccb2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2126,7 +2126,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 	return run_command(&cp);
 }
 
-static int run_update_command(const struct update_data *ud, int subforce)
+static int run_update_command(const struct update_data *ud, int subforce,
+			      int *must_die_on_failure)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2190,7 +2191,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		}
 
 		if (ret == 128)
-			exit(ret);
+			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2222,7 +2223,8 @@ static int run_update_command(const struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(const struct update_data *ud)
+static int run_update_procedure(const struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2249,7 +2251,7 @@ static int run_update_procedure(const struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2386,7 +2388,8 @@ static void update_data_to_args(const struct update_data *update_data,
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	ensure_core_worktree(update_data->sm_path);
 
@@ -2422,9 +2425,15 @@ static int update_submodule(struct update_data *update_data)
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
@@ -2440,14 +2449,13 @@ static int update_submodule(struct update_data *update_data)
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
 
@@ -2480,12 +2488,19 @@ static int update_submodules(struct update_data *update_data)
 
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
2.37.3.1420.g76f8a3d556c

