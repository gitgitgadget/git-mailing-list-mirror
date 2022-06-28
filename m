Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F0CCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbiF1KGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiF1KG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE21DA63
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so16932218wra.4
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnsvt39/xZsKKhJReg6zKy+vtczVM86rKiqEn0MU3vc=;
        b=EMi2VK5UoyEvIsfZbdRSqqtgXyNlpLg6hPZ7O95IznyVqs8wqmn6h0rts3TUr21cCd
         L0usukK1Qre/2Xw+JzE4Qp/39mopVKsUDrBsKuhmdEJr8iBwCVkXqlF5KwZx5yDtvHPI
         05Hc0sW1kHtap+jMDKBSEnNnfhvS3OqW6NqkqRkwKHL9nuyCiR6klESGj11IOK/h1UTx
         u51Z6UovdXlBoh8udIK5q8Rw9rWy2ZZcu6CShH627ZvI8x+lNUM0tz1J8NjlBzh2x6Y7
         +PiAqyaRPi+8M9ValKv0tOhTMxrjBRwtVRPZHhcS68Y7uWvMutSQY/RLV4Sd5rSfHYpm
         CLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnsvt39/xZsKKhJReg6zKy+vtczVM86rKiqEn0MU3vc=;
        b=O6TRDbwon8u/uk3dtE5ZklkvtCpZMVaoLV3aIjWJu7iy2HRT8HBQBsiFNS8NEBQpfE
         zE+lQ/rtI12tDH1GuHU0GyzuthrAx/vzsZ/m8C9CzQlulSS9EOpMMd8B8pBaInAbnyWv
         gvjz57AGoe6xZofJpEJlTLFp61OXOVGcGwJ8VqTXt9iQTDtU1EbV2SA0dZ7iKeuzkv7g
         5DwvMNuBpMWRKzxEptCOlWOIBcjbFrbYD2kXEz/FEThyqHeTduzuraSZqIcAxG+XYbI6
         dnurgtJsQT8PLnaiW0Cp9YYKxY6V/F+W0W53zjz6Vij+aitaodPxJ8iVC6T4K4uoNTAi
         ZZeA==
X-Gm-Message-State: AJIora8nTLtfr1VOLxmgDySqnAe6HlyaB9BJXEV9VOfCx8mv2qk7IeXj
        L3gFTibnTaTadfTphjjG35rZFvFirKdvmQ==
X-Google-Smtp-Source: AGRyM1sjsJSOcbRvajluNZLW/C4BPuYxBbeuV8+SkN5PZ7pv7Q3Zxl8O6FMT8Sg7IWpNk5o5iJiZzA==
X-Received: by 2002:adf:ea91:0:b0:21a:3d15:ae17 with SMTP id s17-20020adfea91000000b0021a3d15ae17mr17329937wrm.486.1656410778614;
        Tue, 28 Jun 2022 03:06:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/12] submodule--helper: eliminate internal "--update" option
Date:   Tue, 28 Jun 2022 12:05:32 +0200
Message-Id: <patch-v4-10.12-abb5cb499aa-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
index e35ae0322ee..d60f6cd9de0 100644
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
2.37.0.880.gf07d56b18ba

