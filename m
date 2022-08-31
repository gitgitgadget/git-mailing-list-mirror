Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EEDECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiHaXTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiHaXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147149C8E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so20122520wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wk4NVQgjtyvUjYHUGzbVeAh7j96d89m1arHwjDBzi18=;
        b=BBGtflmZK3Q8Kiuhw0Teg36X+yhB4IYCAKwIJ+lRmyr/+3bkf6RdJi3ECdml5Or8qZ
         b5POaLdYjjuunQlbJNQTO6iru213t16jO3XwSgY681AAA7UmQe8o4cbfDwtdVjTw/s0e
         NMBO8Fv56MlnBXJdZ+7+xNlw0HhxTLcjkzznsYb3RNRmPWCIE1m6LlNarBeMZwrE2oTd
         qb/7xUlYaMljwobGHX8bTegCvaKi0T8M8eJSICZFvSVyURnxsbnIEtSOhhXs4TpDndl8
         73RW9f0/Nj3jBYia6/SeMUYRrDXwYsSdqoO45IL/h/Sn7WWQMyxeseTtiGkrC5+zM5I9
         +IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wk4NVQgjtyvUjYHUGzbVeAh7j96d89m1arHwjDBzi18=;
        b=WahWSEbG7A581BCmqhQCUYaRYB2Ty2klIJJSxpvpW2RjJZOD34IejQ+FKuG+IAy/PN
         hkIO+noR4IwMp5uuFRy7jYCCfK0TczvmSKxV0e/NXan0/0H2tp0PFrkI1BTnunjhO9jd
         4rv6LXNvlV5UJJ6X26I0nY+pHeQAkf6h/hTsDXUFAbIzPBoGZFOtVqF0AQDNePwhyrn3
         oJxRLQxtFgtd7MiLSf+u1L0McKKB8ErSbZkaH7WKrppkQGv/y7ZVtxsktYorS5fpgutz
         UHbUxdElpSJiaK24QqbsExuJ4tnmf5WcvvOttfW2zpROGgIOA0gxDlHqVkZ8VbnFVz1S
         4uOA==
X-Gm-Message-State: ACgBeo2Zvut+MPfrWKq9cseWhLDjF931/NCDt0O1LvolKNJPoDhnn9b0
        oAToZ5SwJVlRHJzfuvHqtMR86ndKLmunug==
X-Google-Smtp-Source: AA6agR6XySRvXE4nXMNxc2/KmJ/KXvzO0WOG8t7CMmIRxZ4uOOHJ1h4L+3b6zuN+Xs6X75VkferMGw==
X-Received: by 2002:a5d:48c5:0:b0:225:59cc:9b04 with SMTP id p5-20020a5d48c5000000b0022559cc9b04mr13144477wrs.338.1661987919534;
        Wed, 31 Aug 2022 16:18:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.38
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
Subject: [PATCH v4 24/33] submodule--helper: use "code" in run_update_command()
Date:   Thu,  1 Sep 2022 01:18:06 +0200
Message-Id: <patch-v4-24.33-77d21b570e3-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index 35989c81603..234f1f993e1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2130,7 +2130,6 @@ static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
-	int must_die_on_failure = 0;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2144,19 +2143,16 @@ static int run_update_command(const struct update_data *ud, int subforce)
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
@@ -2167,32 +2163,35 @@ static int run_update_command(const struct update_data *ud, int subforce)
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
2.37.3.1420.g76f8a3d556c

