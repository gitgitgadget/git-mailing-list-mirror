From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v22 0/24] rs/ref-transaction
Date: Wed, 1 Oct 2014 18:48:17 -0700
Message-ID: <20141002014817.GS1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVVV-0003Bu-CP
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 03:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbaJBBsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 21:48:23 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33194 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbaJBBsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 21:48:21 -0400
Received: by mail-pd0-f170.google.com with SMTP id p10so1205265pdj.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=adHUGUt1TgbZIlJYmuk1KfLnHjPub3n+j0x5rcr9f7g=;
        b=i4uI2qvoswR5uHUhxBoRmhC5l6Tmqkc0+17OLEzaHtjp+JEbSXDIAJh3QmJ1migj4K
         MkcPgzWDxkP29YCZAbSnBuG4uyhrhub3+7EGRRds4MHHlNI0kjI8yyvaLQzVCgvPjFey
         CqSjXjVdsULws4s52z9o2JOEVQeQlq3EjZTzG+6AxBoes0fSIcpihdSdYBqjqZvNEc5f
         sKj3plQpVajdYV6+9xgs0ScWVTyiJ2vSh3crRvXT7JGGv5tGGfshA/ciuoBo1u1PATIa
         XrtjswGHpg6TE+6NaF9IOkhNhS2+2DzKSWRgdD0Qzbz5CoizPtRv/xgvFEnzNaWu1rkp
         DJrA==
X-Received: by 10.68.106.131 with SMTP id gu3mr12845749pbb.17.1412214500906;
        Wed, 01 Oct 2014 18:48:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id gr5sm2099612pbc.33.2014.10.01.18.48.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 18:48:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257771>

Jonathan Nieder wrote:
> Jonathan Nieder wrote:

>> The next series from Ronnie's collection is available at
>> https://code-review.googlesource.com/#/q/topic:ref-transaction in case
>> someone wants a fresh series to look at.
>
> Here is the outcome of that review.  It could use another set of eyes
> (hint, hint)

Another set of eyes arrived and helped.  Here's a reroll.

Jonathan Nieder (6):
  mv test: recreate mod/ directory instead of relying on stale copy
  branch -d: avoid repeated symref resolution
  packed-ref cache: forbid dot-components in refnames
  refs.c: do not permit err == NULL
  lockfile: remove unable_to_lock_error
  ref_transaction_commit: bail out on failure to remove a ref

Junio C Hamano (1):
  reflog test: test interaction with detached HEAD

Ronnie Sahlberg (17):
  wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
  wrapper.c: add a new function unlink_or_msg
  refs.c: add an err argument to delete_ref_loose
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  rename_ref: don't ask read_ref_full where the ref came from
  refs.c: refuse to lock badly named refs in lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a list of names to skip to is_refname_available
  refs.c: ref_transaction_commit: distinguish name conflicts from other
    errors
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static
  refs.c: change resolve_ref_unsafe reading argument to be a flags field
  branch -d: simplify by using RESOLVE_REF_READING flag
  test: put tests for handling of bad ref names in one place
  refs.c: allow listing and deleting badly named refs
  for-each-ref.c: improve message before aborting on broken ref
  remote rm/prune: print a message when writing packed-refs fails

 branch.c                 |   6 +-
 builtin/blame.c          |   2 +-
 builtin/branch.c         |  22 ++-
 builtin/checkout.c       |   6 +-
 builtin/clone.c          |   2 +-
 builtin/commit.c         |   6 +-
 builtin/fetch.c          |  34 ++--
 builtin/fmt-merge-msg.c  |   2 +-
 builtin/for-each-ref.c   |  11 +-
 builtin/fsck.c           |   2 +-
 builtin/log.c            |   3 +-
 builtin/merge.c          |   2 +-
 builtin/notes.c          |   2 +-
 builtin/receive-pack.c   |   9 +-
 builtin/remote.c         |  20 ++-
 builtin/replace.c        |   5 +-
 builtin/show-branch.c    |   7 +-
 builtin/symbolic-ref.c   |   2 +-
 builtin/tag.c            |   4 +-
 builtin/update-ref.c     |  13 +-
 bundle.c                 |   2 +-
 cache.h                  |  42 +++--
 fast-import.c            |   8 +-
 git-compat-util.h        |  16 +-
 http-backend.c           |   4 +-
 lockfile.c               |  10 --
 notes-merge.c            |   2 +-
 reflog-walk.c            |   5 +-
 refs.c                   | 438 ++++++++++++++++++++++++++++++++---------------
 refs.h                   |  40 +++--
 remote.c                 |  11 +-
 sequencer.c              |   8 +-
 t/t1400-update-ref.sh    |  62 +++----
 t/t1413-reflog-detach.sh |  70 ++++++++
 t/t1430-bad-ref-name.sh  | 207 ++++++++++++++++++++++
 t/t3200-branch.sh        |   9 +
 t/t7001-mv.sh            |  15 +-
 t/t9300-fast-import.sh   |  30 ----
 transport-helper.c       |   5 +-
 transport.c              |   5 +-
 upload-pack.c            |   2 +-
 walker.c                 |   5 +-
 wrapper.c                |  28 ++-
 wt-status.c              |   2 +-
 44 files changed, 838 insertions(+), 348 deletions(-)
 create mode 100755 t/t1413-reflog-detach.sh
 create mode 100755 t/t1430-bad-ref-name.sh

-- 
2.0.0.450.ga793d96

