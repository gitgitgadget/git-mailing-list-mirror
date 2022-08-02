Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5AC3F6B0
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHBPrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiHBPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C6B3191E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so18404849wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KXhhF4qINHNwlyi3FmSPqa0snY6eaOWZqFNUgRAHoMo=;
        b=LTKZLpOfwbwiinbqSiFbcmGH0MGrTRsWj8+5FqEFu4wbubOTD4vQt6oR4nWlyIEtZO
         nhT1p0SMEDmIW0bVYEog4x502IsF/DqKZkXbm+AC26Jmx/T/phTEJOi28KPSGRHjsQTW
         geKOoNH5vgAaFL1n8qd4vNDh9mdRWJlVlYC2KAyarMJsuCVrJBmw/1OEOT0hsqxC3i5+
         cJEyd2imDra9bsuzs5qWKy+TKtIGdjKo4Yr9ENGAs1VcvXPZ7OWdGzN+12rpqb+B7T2f
         Bpcg5TEa1hHF0Wf8RBQl90KFekcbp2BaN6qgda9pXnZ1/rWlMg+VZa2xUeswyhhKECpX
         7Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KXhhF4qINHNwlyi3FmSPqa0snY6eaOWZqFNUgRAHoMo=;
        b=oCazAgUeP21DcfBJ2IO4LD2GxD3pkk0Nhx7r2J0yzB/TrqV6w2edQOEKDNBI14msil
         DP3jzlCY/hOc+goY+Yom1kW3od1zqP2TcDKT0sjQbBstedUr7vt1gmrLkm+sA9u6PVck
         jqFNw87IKpK/3wWW6+E9Z46mn1r3eqW1xpHYNHUw4bqhnB+/7gHXpf76B86GumA6aSQ+
         8dkxfpGlUGNiZNGiqDzIH1UIw4c08r1jyGojYhb9XxqWWhNpGCiFROjhAeKxpZ1EGa19
         Yhp6n4Twkgmm/snuJz2bR0lzLhBS8TMR9fvnrYYRvL69OYwI2qVk1HPHFhWXSSrQAT/5
         W5Jg==
X-Gm-Message-State: ACgBeo2JL4Pi39lPT+9smpISsQiOh9pwwQqKirpf29CXNudfEiOVKEkl
        KY3P6JymvLNhhx5+lT8bR4xkzrahqrQ+aQ==
X-Google-Smtp-Source: AA6agR5CRIv7R/C6MJtL7CKwk5nybP8+2IcUOkLYHdlMZigr6fOYM4h8UqDEjJjgaHzIrf65QJsPwg==
X-Received: by 2002:a5d:4ad2:0:b0:21f:af5:8dc7 with SMTP id y18-20020a5d4ad2000000b0021f0af58dc7mr13909289wrs.575.1659455202014;
        Tue, 02 Aug 2022 08:46:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 25/28] submodule--helper: libify determine_submodule_update_strategy()
Date:   Tue,  2 Aug 2022 17:46:09 +0200
Message-Id: <patch-v2-25.28-9981a75d7e8-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 8d83f1f99d2..2b78fa7573f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1749,24 +1749,27 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -1781,7 +1784,10 @@ static void determine_submodule_update_strategy(struct repository *r,
 	     out->type == SM_UPDATE_NONE))
 		out->type = SM_UPDATE_CHECKOUT;
 
+	ret = 0;
+cleanup:
 	free(key);
+	return ret;
 }
 
 struct update_clone_data {
@@ -2405,14 +2411,22 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
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
@@ -2440,8 +2454,6 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		int ret;
-
 		ret = run_update_procedure(update_data, must_die_on_failure);
 		if (*must_die_on_failure)
 			return ret;
@@ -2452,7 +2464,6 @@ static int update_submodule(struct update_data *update_data,
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
-- 
2.37.1.1233.ge8b09efaedc

