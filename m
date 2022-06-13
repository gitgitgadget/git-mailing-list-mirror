Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA925C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiFMWj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiFMWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3622BC3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so5287042wms.5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvYvjxlRoMlVL3yc+oeRXmrdofcBHgpyoR4UFEdbtwI=;
        b=qrw6kWU3E5heotHysGYORjtIC4Lsh34PJt58RrON4j/dNOMmO/joODzcJHJHMgxO6O
         Ax4Z3bzsJz8m5DW5mGhi3wH9kfpjDpDC3z1zYfbK0Dj8v7tC0wdRKUh0E5FgX5vXL0/S
         l0qvb0l4OHzVLRsRdzGsp+4AMxY+YN/Z2S9N245XnNzmTalVbEPhhIV9Y9OJZQQp5sQa
         X+6aNkID7egFC188NUOrK2R5K9sLjyIMxl2PSvJ4sMVUvqZfC3X/5riN3WGlVgXJ5Tfu
         7SWK2uKDa6IESPmID1V0hINuRXWu5K8NGLqNrDjGKdhFHhpd/aAykJO2qEiGxAYUUr5i
         YlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvYvjxlRoMlVL3yc+oeRXmrdofcBHgpyoR4UFEdbtwI=;
        b=Janx2HJBhHW/F8Auq87c5Hbz1OXQDCz+5PfU6U+rvS8wRuPC1qNSYkQtpdDv5Te+27
         ICywVBXwNVRf72iyVv5dYU575WnAuq46hmUsa6CgcGOfRGvhf/iS8LP6jEtI5SwETInQ
         to4fLmMJj9P4GcCEJwMUpKpQu62MCX4cG8kgqMzMp8JKbtKAdx/3HXa2WH5hV5+rU6w7
         aI2MKmtN7hPpie6UdFqGkxknF2zuuBGK9jTICtS/p7etlKORugb+xT/SjLbMysNH6mrj
         k3T2bgRSK+qdzVzWZWnfUPusVL6boecM2gyP2zR5z5KTACxDm6vHTXuWBWPMaZkBn5D5
         5hVA==
X-Gm-Message-State: AOAM533oyuGr+1LPWlzmfrRBrTKLylpxWOuXvicAtAjLAo6QtDKcZg1i
        d34emNxDklrPX86E5yY2AUldMed3kEzDlQ==
X-Google-Smtp-Source: ABdhPJz6Uy4qBMJdCJ5qp5vs4PApNrutu2VuuuaYqwohEgTePmd6IsOPRltsWGpsvATK2naRi+vDng==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr970824wmq.88.1655159957576;
        Mon, 13 Jun 2022 15:39:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/12] submodule--helper: eliminate internal "--update" option
Date:   Tue, 14 Jun 2022 00:39:01 +0200
Message-Id: <patch-v2-10.12-ac00a9599de-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 42 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 57f0237af23..65cf4b915df 100644
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
@@ -2406,6 +2404,8 @@ static void ensure_core_worktree(const char *path)
 
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
+	enum submodule_update_type ud = update_data->update_default;
+
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->recursive_prefix)
@@ -2429,8 +2429,15 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 		strvec_push(args, "--require-init");
 	if (update_data->depth)
 		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update_data->update_default)
-		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	if (ud == SM_UPDATE_MERGE)
+		strvec_push(args, "--merge");
+	else if (ud == SM_UPDATE_CHECKOUT)
+		strvec_push(args, "--checkout");
+	else if (ud == SM_UPDATE_REBASE)
+		strvec_push(args, "--rebase");
+	else if (ud != SM_UPDATE_UNSPECIFIED)
+		BUG("cannot convert update_default=%d to args", ud);
+
 	if (update_data->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &update_data->references)
@@ -2582,7 +2589,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
-	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2601,16 +2607,13 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2662,17 +2665,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
-	if (update_type == SM_UPDATE_CHECKOUT)
-		opt.update_default = "checkout";
-	else if (update_type == SM_UPDATE_MERGE)
-		opt.update_default = "merge";
-	else if (update_type == SM_UPDATE_REBASE)
-		opt.update_default = "rebase";
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

