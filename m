Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA2C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882B220771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8G0Iv47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392016AbgFSPzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388837AbgFSPVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA5C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so10076698wrt.5
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mc2jmf+pB18IKojxE0rQ4C8yvcUz6rVQMqN4xExd7O0=;
        b=A8G0Iv47epsMO+1NxTX7wIz4fVzysF2z5hpqbtzoDVHIgvU0T+/K/HHHeDA/aFfy0b
         vMKf0hyftPI92d0AyO/R3iwJkF1FRoiDyfE+E96XHL39CGRjLCUroBb+7rB4Lh9tuC/4
         UmR/JUdqCS9AgdNuPg1/oIDxKDAYixpinBEQpMZCJyeQdYQyepbQ51lyWccJ94u3cn2B
         yi2+PkJhMj+cL9NySCh+r+JQIyfX/1gu2IvGuYaoUCe2e1HkmrqI5lEMruEooOLdCrYX
         bBviMslBhNF0qSYPKahoWdURsuwFZusGRJhdt2oJTzqjsUV6P3kTCZ8hjiX6lejT+eEk
         hr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mc2jmf+pB18IKojxE0rQ4C8yvcUz6rVQMqN4xExd7O0=;
        b=aadAqNBYXdWIJH/yMzbBQ6rc7rhWwwMBe7eqFKEx236i5Bg46pCw+y2NXkuGi+rPMn
         iSmUULOtcxklZhQaU7gpKT5hHJj3BrCxbfMo6He1/FdF13G/QrPUNItYgj4Y2BGBk9i9
         kt3/1fjX2UMSGJfe5hyvahs4F35O2K4m0lIh/lDM2t2/shKZO3MJQlnEb+MVBZ81d913
         e47XEOPhSel2ftgfa2V0zLExEQ66JGzH0RfqAiwnXMitBUnI4vqwpW7DtDXrXBWFFQ5l
         B2Y2CFEk7KIYf5h1ETrxsL5SKeViCPV+cpR1FE/RWgYJul+D7l0My9ay66BOcqvF7Y9c
         15+g==
X-Gm-Message-State: AOAM532tpW7AiLaoifWcoP3q2K0Jx/rFJZg2Gc4s+5AaVJdU3JDmaXjm
        IW7vlic1NNp7MwDkafw6oDrr36sg
X-Google-Smtp-Source: ABdhPJyVYZm1Wt5RQR5QhfBvNmTipM1h52Fz8omHtn8WlpYTzWw9SA9id1AKqWGSojh5jSHvtJH9sA==
X-Received: by 2002:adf:f350:: with SMTP id e16mr2837639wrp.43.1592580075520;
        Fri, 19 Jun 2020 08:21:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19sm6894846wmi.33.2020.06.19.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:21:15 -0700 (PDT)
Message-Id: <48d361f44e2aed025a6b55b3b7440b9bc9301322.1592580071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.665.git.1592580071.gitgitgadget@gmail.com>
References: <pull.665.git.1592580071.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Jun 2020 15:21:10 +0000
Subject: [PATCH 3/3] refs: update ref_exists() to take a struct repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There are a number of places where we check for the existance of a
pseudo ref by looking for a file rather than using the refs api.  The
assumption that these refs are always files will not valid once
repositories start storing their refs in a reftable. As the current code
is already aware of which repository the ref is in update ref_exists()
to take a struct repository* so that we can safely change the
file_exists() calls to ref_exists() later. It would be possible to
change the file_exists() to use refs_ref_exists(get_main_ref_store(r),
...) but that gets quite cumbersome.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c                 | 14 ++++----
 branch.h                 |  6 ++--
 builtin/bisect--helper.c |  2 +-
 builtin/branch.c         | 19 +++++-----
 builtin/checkout.c       | 14 +++++---
 builtin/commit.c         |  4 +--
 builtin/for-each-ref.c   |  4 +--
 builtin/log.c            |  6 ++--
 builtin/ls-remote.c      |  2 +-
 builtin/merge.c          |  2 +-
 builtin/pull.c           |  2 +-
 builtin/rebase.c         |  4 +--
 builtin/receive-pack.c   |  2 +-
 builtin/remote.c         |  5 +--
 builtin/stash.c          |  4 +--
 builtin/tag.c            |  6 ++--
 builtin/verify-tag.c     |  2 +-
 builtin/worktree.c       |  8 ++---
 ref-filter.c             | 76 +++++++++++++++++++++++++---------------
 ref-filter.h             | 11 +++---
 refs.c                   |  4 +--
 refs.h                   |  2 +-
 remote.c                 | 30 +++++++++-------
 remote.h                 | 13 ++++---
 sha1-name.c              |  5 +--
 wt-status.c              | 41 ++++++++++++----------
 wt-status.h              |  2 +-
 27 files changed, 168 insertions(+), 122 deletions(-)

