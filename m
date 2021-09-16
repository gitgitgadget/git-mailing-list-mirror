Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842FCC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1561108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhIPKer (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhIPKep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D7C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c1so2558972pfp.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TaZPwx/RaQvt27yfvLBvnREbW9wPfsE3i+D5HXIMws=;
        b=kWPMaYUhdDd4j45tJWET6Taz5vQyhaYUlZudrOVYSkxvf9D1tFdIqL5l9XXhE3X8hG
         1e5B34aR6OaVK7i3avHi5Efv11K+NyFFCsLxL4iFkHYJVPM4vW2u+kknIeVpVhAE51ml
         38+1MqPAMwYLd/e23vvFpZ19clYLy9+YLQV/uRj/X/ouZTobnJrqq3d9Hdjb9SH5ZMvR
         57H2WE/KWzgGDFCzuIuoW1MNKnf69hCyhE6+YY2CfL5W74mTQk534QzOuZYjNua7YA7k
         qxU5CRY31mL6fbbljQSHm8gRU/3HTEuG8qju1H+M849oMb7x8ud8rkkR7GkWnkp7f0v5
         jZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TaZPwx/RaQvt27yfvLBvnREbW9wPfsE3i+D5HXIMws=;
        b=Ln3giFUO2flRUiqIueQ/siTrMoSKhiaOvh0sxeW/4jROzxxGdEhuOUu2YMW8ieMggM
         XWgJugnhGDmr4GQvaV2ivHoWtjXusU1Ozg/C3zikCRjnT2q12JI44M9uxCbpmeee9KuB
         fj6687ZfXNT9HFBhYTrZGOwx9snk6T7nRekeBRqGOS1SLLDEARdMi0w+waL0mOK3wav2
         uGWwDp+lsoE/JTXb7QxDeeB3vXJ2e0jo9zXUgP8YEdH66rkHdS6TlyofE7H4EDmXybAh
         1WjWOy3efWdac/mUGdJZH6Dbay938/nmt6Qi+bXYtUjxdY3gJWlpmhpP2Pv1WcPczknH
         iTWA==
X-Gm-Message-State: AOAM531HqQ4hgqBTbVA3DDWn3Z8FhCB/j9x3oKEfrYcOltC378VS+5R/
        G4bc0a6HeamxTw44TcGkv2g=
X-Google-Smtp-Source: ABdhPJzdWiT67bsow75ah2oPHS2VFOeaOLLTrLiBoaxhVIeXbLjSrSdSvXFsAjjARfBSiMS3JrUBOQ==
X-Received: by 2002:a65:400c:: with SMTP id f12mr4346454pgp.296.1631788405007;
        Thu, 16 Sep 2021 03:33:25 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:24 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 6/8] submodule--helper: remove update-clone subcommand
Date:   Thu, 16 Sep 2021 16:02:39 +0530
Message-Id: <20210916103241.62376-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
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
index 1eea626864..c1ce3981ad 100644
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
@@ -3564,7 +3467,6 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
 	{"update-module-mode", module_update_module_mode, 0},
-	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-- 
2.32.0

