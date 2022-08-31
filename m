Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCACECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiHaXT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiHaXSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEE9C8E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso413142wmc.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nQIz+mioS3ddGaOOQaZMYNsXzT4AlZA16+3TEwHqWF0=;
        b=n/yi4WUAMRzyVaBRBQR6wdRm1jXDK63XjkcAi96qEV9JMXAilEkzP8/cbRHuOAGMpW
         vs04gm4Q8wHyBdSV25rm5jfwXrU/zQMVLpaj41cXcI0tppHypgPBJ/23XVfpDDG1mX80
         Sq2bmwQv/jT0gLD1fT1yvgMILy5/DqDd/RIr9Mma1dJX10wi6iu9yj/XHju7RFtnBLlk
         PK4gM06inT5a1dzKIAeAbr0eJy2e9MbyaHhhIQdUb3lfa/vHzjVelPAisBKnttCha0WR
         HxNoQk1/AhBDCTYsd5CJch+nbZ7jqM0SsHmrGfibl4R+YZh4rHXpyun8lY1cFbVdQYmC
         P2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nQIz+mioS3ddGaOOQaZMYNsXzT4AlZA16+3TEwHqWF0=;
        b=TZDzv2VDIncHBG6W9mmihQr3WMjmxf5bgFfDaypTDFbqZsWaV2l3NoL/U2eCpmwtac
         bgQhBtH9nsq3uL7CIISt7U+SFqH8IFQHVscZAVHUPxX7ER4lpr53OVKVAXNXLndJWvSZ
         nPoIAG6HjG9JItrz1zIJ8uEzVmpHvm3I6B3IdB1EhHpXXVdKLkCw903Z5regq81MYoTV
         E+5rwDW5U5qih3H2ymFyujWP4zCKyyQbVHP6fTZ0PgCDZZRy505gfc5kOgAmEEB5NHoY
         +A7PKnIN8MYaUUVWx0vCTn3FmT0u41JuGeiWa52k4Cuf8TxoiOhkHWm8HkztS2AtkQVd
         f7bA==
X-Gm-Message-State: ACgBeo0pXWSLgrCzUOIqgdsasDZz2t8IhBQjCR6nCzPmHWgRzb3Wf0SV
        YlhcAMm33xMYlHw7vFMqd3B5uLeL89ug+w==
X-Google-Smtp-Source: AA6agR6lY9L669v5b38pyvI2xCFM+JVn29vX67ZI1111svGMu9LutTqQ+FTaW0fIgqpo6f5PNOxHHw==
X-Received: by 2002:a7b:ce05:0:b0:3a5:c069:25b3 with SMTP id m5-20020a7bce05000000b003a5c06925b3mr3313410wmc.87.1661987921298;
        Wed, 31 Aug 2022 16:18:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 26/33] submodule--helper: libify determine_submodule_update_strategy()
Date:   Thu,  1 Sep 2022 01:18:08 +0200
Message-Id: <patch-v4-26.33-512106bc6be-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Libify the determine_submodule_update_strategy() by having it invoke
die_message() rather than die(), and returning the code die_message()
returns on failure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 166c6aaccb2..2f78529736d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1733,24 +1733,27 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void determine_submodule_update_strategy(struct repository *r,
-						int just_cloned,
-						const char *path,
-						enum submodule_update_type update,
-						struct submodule_update_strategy *out)
+static int determine_submodule_update_strategy(struct repository *r,
+					       int just_cloned,
+					       const char *path,
+					       enum submodule_update_type update,
+					       struct submodule_update_strategy *out)
 {
 	const struct submodule *sub = submodule_from_path(r, null_oid(), path);
 	char *key;
 	const char *val;
+	int ret;
 
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
 		out->type = update;
 	} else if (!repo_config_get_string_tmp(r, key, &val)) {
-		if (parse_submodule_update_strategy(val, out) < 0)
-			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
-				val, path);
+		if (parse_submodule_update_strategy(val, out) < 0) {
+			ret = die_message(_("Invalid update mode '%s' configured for submodule path '%s'"),
+					  val, path);
+			goto cleanup;
+		}
 	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
 		if (sub->update_strategy.type == SM_UPDATE_COMMAND)
 			BUG("how did we read update = !command from .gitmodules?");
@@ -1765,7 +1768,10 @@ static void determine_submodule_update_strategy(struct repository *r,
 	     out->type == SM_UPDATE_NONE))
 		out->type = SM_UPDATE_CHECKOUT;
 
+	ret = 0;
+cleanup:
 	free(key);
+	return ret;
 }
 
 struct update_clone_data {
@@ -2391,14 +2397,22 @@ static void update_data_to_args(const struct update_data *update_data,
 static int update_submodule(struct update_data *update_data,
 			    int *must_die_on_failure)
 {
+	int ret;
+
 	ensure_core_worktree(update_data->sm_path);
 
 	update_data->displaypath = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
 
-	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
-					    update_data->sm_path, update_data->update_default,
-					    &update_data->update_strategy);
+	ret = determine_submodule_update_strategy(the_repository,
+						  update_data->just_cloned,
+						  update_data->sm_path,
+						  update_data->update_default,
+						  &update_data->update_strategy);
+	if (ret) {
+		*must_die_on_failure = 1;
+		return ret;
+	}
 
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
@@ -2426,8 +2440,6 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		int ret;
-
 		ret = run_update_procedure(update_data, must_die_on_failure);
 		if (*must_die_on_failure)
 			return ret;
@@ -2438,7 +2450,6 @@ static int update_submodule(struct update_data *update_data,
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
-- 
2.37.3.1420.g76f8a3d556c

