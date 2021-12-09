Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C1C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhLIVX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLIVX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:23:28 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686CC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 13:19:54 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 61-20020a17090a09c300b001adc4362b42so4326422pjo.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nESEOW7YLVtXM8G09NNig2NPwk6cRE7iV9vafQLgWRs=;
        b=jI8GcfFVQ1j+XPXTr8i9ilA9g98nFnujGKHE0SuxzgSF6H9xHmP9DZKl2FiAjZLqKW
         z9lqPG9eQXGNlaacfqnHqAWOu6gpmWmprRDcoPYmrNfW+ikWncrq6cj4LdkojwL4ySm+
         MKq/EJEHr3KFHLdJp+eeLINw/gW5LeeCvtrx9xcjyuwkBL2xglQqdvtl1EvP4jEOp2E+
         uV9JVp3Bux8qwH31Ah06mBOiVP9MM98OchYRGrOsctiGrZEUveY/kGJ59TqHrwJjGVFC
         ft7DckiZkYblCSfMj/3UBYKU++ZmJVU22j4IxsIQkG+0HVSGbcgWvB8mK5zSmhSKU3ej
         7RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nESEOW7YLVtXM8G09NNig2NPwk6cRE7iV9vafQLgWRs=;
        b=jSz/pyNe+SCZ1S9U1l/PjMAs3npDt5xZsICGj85LUco4wyPr9O68RQVeGzYsoRO+B4
         Z6VZgLr4Wr5/LI6xikqBhd+2LB3KX5Pr68w1Ic5FbnNLXIu8h/g3cr6dOgA/uY6ADiFw
         gtmnhWusCGHv5jzjlXNrQHQJen9nqER/B6fDHTRS3oY9v9XLGJyuAWrbaToVAGmnw5Oz
         lkzuhl0aJJKrpjPLSFvoqCzYtJDI4nHHmQrzgK+S5/sqTVfogOMif/PTZV2KFb6Ddhn6
         a1+364p000JwtBe1Ky3YBUouRmUH40Rfry41tRj6xib8yRqxGpxbMfrznhH5VBdgjxMl
         StWw==
X-Gm-Message-State: AOAM532DdZvQ3gMGcO1cK7W8N5vK/6Ca2AjfbJeoX2WNZ1Pe+JSzE1PT
        uggz/eRjueN/SncDEFHvrK1OyUpb3+uTi8Gqby0v
X-Google-Smtp-Source: ABdhPJzfWdj3N+TxeDB6btKuoVfVwREyKUIxmezExSDvPPzra4Vi7dDDnhOVBsTs2/KU3GC0n5FcTVcZg39DpYw11ryd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:70e:: with SMTP id
 14mr27013782pgh.151.1639084794329; Thu, 09 Dec 2021 13:19:54 -0800 (PST)
Date:   Thu,  9 Dec 2021 13:19:51 -0800
In-Reply-To: <20211209184928.71413-2-chooglen@google.com>
Message-Id: <20211209211951.498358-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-2-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v3 1/5] branch: move --set-upstream-to behavior to setup_tracking()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> This refactor is motivated by a desire to add a "dry_run" parameter to
> create_branch() that will validate whether or not a branch can be
> created without actually creating it - this behavior be used in a
> subsequent commit that adds `git branch --recurse-submodules topic`.

When I said that the patch was doing too much [1], I meant that for a
patch that is supposed to be about refactoring, there were many lines
that didn't seem to be a straightforward move. I've attached a version
of the patch that I expected - notice that a reviewer can see that the
lines are straightforwardly moved.

[1] https://lore.kernel.org/git/20211123231035.3607109-1-jonathantanmy@google.com/