diff --git a/branch.c b/branch.c
index 2d9e7675a6e..976d923196c 100644
--- a/branch.c
+++ b/branch.c
@@ -183,12 +183,13 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref)
+int validate_branchname(struct repository *r, const char *name,
+			struct strbuf *ref)
 {
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
-	return ref_exists(ref->buf);
+	return ref_exists(r, ref->buf);
 }
 
 /*
@@ -197,11 +198,12 @@ int validate_branchname(const char *name, struct strbuf *ref)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(struct repository *r, const char *name,
+			    struct strbuf *ref, int force)
 {
 	const char *head;
 
-	if (!validate_branchname(name, ref))
+	if (!validate_branchname(r, name, ref))
 		return 0;
 
 	if (!force)
@@ -260,8 +262,8 @@ void create_branch(struct repository *r,
 		explicit_tracking = 1;
 
 	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
+	    ? validate_branchname(r, name, &ref)
+	    : validate_new_branchname(r, name, &ref, force)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index df0be61506f..2c0f7164a92 100644
--- a/branch.h
+++ b/branch.h
@@ -50,7 +50,8 @@ void create_branch(struct repository *r,
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(struct repository *r, const char *name,
+			struct strbuf *ref);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -58,7 +59,8 @@ int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(struct repository *r, const char *name,
+			    struct strbuf *ref, int force);
 
 /*
  * Remove information about the merge state on the current
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 09b37b67913..59e8898d9c1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -336,7 +336,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
 
-	if (ref_exists(bad_ref))
+	if (ref_exists(the_repository, bad_ref))
 		missing_bad = 0;
 
 	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
diff --git a/builtin/branch.c b/builtin/branch.c
index a4409d42d7c..59938d1bc04 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -126,7 +126,8 @@ static int branch_merged(int kind, const char *name,
 
 	if (kind == FILTER_REFS_BRANCHES) {
 		struct branch *branch = branch_get(name);
-		const char *upstream = branch_get_upstream(branch, NULL);
+		const char *upstream =
+			branch_get_upstream(the_repository, branch, NULL);
 		struct object_id oid;
 
 		if (upstream &&
@@ -428,12 +429,13 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 
-	ref_array_sort(sorting, &array);
+	ref_array_sort(the_repository, sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
 		struct strbuf out = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		if (format_ref_array_item(array.items[i], format, &out, &err))
+		if (format_ref_array_item(the_repository, array.items[i],
+					  format, &out, &err))
 			die("%s", err.buf);
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
@@ -509,7 +511,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
 		 */
-		if (ref_exists(oldref.buf))
+		if (ref_exists(the_repository, oldref.buf))
 			recovery = 1;
 		else
 			die(_("Invalid branch name: '%s'"), oldname);
