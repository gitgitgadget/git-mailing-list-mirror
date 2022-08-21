Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7D6C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHUOAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiHUN7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32741237EB
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e20so9799182wri.13
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=suheVDeLx9/bnptyH6p1jGjr0U0Myr2tQZ/ivfgdCP0=;
        b=GvEWwisH4Fl/lMX7onILdgLTdlVygFJp/2Rtku3cWJB5ozP8OCGH63yD3qkRpZyggK
         57rKcoq707VILQyFp9brPPGSKoQI81kPDKNHX2O3bQgF6BOAGJu82J2SVZwWLUfguKr7
         tYIJukxMr9lt5hsaBRlfmy6zEU+OhrIyUqFFw8BpgG4FL1w9RtZ3Tsdmce6FSdgW4/PD
         Iea9m1d7lLt9c/Ud0lDB6Wx591X6mHmAS6AgPphpIjhp85p9WvvX9zCyeFQXm81yRJXB
         xEhlG0vl3X/DZRy1BNiDjLknHmi+jtzaBcCSFS0GluJzE3NLY9IFoG5R4Ujn9a8kOyYh
         M4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=suheVDeLx9/bnptyH6p1jGjr0U0Myr2tQZ/ivfgdCP0=;
        b=CFtNkzMABHLXlpXtVjDy0oJtlsgQoNB6ieCBzR4JvhUlH2jsLM8KgCUDmwAxNtFiUE
         BQcojlKax6qzAySQUMBOy2680YcME4PHNuygn3bjZOTGtDRShXk0NO0xVGx3IRsKW0Qu
         rt6X9ZoTlSpb4HZp+ZzChzJSIif6lxDJBa/KA9QAcxLGYqBfnrvVA8D+k/jG7m5aij9F
         MwPOZDlERXH1jAh81Ju4PiH0/DsNF6SWyPgC9GAy9MznKePqhLqajpAm9rky+ncQKHCf
         YC3F076dAOkLfp/nlAGxVUfjcPuIJYnhCdJXDYo8c9rqtt8e4ofhCJ0ECz0/JMudfn2d
         +zLQ==
X-Gm-Message-State: ACgBeo0cZYiVJZaNDXVqCLcHcN2xSOQOl/g3Upjbxa9aiCP2CDDoccoA
        DEpTRZ3xiGGtV5OitGdLr189XgFSrnizS+T6
X-Google-Smtp-Source: AA6agR6LkkBmkV7jOAHR110q7XcEPdaoMaNaojDXmsGFmkbSaGvv8pbT5lFMLY8Q0+AH//vzwbyuxg==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id t14-20020adfeb8e000000b00223a1f626b2mr8680894wrn.216.1661090331399;
        Sun, 21 Aug 2022 06:58:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 25/32] submodule--helper: libify determine_submodule_update_strategy()
Date:   Sun, 21 Aug 2022 15:57:34 +0200
Message-Id: <patch-v3-25.32-dfd5c8bcd61-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index 84e5e3beeb5..4d102f2b32e 100644
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
@@ -2389,14 +2395,22 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
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
@@ -2424,8 +2438,6 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		int ret;
-
 		ret = run_update_procedure(update_data, must_die_on_failure);
 		if (*must_die_on_failure)
 			return ret;
@@ -2436,7 +2448,6 @@ static int update_submodule(struct update_data *update_data,
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
-- 
2.37.2.1279.g64dec4e13cf

