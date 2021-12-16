Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C361C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhLPXde (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhLPXda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67AC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:30 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id p128-20020a62d086000000b004ba5abcfb35so415148pfg.21
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M748gRy/mDRvXRy6bwXOXeIR6GSaZHA8Z+pYZD8+TSU=;
        b=QQ4PYqtEaEJSuKEs0SaxKizyw1twt5SiO822wRH7N4mYLMt4L3KQpxOBQYSMl0c5Nn
         rDvqXuOhifJNbIPNDVFGR5m2nxe+VsFWqVS1Znj3gwixrNfme3DRnYBdpAehZGAJTOUD
         Pb8eC1EbHGB1l2+UxC7TboEzskX1C98qhQm0XKJb+g8fkoC2IzYDV8HTlF9TdH3fFYhE
         dghEnuZVkD9gYnQCxuDf75rrZw/V3ob/0r2mYn8Zhr9UueLO+JG6ltk55p2jYwnVd8W0
         Wge37QD/eIexVHHjnaOn7/5OjwCBg7MgqHvXZhdizJMeyrSRbY4QDO+6pkd2wd84c+To
         0BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M748gRy/mDRvXRy6bwXOXeIR6GSaZHA8Z+pYZD8+TSU=;
        b=paz5D4XaLRKKVlnzbHqc4P1QPXB85Q2XmZooKQ456ybplfWbJ/TXDGMuDtSDW2yDUn
         2oytiEn3HgcPnYlvYBgtcGXHIZWlk279XF2b9WEhxRRykEZg5GLmzy5CMXJN62nRHCS2
         O5malu+WDNVZDiNlAOMxr6ZNl0/M+c4Pi/zQW5K5WtoliS5I+wJFSZFtGooxCP3FzyhL
         NR5qa38qdfyUCp0X8HqBXoCKceon3tESecaKi8YhIXpyzA88LDEIwLU+bhUQAFUs9Hpy
         Sc0HPuyWi+NhpJLselnABJWL1rs34kbRi/MXQNrlar47Mz8JNdFwSD/S2A2E1rPU8Pjb
         CMfg==
X-Gm-Message-State: AOAM533B8gC8D6Dl7q1IVenwEhGMQFqrEQj9Siy6sp+sMDIGhWHFr7be
        IG75cL25j7kTieJqR63WPTTXoBo0dFG55APKf1I+kY+FJo3ao6KaPMILmP9CFQY3pjLv/xCEWvT
        XfniQ20TtT268KUpNONyTb+Lk2f7eY+UeMSiIgWU1SWUgmfrSdzSNEzmTaL3Et4k=
X-Google-Smtp-Source: ABdhPJw66X20GO/nK3CY14vdqCfBleIfJqsbXMJLe8o5F7ErlhK4As/xqkyct++zfJ0aqZcoHUNjgoCWCw9IeA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c402:b0:148:ac81:1242 with SMTP
 id k2-20020a170902c40200b00148ac811242mr214832plk.162.1639697609436; Thu, 16
 Dec 2021 15:33:29 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:20 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211216233324.65126-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
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

This refactor is motivated by a desire to add a "dry_run" parameter to
create_branch() that will validate whether or not a branch can be
created without actually creating it - this behavior will be used in a
subsequent commit that adds `git branch --recurse-submodules topic`.

Adding "dry_run" is not obvious because create_branch() is also used to
set tracking information without creating a branch, i.e. when using
--set-upstream-to. This appears to be a leftover from 4fc5006676 (Add
branch --set-upstream, 2010-01-18), when --set-upstream would sometimes
create a branch and sometimes update tracking information without
creating a branch. However, we no longer support --set-upstream, so it
makes more sense to set tracking information with another function and
use create_branch() only to create branches. In a later commit, we will
remove the now-unnecessary logic from create_branch() so that "dry_run"
becomes trivial to implement.

Introduce dwim_and_setup_tracking(), which replaces create_branch()
in `git branch --set-upstream-to`. Ensure correctness by moving the DWIM
and branch validation logic from create_branch() into a helper function,
dwim_branch_start(), so that the logic is shared by both functions.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c         | 87 ++++++++++++++++++++++++++++++++++++------------
 branch.h         | 22 ++++++++++++
 builtin/branch.c |  9 ++---
 3 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/branch.c b/branch.c
index eed8665b76..54e989f3c8 100644
--- a/branch.c
+++ b/branch.c
@@ -212,9 +212,11 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
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
@@ -239,7 +241,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_INHERIT:
 			break;
 		default:
-			return;
+			goto cleanup;
 		}
 
 	if (tracking.matches > 1)
@@ -252,6 +254,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			      tracking.srcs) < 0)
 		exit(-1);
 
+cleanup:
 	string_list_clear(tracking.srcs, 0);
 }
 
@@ -340,31 +343,37 @@ N_("\n"
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
@@ -401,7 +410,34 @@ void create_branch(struct repository *r,
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("not a valid branch point: '%s'"), start_name);
-	oidcpy(&oid, &commit->object.oid);
+	if (out_real_ref)
+		*out_real_ref = real_ref ? xstrdup(real_ref) : NULL;
+	if (out_oid)
+		oidcpy(out_oid, &commit->object.oid);
+
+	FREE_AND_NULL(real_ref);
+}
+
+void create_branch(struct repository *r, const char *name,
+		   const char *start_name, int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track)
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
@@ -435,6 +471,15 @@ void create_branch(struct repository *r,
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
index e99bdae897..4a9e0f5727 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -828,12 +828,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

