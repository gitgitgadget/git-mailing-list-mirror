Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F07C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiHBPr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiHBPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44D33435
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z16so18345809wrh.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KEjszNGS9OWPs/ST/nKsVRAPxWIreiSqpXI+cVdY4/o=;
        b=DwPe+V78xEo8MUOZDPxOLtLsIV3FGt5UCq2CnA3sgAbcsiVviUMceY9ElS74zGR/lB
         WE3ZohoG76FM25LYWs/Kul/IX9ia9zOof91UefnGiivCmlU1VgroKniEFBd9NowSrnLI
         nnftwtD0mI9tRUiAbGblP3q/HYoshq5MlSZNfjopyoDioUzef3hQK5Lum/A1uWAh6hgo
         Ia9lltSlO0FhpDkptyOgWKBUQJ0/qAvuqv20D5EGsOrYf4GuCuVuGuQsaCKXnMOCsIcZ
         1y9UU2KFwkMYsqhIR8UbOvq8TzpRl3W70xJnhRzFC+jxruLNXFAf/AuWWBNA3PTlxq9L
         OnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KEjszNGS9OWPs/ST/nKsVRAPxWIreiSqpXI+cVdY4/o=;
        b=PUDv/YnaSff/xZoIs2hRQxcTmtuWA10sd2acaWWiz+1UdpEKeLAUJ29cep4XS6AO2O
         glD5Mp2ykjTBsX7STBsyTHda2xT0THWsOgNiRy+m3S+9rtTV2wUHFTa3BdCsaVTIb6d/
         yb6fBblH4CIRs+G0ms/DTS7r4qj5/ZwxLJkhYU+iBXJ81eWqjRjeDMo0jgoeeRg/qpDx
         PivUNeUbPoGHdeQAJ/DziqosO2cwBE6HucIh0OeVQykb8mbmaZwDFeEhoe/8fOjohR66
         W4vPHreFjISnT2uc9LrgW+HdalMxBPrhNESMrJKZsQ8gr67vkwMEcKF/tCmdVU/M5M8U
         CeZA==
X-Gm-Message-State: ACgBeo0mS8xTb/CyVEP0Zi4wyOCptUZy6OlWl3e7MnyP0lQQLf/lyDaV
        leIZmMgUP90pgHd0uz5beOBkShl+ynHnIQ==
X-Google-Smtp-Source: AA6agR4O+23o4HWgMTeczMdJRjokf78Aul7D6eyaUImzrzjnQloM4iQFHRh+80F7cCPBzWiultV2/g==
X-Received: by 2002:a5d:514f:0:b0:220:6b4d:f806 with SMTP id u15-20020a5d514f000000b002206b4df806mr4439729wrt.137.1659455202883;
        Tue, 02 Aug 2022 08:46:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 26/28] submodule--helper: libify "must_die_on_failure" code paths
Date:   Tue,  2 Aug 2022 17:46:10 +0200
Message-Id: <patch-v2-26.28-b48705c6cc0-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the codepaths around update_submodules() were
changed from using exit() or die() to ferrying up a
"must_die_on_failure" in the cases where we'd exit(), and in most
cases where we'd die().

We needed to do this this to ensure that we'd early exit or otherwise
abort the update_submodules() processing before it was completed.

Now that those preceding changes have shown that we've converted those
paths, we can remove the remaining "ret == 128" special-cases, leaving
the only such special-case in update_submodules(). I.e. we now know
after having gone through the various codepaths that we were only
returning 128 if we meant to early abort.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2b78fa7573f..79a11992d1c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2147,8 +2147,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce,
-			      int *must_die_on_failure)
+static int run_update_command(struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2211,8 +2210,6 @@ static int run_update_command(struct update_data *ud, int subforce,
 			    ud->update_strategy.type);
 		}
 
-		if (ret == 128)
-			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2244,8 +2241,7 @@ static int run_update_command(struct update_data *ud, int subforce,
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud,
-				int *must_die_on_failure)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2272,7 +2268,7 @@ static int run_update_procedure(struct update_data *ud,
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce, must_die_on_failure);
+	return run_update_command(ud, subforce);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2408,8 +2404,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data,
-			    int *must_die_on_failure)
+static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
@@ -2454,11 +2449,9 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		ret = run_update_procedure(update_data, must_die_on_failure);
-		if (*must_die_on_failure)
-			return ret;
+		ret = run_update_procedure(update_data);
 		if (ret)
-			return 1;
+			return ret;
 	}
 
 	if (update_data->recursive) {
@@ -2476,12 +2469,9 @@ static int update_submodule(struct update_data *update_data,
 
 		/* die() if child process die()'d */
 		ret = run_command(&cp);
-		if (!ret)
-			return 0;
-		die_message(_("Failed to recurse into submodule path '%s'"),
-			    update_data->displaypath);
-		if (ret == 128)
-			*must_die_on_failure = 1;
+		if (ret)
+			die_message(_("Failed to recurse into submodule path '%s'"),
+				    update_data->displaypath);
 		return ret;
 	}
 
@@ -2514,17 +2504,16 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
-		int must_die_on_failure = 0;
 		int code;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		code = update_submodule(update_data, &must_die_on_failure);
+		code = update_submodule(update_data);
 		if (code)
 			ret = code;
-		if (must_die_on_failure)
+		if (code == 128)
 			goto cleanup;
 		else if (code)
 			ret = 1;
-- 
2.37.1.1233.ge8b09efaedc

