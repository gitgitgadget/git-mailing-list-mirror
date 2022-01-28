Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D82AC433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiA1M46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiA1M4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26941C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ka4so15661057ejc.11
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CkVXVSLQjPNsyMtndkuFpOhvRKOg6s5ggD5msOvIso=;
        b=KY7hInCdoEnhMn+LeBtZo623ZUsBpr4yRyXevXrff0dXLdNuduPmxGS9GZZzi7F02w
         9tkF/lauKtgkh87J2xlCk256Qvyv3sLD7ys6agNvm+KNF+5zsaK0/iL/wbH0OxWPG9jb
         L7NjJmOS5ZCpoo7e788Gp6rZD90Sd22e+yaB3M99JEBgU6bs7jHYpgvcTWfOlr/VtGSB
         GGn8LvQDlH0CIVNi0NM+upgMM+lXdw28mUbV+KFWDvzjg5/2N7WEk+74au6UqSXdHWRI
         ImzmcCnTDrDqm8QUaAvtTNvxoUXVXY9Ssl5SgnkvYaiDX73a4qMaLLfizL56mXxmJBrZ
         rsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CkVXVSLQjPNsyMtndkuFpOhvRKOg6s5ggD5msOvIso=;
        b=iE2nnTSyWoTJt45Dqch3XCsdrZZ6rZp8dQbEWcge39X/ZbHEAY4dHJKBsnDEZsuibH
         9PvZZiP4Hhk9M3i/3pksCAvZklvkuyS88Lkm/foqSpX4YPTIeHAe7o036NOETjeENeWd
         3HKUaGbSJF321SIryLjmF8v68laKDE5l+1PhVrGkYu0LKz05rFoFcQRS5VTV32ZgKL+E
         JG19Uef0xqctIqU9a5bijTdPch2x6kbgDkRG74uQwAZ0LLLJSdZMWdp49dxmv7WrpSEG
         uMO/P3dS74TSEqd9Wed85W0Xelm/b8Dgr4HfP8boPT7cDhS+JSJb1du3skhTFYubuthE
         PhLA==
X-Gm-Message-State: AOAM530bEHqdCiCruj0gLjOy7eGogBRAQlKjAYslONrcUUl53fAe8biJ
        gBED2V8Dji5HaAo9SMoQZATkag6jC7LpxA==
X-Google-Smtp-Source: ABdhPJyrMWfyeTYczCvOrW+6ugX2QdkYJm3Qgt6B/6POrw9BeF5u4iiUtTSAWnntKkO3feTWQKTnLA==
X-Received: by 2002:a17:907:9807:: with SMTP id ji7mr7016183ejc.194.1643374610510;
        Fri, 28 Jan 2022 04:56:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/9] submodule--helper: run update using child process struct
Date:   Fri, 28 Jan 2022 13:56:35 +0100
Message-Id: <patch-v5-4.9-e1df2dd4457-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We switch to using the run-command API function that takes a
'struct child process', since we are using a lot of the options. This
will also make it simple to switch over to using 'capture_command()'
when we start handling the output of the command completely in C.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 09cda67c1ea..db71e6f4ec8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2344,47 +2344,45 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 static int run_update_command(struct update_data *ud, int subforce)
 {
-	struct strvec args = STRVEC_INIT;
-	struct strvec child_env = STRVEC_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
-	int git_cmd;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd = 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd = 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd = 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd = 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.use_shell = 1;
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
 
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
-				     ud->sm_path, child_env.v)) {
+	cp.dir = xstrdup(ud->sm_path);
+	prepare_submodule_repo_env(&cp.env_array);
+	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-- 
2.35.0.914.ge5c8aab0d5b