---
Changes since v21:

 branch.c                    |   2 +-
 builtin/blame.c             |   2 +-
 builtin/branch.c            |  25 ++---
 builtin/checkout.c          |   6 +-
 builtin/clone.c             |   2 +-
 builtin/commit.c            |   2 +-
 builtin/fetch.c             |   6 +-
 builtin/fmt-merge-msg.c     |   2 +-
 builtin/for-each-ref.c      |  11 +-
 builtin/fsck.c              |   2 +-
 builtin/log.c               |   4 +-
 builtin/merge.c             |   2 +-
 builtin/notes.c             |   2 +-
 builtin/receive-pack.c      |   4 +-
 builtin/remote.c            |  21 ++--
 builtin/show-branch.c       |   9 +-
 builtin/symbolic-ref.c      |   2 +-
 builtin/update-ref.c        |   3 +-
 bundle.c                    |   2 +-
 cache.h                     |  33 ++++--
 http-backend.c              |   5 +-
 notes-merge.c               |   2 +-
 reflog-walk.c               |   6 +-
 refs.c                      | 263 +++++++++++++++++++++++++-------------------
 refs.h                      |  34 +++---
 remote.c                    |  13 ++-
 sequencer.c                 |   4 +-
 t/t1400-update-ref.sh       |  46 ++------
 t/t1402-check-ref-format.sh |  48 --------
 t/t1413-reflog-detach.sh    |  70 ++++++++++++
 t/t1430-bad-ref-name.sh     | 207 ++++++++++++++++++++++++++++++++++
 t/t9300-fast-import.sh      |  30 -----
 transport-helper.c          |   5 +-
 transport.c                 |   6 +-
 upload-pack.c               |   2 +-
 wt-status.c                 |   2 +-
 36 files changed, 557 insertions(+), 328 deletions(-)

diff --git c/branch.c w/branch.c
index ba3e1c1..adb07c6 100644
--- c/branch.c
+++ w/branch.c
@@ -186,7 +186,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 		const char *head;
 		unsigned char sha1[20];
 
-		head = resolve_ref_unsafe("HEAD", sha1, NULL, 0);
+		head = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
diff --git c/builtin/blame.c w/builtin/blame.c
index b8bec0a..5cbd38f 100644
--- c/builtin/blame.c
+++ w/builtin/blame.c
@@ -2292,7 +2292,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->object.type = OBJ_COMMIT;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, NULL, RESOLVE_REF_READING))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
 		die("no such ref: HEAD");
 
 	parent_tail = append_parent(parent_tail, head_sha1);
