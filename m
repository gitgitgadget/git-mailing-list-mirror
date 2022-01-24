Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E5C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381757AbiAXWc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582626AbiAXWPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:15:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88943C04A2C4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y17-20020a170902d65100b0014a17faf0bdso3961521plh.12
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qbm8RFqn3Of+2Q951Tq6ed+SI643yO7op5S/t3iQ/r4=;
        b=tOu2mxvTmLfQG5vIeE8n7IxRyQTUfCKMwA24F/MlCHcObWwH2LYEz4mvDniOBl6pX/
         cGOnoxfDZP6oAtSym1idaAIsFzY8TbQAoo21oBB/HEbgt8CpfyO16pPmGYQ9RNE2Wfm4
         b4BNe/HTz28C1AOnRYyD5lH2cqZa8j/wDXYrT9DNhPOIklvyyw7Rb0aKBZs+zg+tny/T
         CFzefNptFmv0FbVCc6ucHobOC8MLThcMD5nrAoNfYt5rVI+ahVzLchJXCj0R7VXWHzD/
         +zWqMEKci5cuaO7vk0uTD5YGBUxWsB9R9WidAR/SVTx4mKcJn3TjVV9Pl6I2O7T9jM93
         KmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qbm8RFqn3Of+2Q951Tq6ed+SI643yO7op5S/t3iQ/r4=;
        b=yPu/k06YnpAwHSXGyex+b55YplIb8I3wt/fyNA49jYDnMhVdQ6yeQUG7E2DCV95gkD
         sQR4wfL5/N3yEwfERgCO43n8/yxpimeTAqPa/QMHSikwzVlRF9dFeWMNMcUOuPHrK3Yb
         0nkXZovQk4wPveQYKtAJc/7aQbcxE+2akBLP3nAOt/ZTA6PYABYxFvC7Xj36akSexD/9
         HBF2pemK3MBVAkBYblaEpoNuDX0dYWP3SaEJRc2l8LO4CYc4MpC9Z0NzEYGEiU3+U7zT
         P3nt6vav2WNm/lDJtFUWJP1CACrpDOX6HjeziHyft089PNjfskusZ5gJeloOB//KyDdT
         9RqA==
X-Gm-Message-State: AOAM532wcrlWPvlrA/zz7rLmcKEVr1qHWEhkxFr7wDfxNSrWImUzn/15
        lf1be+wOJ/d++dF3uY7m+WprGQzZ2jpKT17E3I+64Xu7L3E8Xx8qAd54ZpFfsoqBX+Up6bvPPCj
        LvFytmadZW8TXrJvpam8WNYXbRC/muWgqZ/g57b2h8JwlNggcH6NI/wgcOVIP6LU=
X-Google-Smtp-Source: ABdhPJwKHtwIArJrUNN3FKNoLIixgvpAnsXqlmlog0+PWR3n/TjU0Q9JqhVdD7CDM+WIK9szKWz+9ud6uW4TPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:84cf:0:b0:4c8:7234:e6ca with SMTP id
 x15-20020aa784cf000000b004c87234e6camr8829397pfn.35.1643057101906; Mon, 24
 Jan 2022 12:45:01 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:37 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220124204442.39353-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 1/6] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is preparation for a future commit that will simplify
create_branch() so that it always creates a branch. This will allow
create_branch() to accept a dry_run parameter (which is needed for "git
branch --recurse-submodules").

create_branch() used to always create a branch, but 4fc5006676 (Add
branch --set-upstream, 2010-01-18) changed it to also be able to set
tracking information without creating a branch.

Refactor the code that sets tracking information into its own functions
dwim_branch_start() and dwim_and_setup_tracking(). Also change an
invocation of create_branch() in cmd_branch() in builtin/branch.c to use
dwim_and_setup_tracking(), since that invocation is only for setting
tracking information (in "git branch --set-upstream-to").

As of this commit, create_branch() is no longer invoked in a way that
does not create branches.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c         | 87 +++++++++++++++++++++++++++++++++++++-----------
 branch.h         | 22 ++++++++++++
 builtin/branch.c |  9 ++---
 3 files changed, 92 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index a4e4631ef1..f3a31930fb 100644
--- a/branch.c
+++ b/branch.c
@@ -218,9 +218,11 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 }
 
 /*
- * This is called when new_ref is branched off of orig_ref, and tries
- * to infer the settings for branch.<new_ref>.{remote,merge} from the
- * config.
+ * Used internally to set the branch.<new_ref>.{remote,merge} config
+ * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
+ * dwim_and_setup_tracking(), this does not do DWIM, i.e. "origin/main"
+ * will not be expanded to "refs/remotes/origin/main", so it is not safe
+ * for 'orig_ref' to be raw user input.
  */
 static void setup_tracking(const char *new_ref, const char *orig_ref,
 			   enum branch_track track, int quiet)
