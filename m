Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B536C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358383AbiFVO3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358330AbiFVO2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CA1BE8C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so2969905wrb.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wwwI4qqpzZTy3Y5bdB03I5MpocAA7+dN8OCW4cRUD4=;
        b=AaWHsw+BJDiBMxsRXfsLNxa62N2j2QW3Hh6DsUR9VtF2Hwx4zR4o6kr9C2Lnf7Esut
         TJFfaDOROUg50KoNi2iDZRGCHfAh2XXDv8QIz+Oqmz0W8dyaPwnG1UXXBkr/gtFvfdbG
         tFWN21Bj6Uzub23g6AvzpmMIdVDECv9Iyxwddtq1F8fr4ESN//IH2Da1qas/dLyhPLdh
         aGA1Kc0OLUQfllQifwFiV5E2Bt6aKWGKpI1bc8UNf6+B241jfsZasMiDWnVP1QtzmmVC
         Z6X5P3ucuF8QPFGvaBH8dJXuK34uND9tl4dGKekgwq0QDbNiSD1tu8eKIlOs/r28uKpx
         oY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wwwI4qqpzZTy3Y5bdB03I5MpocAA7+dN8OCW4cRUD4=;
        b=dDgMPCg/eoOC/CAARWWm6jPfqaaR24gEU5kkl2cs13OBHqLvjdYERaaaOa1ZFtge43
         lXNMZYcCtDXhe9BHk1zGMGsFrCsZvQyqiUqTY9Pt2UrQ08zydGX9zs+i2go9V+nFo0de
         2wW2CGYCRaAb6zoN1gtdVa+WUxpYg59H0LaDLLdv78fPAeQu0wp5E/ht3GK8d/Y4bTKa
         nmlUxeLvPfF/sM2yhWG79Sn5KXp6ek2WahyIZfPc79MRJJKMQ5to3ueqVLtxbYg3asZw
         3vWjgiQ77qW+zc8CcTuAyjzseA2j8k+qFHMnPsVtkLQGo2tLuatpc+fFAd0kUqBKwdtC
         nRpQ==
X-Gm-Message-State: AJIora/MiBbE1Zk1HrbH1ghRL8HVYcChCfvYUP+JCC8GlpTf+q4gR3pN
        WFTNDzTd2VvOq7UIUk7s0sjM4Eb41TQcXg==
X-Google-Smtp-Source: AGRyM1vdCAEd11BE16Wm1f39d7fcE9z2dpYkycABiaut10GOvAlxx49+SUROJ6qY9FHYySTJJftDlA==
X-Received: by 2002:a5d:6f19:0:b0:21a:3802:8b5b with SMTP id ay25-20020a5d6f19000000b0021a38028b5bmr3622990wrb.391.1655908101027;
        Wed, 22 Jun 2022 07:28:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/12] submodule--helper: eliminate internal "--update" option
Date:   Wed, 22 Jun 2022 16:28:05 +0200
Message-Id: <patch-v3-10.12-66a229227a1-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Follow-up on the preceding commit which taught "git submodule--helper
update" to understand "--merge", "--checkout" and "--rebase" and use
those options instead of "--update=(rebase|merge|checkout|none)" when
the command invokes itself.

Unlike the preceding change this isn't strictly necessary to
eventually change "git-submodule.sh" so that it invokes "git
submodule--helper update" directly, but let's remove this
inconsistency in the command-line interface. We shouldn't need to
carry special synonyms for existing options in "git submodule--helper"
when that command can use the primary documented names instead.

But, as seen in the post-image this makes the control flow within
"builtin/submodule--helper.c" simpler, we can now write directly to
the "update_default" member of "struct update_data" when parsing the
options in "module_update()".

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 928b7a948b2..e7ee7b404be 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1818,7 +1818,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 static void determine_submodule_update_strategy(struct repository *r,
 						int just_cloned,
 						const char *path,
-						const char *update,
+						enum submodule_update_type update,
 						struct submodule_update_strategy *out)
 {
 	const struct submodule *sub = submodule_from_path(r, null_oid(), path);
@@ -1828,9 +1828,7 @@ static void determine_submodule_update_strategy(struct repository *r,
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
-		if (parse_submodule_update_strategy(update, out) < 0)
-			die(_("Invalid update mode '%s' for submodule path '%s'"),
-				update, path);
+		out->type = update;
 	} else if (!repo_config_get_string_tmp(r, key, &val)) {
 		if (parse_submodule_update_strategy(val, out) < 0)
 			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
@@ -1882,7 +1880,7 @@ struct update_data {
 	const char *prefix;
 	const char *recursive_prefix;
 	const char *displaypath;
-	const char *update_default;
+	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
@@ -2424,6 +2422,8 @@ static const char *submodule_update_type_to_label(enum submodule_update_type typ
 
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
+	enum submodule_update_type update_type = update_data->update_default;
+
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->recursive_prefix)
@@ -2447,8 +2447,10 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 		strvec_push(args, "--require-init");
 	if (update_data->depth)
 		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update_data->update_default)
-		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	if (update_type != SM_UPDATE_UNSPECIFIED)
+		strvec_pushf(args, "--%s",
+			     submodule_update_type_to_label(update_type));
+
 	if (update_data->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &update_data->references)
@@ -2600,7 +2602,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
-	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2619,16 +2620,13 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &opt.update_default,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_SET_INT(0, "checkout", &update_type,
+		OPT_SET_INT(0, "checkout", &opt.update_default,
 			N_("use the 'checkout' update strategy (default)"),
 			SM_UPDATE_CHECKOUT),
-		OPT_SET_INT('m', "merge", &update_type,
+		OPT_SET_INT('m', "merge", &opt.update_default,
 			N_("use the 'merge' update strategy"),
 			SM_UPDATE_MERGE),
-		OPT_SET_INT('r', "rebase", &update_type,
+		OPT_SET_INT('r', "rebase", &opt.update_default,
 			N_("use the 'rebase' update strategy"),
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
@@ -2680,13 +2678,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
-	if (update_type != SM_UPDATE_UNSPECIFIED)
-		opt.update_default = submodule_update_type_to_label(update_type);
-
 	if (opt.update_default)
-		if (parse_submodule_update_strategy(opt.update_default,
-						    &opt.update_strategy) < 0)
-			die(_("bad value for update parameter"));
+		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
 		list_objects_filter_release(&filter_options);
-- 
2.36.1.1239.gfba91521d90

