Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiA1M5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiA1M4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DEC06174A
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id p12so9672401edq.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiEe93qmAg1dxSQk6p3M+ohyOePGHkjvVrCe5PQ3UuI=;
        b=PXfC3jk19bdcQt5OuaZZhDWxE2y6i3hlCoOm1NtX26q38Emn9b3hPSWMpN78C690RS
         H2qVQxUio9nlx1JUGMRQeXqxbFjUnjFQG4ULUjqvZK7IzGXK9ESgXnkuNOTHQIpduwWy
         vVJLF85vFlI4xP0kfx791b+yWGZ+M9jhKNhp1/DZbb8zDCSKO/1qxl4AgYvumyK62ufj
         TB7nKNc5EzKuc+j7XapWRh0iJhUTg4bWGhRgGJK+s1cKEjPYGVELoGPwIFfkC7S5JU1Y
         gp6lKscJvt6GAsqK6rIm//XT7JwCcbfqUbMkgnSX0azCgLL/Pj6HV93likhmmphcxZA1
         uqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiEe93qmAg1dxSQk6p3M+ohyOePGHkjvVrCe5PQ3UuI=;
        b=Q81Is/caRrheD1Wi4FUud2dww+7jHJrjYAEsq1OaHs3YYr/V6xX954FhIQMaEKgvpy
         +wkLFSb/ZoNJfxPX6+/km8/T60iynNPZS+8gJtyUVymeWcn9O5Q2dmYDNm+fs+uDd3p0
         hy60cEB3Sx46A4LSxOk7K6+JRNaHErtM5tmpIAG2xepQJfPX05Ln9Q66C6QSwkrsx7eF
         4skCdt9GJ0BbI+umc6VerI8oBFvzeTMG4sIiLiA1NkcHkr3ffmapeUKJtx3mi7SsFTth
         br5t7XeDaQTZ0/WQCaZRYL4OJ7ZDMTgpHKibpn5dxnY4NXr2Le42pq2KHZiWuj34s9qD
         YGQg==
X-Gm-Message-State: AOAM5320Q0AoIK736WtXfKbrlmREuJkSFU5fxHd7NZtBlH3/4qfAqtgb
        prIChF6oZiqQ1j7kpgCBDhEWauEz34O2Cw==
X-Google-Smtp-Source: ABdhPJz5sXTU/7HF5CLwapw2TX6TsUUo3ZN4P/R7weuK6Przo/1jRLrs5oFCNH3uLbwo6o8NFEwClg==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr3232234edz.69.1643374612297;
        Fri, 28 Jan 2022 04:56:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/9] builtin/submodule--helper.c: rename option variables to "opt"
Date:   Fri, 28 Jan 2022 13:56:37 +0100
Message-Id: <patch-v5-6.9-ef097f7ea51-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "suc" variable in update_clone() to "opt", and do the same
for the "update_data" variable in run_update_procedure().

The only reason for this change is to make the subsequent commit's
diff smaller, by doing this rename we can "anchor" the diff better, as
it "borrow" most of the options declared here as-is as far as the diff
rename detection is concerned.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 74 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f79bdf4d51..c2d4fd0347a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2517,36 +2517,36 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &suc.dissociate,
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
+		OPT_STRING(0, "depth", &opt.depth, "<depth>",
 			   N_("create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
 			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &suc.progress,
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &suc.require_init,
+		OPT_BOOL(0, "require-init", &opt.require_init,
 			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &suc.single_branch,
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
@@ -2555,32 +2555,32 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
 		NULL
 	};
-	suc.prefix = prefix;
+	opt.prefix = prefix;
 
-	update_clone_config_from_gitmodules(&suc.max_jobs);
-	git_config(git_update_clone_config, &suc.max_jobs);
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
 	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
 		return 1;
 
 	if (pathspec.nr)
-		suc.warn_if_uninitialized = 1;
+		opt.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	return update_submodules(&opt);
 }
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
 	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
 	char *prefixed_path, *update = NULL;
-	struct update_data update_data = UPDATE_DATA_INIT;
+	struct update_data opt = UPDATE_DATA_INIT;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
@@ -2589,20 +2589,20 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 			 N_("don't fetch new objects from the remote site")),
 		OPT_BOOL(0, "just-cloned", &just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
+		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
+		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
+		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
 			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
 		OPT_END()
@@ -2618,27 +2618,27 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage_with_options(usage, options);
 
-	update_data.force = !!force;
-	update_data.quiet = !!quiet;
-	update_data.nofetch = !!nofetch;
-	update_data.just_cloned = !!just_cloned;
-	update_data.sm_path = argv[0];
+	opt.force = !!force;
+	opt.quiet = !!quiet;
+	opt.nofetch = !!nofetch;
+	opt.just_cloned = !!just_cloned;
+	opt.sm_path = argv[0];
 
-	if (update_data.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
+	if (opt.recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
 	else
-		prefixed_path = xstrdup(update_data.sm_path);
+		prefixed_path = xstrdup(opt.sm_path);
 
-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
+	opt.displaypath = get_submodule_displaypath(prefixed_path, prefix);
 
-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update,
-					    &update_data.update_strategy);
+	determine_submodule_update_strategy(the_repository, opt.just_cloned,
+					    opt.sm_path, update,
+					    &opt.update_strategy);
 
 	free(prefixed_path);
 
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data);
+	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
+		return do_run_update_procedure(&opt);
 
 	return 3;
 }
-- 
2.35.0.914.ge5c8aab0d5b