@@ -341,31 +343,37 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+/**
+ * DWIMs a user-provided ref to determine the starting point for a
+ * branch and validates it, where:
+ *
+ *   - r is the repository to validate the branch for
+ *
+ *   - start_name is the ref that we would like to test. This is
+ *     expanded with DWIM and assigned to out_real_ref.
+ *
+ *   - track is the tracking mode of the new branch. If tracking is
+ *     explicitly requested, start_name must be a branch (because
+ *     otherwise start_name cannot be tracked)
+ *
+ *   - out_oid is an out parameter containing the object_id of start_name
+ *
+ *   - out_real_ref is an out parameter containing the full, 'real' form
+ *     of start_name e.g. refs/heads/main instead of main
+ *
+ */
+static void dwim_branch_start(struct repository *r, const char *start_name,
+			   enum branch_track track, char **out_real_ref,
+			   struct object_id *out_oid)
 {
 	struct commit *commit;
 	struct object_id oid;
 	char *real_ref;
-	struct strbuf ref = STRBUF_INIT;
-	int forcing = 0;
-	int dont_change_ref = 0;
 	int explicit_tracking = 0;
 
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
-	}
-
 	real_ref = NULL;
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
@@ -402,7 +410,37 @@ void create_branch(struct repository *r,
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	oidcpy(&oid, &commit->object.oid);
+	if (out_real_ref) {
+		*out_real_ref = real_ref;
+		real_ref = NULL;
+	}
+	if (out_oid)
+		oidcpy(out_oid, &commit->object.oid);
+
+	FREE_AND_NULL(real_ref);
+}
+
+void create_branch(struct repository *r,
+		   const char *name, const char *start_name,
+		   int force, int clobber_head_ok, int reflog,
+		   int quiet, enum branch_track track)
+{
+	struct object_id oid;
+	char *real_ref;
+	struct strbuf ref = STRBUF_INIT;
+	int forcing = 0;
+	int dont_change_ref = 0;
+
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
+	    ? validate_branchname(name, &ref)
+	    : validate_new_branchname(name, &ref, force)) {
+		if (!force)
+			dont_change_ref = 1;
+		else
+			forcing = 1;
+	}
+
+	dwim_branch_start(r, start_name, track, &real_ref, &oid);
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -436,6 +474,15 @@ void create_branch(struct repository *r,
 	free(real_ref);
 }
 
+void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			     const char *orig_ref, enum branch_track track,
+			     int quiet)
+{
+	char *real_orig_ref;
+	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
+	setup_tracking(new_ref, real_orig_ref, track, quiet);
+}
+
 void remove_merge_branch_state(struct repository *r)
 {
 	unlink(git_path_merge_head(r));
diff --git a/branch.h b/branch.h
index 815dcd40c0..ab2315c611 100644
--- a/branch.h
+++ b/branch.h
@@ -18,6 +18,28 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+/**
+ * Sets branch.<new_ref>.{remote,merge} config settings such that
+ * new_ref tracks orig_ref according to the specified tracking mode.
+ *
+ *   - new_ref is the name of the branch that we are setting tracking
+ *     for.
+ *
+ *   - orig_ref is the name of the ref that is 'upstream' of new_ref.
+ *     orig_ref will be expanded with DWIM so that the config settings
+ *     are in the correct format e.g. "refs/remotes/origin/main" instead
+ *     of "origin/main".
+ *
+ *   - track is the tracking mode e.g. BRANCH_TRACK_REMOTE causes
+ *     new_ref to track orig_ref directly, whereas BRANCH_TRACK_INHERIT
+ *     causes new_ref to track whatever orig_ref tracks.
+ *
+ *   - quiet suppresses tracking information.
+ */
+void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			     const char *orig_ref, enum branch_track track,
+			     int quiet);
+
 /*
  * Creates a new branch, where:
  *
diff --git a/builtin/branch.c b/builtin/branch.c
index 1890afd4e5..59768a3f67 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -822,12 +822,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
 
-		/*
-		 * create_branch takes care of setting up the tracking
-		 * info and making sure new_upstream is correct
-		 */
-		create_branch(the_repository, branch->name, new_upstream,
-			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		dwim_and_setup_tracking(the_repository, branch->name,
+					new_upstream, BRANCH_TRACK_OVERRIDE,
+					quiet);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
-- 
2.33.GIT

