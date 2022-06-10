Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B9C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbiFJA0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345461AbiFJA0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856036161
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z9so6383488wmf.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R9q1c6Tj6lmTx3JnybLPHhUwp0frzKJuRai94Y5G2p0=;
        b=HVbd/QkETNLL5EVSbVjkeso/h7iUAd9NPXgpU156wbLXnVJ+XuFEfr133c1libdcJS
         0EjyaM/Ty5QBQl4UOmIAu+8BTR5kF7cS9gIlbj79dfFGmupLwQTN/B6X+IAChB7z18yn
         t8b1Nh8+pLiWcEK3PUU/8/H6iy8rgszmhKXl03ZUVNKJTY6RjQdEzP+YZRv89JBUwnE5
         OoGxGwDb8gaSx4BI/uA7K7kxQ37V4R+hyAyDMvFF9iePtaA0VsFLFY9b+b8oVHQmHS5o
         5lBsAxXXpe+WgXHSmzS29eM0TqgL6z80fqgxDm0XgWEfIo22lhFuAgoC4cDsrIJgv+v9
         k73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R9q1c6Tj6lmTx3JnybLPHhUwp0frzKJuRai94Y5G2p0=;
        b=Wsr8SQhXO+5OUO+tWGgT+8QFVfwe1316NBigNS3xUqgafz9WzejnbaQS+YU0N5+TfV
         CkowNP46aFnTCWc8oD5F0oye7+d37X45xg3ycsolxuilA3yM06s9RZlrW06D/zJAwtwW
         bHxMrHnjszQiqiK8zE1GJUnua8hKM8UQgE6Jrx3DMdYCSs4eqiQvu3whyEFQyTl0so4V
         bW/Sm0vKA2/TOFuY893EA+UR9XNx9xlc23uKt9iR9GreVTe51hA8Xq4P5OuosGcPijCe
         9TeBATUjHhBqoWU0ZY/LQsnipv4IdjaLBFEqO0dKKFLqxtsP8bszUSOhRT7KZfqFDMPl
         pD1Q==
X-Gm-Message-State: AOAM533NoO3N0te3xJN4X6jFEPjHizgbjPr+CrQVKitcwd3ICwJDFz7a
        j9bsUrvp241VHXq6I0EFiQKINA9ex3hIxTjQ
X-Google-Smtp-Source: ABdhPJyUOhYIIgfjbHN3PG7prlKt6qPZMY309QrRmv7u5YsXOApAP1moIlOJpd0qWOKwOI/3wDtEEA==
X-Received: by 2002:a7b:c401:0:b0:397:26fb:ebf7 with SMTP id k1-20020a7bc401000000b0039726fbebf7mr5924224wmi.90.1654820789650;
        Thu, 09 Jun 2022 17:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020adffb42000000b00210326c4a90sm26092367wrs.49.2022.06.09.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:28 -0700 (PDT)
Message-Id: <1bed100c12e851bf5697af6cb96275510ae52b2f.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:18 +0000
Subject: [PATCH 5/8] submodule--helper update: use one param per type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

git-submodule.sh accepts literal 'update types' as options, but parses
them into a "--update" option for "git submodule--helper update", e.g.
"--checkout" becomes "--update=checkout".

Teach the 'update type' options to "git submodule--helper update" so
that we no longer have to do this parsing in git-submodule.sh, and
append them to `opts`.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 37 ++++++++++++++++++++++++-------------
 git-submodule.sh            |  8 +++-----
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a40f9f143e8..09510ebc026 100644
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
@@ -1882,7 +1880,6 @@ struct update_data {
 	const char *prefix;
 	const char *recursive_prefix;
 	const char *displaypath;
-	const char *update_default;
 	struct object_id suboid;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
@@ -1892,6 +1889,7 @@ struct update_data {
 	int max_jobs;
 	int single_branch;
 	int recommend_shallow;
+	enum submodule_update_type update_default;
 	unsigned int require_init;
 	unsigned int force;
 	unsigned int quiet;
@@ -2429,8 +2427,20 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 		strvec_push(args, "--require-init");
 	if (update_data->depth)
 		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update_data->update_default)
-		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	switch (update_data->update_default) {
+	case SM_UPDATE_MERGE:
+		strvec_push(args, "--merge");
+		break;
+	case SM_UPDATE_CHECKOUT:
+		strvec_push(args, "--checkout");
+		break;
+	case SM_UPDATE_REBASE:
+		strvec_push(args, "--rebase");
+		break;
+	default:
+		break;
+	}
+
 	if (update_data->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &update_data->references)
@@ -2600,9 +2610,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &opt.update_default,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
+		OPT_SET_INT(0, "checkout", &opt.update_default,
+			    N_("update using checkout"), SM_UPDATE_CHECKOUT),
+		OPT_SET_INT('r', "rebase", &opt.update_default,
+			    N_("update using rebase"), SM_UPDATE_REBASE),
+		OPT_SET_INT('m', "merge", &opt.update_default,
+			    N_("update using merge"), SM_UPDATE_MERGE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
@@ -2654,9 +2667,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	opt.filter_options = &filter_options;
 
 	if (opt.update_default)
-		if (parse_submodule_update_strategy(opt.update_default,
-						    &opt.update_strategy) < 0)
-			die(_("bad value for update parameter"));
+		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
 		list_objects_filter_release(&filter_options);
diff --git a/git-submodule.sh b/git-submodule.sh
index f61d12ccd21..d93b6dfbbd7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -35,7 +35,6 @@ force=
 cached=
 recursive=
 files=
-update=
 prefix=
 custom_name=
 depth=
@@ -267,7 +266,7 @@ cmd_update()
 			opts="$opts $1"
 			;;
 		-r|--rebase)
-			update="rebase"
+			opts="$opts $1"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -281,13 +280,13 @@ cmd_update()
 			opts="$opts $1"
 			;;
 		-m|--merge)
-			update="merge"
+			opts="$opts $1"
 			;;
 		--recursive)
 			opts="$opts $1"
 			;;
 		--checkout)
-			update="checkout"
+			opts="$opts $1"
 			;;
 		--recommend-shallow)
 			opts="$opts $1"
@@ -343,7 +342,6 @@ cmd_update()
 		${GIT_QUIET:+--quiet} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
-		${update:+--update "$update"} \
 		$opts \
 		-- \
 		"$@"
-- 
gitgitgadget