diff --git c/builtin/branch.c w/builtin/branch.c
index 5d5bc56..94aaea1 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -129,8 +129,8 @@ static int branch_merged(int kind, const char *name,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name = reference_name_to_free =
-		     resolve_refdup(branch->merge[0]->dst, sha1,
-				    NULL, RESOLVE_REF_READING)) != NULL)
+		     resolve_refdup(branch->merge[0]->dst, RESOLVE_REF_READING,
+				    sha1, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -234,13 +234,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1, &flags,
+		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
-					    | RESOLVE_REF_NODEREF
-					    | RESOLVE_REF_ALLOW_BAD_NAME);
-		if (!target ||
-		    (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		     is_null_sha1(sha1))) {
+					    | RESOLVE_REF_NO_RECURSE
+					    | RESOLVE_REF_ALLOW_BAD_NAME,
+					    sha1, &flags);
+		if (!target) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
@@ -255,7 +254,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF|REF_BADNAMEOK)) {
+		if (delete_ref(name, sha1, REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
@@ -268,8 +267,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       ? _("Deleted remote branch %s (was %s).\n")
 			       : _("Deleted branch %s (was %s).\n"),
 			       bname.buf,
-			       (flags & REF_ISSYMREF)
-			       ? target
+			       (flags & REF_ISBROKEN) ? "broken"
+			       : (flags & REF_ISSYMREF) ? target
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
@@ -301,7 +300,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 	int flag;
 	const char *dst, *cp;
 
-	dst = resolve_ref_unsafe(src, sha1, &flag, 0);
+	dst = resolve_ref_unsafe(src, 0, sha1, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
 	if (prefix && (cp = skip_prefix(dst, prefix)))
@@ -867,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", head_sha1, NULL, 0);
+	head = resolve_refdup("HEAD", 0, head_sha1, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD")) {
diff --git c/builtin/checkout.c w/builtin/checkout.c
index 64af1f7..a5fef2d 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -356,7 +356,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", rev, &flag, 0);
+	read_ref_full("HEAD", 0, rev, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
@@ -771,7 +771,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	unsigned char rev[20];
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", rev, &flag, 0);
+	old.path = path_to_free = resolve_refdup("HEAD", 0, rev, &flag);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
@@ -1068,7 +1068,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		unsigned char rev[20];
 		int flag;
 
-		if (!read_ref_full("HEAD", rev, &flag, 0) &&
+		if (!read_ref_full("HEAD", 0, rev, &flag) &&
 		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
 			return switch_unborn_to_new_branch(opts);
 	}
diff --git c/builtin/clone.c w/builtin/clone.c
index 12a78e1..0f5c880 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -622,7 +622,7 @@ static int checkout(void)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", sha1, NULL, RESOLVE_REF_READING);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git c/builtin/commit.c w/builtin/commit.c
index 3536330..9ccc78b 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -1468,7 +1468,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", junk_sha1, NULL, 0);
+	head = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
 	printf("[%s%s ",
 		starts_with(head, "refs/heads/") ?
 			head + 11 :
diff --git c/builtin/fetch.c w/builtin/fetch.c
index 2e3bc73..30b40f6 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -392,10 +392,10 @@ static int s_update_ref(const char *action,
 		goto fail;
 
 	ret = ref_transaction_commit(transaction, &err);
-	if (ret == UPDATE_REFS_NAME_CONFLICT)
-		df_conflict = 1;
-	if (ret)
+	if (ret) {
+		df_conflict = (ret == TRANSACTION_NAME_CONFLICT);
 		goto fail;
+	}
 
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git c/builtin/fmt-merge-msg.c w/builtin/fmt-merge-msg.c
index b2355ad..afe05dc 100644
--- c/builtin/fmt-merge-msg.c
+++ w/builtin/fmt-merge-msg.c
@@ -602,7 +602,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", head_sha1, NULL, RESOLVE_REF_READING);
+		resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git c/builtin/for-each-ref.c w/builtin/for-each-ref.c
index 090390c..a88d681 100644
--- c/builtin/for-each-ref.c
+++ w/builtin/for-each-ref.c
@@ -649,8 +649,8 @@ static void populate_value(struct refinfo *ref)
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, unused1,
-					     NULL, RESOLVE_REF_READING);
+		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
+					     unused1, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
@@ -708,8 +708,8 @@ static void populate_value(struct refinfo *ref)
 			const char *head;
 			unsigned char sha1[20];
 
-			head = resolve_ref_unsafe("HEAD", sha1,
-						  NULL, RESOLVE_REF_READING);
+			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+						  sha1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
 			else
@@ -853,8 +853,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
-	if ((flag & REF_ISBROKEN) &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
 		  return 0;
 	}
diff --git c/builtin/fsck.c w/builtin/fsck.c
index 506e32b..7cd109a 100644
--- c/builtin/fsck.c
+++ w/builtin/fsck.c
@@ -560,7 +560,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", head_sha1, &flag, 0);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_sha1, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
diff --git c/builtin/log.c w/builtin/log.c
index 230a9ef..493440a 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -1395,8 +1395,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (check_head) {
 			unsigned char sha1[20];
 			const char *ref;
-			ref = resolve_ref_unsafe("HEAD", sha1, NULL,
-						 RESOLVE_REF_READING);
+			ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+						 sha1, NULL);
 			if (ref && starts_with(ref, "refs/heads/"))
 				branch_name = xstrdup(ref + strlen("refs/heads/"));
 			else
diff --git c/builtin/merge.c w/builtin/merge.c
index d262279..6f56967 100644
--- c/builtin/merge.c
+++ w/builtin/merge.c
@@ -1108,7 +1108,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, &flag, 0);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, &flag);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
diff --git c/builtin/notes.c w/builtin/notes.c
index 16df78c..eaf297d 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -703,7 +703,7 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", sha1, NULL, 0);
+		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
 
diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 555a4a6..8a6e7e3 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -656,7 +656,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, sha1, &flag, 0);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, sha1, &flag);
 	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
@@ -817,7 +817,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, NULL, 0);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
 	checked_connectivity = 1;
 	for (cmd = commands; cmd; cmd = cmd->next) {
diff --git c/builtin/remote.c w/builtin/remote.c
index 6eaeee7..8517cfa 100644
--- c/builtin/remote.c
+++ w/builtin/remote.c
@@ -568,8 +568,8 @@ static int read_remote_branches(const char *refname,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
-		symref = resolve_ref_unsafe(refname, orig_sha1, &flag,
-					    RESOLVE_REF_READING);
+		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
+					    orig_sha1, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
@@ -705,7 +705,7 @@ static int mv(int argc, const char **argv)
 		int flag = 0;
 		unsigned char sha1[20];
 
-		read_ref_full(item->string, sha1, &flag, RESOLVE_REF_READING);
+		read_ref_full(item->string, RESOLVE_REF_READING, sha1, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
@@ -750,13 +750,16 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
+	struct strbuf err = STRBUF_INIT;
 	const char **branch_names;
 	int i, result = 0;
 
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
-	result |= repack_without_refs(branch_names, branches->nr, NULL);
+	if (repack_without_refs(branch_names, branches->nr, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
 	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
@@ -1333,9 +1336,13 @@ static int prune_remote(const char *remote, int dry_run)
 		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run)
-			result |= repack_without_refs(delete_refs,
-						      states.stale.nr, NULL);
+		if (!dry_run) {
+			struct strbuf err = STRBUF_INIT;
+			if (repack_without_refs(delete_refs, states.stale.nr,
+						&err))
+				result |= error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		free(delete_refs);
 	}
 
diff --git c/builtin/show-branch.c w/builtin/show-branch.c
index ef6ea52..acc8dc1 100644
--- c/builtin/show-branch.c
+++ w/builtin/show-branch.c
@@ -727,8 +727,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (ac == 0) {
 			static const char *fake_av[2];
 
-			fake_av[0] = resolve_refdup("HEAD", sha1, NULL,
-						    RESOLVE_REF_READING);
+			fake_av[0] = resolve_refdup("HEAD",
+						    RESOLVE_REF_READING,
+						    sha1, NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -790,8 +791,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	head_p = resolve_ref_unsafe("HEAD", head_sha1, NULL,
-				    RESOLVE_REF_READING);
+	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+				    head_sha1, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git c/builtin/symbolic-ref.c w/builtin/symbolic-ref.c
index 1dd04af..29fb3f1 100644
--- c/builtin/symbolic-ref.c
+++ w/builtin/symbolic-ref.c
@@ -13,7 +13,7 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, sha1, &flag, 0);
+	const char *refname = resolve_ref_unsafe(HEAD, 0, sha1, &flag);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
diff --git c/builtin/update-ref.c w/builtin/update-ref.c
index e379fdd..6c9be05 100644
--- c/builtin/update-ref.c
+++ w/builtin/update-ref.c
@@ -419,8 +419,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (no_deref)
 		flags = REF_NODEREF;
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL,
-				  flags|REF_BADNAMEOK);
+		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags, UPDATE_REFS_DIE_ON_ERR);
diff --git c/bundle.c w/bundle.c
index 32dd2f7..d92e49c 100644
--- c/bundle.c
+++ w/bundle.c
@@ -311,7 +311,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
-		if (read_ref_full(e->name, sha1, &flag, RESOLVE_REF_READING))
+		if (read_ref_full(e->name, RESOLVE_REF_READING, sha1, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
diff --git c/cache.h w/cache.h
index 995729f..f582b6c 100644
--- c/cache.h
+++ w/cache.h
@@ -946,8 +946,8 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-extern int read_ref_full(const char *refname, unsigned char *sha1,
-			 int *flags, int resolve_flags);
+extern int read_ref_full(const char *refname, int resolve_flags,
+			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
 
 /*
@@ -969,27 +969,36 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
+ * If the RESOLVE_REF_NO_RECURSE flag is passed, only resolves one
+ * level of symbolic reference.  The value stored in sha1 for a symbolic
+ * reference will always be null_sha1 in this case, and the return
+ * value is the reference that the symref refers to directly.
+ *
  * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references), REF_ISSYMREF (if the initial reference was a
- * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
+ * symbolic reference), REF_BAD_NAME (if the reference name is ill
+ * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
+ * (if the ref is malformed).
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * RESOLVE_REF_ALLOW_BAD_NAME disables most of the ref name checking except
- * for names that are absolute paths or contain ".." components. For both
- * these cases the function will return NULL and set errno to EINVAL.
- * If the name is bad then the function will set the REF_ISBROKEN flag and
- * return the name, if the ref exists, or NULL, if it does not.
- * When this flag is set, any badly named refs will resolve to nullsha1.
+ * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
+ * name is invalid according to git-check-ref-format(1).  If the name
+ * is bad then the value stored in sha1 will be null_sha1 and the
+ * REF_ISBROKEN and REF_BAD_NAME flags will be set.
+ *
+ * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
+ * directory and do not consist of all caps and underscores cannot be
+ * resolved.  The function returns NULL for such ref names.
  */
 #define RESOLVE_REF_READING 0x01
-#define RESOLVE_REF_NODEREF 0x02
+#define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
-extern char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
+extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
+extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git c/http-backend.c w/http-backend.c
index 8f94f9b..e172886 100644
--- c/http-backend.c
+++ w/http-backend.c
@@ -417,8 +417,9 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 
 	if (flag & REF_ISSYMREF) {
 		unsigned char unused[20];
-		const char *target = resolve_ref_unsafe(refname, unused,
-						NULL, RESOLVE_REF_READING);
+		const char *target = resolve_ref_unsafe(refname,
+							RESOLVE_REF_READING,
+							unused, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
diff --git c/notes-merge.c w/notes-merge.c
index ffca602..3c88d17 100644
--- c/notes-merge.c
+++ w/notes-merge.c
@@ -549,7 +549,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
 
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, local_sha1, NULL, 0))
+	if (read_ref_full(o->local_ref, 0, local_sha1, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_sha1(local_sha1))
diff --git c/reflog-walk.c w/reflog-walk.c
index feeaf0a..23345ea 100644
--- c/reflog-walk.c
+++ w/reflog-walk.c
@@ -48,8 +48,8 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		unsigned char sha1[20];
 		const char *name;
 		void *name_to_free;
-		name = name_to_free = resolve_refdup(ref, sha1, NULL,
-						     RESOLVE_REF_READING);
+		name = name_to_free = resolve_refdup(ref, RESOLVE_REF_READING,
+						     sha1, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -175,7 +175,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (*branch == '\0') {
 			unsigned char sha1[20];
 			free(branch);
-			branch = resolve_refdup("HEAD", sha1, NULL, 0);
+			branch = resolve_refdup("HEAD", 0, sha1, NULL);
 			if (!branch)
 				die ("No current branch");
 
diff --git c/refs.c w/refs.c
index 3b27758..d9d327d 100644
--- c/refs.c
+++ w/refs.c
@@ -69,16 +69,8 @@ static int check_refname_component(const char *refname, int flags)
 out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
-		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
-		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
-	}
+	if (refname[0] == '.')
+		return -1; /* Component starts with '.'. */
 	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
@@ -193,8 +185,8 @@ struct ref_dir {
 
 /*
  * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
- * REF_ISPACKED=0x02, and REF_ISBROKEN=0x04 are public values; see
- * refs.h.
+ * REF_ISPACKED=0x02, REF_ISBROKEN=0x04 and REF_BAD_NAME=0x08 are
+ * public values; see refs.h.
  */
 
 /*
@@ -202,16 +194,16 @@ struct ref_dir {
  * the correct peeled value for the reference, which might be
  * null_sha1 if the reference is not a tag or if it is broken.
  */
-#define REF_KNOWS_PEELED 0x08
+#define REF_KNOWS_PEELED 0x10
 
 /* ref_entry represents a directory of references */
-#define REF_DIR 0x10
+#define REF_DIR 0x20
 
 /*
  * Entry has not yet been read from disk (used only for REF_DIR
  * entries representing loose references)
  */
-#define REF_INCOMPLETE 0x20
+#define REF_INCOMPLETE 0x40
 
 /*
  * A ref_entry represents either a reference or a "subdirectory" of
@@ -280,6 +272,37 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
+static int escapes_cwd(const char *path) {
+	char *buf;
+	int result;
+
+	if (is_absolute_path(path))
+		return 1;
+	buf = xmalloc(strlen(path) + 1);
+	result = !!normalize_path_copy(buf, path);
+	free(buf);
+	return result;
+}
+
+/*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long as the rest
+ * of the path components does not allow it to escape from this directory.
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_'.
+ */
+static int refname_is_safe(const char *refname)
+{
+	if (starts_with(refname, "refs/"))
+		return !escapes_cwd(refname + strlen("refs/"));
+	while (*refname) {
+		if (!isupper(*refname) && *refname != '_')
+			return 0;
+		refname++;
+	}
+	return 1;
+}
+
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
@@ -288,8 +311,10 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	struct ref_entry *ref;
 
 	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
+	if (!check_name && !refname_is_safe(refname))
+		die("Reference has invalid name: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -822,10 +847,9 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
- * oldrefname is non-NULL, ignore potential conflicts with oldrefname
- * (e.g., because oldrefname is scheduled for deletion in the same
- * operation). skiplist contains a list of refs we want to skip checking for
- * conflicts with. skiplist must be sorted.
+ * skiplist is non-NULL, ignore potential conflicts with names in
+ * skiplist (e.g., because those refs are scheduled for deletion in
+ * the same operation).  skiplist must be sorted.
  */
 static int is_refname_available(const char *refname,
 				struct ref_dir *dir,
@@ -1062,9 +1086,9 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		if (refname) {
 			int flag = REF_ISPACKED;
 
-			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
-				flag |= REF_ISBROKEN;
+			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 				hashclr(sha1);
+				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			last = create_ref_entry(refname, sha1, flag, 0);
 			if (peeled == PEELED_FULLY ||
@@ -1198,16 +1222,16 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else if (read_ref_full(refname.buf, sha1, &flag,
-						 RESOLVE_REF_READING)) {
+			} else if (read_ref_full(refname.buf,
+						 RESOLVE_REF_READING,
+						 sha1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
 			if (check_refname_format(refname.buf,
-						 REFNAME_ALLOW_ONELEVEL|
-						 REFNAME_DOT_COMPONENT)) {
+						 REFNAME_ALLOW_ONELEVEL)) {
 				hashclr(sha1);
-				flag |= REF_ISBROKEN;
+				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
 					 create_ref_entry(refname.buf, sha1, flag, 0));
@@ -1329,10 +1353,10 @@ static struct ref_entry *get_packed_ref(const char *refname)
  * A loose ref file doesn't exist; check for a packed ref.  The
  * options are forwarded from resolve_safe_unsafe().
  */
-static const char *handle_missing_loose_ref(const char *refname,
-					    unsigned char *sha1,
-					    int reading,
-					    int *flag)
+static int resolve_missing_loose_ref(const char *refname,
+				     int resolve_flags,
+				     unsigned char *sha1,
+				     int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1343,33 +1367,22 @@ static const char *handle_missing_loose_ref(const char *refname,
 	entry = get_packed_ref(refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
-		if (flag)
-			*flag |= REF_ISPACKED;
-		return refname;
+		if (flags)
+			*flags |= REF_ISPACKED;
+		return 0;
 	}
 	/* The reference is not a packed reference, either. */
-	if (reading) {
-		return NULL;
+	if (resolve_flags & RESOLVE_REF_READING) {
+		errno = ENOENT;
+		return -1;
 	} else {
 		hashclr(sha1);
-		return refname;
+		return 0;
 	}
 }
 
-static int escapes_cwd(const char *path) {
-	char *buf;
-	int result;
-
-	if (is_absolute_path(path))
-		return 1;
-	buf = xmalloc(strlen(path) + 1);
-	result = normalize_path_copy(buf, path);
-	free(buf);
-	return result;
-}
-
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *flags, int resolve_flags)
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
@@ -1381,14 +1394,22 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 		*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (flags)
+			*flags |= REF_BAD_NAME;
+
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    escapes_cwd(refname)) {
+		    !refname_is_safe(refname)) {
 			errno = EINVAL;
 			return NULL;
 		}
-		hashclr(sha1);
-		if (flags)
-			*flags |= REF_ISBROKEN;
+		/*
+		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * missing refs and refs that were present but invalid,
+		 * to complain about the latter to stderr.
+		 *
+		 * We don't know whether the ref exists, so don't set
+		 * REF_ISBROKEN yet.
+		 */
 		bad_name = 1;
 	}
 	for (;;) {
@@ -1415,12 +1436,17 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 		 */
 	stat_ref:
 		if (lstat(path, &st) < 0) {
-			if (errno == ENOENT)
-				return handle_missing_loose_ref(refname, sha1,
-					resolve_flags & RESOLVE_REF_READING,
-					flags);
-			else
+			if (errno != ENOENT)
 				return NULL;
+			if (resolve_missing_loose_ref(refname, resolve_flags,
+						      sha1, flags))
+				return NULL;
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			return refname;
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
@@ -1440,7 +1466,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 				refname = refname_buffer;
 				if (flags)
 					*flags |= REF_ISSYMREF;
-				if (resolve_flags & RESOLVE_REF_NODEREF) {
+				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 					hashclr(sha1);
 					return refname;
 				}
@@ -1493,8 +1519,11 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 				errno = EINVAL;
 				return NULL;
 			}
-			if (bad_name)
+			if (bad_name) {
 				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
 			return refname;
 		}
 		if (flags)
@@ -1502,23 +1531,28 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flags)
-				*flags |= REF_ISBROKEN;
-			errno = EINVAL;
-			return NULL;
-		}
 		refname = strcpy(refname_buffer, buf);
-		if (resolve_flags & RESOLVE_REF_NODEREF) {
+		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
 		}
+		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+			if (flags)
+				*flags |= REF_BAD_NAME | REF_ISBROKEN;
+
+			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+			    !refname_is_safe(buf)) {
+				errno = EINVAL;
+				return NULL;
+			}
+			bad_name = 1;
+		}
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags)
+char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags)
 {
-	const char *ret = resolve_ref_unsafe(ref, sha1, flags, resolve_flags);
+	const char *ret = resolve_ref_unsafe(ref, resolve_flags, sha1, flags);
 	return ret ? xstrdup(ret) : NULL;
 }
 
@@ -1529,22 +1563,22 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int *flags, int resolve_flags)
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
 {
-	if (resolve_ref_unsafe(refname, sha1, flags, resolve_flags))
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
 		return 0;
 	return -1;
 }
 
 int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(refname, sha1, NULL, RESOLVE_REF_READING);
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
 int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, NULL, RESOLVE_REF_READING);
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
@@ -1658,7 +1692,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, base, &flag, RESOLVE_REF_READING))
+	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
 		return -1;
 
 	/*
@@ -1699,7 +1733,7 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, junk, NULL, 0);
+	resolves_to = resolve_ref_unsafe(refname, 0, junk, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -1824,7 +1858,7 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", sha1, &flag, RESOLVE_REF_READING))
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, sha1, &flag))
 		return fn("HEAD", sha1, flag, cb_data);
 
 	return 0;
@@ -1904,7 +1938,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, &flag, RESOLVE_REF_READING))
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, sha1, &flag))
 		ret = fn(buf.buf, sha1, flag, cb_data);
 	strbuf_release(&buf);
 
@@ -1999,8 +2033,9 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (read_ref_full(lock->ref_name, lock->old_sha1, NULL,
-			  mustexist ? RESOLVE_REF_READING : 0)) {
+	if (read_ref_full(lock->ref_name,
+			  mustexist ? RESOLVE_REF_READING : 0,
+			  lock->old_sha1, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
@@ -2073,8 +2108,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result, &flag,
-				       RESOLVE_REF_READING);
+		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
+				       this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -2103,7 +2138,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		const char *ref, *it;
 
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, NULL, RESOLVE_REF_READING);
+		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
+					 hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path))
@@ -2145,16 +2181,16 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	if (flags & REF_BADNAMEOK)
-		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
-
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_NODEREF)
-		resolve_flags |= RESOLVE_REF_NODEREF;
+	if (flags & REF_DELETING) {
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+		if (flags & REF_NODEREF)
+			resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	}
 
-	refname = resolve_ref_unsafe(refname, lock->old_sha1, &type,
-				     resolve_flags);
+	refname = resolve_ref_unsafe(refname, resolve_flags,
+				     lock->old_sha1, &type);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2167,8 +2203,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			error("there are still refs under '%s'", orig_refname);
 			goto error_return;
 		}
-		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
-					     &type, resolve_flags);
+		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
+					     lock->old_sha1, &type);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2521,7 +2557,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 		unsigned char sha1[20];
 		int flags;
 
-		if (read_ref_full(entry->name, sha1, &flags, 0))
+		if (read_ref_full(entry->name, 0, sha1, &flags))
 			/* We should at least have found the packed ref. */
 			die("Internal error");
 		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
@@ -2712,8 +2748,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, &flag,
-				    RESOLVE_REF_READING);
+	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
+				    orig_sha1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2742,7 +2778,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, NULL, RESOLVE_REF_READING) &&
+	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
@@ -2956,7 +2992,7 @@ static int is_branch(const char *refname)
 }
 
 /*
- * Writes sha1 into the ref specified by the lock. Makes sure that errno
+ * Write sha1 into the ref specified by the lock. Make sure that errno
  * is sane on error.
  */
 static int write_ref_sha1(struct ref_lock *lock,
@@ -3020,8 +3056,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", head_sha1, &head_flag,
-					      RESOLVE_REF_READING);
+		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -3388,7 +3424,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
 				unsigned char sha1[20];
-				if (read_ref_full(name->buf, sha1, NULL, 0))
+				if (read_ref_full(name->buf, 0, sha1, NULL))
 					retval = error("bad ref for %s", name->buf);
 				else
 					retval = fn(name->buf, sha1, 0, cb_data);
@@ -3667,27 +3703,30 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
-		ret = -1;
+		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		int flags = update->flags;
 
+		if (is_null_sha1(update->new_sha1))
+			flags |= REF_DELETING;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
 						   NULL,
-						   update->flags,
+						   flags,
 						   &update->type);
 		if (!update->lock) {
-			int df_conflict = (errno == ENOTDIR);
-
+			ret = (errno == ENOTDIR)
+				? TRANSACTION_NAME_CONFLICT
+				: TRANSACTION_GENERIC_ERROR;
 			strbuf_addf(err, "Cannot lock the ref '%s'.",
 				    update->refname);
-			ret = df_conflict ? UPDATE_REFS_NAME_CONFLICT : -1;
 			goto cleanup;
 		}
 	}
@@ -3697,15 +3736,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     update->msg);
-			update->lock = NULL; /* freed by write_ref_sha1 */
-			if (ret) {
+			if (write_ref_sha1(update->lock, update->new_sha1,
+					   update->msg)) {
+				update->lock = NULL; /* freed by write_ref_sha1 */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
-				ret = -1;
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
+			update->lock = NULL; /* freed by write_ref_sha1 */
 		}
 	}
 
@@ -3715,7 +3754,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
-				ret = -1;
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
@@ -3725,7 +3764,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	if (repack_without_refs(delnames, delnum, err)) {
-		ret = -1;
+		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
 	for (i = 0; i < delnum; i++)
diff --git c/refs.h w/refs.h
index a96e174..3b35387 100644
--- c/refs.h
+++ w/refs.h
@@ -56,11 +56,15 @@ struct ref_transaction;
 
 /*
  * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file, or
- * symbolic reference refers to ill-formatted reference name.
+ * reference (directly or indirectly), corrupt reference file,
+ * reference exists but name is bad, or symbolic reference refers to
+ * ill-formatted reference name.
  */
 #define REF_ISBROKEN 0x04
 
+/* Reference name is not well formed (see git-check-ref-format(1)). */
+#define REF_BAD_NAME 0x08
+
 /*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
@@ -175,12 +179,12 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
- * REF_BADNAMEOK: allow locking a ref that has a bad name.
+ * REF_DELETING: tolerate broken refs
  *
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
-#define REF_BADNAMEOK	0x02
+#define REF_DELETING	0x02
 /*
  * This function sets errno to something meaningful on failure.
  */
@@ -226,7 +230,6 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
-#define REFNAME_DOT_COMPONENT 4
 
 /*
  * Return 0 iff refname has the correct format for a refname according
@@ -234,10 +237,7 @@ extern int for_each_reflog(each_ref_fn, void *);
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.  If
- * REFNAME_DOT_COMPONENT is set in flags, then allow refname
- * components to start with "." (but not a whole component equal to
- * "." or "..").
+ * components.  No leading or repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
@@ -270,8 +270,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * The following functions add a reference check or update to a
  * ref_transaction.  In all of them, refname is the name of the
  * reference to be affected.  The functions make internal copies of
- * refname, so the caller retains ownership of the parameter.  flags
- * can be REF_NODEREF; it is passed to update_ref_lock().
+ * refname and msg, so the caller retains ownership of these parameters.
+ * flags can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
 /*
@@ -322,14 +322,14 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 
 /*
  * Commit all of the changes that have been queued in transaction, as
- * atomically as possible.  Return a nonzero value if there is a
- * problem.
+ * atomically as possible.
  *
- * Function returns 0 on success, -1 for generic failures and
- * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a naming conflict.
- * For example, the ref names A and A/B conflict.
+ * Returns 0 for success, or one of the below error codes for errors.
  */
-#define UPDATE_REFS_NAME_CONFLICT -2
+/* Naming conflict (for example, the ref names A and A/B conflict). */
+#define TRANSACTION_NAME_CONFLICT -1
+/* All other errors. */
+#define TRANSACTION_GENERIC_ERROR -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
diff --git c/remote.c w/remote.c
index 67c375d..25b07ac 100644
--- c/remote.c
+++ w/remote.c
@@ -486,7 +486,7 @@ static void read_config(void)
 		return;
 	default_remote_name = "origin";
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", sha1, &flag, 0);
+	head_ref = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    starts_with(head_ref, "refs/heads/")) {
 		current_branch =
@@ -1121,8 +1121,8 @@ static char *guess_ref(const char *name, struct ref *peer)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	const char *r = resolve_ref_unsafe(peer->name, sha1, NULL,
-					   RESOLVE_REF_READING);
+	const char *r = resolve_ref_unsafe(peer->name, RESOLVE_REF_READING,
+					   sha1, NULL);
 	if (!r)
 		return NULL;
 
@@ -1183,8 +1183,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		unsigned char sha1[20];
 		int flag;
 
-		dst_value = resolve_ref_unsafe(matched_src->name, sha1, &flag,
-					       RESOLVE_REF_READING);
+		dst_value = resolve_ref_unsafe(matched_src->name,
+					       RESOLVE_REF_READING,
+					       sha1, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1658,7 +1659,7 @@ static int ignore_symref_update(const char *refname)
 	unsigned char sha1[20];
 	int flag;
 
-	if (!resolve_ref_unsafe(refname, sha1, &flag, 0))
+	if (!resolve_ref_unsafe(refname, 0, sha1, &flag))
 		return 0; /* non-existing refs are OK */
 	return (flag & REF_ISSYMREF);
 }
diff --git c/sequencer.c w/sequencer.c
index 6a05ad4..70fb7a8 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -366,7 +366,7 @@ static int is_index_unchanged(void)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, NULL, RESOLVE_REF_READING))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
 		return error(_("Could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
@@ -912,7 +912,7 @@ static int rollback_single_pick(void)
 	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
 	    !file_exists(git_path("REVERT_HEAD")))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", head_sha1, NULL, 0))
+	if (read_ref_full("HEAD", 0, head_sha1, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_sha1(head_sha1))
 		return error(_("cannot abort from a branch yet to be born"));
diff --git c/t/t1400-update-ref.sh w/t/t1400-update-ref.sh
index ff4607b..7b4707b 100755
--- c/t/t1400-update-ref.sh
+++ w/t/t1400-update-ref.sh
@@ -126,6 +126,16 @@ test_expect_success 'update-ref --no-deref -d can delete self-reference' '
 	test_path_is_missing .git/refs/heads/self
 '
 
+test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
+	>.git/refs/heads/bad &&
+	test_when_finished "rm -f .git/refs/heads/bad" &&
+	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
+	test_when_finished "rm -f .git/refs/heads/ref-to-bad" &&
+	test_path_is_file .git/refs/heads/ref-to-bad &&
+	git update-ref --no-deref -d refs/heads/ref-to-bad &&
+	test_path_is_missing .git/refs/heads/ref-to-bad
+'
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
@@ -390,12 +400,6 @@ test_expect_success 'stdin fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin fails create with bad ref name' '
-	echo "create ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -414,12 +418,6 @@ test_expect_success 'stdin fails update with no ref' '
 	grep "fatal: update: missing <ref>" err
 '
 
-test_expect_success 'stdin fails update with bad ref name' '
-	echo "update ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -438,12 +436,6 @@ test_expect_success 'stdin fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin fails delete with bad ref name' '
-	echo "delete ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -716,12 +708,6 @@ test_expect_success 'stdin -z fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails create with bad ref name' '
-	printf $F "create ~a " "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a " err
-'
-
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
@@ -746,12 +732,6 @@ test_expect_success 'stdin -z fails update with too few args' '
 	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
-test_expect_success 'stdin -z fails update with bad ref name' '
-	printf $F "update ~a" "$m" "" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
@@ -784,12 +764,6 @@ test_expect_success 'stdin -z fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails delete with bad ref name' '
-	printf $F "delete ~a" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
diff --git c/t/t1402-check-ref-format.sh w/t/t1402-check-ref-format.sh
index 058fa37..1a5a5f3 100755
--- c/t/t1402-check-ref-format.sh
+++ w/t/t1402-check-ref-format.sh
@@ -196,52 +196,4 @@ invalid_ref_normalized 'heads///foo.lock'
 invalid_ref_normalized 'foo.lock/bar'
 invalid_ref_normalized 'foo.lock///bar'
 
-test_expect_success 'git branch shows badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch >output &&
-	grep -e "broken...ref" output
-'
-
-test_expect_success 'git branch -d can delete badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch -d broken...ref &&
-	git branch >output &&
-	! grep -e "broken...ref" output
-'
-
-test_expect_success 'git branch -D can delete badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch -D broken...ref &&
-	git branch >output &&
-	! grep -e "broken...ref" output
-'
-
-test_expect_success 'git update-ref -d can delete badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git update-ref -d refs/heads/broken...ref &&
-	git branch >output &&
-	! grep -e "broken...ref" output
-'
-
-test_expect_success 'git branch can not create a badly named ref' '
-	test_must_fail git branch broken...ref
-'
-
-test_expect_success 'git branch can not rename to a bad ref name' '
-	git branch goodref &&
-	test_must_fail git branch -m goodref broken...ref
-'
-
-test_expect_failure 'git branch can rename from a bad ref name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch -m broken...ref renamed &&
-	test_must_fail git rev-parse broken...ref &&
-	test_cmp_rev master renamed
-'
-
 test_done
diff --git c/t/t1413-reflog-detach.sh w/t/t1413-reflog-detach.sh
new file mode 100755
index 0000000..c730600
--- /dev/null
+++ w/t/t1413-reflog-detach.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='Test reflog interaction with detached HEAD'
+. ./test-lib.sh
+
+reset_state () {
+	git checkout master &&
+	cp saved_reflog .git/logs/HEAD
+}
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m initial &&
+	git branch side &&
+	test_tick &&
+	git commit --allow-empty -m second &&
+	cat .git/logs/HEAD >saved_reflog
+'
+
+test_expect_success baseline '
+	reset_state &&
+	git rev-parse master master^ >expect &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'switch to branch' '
+	reset_state &&
+	git rev-parse side master master^ >expect &&
+	git checkout side &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'detach to other' '
+	reset_state &&
+	git rev-parse master side master master^ >expect &&
+	git checkout side &&
+	git checkout master^0 &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'detach to self' '
+	reset_state &&
+	git rev-parse master master master^ >expect &&
+	git checkout master^0 &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attach to self' '
+	reset_state &&
+	git rev-parse master master master master^ >expect &&
+	git checkout master^0 &&
+	git checkout master &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attach to other' '
+	reset_state &&
+	git rev-parse side master master master^ >expect &&
+	git checkout master^0 &&
+	git checkout side &&
+	git log -g --format=%H >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git c/t/t1430-bad-ref-name.sh w/t/t1430-bad-ref-name.sh
new file mode 100755
index 0000000..468e856
--- /dev/null
+++ w/t/t1430-bad-ref-name.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+
+test_description='Test handling of ref names that check-ref-format rejects'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit one &&
+	test_commit two
+'
+
+test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit .badbranchname
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit bad[branch]name
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'git branch shows badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch >output &&
+	grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -D can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -D broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -D cannot delete non-ref in .git dir' '
+	echo precious >.git/my-private-file &&
+	echo precious >expect &&
+	test_must_fail git branch -D ../../my-private-file &&
+	test_cmp expect .git/my-private-file
+'
+
+test_expect_success 'branch -D cannot delete absolute path' '
+	git branch -f extra &&
+	test_must_fail git branch -D "$(pwd)/.git/refs/heads/extra" &&
+	test_cmp_rev HEAD extra
+'
+
+test_expect_success 'git branch cannot create a badly named ref' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_must_fail git branch broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -m cannot rename to a bad ref name' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_might_fail git branch -D goodref &&
+	git branch goodref &&
+	test_must_fail git branch -m goodref broken...ref &&
+	test_cmp_rev master goodref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_failure 'branch -m can rename from a bad ref name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -m broken...ref renamed &&
+	test_cmp_rev master renamed &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'push cannot create a badly named ref' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_failure 'push --mirror can delete badly named ref' '
+	top=$(pwd) &&
+	git init src &&
+	git init dest &&
+
+	(
+		cd src &&
+		test_commit one
+	) &&
+	(
+		cd dest &&
+		test_commit two &&
+		git checkout --detach &&
+		cp .git/refs/heads/master .git/refs/heads/broken...ref
+	) &&
+	git -C src push --mirror "file://$top/dest" &&
+	git -C dest branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'rev-parse skips symref pointing to broken name' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch shadow one &&
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
+
+	git rev-parse --verify one >expect &&
+	git rev-parse --verify shadow >actual 2>err &&
+	test_cmp expect actual &&
+	test_i18ngrep "ignoring.*refs/tags/shadow" err
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
+	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_path_is_file .git/refs/heads/badname &&
+	git update-ref --no-deref -d refs/heads/badname &&
+	test_path_is_missing .git/refs/heads/badname
+'
+
+test_expect_success 'update-ref -d can delete broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git update-ref -d refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
+	echo precious >.git/my-private-file &&
+	echo precious >expect &&
+	test_must_fail git update-ref -d my-private-file &&
+	test_cmp expect .git/my-private-file
+'
+
+test_expect_success 'update-ref -d cannot delete absolute path' '
+	git branch -f extra &&
+	test_must_fail git update-ref -d "$(pwd)/.git/refs/heads/extra" &&
+	test_cmp_rev HEAD extra
+'
+
+test_expect_success 'update-ref --stdin fails create with bad ref name' '
+	echo "create ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails update with bad ref name' '
+	echo "update ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails delete with bad ref name' '
+	echo "delete ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails create with bad ref name' '
+	printf "%s\0" "create ~a " refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a " err
+'
+
+test_expect_success 'update-ref --stdin -z fails update with bad ref name' '
+	printf "%s\0" "update ~a" refs/heads/master "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
+	printf "%s\0" "delete ~a" refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_done
diff --git c/t/t9300-fast-import.sh w/t/t9300-fast-import.sh
index 5fc9ef2..3d156f9 100755
--- c/t/t9300-fast-import.sh
+++ w/t/t9300-fast-import.sh
@@ -347,36 +347,6 @@ test_expect_success 'B: fail on invalid blob sha1' '
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
-commit .badbranchname
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
-commit bad[branch]name
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
 commit TEMP_TAG
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
diff --git c/transport-helper.c w/transport-helper.c
index 8365441..3497a5e 100644
--- c/transport-helper.c
+++ w/transport-helper.c
@@ -890,8 +890,9 @@ static int push_refs_with_export(struct transport *transport,
 
 					/* Follow symbolic refs (mainly for HEAD). */
 					name = resolve_ref_unsafe(
-						 ref->peer_ref->name, sha1,
-						 &flag, RESOLVE_REF_READING);
+						 ref->peer_ref->name,
+						 RESOLVE_REF_READING,
+						 sha1, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
diff --git c/transport.c w/transport.c
index 3ba7bbf..76e0a9a 100644
--- c/transport.c
+++ w/transport.c
@@ -168,8 +168,8 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
-		tmp = resolve_ref_unsafe(localname, sha, &flag,
-					 RESOLVE_REF_READING);
+		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
+					 sha, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
@@ -754,7 +754,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	unsigned char head_sha1[20];
 	char *head;
 
-	head = resolve_refdup("HEAD", head_sha1, NULL, RESOLVE_REF_READING);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git c/upload-pack.c w/upload-pack.c
index 3b51ccb..4542565 100644
--- c/upload-pack.c
+++ w/upload-pack.c
@@ -743,7 +743,7 @@ static int find_symref(const char *refname, const unsigned char *sha1, int flag,
 
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, unused, &flag, 0);
+	symref_target = resolve_ref_unsafe(refname, 0, unused, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, refname);
diff --git c/wt-status.c w/wt-status.c
index 6819e2b..c3cbf50 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -128,7 +128,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", sha1, NULL, 0);
+	s->branch = resolve_refdup("HEAD", 0, sha1, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
