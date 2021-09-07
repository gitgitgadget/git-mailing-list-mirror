Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159AC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAC3610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhIGMBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbhIGMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E5C06179A
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x19so7987433pfu.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfOiMwzMIYfsBlBP6e/EZBwrcelP8aCGWclRB6siwWM=;
        b=Eh9cjKE8ZwAr+RIKMxF4XKn9QXbd65t+wA/4pTmAouDBCjEgSTvVJhNkGCnFxdYcY2
         BdoVlHnCYyAdJkFdnf/V9Vy75gF6VHueKUj1fwA/nYFUyr/4+2LrjCV1J1lXws2xGP0+
         lAWOLDTGpgCqVQX2BmykFLrWJYWadWqdRGOzp8dkdqGfluG61PLT/zFnKvZeomyl4EpO
         yzyj5SRHsZCk2kK5brBsmuA+msCVlXvbUWXQOgqQuOM7gF9Pm/YPpnE9f4mRpsmuSH2X
         UYMqPoH7qvx8gPHarffL7NFtDZRxFb6zHbWvJIhb0y6+H4GFbymDY8agcKtN77q6ZzYa
         7qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfOiMwzMIYfsBlBP6e/EZBwrcelP8aCGWclRB6siwWM=;
        b=sHN/0hjESDxDFgXNJBa9zGey5WGdDCQkJ1b18l8t+MO8myEj4qQZ4BLsJuWVD7epXr
         H7AtqyH94+DUscu4AeQE0Mo9WPFnIeNd23RyqPGWf5tNDbpzbXuq0j6p4SZUbZq1l4XX
         38jGLkHWxAYByJ+DUA+9XZIUB4kRm2nJ3brs6kK7eqDRiHE6Ohxq4w9nrdVtGl3MSO/g
         U2oqfPiViyWXKk14liiAMlSicLvlQGFPVVzRmaS9FyyedM5RWYcCF6ogI4b6HpM86cLB
         +ide2XQ9b6Jg7G1/27Aa/AutHDODW/xKCyea+gcdLDbsiUE0VUg3rE/XJYsSKChmZje/
         1HjQ==
X-Gm-Message-State: AOAM530wPEXsFcuE2ts+SvILiHBBab6remNIZSmqzvSDZmatXKB6dda2
        liO0p3aeJWmv8y2ZtXnLGbgDHndtLyM=
X-Google-Smtp-Source: ABdhPJy/6m1FVcxnIo4a58J3y2vnKVo06jQJykOAwSMUvFNjw/6WYaR+0QmHjGkPJ4VGmomRPlllhQ==
X-Received: by 2002:a63:788d:: with SMTP id t135mr15613490pgc.116.1631016019759;
        Tue, 07 Sep 2021 05:00:19 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:19 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 08/13] submodule--helper: remove update-clone subcommand
Date:   Tue,  7 Sep 2021 17:29:27 +0530
Message-Id: <20210907115932.36068-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer need this subcommand as the shell version calls the
'update' subcommand instead, which does all the cloning within C itself.

We also no longer need the 'update_clone_submodules()' and
'update_clone_submodule()' functions, so we remove those as well.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 98 -------------------------------------
 1 file changed, 98 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2cccb9a9ab..a628660d6b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2552,103 +2552,6 @@ static int do_run_update_procedure(struct update_data *ud, struct string_list *e
 	return run_update_command(ud, subforce, err);
 }
 
-static void update_clone_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
-static int update_clone_submodules(struct submodule_update_clone *suc)
-{
-	int i;
-
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
-				   "parallel/update");
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc->quickstop)
-		return 1;
-
-	for (i = 0; i < suc->update_clone_nr; i++)
-		update_clone_submodule(&suc->update_clone[i]);
-
-	return 0;
-}
-
-static int update_clone(int argc, const char **argv, const char *prefix)
-{
-	const char *update = NULL;
-	struct pathspec pathspec;
-	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
-
-	struct option module_update_clone_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
-			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &suc.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
-			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &suc.progress,
-			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &suc.require_init,
-			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &suc.single_branch,
-			 N_("clone only one branch, HEAD or --branch")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-	suc.prefix = prefix;
-
-	update_clone_config_from_gitmodules(&suc.max_jobs);
-	git_config(git_update_clone_config, &suc.max_jobs);
-
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
-			     git_submodule_helper_usage, 0);
-
-	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
-			die(_("bad value for update parameter"));
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
-		return 1;
-
-	if (pathspec.nr)
-		suc.warn_if_uninitialized = 1;
-
-	return update_clone_submodules(&suc);
-}
-
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
 	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
@@ -3561,7 +3464,6 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
 	{"update-module-mode", module_update_module_mode, 0},
-	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-- 
2.32.0

