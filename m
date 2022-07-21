Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4415DC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiGUTPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiGUTOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE78E4E8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c22so1580310wmr.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0p78tp0cQ1nimRWu78Wr+IAzeR2L++QSAxatdTTwpc=;
        b=P8D6oangFH7cbsDNwDjbKyTBYjiciUWQlkCxn3eYwinsoP36VUF+rkbsLv6CXTHHr+
         EP9BL8PD8EGigfiIVUfx34L2xCecCvJ8di2kJMqKHxq/S/fWBK09XHA+dqJ/Cc04hM/w
         1/oUry9hM1v59dTsV9UavufgUaO6dIaMOvEmGPQS2dvJk95RPmkWjxpaTBAIOwiSBLF2
         CjPuLtokc2LOQqK8wn/svUDUSS4PVq217++7Gdkr/ItwDpEYTxVYYNs/Xb363mNdcRq8
         kRfJF9O9Vib1k7r0pSg9FJEWlrfKTIucpFYoIbeEYeTQpEXEOs++EHoHj7k+upbzFbzv
         BXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0p78tp0cQ1nimRWu78Wr+IAzeR2L++QSAxatdTTwpc=;
        b=WstDB3x1rO5SRiaBYPp/SnCPzBhXx1aSnz4JTJKw0ROy9wqBFqmuo5wMFSDxA32leN
         RSx3oGl5D4RwcPrV293hm1OISCspnJ2Y/0SasoIhowrBYiWwEcTBYcDEOkonzJ8tOhbD
         tNqj0GSEarsqripQ+cTNuHagh5JMWzudUGt2+8GNMnLC/aB0S2VOY52k7kcFUT8WYOsu
         wnusyR0VI8htQEFQDDEgvkbvBKxr0rkLMxprxIL3jj9qPsv3C6fc/6wqtY3r8IMPBDVU
         gH9eCbfiO9DlV7Toi4wTsNcYzYBONMnTeRbLXNyPCJkcDmmvUUjteo313gfeVOukiueF
         WQRw==
X-Gm-Message-State: AJIora8jzlxPglrBInY19+Rk5RxLmE9BtoY8rd88HWf6zON0Rl+FAyAP
        Zj62MtPAIKsOJxrAsTY5u0lJu3ZeHpcAQw==
X-Google-Smtp-Source: AGRyM1t7CmGLjnIoWcKBZnKj4l9QgZQPypMZlku8zJWAGFUTlAurBuuBXYh4rL+IUdheE2SRHnh6JA==
X-Received: by 2002:a1c:f719:0:b0:3a3:15d4:5752 with SMTP id v25-20020a1cf719000000b003a315d45752mr9780684wmh.194.1658430860746;
        Thu, 21 Jul 2022 12:14:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 23/26] submodule--helper: don't exit() on failure, return
Date:   Thu, 21 Jul 2022 21:13:19 +0200
Message-Id: <patch-v3-23.26-4c60784d281-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
call these routines as a library in the future, and to avoid leaking
memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 790f0ccb82e..b65665105e7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2283,7 +2283,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce,
+			      int *must_die_on_failurep)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2345,8 +2346,10 @@ static int run_update_command(struct update_data *ud, int subforce)
 			BUG("unexpected update strategy type: %s",
 			    submodule_strategy_to_string(&ud->update_strategy));
 		}
-		if (must_die_on_failure)
-			exit(128);
+		if (must_die_on_failure) {
+			*must_die_on_failurep = 1;
+			return 128;
+		}
 
 		/* the command failed, but update must continue */
 		return 1;
@@ -2380,7 +2383,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2407,7 +2411,7 @@ static int run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2543,7 +2547,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	int ret = 1;
 
@@ -2584,8 +2589,13 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		if (run_update_procedure(update_data))
+		ret = run_update_procedure(update_data, must_die_on_failure);
+		if (ret && *must_die_on_failure) {
+			goto cleanup;
+		} else if (ret) {
+			ret = 1;
 			goto cleanup;
+		}
 	}
 
 	if (update_data->recursive) {
@@ -2608,7 +2618,8 @@ static int update_submodule(struct update_data *update_data)
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
 		if (ret == 128) {
-			exit(ret);
+			*must_die_on_failure = 1;
+			goto cleanup;
 		} else if (ret) {
 			ret = 1;
 			goto cleanup;
@@ -2646,13 +2657,18 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
+		int code;
+		int must_die_on_failure = 0;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		if (update_submodule(update_data))
-			res = 1;
+		code = update_submodule(update_data, &must_die_on_failure);
+		if (code)
+			res = code;
+		if (must_die_on_failure)
+			goto cleanup;
 	}
 
 cleanup:
-- 
2.37.1.1095.g0bd6f54ba8a

