Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD63C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhLPAc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLPAc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:32:29 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9409C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b26-20020aa7951a000000b004a815eb3a3aso14347956pfp.16
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbYza/GP7WYyLzpwPZmV+unBxsqsArXISKdi6C05Qvw=;
        b=Yzbtpbjpu7y8oVxrc6XxSpNyNZmhaXo0kvCAMR3Ic0bSDQe0FlnVq4N2jX1DiajDyd
         5stt1hSif/5DNjE3uxFMxKlx3T7Q/d8/NzXf5zKkz7Q5tkA9GsmgKoj4a/Mi6JYPmGLD
         YbZmu1Ii4OXZKgahppnXBE3gDjKiDHb/hK322OtGiLmvnprVpecYQ2u5RkLF2c186lLh
         vOR4L9zLJmZ5KLsroNFqZcBTs/cD7Jj56e0Ps+ss1uO5I7+49VAbS8llgZZN2mvT8tNy
         WlrJ07FzwASTGGk55epUXUL5S3Cr2FcSvj91jD07u/Qw6MJ9hDLR1/VyNbNLzM/6Hp04
         wpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbYza/GP7WYyLzpwPZmV+unBxsqsArXISKdi6C05Qvw=;
        b=OlkJ0NJZ/g5hq0p8huHV27me15/MAdPvcgm/BcRPC0AosKTN0U9eEWsWiqrPhB6GS4
         Tr7SZiwQMIG/mgd5ddSwuO63OvhAudmvqW1NKC03zXMUVQQDDuhvtnEChgL+hELfKtK/
         Gs0yMfgsH3vYRBfwAK/JSIa1yYrdG+FiObddxd81OplDEE149SgTCrVfdI8u/In0pfPN
         /r4G/1TrnIFYbOujqXmtMrj8RXE9kLYbAINRopjshhB1CLr32fcSs/y8cFUsQzmTuAIe
         UtPNm70sKcgRFSiVxmvoaqxsWfA2dyLgPTXs7Pt3J2HPGEh/whHk2aTG5ZpecRuRxPxv
         BCHg==
X-Gm-Message-State: AOAM531NESX6MmRmo6lXdGrk1kxuI5S3+4jvQfRIdw+lHYTraFgpmwpY
        6T6vLXyV9lYortVj5brUaIRyl7wVyy65k+xm2V6QTAN0iaKaXfJAAcROHhIYz0pGStnWp0o6Orj
        P5GjgmHFiKFmiqSqRfvjxCIB8SL39d5ODODv1jllEO4S4icqwbomik7pHE2ksFLQ=
X-Google-Smtp-Source: ABdhPJyeqQa7/KWfBTN357NMglTQi8+XZl1ibVGcT7SCiB8Yd24yu+IoiTfuKv6wmFi9lTiPhuhO8+vTr9oxeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:15c5:b0:4a0:3c1:4f43 with SMTP
 id o5-20020a056a0015c500b004a003c14f43mr11511817pfu.33.1639614748300; Wed, 15
 Dec 2021 16:32:28 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:32:09 -0800
In-Reply-To: <20211216003213.99135-1-chooglen@google.com>
Message-Id: <20211216003213.99135-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com> <20211216003213.99135-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
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
index 6e7e2af5cb..fc3304e51d 100644
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
 
@@ -335,31 +338,37 @@ N_("\n"
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
@@ -396,7 +405,34 @@ void create_branch(struct repository *r,
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
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
@@ -430,6 +466,15 @@ void create_branch(struct repository *r,
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
index 81a29edb4a..16a7e80df5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -823,12 +823,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

