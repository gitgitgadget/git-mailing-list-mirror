Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4999C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiHBPr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiHBPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23531392
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l4so18419753wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6ekCGJPlnfLqEjjNw/aTmw3KqnQZ3f7Cv+piTlnlEP0=;
        b=l2I3ufKKmb9QcEbOgRfPmQEtwOjgJGjYRr99PfOdyHMYGsnZHXcYVRz1Kia0SKWuKm
         gvhFNDRfOlCu4brPjkp0wyriggZqjeWnpIkX29izUhqOmjTwHmy9XiqFAMypEW6erK5T
         FQINw+aPfR+IxtQjloiRe66rCVjIDXvj8Llss2tSNz/t+wwmQy37Zdt0q6rrnH7R2thA
         R6Gqw5WAZw3V/p/41XCfd9JPrW7V3Kp2zdjDpmEEjULl9DpH+KM76ujAawle/OTJO5DD
         btBgvRlH2+HgtaVjqAmw307IlwegJm8r8xONO0A1K3MLc+caxLhFbkPtz0xQIWG8DIJP
         4PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6ekCGJPlnfLqEjjNw/aTmw3KqnQZ3f7Cv+piTlnlEP0=;
        b=3D+GHr8XS1SIBPVqX1UV0w3d0X7LBCQTg3EBRz9AyxpP84YB9tcWd7iU24R05J6AGI
         G6hVuWbi2xBgvNMgV/b910112G4sL5WhAdoWmxY987AvI9ezcWAg3WQUo9VrR+QuqOxX
         Xo2XtWAsspNGvwcwJAerE+wFUeculgzOeNr9hvyHeajUkhw4Xx6uayKO1+IVKJIiOAcB
         v+m7QaH8SgIiIqXuiaoi8w+oHduUqHHDc0AmfUVlSLl8xRlLpLXVLA4PIJCgMUqMC9KX
         VBvIbBkbzeux8Fz8pB8+CLGhLzYryiJWUBNpXdVLcdFjDOUDB1QfE//qIVSEy+mm+Wgj
         5jyg==
X-Gm-Message-State: ACgBeo1rnFjabqxNLGGhvCnN5KCc8YXVDi4hwCZOre6UoOj/8kf7VGlG
        r+7I3Og4yXBwevXhe3TMwvKsptpGRWDThw==
X-Google-Smtp-Source: AA6agR5ke7e6QP0+4m2JwuuydfdPFxnqLrs77i79/141cT6pz9yBAX6fuvwukrWXxgXeLQua8gZ/mA==
X-Received: by 2002:adf:fe0d:0:b0:220:5df9:e5cf with SMTP id n13-20020adffe0d000000b002205df9e5cfmr8788240wrr.332.1659455199594;
        Tue, 02 Aug 2022 08:46:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/28] submodule--helper: use "code" in run_update_command()
Date:   Tue,  2 Aug 2022 17:46:07 +0200
Message-Id: <patch-v2-23.28-db2d2fb5a21-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index d787c0fead4..bac45e2bab7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2145,7 +2145,6 @@ static int run_update_command(struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
-	int must_die_on_failure = 0;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2159,19 +2158,16 @@ static int run_update_command(struct update_data *ud, int subforce)
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
@@ -2182,32 +2178,35 @@ static int run_update_command(struct update_data *ud, int subforce)
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
2.37.1.1233.ge8b09efaedc

