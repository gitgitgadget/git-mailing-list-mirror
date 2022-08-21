Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90812C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiHUN75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiHUN7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9A237E1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq11so3713088wrb.12
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TE5sRvZLSD0CeQucb1GNMKqkll0IslG4KOS3GpgN1Kk=;
        b=BcGLrS/1xUq29pv9qyG5g0pvwh2a6BEAmqQXZLggy95KU+UJb9n4COzvUIJNXG+rzR
         BdDAMMTN/YjKX0op7Zlh66bmAkwIGhQ73szb/BKOfyfOyfn4t17fdoQvZl6NSCCeUs0K
         LyYK+8eN99QowCUf4p/evL9+ob5BU3ManUsAOV9xbK1A5nZT6vlWlrDsObWe1jc3l262
         XBsukgxBCtBmsoFpSm1UITFg5SJPi9ZJguEEaxJvCbCGEmIqRwQvHOzEWcrl4tO4Jvvm
         Lib8FeIwrg2gR6voVmwwB1OeZouIt5mVmObvOLtmlxGKNzua4GK0OO0QLKYFy2l/Fcc0
         uUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TE5sRvZLSD0CeQucb1GNMKqkll0IslG4KOS3GpgN1Kk=;
        b=SCfPJtrmvurNreJTGXEd4efcjdi3o0TCQ5IMPlMHd/58sHu+FO/+Twu+ucI/GvcGX1
         6L3Qo1333GIFoCpmyO3rIQqV6PjS5cZZh2mgxwSnk2eEgjq4WfokKHoKeDXWvonhbdrj
         YEDCJIz0RvwgTJH0170iznfaoXizcI62kZAZnX0kJu2dth7x+RYVMNoMCCGAj/hQUgpt
         /9KbgiQiWWzku6CoWxpyJiJktinOdn9YU115SAKq7lW7L/VUTD80+dzQTpTg6HO/FNsc
         1WkgZfRsXIynhWXwv1UmLH+GrZ5zFesSjp04H39FtoP2NADgCoSYCKvEg7+QGeGT23mY
         HVqg==
X-Gm-Message-State: ACgBeo15K++CDucrjBob+wabNDQdNk8aJe0YQ9iOGbyjIn8VuJzhTKD0
        67aWsdu1Do/YCnJqX9rA1I2j2pJDRMKTtJvw
X-Google-Smtp-Source: AA6agR5U7AILBHOA4bH35Ue/Qdq4I2H4D7i5ZvpBi2T/VCEcaLP8AjtJWmA9JxeN8gzmyjFcX8BAQg==
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id i11-20020a0560001acb00b002235de3f8bfmr8503392wry.691.1661090329229;
        Sun, 21 Aug 2022 06:58:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 23/32] submodule--helper: use "code" in run_update_command()
Date:   Sun, 21 Aug 2022 15:57:32 +0200
Message-Id: <patch-v3-23.32-6cac6cb2fa6-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply some DRY principles in run_update_command() and don't have two
"switch" statements over "ud->update_strategy.type" determine the same
thing.

First we were setting "must_die_on_failure = 1" in all cases except
"SM_UPDATE_CHECKOUT" (and we'd BUG(...) out on the rest). This code
was added in c51f8f94e5b (submodule--helper: run update procedures
from C, 2021-08-24).

Then we'd duplicate same "switch" logic when we were using the
"must_die_on_failure" variable.

Let's instead have the "case" branches in that inner "switch"
determine whether or not the "update must continue" by picking an exit
code.

This also mostly avoids hardcoding the "128" exit code, instead we can
make use of the return value of the die_message() function, which
we've been calling here since 55b3f12cb54 (submodule update: use
die_message(), 2022-03-15). We're still hardcoding it to determine if
we "exit()", but subsequent commit(s) will address that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c83b0897740..44b08a01c54 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2129,7 +2129,6 @@ static int run_update_command(struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
-	int must_die_on_failure = 0;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2143,19 +2142,16 @@ static int run_update_command(struct update_data *ud, int subforce)
 		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
 			strvec_push(&cp.args, "--quiet");
-		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_MERGE:
 		cp.git_cmd = 1;
 		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
 			strvec_push(&cp.args, "--quiet");
-		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_COMMAND:
 		cp.use_shell = 1;
 		strvec_push(&cp.args, ud->update_strategy.command);
-		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %d",
@@ -2166,32 +2162,35 @@ static int run_update_command(struct update_data *ud, int subforce)
 	cp.dir = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
+		int ret;
+
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
 				    oid, ud->displaypath);
+			/* the command failed, but update must continue */
+			ret = 1;
 			break;
 		case SM_UPDATE_REBASE:
-			die_message(_("Unable to rebase '%s' in submodule path '%s'"),
-			    oid, ud->displaypath);
+			ret = die_message(_("Unable to rebase '%s' in submodule path '%s'"),
+					  oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			die_message(_("Unable to merge '%s' in submodule path '%s'"),
-			    oid, ud->displaypath);
+			ret = die_message(_("Unable to merge '%s' in submodule path '%s'"),
+					  oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
-			    ud->update_strategy.command, oid, ud->displaypath);
+			ret = die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
+					  ud->update_strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %d",
 			    ud->update_strategy.type);
 		}
-		if (must_die_on_failure)
-			exit(128);
 
-		/* the command failed, but update must continue */
-		return 1;
+		if (ret == 128)
+			exit(ret);
+		return ret;
 	}
 
 	if (ud->quiet)
-- 
2.37.2.1279.g64dec4e13cf