> +void setup_tracking(const char *new_ref, const char *orig_ref,
> +			   enum branch_track track, int quiet, int expand_orig)
>  {
>  	struct tracking tracking;
>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	char *full_orig_ref;
> +	struct object_id unused_oid;
>  
>  	memset(&tracking, 0, sizeof(tracking));
> -	tracking.spec.dst = (char *)orig_ref;
> +	if (expand_orig)
> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
> +	else
> +		full_orig_ref = xstrdup(orig_ref);

Having two meanings for a parameter (and which meaning used depending on
another parameter) is quite confusing - I think it's better to call
another function to expand the ref if necessary. See my patch below for
an example.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 267a624671..18e285a876 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -42,6 +42,23 @@ test_expect_success 'git branch abc should create a branch' '
>  	git branch abc && test_path_is_file .git/refs/heads/abc
>  '
>  
> +test_expect_success 'git branch abc should fail when abc exists' '
> +	test_must_fail git branch abc
> +'
> +
> +test_expect_success 'git branch --force abc should fail when abc is checked out' '
> +	test_when_finished git switch main &&
> +	git switch abc &&
> +	test_must_fail git branch --force abc HEAD~1
> +'
> +
> +test_expect_success 'git branch --force abc should succeed when abc exists' '
> +	git rev-parse HEAD~1 >expect &&
> +	git branch --force abc HEAD~1 &&
> +	git rev-parse abc >actual &&
> +	test_cmp expect actual
> +'

This seems like an unrelated test for a refactoring that doesn't seem to
touch "force" (in builtin/branch.c, the line removed hardcodes force to
0).

Below is my diff, as mentioned.

---
diff --git a/branch.c b/branch.c
index 07a46430b3..a6803e9900 100644
--- a/branch.c
+++ b/branch.c
@@ -131,8 +131,8 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static void setup_tracking(const char *new_ref, const char *orig_ref,
-			   enum branch_track track, int quiet)
+void setup_tracking(const char *new_ref, const char *orig_ref,
+		    enum branch_track track, int quiet)
 {
 	struct tracking tracking;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
@@ -243,30 +243,12 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+void TODO_name(struct repository *r, const char *start_name, int explicit_tracking,
+	       char **out_real_ref, struct commit **out_commit)
 {
 	struct commit *commit;
 	struct object_id oid;
 	char *real_ref;
-	struct strbuf ref = STRBUF_INIT;
-	int forcing = 0;
-	int dont_change_ref = 0;
-	int explicit_tracking = 0;
-
-	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
-		explicit_tracking = 1;
-
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
-	}
 
 	real_ref = NULL;
 	if (get_oid_mb(start_name, &oid)) {
@@ -304,6 +286,38 @@ void create_branch(struct repository *r,
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
+	if (out_real_ref)
+		*out_real_ref = real_ref;
+	if (out_commit)
+		*out_commit = commit;
+}
+
+void create_branch(struct repository *r,
+		   const char *name, const char *start_name,
+		   int force, int clobber_head_ok, int reflog,
+		   int quiet, enum branch_track track)
+{
+	struct commit *commit;
+	struct object_id oid;
+	char *real_ref = NULL;
+	struct strbuf ref = STRBUF_INIT;
+	int forcing = 0;
+	int dont_change_ref = 0;
+	int explicit_tracking = 0;
+
+	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
+		explicit_tracking = 1;
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
+	TODO_name(r, start_name, explicit_tracking, &real_ref, &commit);
 	oidcpy(&oid, &commit->object.oid);
 
 	if (reflog)
diff --git a/branch.h b/branch.h
index df0be61506..577483012b 100644
--- a/branch.h
+++ b/branch.h
@@ -1,6 +1,7 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+struct commit;
 struct repository;
 struct strbuf;
 
@@ -17,6 +18,11 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+void setup_tracking(const char *new_ref, const char *orig_ref,
+		    enum branch_track track, int quiet);
+void TODO_name(struct repository *r, const char *start_name, int explicit_tracking,
+	       char **out_real_ref, struct commit **out_commit);
+
 /*
  * Creates a new branch, where:
  *
diff --git a/builtin/branch.c b/builtin/branch.c
index 81b5c111cb..78f5c1d17e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -806,6 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
+		char *real_ref;
 
 		if (argc > 1)
 			die(_("too many arguments to set new upstream"));
@@ -821,12 +822,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
 
-		/*
-		 * create_branch takes care of setting up the tracking
-		 * info and making sure new_upstream is correct
-		 */
-		create_branch(the_repository, branch->name, new_upstream,
-			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		TODO_name(the_repository, new_upstream, 1, &real_ref, NULL);
+		setup_tracking(branch->name, real_ref, BRANCH_TRACK_OVERRIDE, quiet);
+		free(real_ref);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