@@ -520,9 +522,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(the_repository, newname, &newref);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(the_repository, newname, &newref,
+					force);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
@@ -756,7 +759,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("cannot edit description of more than one branch"));
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!ref_exists(branch_ref.buf)) {
+		if (!ref_exists(the_repository, branch_ref.buf)) {
 			strbuf_release(&branch_ref);
 
 			if (!argc)
@@ -802,7 +805,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(the_repository, branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
 
 		/*
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4f8c9924953..c1fe6aad9bf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -832,7 +832,8 @@ static void report_tracking(struct branch_info *new_branch_info)
 	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new_branch_info->name);
 
-	if (!format_tracking_info(branch, &sb, AHEAD_BEHIND_FULL))
+	if (!format_tracking_info(the_repository, branch, &sb,
+				  AHEAD_BEHIND_FULL))
 		return;
 	fputs(sb.buf, stdout);
 	strbuf_release(&sb);
@@ -923,7 +924,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		if (old_branch_info->path && old_branch_info->name) {
-			if (!ref_exists(old_branch_info->path) && reflog_exists(old_branch_info->path))
+			if (!ref_exists(the_repository,
+					old_branch_info->path) &&
+			    reflog_exists(old_branch_info->path))
 				delete_reflog(old_branch_info->path);
 		}
 	}
@@ -1728,10 +1731,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+			opts->branch_exists = validate_branchname(
+				the_repository, opts->new_branch, &buf);
 		else
-			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
+			opts->branch_exists = validate_new_branchname(
+				the_repository, opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index d1b7396052a..496e641ebca 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -538,7 +538,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
 	wt_status_collect(s);
-	wt_status_print(s);
+	wt_status_print(the_repository, s);
 	wt_status_collect_free_buffers(s);
 
 	return s->committable;
@@ -1457,7 +1457,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (s.relative_paths)
 		s.prefix = prefix;
 
-	wt_status_print(&s);
+	wt_status_print(the_repository, &s);
 	wt_status_collect_free_buffers(&s);
 
 	return 0;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 57489e4eab1..df5edcb68de 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,12 +76,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
-	ref_array_sort(sorting, &array);
+	ref_array_sort(the_repository, sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+		show_ref_array_item(the_repository, array.items[i], &format);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/log.c b/builtin/log.c
index d104d5c6889..90a5b659292 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1445,7 +1445,8 @@ static struct commit *get_base_commit(const char *base_commit,
 			die(_("unknown commit %s"), base_commit);
 	} else if ((base_commit && !strcmp(base_commit, "auto"))) {
 		struct branch *curr_branch = branch_get(NULL);
-		const char *upstream = branch_get_upstream(curr_branch, NULL);
+		const char *upstream =
+			branch_get_upstream(the_repository, curr_branch, NULL);
 		if (upstream) {
 			struct commit_list *base_list;
 			struct commit *commit;
@@ -2201,7 +2202,8 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		break;
 	default:
 		current_branch = branch_get(NULL);
-		upstream = branch_get_upstream(current_branch, NULL);
+		upstream = branch_get_upstream(the_repository, current_branch,
+					       NULL);
 		if (!upstream) {
 			fprintf(stderr, _("Could not find a tracked"
 					" remote branch, please"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ef519514bd..5e2ccd3935d 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -136,7 +136,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (sorting)
-		ref_array_sort(sorting, &ref_array);
+		ref_array_sort(the_repository, sorting, &ref_array);
 
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
diff --git a/builtin/merge.c b/builtin/merge.c
index 72633be6503..1d8b72a0408 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -549,7 +549,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		struct strbuf truname = STRBUF_INIT;
 		strbuf_addf(&truname, "refs/heads/%s", remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (ref_exists(truname.buf)) {
+		if (ref_exists(the_repository, truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    oid_to_hex(&remote_head->object.oid),
diff --git a/builtin/pull.c b/builtin/pull.c
index ea4148ba1e1..1f7c2e8e7e7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -736,7 +736,7 @@ static const char *get_upstream_branch(const char *remote)
 	if (strcmp(curr_branch_remote, rm->name))
 		return NULL;
 
-	return branch_get_upstream(curr_branch, NULL);
+	return branch_get_upstream(the_repository, curr_branch, NULL);
 }
 
 /**
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 82284df8d94..77038a6611d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1800,8 +1800,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			struct branch *branch;
 
 			branch = branch_get(NULL);
-			options.upstream_name = branch_get_upstream(branch,
-								    NULL);
+			options.upstream_name = branch_get_upstream(
+				the_repository, branch, NULL);
 			if (!options.upstream_name)
 				error_on_missing_default_upstream();
 			if (fork_point < 0)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ea3d0f01af3..2f025c51364 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1151,7 +1151,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(the_repository, old_oid)) {
 			old_oid = NULL;
-			if (ref_exists(name)) {
+			if (ref_exists(the_repository, name)) {
 				rp_warning("Allowing deletion of corrupt ref.");
 			} else {
 				rp_warning("Deleting a non-existent ref.");
diff --git a/builtin/remote.c b/builtin/remote.c
index cde14a7bebe..6e3e2bdd46b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -358,7 +358,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	states->tracked.strdup_strings = 1;
 	states->stale.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
-		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
+		if (!ref->peer_ref ||
+		    !ref_exists(the_repository, ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
@@ -1353,7 +1354,7 @@ static int set_head(int argc, const char **argv)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!ref_exists(buf2.buf))
+		if (!ref_exists(the_repository, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
 			result |= error(_("Could not setup %s"), buf.buf);
diff --git a/builtin/stash.c b/builtin/stash.c
index a9dee125c4f..b84c6dce465 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -157,7 +157,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 
 	strbuf_init(&info->revision, 0);
 	if (!commit) {
-		if (!ref_exists(ref_stash)) {
+		if (!ref_exists(the_repository, ref_stash)) {
 			free_stash_info(info);
 			fprintf_ln(stderr, _("No stash entries found."));
 			return -1;
@@ -688,7 +688,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (!ref_exists(ref_stash))
+	if (!ref_exists(the_repository, ref_stash))
 		return 0;
 
 	cp.git_cmd = 1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 109f8393100..0601735deb1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -61,10 +61,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
-	ref_array_sort(sorting, &array);
+	ref_array_sort(the_repository, sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format);
+		show_ref_array_item(the_repository, array.items[i], format);
 	ref_array_clear(&array);
 	free(to_free);
 
@@ -121,7 +121,7 @@ static int verify_tag(const char *name, const char *ref,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid, format);
+		pretty_print_ref(the_repository, name, oid, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06ba..e6cd33c86ec 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -71,7 +71,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, &oid, &format);
+			pretty_print_ref(the_repository, name, &oid, &format);
 	}
 	return had_error;
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d99db356684..45a831cc91f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -273,7 +273,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-	    ref_exists(symref.buf)) {
+	    ref_exists(the_repository, symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
 			die_if_checked_out(symref.buf, 0);
@@ -442,7 +442,7 @@ static void print_preparing_worktree_line(int detach,
 	} else {
 		struct strbuf s = STRBUF_INIT;
 		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
-		    ref_exists(s.buf))
+		    ref_exists(the_repository, s.buf))
 			printf_ln(_("Preparing worktree (checking out '%s')"),
 				  branch);
 		else {
@@ -465,7 +465,7 @@ static const char *dwim_branch(const char *path, const char **new_branch)
 
 	UNLEAK(branchname);
 	if (!strbuf_check_branch_ref(&ref, branchname) &&
-	    ref_exists(ref.buf)) {
+	    ref_exists(the_repository, ref.buf)) {
 		strbuf_release(&ref);
 		return branchname;
 	}
@@ -529,7 +529,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 		if (!opts.force &&
 		    !strbuf_check_branch_ref(&symref, new_branch) &&
-		    ref_exists(symref.buf))
+		    ref_exists(the_repository, symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index bf7b70299b4..49b0a3f5878 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1412,14 +1412,15 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 		return xstrdup(refname);
 }
 
-static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
+static void fill_remote_ref_details(struct repository *r,
+				    struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
 	if (atom->u.remote_ref.option == RR_REF)
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
-		if (stat_tracking_info(branch, &num_ours, &num_theirs,
+		if (stat_tracking_info(r, branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
@@ -1438,7 +1439,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			free((void *)to_free);
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
-		if (stat_tracking_info(branch, &num_ours, &num_theirs,
+		if (stat_tracking_info(r, branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup("");
@@ -1605,7 +1606,8 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static int populate_value(struct ref_array_item *ref, struct strbuf *err)
+static int populate_value(struct repository *r, struct ref_array_item *ref,
+			  struct strbuf *err)
 {
 	struct object *obj;
 	int i;
@@ -1658,9 +1660,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			}
 			branch = branch_get(branch_name);
 
-			refname = branch_get_upstream(branch, NULL);
+			refname = branch_get_upstream(r, branch, NULL);
 			if (refname)
-				fill_remote_ref_details(atom, refname, branch, &v->s);
+				fill_remote_ref_details(r, atom, refname,
+							branch, &v->s);
 			else
 				v->s = xstrdup("");
 			continue;
@@ -1675,13 +1678,14 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (atom->u.remote_ref.push_remote)
 				refname = NULL;
 			else {
-				refname = branch_get_push(branch, NULL);
+				refname = branch_get_push(r, branch, NULL);
 				if (!refname)
 					continue;
 			}
 			/* We will definitely re-init v->s on the next line. */
 			free((char *)v->s);
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			fill_remote_ref_details(r, atom, refname, branch,
+						&v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {
 			v->s = xstrdup(atom->u.color);
@@ -1785,11 +1789,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static int get_ref_atom_value(struct ref_array_item *ref, int atom,
-			      struct atom_value **v, struct strbuf *err)
+static int get_ref_atom_value(struct repository *r, struct ref_array_item *ref,
+			      int atom, struct atom_value **v,
+			      struct strbuf *err)
 {
 	if (!ref->value) {
-		if (populate_value(ref, err))
+		if (populate_value(r, ref, err))
 			return -1;
 		fill_missing_values(ref->value);
 	}
@@ -2273,7 +2278,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
-static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
+static int cmp_ref_sorting(struct repository *r, struct ref_sorting *s,
+			   struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -2281,9 +2287,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err = STRBUF_INIT;
 
-	if (get_ref_atom_value(a, s->atom, &va, &err))
+	if (get_ref_atom_value(r, a, s->atom, &va, &err))
 		die("%s", err.buf);
-	if (get_ref_atom_value(b, s->atom, &vb, &err))
+	if (get_ref_atom_value(r, b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
@@ -2303,18 +2309,25 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	return (s->reverse) ? -cmp : cmp;
 }
 
-static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
+struct ref_sorting_internal {
+	struct repository *r;
+	struct ref_sorting *s;
+};
+
+static int compare_refs(const void *a_, const void *b_, void *data)
 {
 	struct ref_array_item *a = *((struct ref_array_item **)a_);
 	struct ref_array_item *b = *((struct ref_array_item **)b_);
+	struct ref_sorting_internal *s_internal = data;
+	struct repository *r = s_internal->r;
 	struct ref_sorting *s;
 
-	for (s = ref_sorting; s; s = s->next) {
-		int cmp = cmp_ref_sorting(s, a, b);
+	for (s = s_internal->s; s; s = s->next) {
+		int cmp = cmp_ref_sorting(r, s, a, b);
 		if (cmp)
 			return cmp;
 	}
-	s = ref_sorting;
+	s = s_internal->s;
 	return s && s->ignore_case ?
 		strcasecmp(a->refname, b->refname) :
 		strcmp(a->refname, b->refname);
@@ -2326,9 +2339,12 @@ void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
 		sorting->ignore_case = !!flag;
 }
 
-void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
+void ref_array_sort(struct repository *r, struct ref_sorting *sorting,
+		    struct ref_array *array)
 {
-	QSORT_S(array->items, array->nr, compare_refs, sorting);
+	struct ref_sorting_internal data = { r, sorting };
+
+	QSORT_S(array->items, array->nr, compare_refs, &data);
 }
 
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
@@ -2353,10 +2369,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-int format_ref_array_item(struct ref_array_item *info,
-			   const struct ref_format *format,
-			   struct strbuf *final_buf,
-			   struct strbuf *error_buf)
+int format_ref_array_item(struct repository *r, struct ref_array_item *info,
+			  const struct ref_format *format,
+			  struct strbuf *final_buf,
+			  struct strbuf *error_buf)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
@@ -2372,7 +2388,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (pos < 0 ||
+		    get_ref_atom_value(r, info, pos, &atomv, error_buf) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
 			return -1;
@@ -2399,13 +2416,13 @@ int format_ref_array_item(struct ref_array_item *info,
 	return 0;
 }
 
-void show_ref_array_item(struct ref_array_item *info,
+void show_ref_array_item(struct repository *r, struct ref_array_item *info,
 			 const struct ref_format *format)
 {
 	struct strbuf final_buf = STRBUF_INIT;
 	struct strbuf error_buf = STRBUF_INIT;
 
-	if (format_ref_array_item(info, format, &final_buf, &error_buf))
+	if (format_ref_array_item(r, info, format, &final_buf, &error_buf))
 		die("%s", error_buf.buf);
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	strbuf_release(&error_buf);
@@ -2413,13 +2430,14 @@ void show_ref_array_item(struct ref_array_item *info,
 	putchar('\n');
 }
 
-void pretty_print_ref(const char *name, const struct object_id *oid,
+void pretty_print_ref(struct repository *r, const char *name,
+		      const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
-	show_ref_array_item(ref_item, format);
+	show_ref_array_item(r, ref_item, format);
 	free_array_item(ref_item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 8ecc33cdfa5..32f04247670 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -113,16 +113,18 @@ void ref_array_clear(struct ref_array *array);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+void ref_array_sort(struct repository *r, struct ref_sorting *sort,
+		    struct ref_array *array);
 /*  Set the ignore_case flag for all elements of a sorting list */
 void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
 /*  Based on the given format and quote_style, fill the strbuf */
-int format_ref_array_item(struct ref_array_item *info,
+int format_ref_array_item(struct repository *r, struct ref_array_item *info,
 			  const struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
 /*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+void show_ref_array_item(struct repository *r, struct ref_array_item *info,
+			 const struct ref_format *format);
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */
@@ -140,7 +142,8 @@ void setup_ref_filter_porcelain_msg(void);
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
  */
-void pretty_print_ref(const char *name, const struct object_id *oid,
+void pretty_print_ref(struct repository *r, const char *name,
+		      const struct object_id *oid,
 		      const struct ref_format *format);
 
 /*
diff --git a/refs.c b/refs.c
index 7f120f8d33a..f60dc66b78e 100644
--- a/refs.c
+++ b/refs.c
@@ -316,9 +316,9 @@ static int refs_ref_exists(struct ref_store *refs, const char *refname)
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
 
-int ref_exists(const char *refname)
+int ref_exists(struct repository *r, const char *refname)
 {
-	return refs_ref_exists(get_main_ref_store(the_repository), refname);
+	return refs_ref_exists(get_main_ref_store(r), refname);
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
diff --git a/refs.h b/refs.h
index b0a7ab490f2..d3e9e178f73 100644
--- a/refs.h
+++ b/refs.h
@@ -105,7 +105,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
-int ref_exists(const char *refname);
+int ref_exists(struct repository *r, const char *refname);
 
 int should_autocreate_reflog(const char *refname);
 
diff --git a/remote.c b/remote.c
index 534c6426f1e..1c4ac83ba66 100644
--- a/remote.c
+++ b/remote.c
@@ -1604,7 +1604,8 @@ static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 	return NULL;
 }
 
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+const char *branch_get_upstream(struct repository *r, struct branch *branch,
+				struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
@@ -1615,7 +1616,7 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 		 * or because it is not a real branch, and get_branch
 		 * auto-vivified it?
 		 */
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(r, branch->refname))
 			return error_buf(err, _("no such branch: '%s'"),
 					 branch->name);
 		return error_buf(err,
@@ -1645,7 +1646,8 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
+static const char *branch_get_push_1(struct repository *r,
+				     struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
 
@@ -1682,14 +1684,14 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
+		return branch_get_upstream(r, branch, err);
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
 			const char *up, *cur;
 
-			up = branch_get_upstream(branch, err);
+			up = branch_get_upstream(r, branch, err);
 			if (!up)
 				return NULL;
 			cur = tracking_for_push_dest(remote, branch->refname, err);
@@ -1705,13 +1707,14 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 	BUG("unhandled push situation");
 }
 
-const char *branch_get_push(struct branch *branch, struct strbuf *err)
+const char *branch_get_push(struct repository *r, struct branch *branch,
+			    struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
 	if (!branch->push_tracking_ref)
-		branch->push_tracking_ref = branch_get_push_1(branch, err);
+		branch->push_tracking_ref = branch_get_push_1(r, branch, err);
 	return branch->push_tracking_ref;
 }
 
@@ -1961,15 +1964,16 @@ static int stat_branch_pair(const char *branch_name, const char *base,
  * upstream defined, or ref does not exist).  Returns 0 if the commits are
  * identical.  Returns 1 if commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+int stat_tracking_info(struct repository *r, struct branch *branch,
+		       int *num_ours, int *num_theirs,
 		       const char **tracking_name, int for_push,
 		       enum ahead_behind_flags abf)
 {
 	const char *base;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = for_push ? branch_get_push(branch, NULL) :
-		branch_get_upstream(branch, NULL);
+	base = for_push ? branch_get_push(r, branch, NULL) :
+			  branch_get_upstream(r, branch, NULL);
 	if (tracking_name)
 		*tracking_name = base;
 	if (!base)
@@ -1981,15 +1985,15 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf)
+int format_tracking_info(struct repository *r, struct branch *branch,
+			 struct strbuf *sb, enum ahead_behind_flags abf)
 {
 	int ours, theirs, sti;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	sti = stat_tracking_info(r, branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
 		if (!full_base)
 			return 0;
diff --git a/remote.h b/remote.h
index 5cc26c1b3b3..bd62d2fa9ad 100644
--- a/remote.h
+++ b/remote.h
@@ -278,7 +278,8 @@ int branch_merge_matches(struct branch *, int n, const char *);
  * message is recorded there (if the function does not return NULL, then
  * `err` is not touched).
  */
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
+const char *branch_get_upstream(struct repository *r, struct branch *branch,
+				struct strbuf *err);
 
 /**
  * Return the tracking branch that corresponds to the ref we would push to
@@ -286,7 +287,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
  *
  * The return value and `err` conventions match those of `branch_get_upstream`.
  */
-const char *branch_get_push(struct branch *branch, struct strbuf *err);
+const char *branch_get_push(struct repository *r, struct branch *branch,
+			    struct strbuf *err);
 
 /* Flags to match_refs. */
 enum match_refs_flags {
@@ -305,11 +307,12 @@ enum ahead_behind_flags {
 };
 
 /* Reporting of tracking info */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+int stat_tracking_info(struct repository *r, struct branch *branch,
+		       int *num_ours, int *num_theirs,
 		       const char **upstream_name, int for_push,
 		       enum ahead_behind_flags abf);
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf);
+int format_tracking_info(struct repository *r, struct branch *branch,
+			 struct strbuf *sb, enum ahead_behind_flags abf);
 
 struct ref *get_local_heads(void);
 /*
diff --git a/sha1-name.c b/sha1-name.c
index 0b8cb5247ab..536afaab67e 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1469,7 +1469,8 @@ static int interpret_branch_mark(struct repository *r,
 				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
-				 const char *(*get_data)(struct branch *,
+				 const char *(*get_data)(struct repository *,
+							 struct branch *,
 							 struct strbuf *),
 				 unsigned allowed)
 {
@@ -1492,7 +1493,7 @@ static int interpret_branch_mark(struct repository *r,
 	} else
 		branch = branch_get(NULL);
 
-	value = get_data(branch, &err);
+	value = get_data(r, branch, &err);
 	if (!value)
 		die("%s", err.buf);
 
diff --git a/wt-status.c b/wt-status.c
index 98dfa6f73f9..809b1d56c4b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1086,7 +1086,8 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	}
 }
 
-static void wt_longstatus_print_tracking(struct wt_status *s)
+static void wt_longstatus_print_tracking(struct repository *r,
+					 struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
@@ -1102,7 +1103,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 
 	t_begin = getnanotime();
 
-	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
+	if (!format_tracking_info(r, branch, &sb, s->ahead_behind_flags))
 		return;
 
 	if (advice_status_ahead_behind_warning &&
@@ -1683,7 +1684,7 @@ static void wt_longstatus_print_state(struct wt_status *s)
 		show_bisect_in_progress(s, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s)
+static void wt_longstatus_print(struct repository *r, struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
@@ -1716,7 +1717,7 @@ static void wt_longstatus_print(struct wt_status *s)
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
-			wt_longstatus_print_tracking(s);
+			wt_longstatus_print_tracking(r, s);
 	}
 
 	wt_longstatus_print_state(s);
@@ -1878,7 +1879,8 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	}
 }
 
-static void wt_shortstatus_print_tracking(struct wt_status *s)
+static void wt_shortstatus_print_tracking(struct repository *r,
+					  struct wt_status *s)
 {
 	struct branch *branch;
 	const char *header_color = color(WT_STATUS_HEADER, s);
@@ -1914,7 +1916,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base,
+	sti = stat_tracking_info(r, branch, &num_ours, &num_theirs, &base,
 				 0, s->ahead_behind_flags);
 	if (sti < 0) {
 		if (!base)
@@ -1954,12 +1956,12 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-static void wt_shortstatus_print(struct wt_status *s)
+static void wt_shortstatus_print(struct repository *r, struct wt_status *s)
 {
 	struct string_list_item *it;
 
 	if (s->show_branch)
-		wt_shortstatus_print_tracking(s);
+		wt_shortstatus_print_tracking(r, s);
 
 	for_each_string_list_item(it, &s->change) {
 		struct wt_status_change_data *d = it->util;
@@ -1976,13 +1978,13 @@ static void wt_shortstatus_print(struct wt_status *s)
 		wt_shortstatus_other(it, s, "!!");
 }
 
-static void wt_porcelain_print(struct wt_status *s)
+static void wt_porcelain_print(struct repository *r, struct wt_status *s)
 {
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
-	wt_shortstatus_print(s);
+	wt_shortstatus_print(r, s);
 }
 
 /*
@@ -2018,7 +2020,8 @@ static void wt_porcelain_print(struct wt_status *s)
  * upstream.  When AHEAD_BEHIND_QUICK is requested and the branches
  * are different, '?' will be substituted for the actual count.
  */
-static void wt_porcelain_v2_print_tracking(struct wt_status *s)
+static void wt_porcelain_v2_print_tracking(struct repository *r,
+					   struct wt_status *s)
 {
 	struct branch *branch;
 	const char *base;
@@ -2053,7 +2056,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
+		ab_info = stat_tracking_info(r, branch, &nr_ahead, &nr_behind,
 					     &base, 0, s->ahead_behind_flags);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
@@ -2328,14 +2331,14 @@ static void wt_porcelain_v2_print_other(
  * [<v2_ignored_items>]*
  *
  */
-static void wt_porcelain_v2_print(struct wt_status *s)
+static void wt_porcelain_v2_print(struct repository *r, struct wt_status *s)
 {
 	struct wt_status_change_data *d;
 	struct string_list_item *it;
 	int i;
 
 	if (s->show_branch)
-		wt_porcelain_v2_print_tracking(s);
+		wt_porcelain_v2_print_tracking(r, s);
 
 	for (i = 0; i < s->change.nr; i++) {
 		it = &(s->change.items[i]);
@@ -2362,7 +2365,7 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
-void wt_status_print(struct wt_status *s)
+void wt_status_print(struct repository *r, struct wt_status *s)
 {
 	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
 	trace2_data_intmax("status", s->repo, "count/untracked",
@@ -2373,20 +2376,20 @@ void wt_status_print(struct wt_status *s)
 
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s);
+		wt_shortstatus_print(r, s);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(s);
+		wt_porcelain_print(r, s);
 		break;
 	case STATUS_FORMAT_PORCELAIN_V2:
-		wt_porcelain_v2_print(s);
+		wt_porcelain_v2_print(r, s);
 		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		BUG("finalize_deferred_config() should have been called");
 		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
-		wt_longstatus_print(s);
+		wt_longstatus_print(r, s);
 		break;
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 73ab5d4da1c..31383ad9e3c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -147,7 +147,7 @@ size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_append_cut_line(struct strbuf *buf);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
-void wt_status_print(struct wt_status *s);
+void wt_status_print(struct repository *r, struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_collect_free_buffers(struct wt_status *s);
 void wt_status_get_state(struct repository *repo,
-- 
gitgitgadget
