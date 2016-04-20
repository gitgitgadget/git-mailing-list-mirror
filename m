From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/12] worktree.c: test if branch being rebased in another worktree
Date: Wed, 20 Apr 2016 20:24:50 +0700
Message-ID: <1461158693-21289-10-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9X-00058K-8t
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbcDTN0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:38 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36427 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:37 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so18322658pfe.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzLVMsfScglndJCzVZ+P4kFvd7xjl4sVlVJsuTAL72c=;
        b=kmnW92z52Beh2fcRfJs+3OkTe018criwu1vZRLIQdWmvz/hX146HycPlPr3XXL/Bak
         h8C0Xbjz1gRsXEYaJHzVF9ainY4kGV1GXYYpeTQuzRpxn1LNRcN5kVTLn9JpFDWOGSye
         5ZSnRma6YfsUFp2MjSP9uCABaYwC6K2S1dVccw2Yt1PadDkkRmBWXsWaPRhD+rECnUHd
         fwG8SahlRGH0vnFEMT/ZpvSZRhmwKz8kP8hpKPUtLc5mhsCZOZruKqkEj7uTsuMjoiiz
         r9sKoLppSzSrfwBS/uzxwAfsnkHwYX90EZKocdBq4XBReyS31k/yBpJZgyfkNP8cEExN
         EfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzLVMsfScglndJCzVZ+P4kFvd7xjl4sVlVJsuTAL72c=;
        b=VDlVBmY5hSi79MSQfr7MUk1NJy+UpSe095tU2fZ8r4Ar3JR0xE+qLbLpraN2pEoGnE
         ck+yCWhFTuZkPcr6igip/Yls7N9566ASuxDh8jhCk5KiSC55fZfR+lfK5XP9oGa6Poqm
         6eIePn0jIhdsOGVerQTg/FlRX3cktqYkJHg79yGCk2bXV2MmL0pUk1ztloG8w44D3/gy
         vfG6yeZ/5vSsiwDCQeguGz07hYWd9ZtrshWRL+Y3K7vEj6zqcalbkYgUa1AE/wmBCc08
         jUwBoCDt7MHXUUXeBs3oOLS6X4enB21TnCcmLLgJcj94SPdSSfDuFkao09UaKqdRDlcC
         y1mA==
X-Gm-Message-State: AOPr4FXwZDr5en3Rj3Gp2AO6sssS/7ulrsjAoBGynlatoFhDjjPjL03gKBSsSrKpAW4uLA==
X-Received: by 10.98.1.197 with SMTP id 188mr12274249pfb.8.1461158796728;
        Wed, 20 Apr 2016 06:26:36 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id qb1sm31948669pac.44.2016.04.20.06.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292021>

This function find_shared_symref() is used in a couple places:

1) in builtin/branch.c: it's used to detect if a branch is checked out
   elsewhere and refuse to delete the branch.

2) in builtin/notes.c: it's used to detect if a note is being merged in
   another worktree

3) in branch.c, the function die_if_checked_out() is actually used by
   "git checkout" and "git worktree add" to see if a branch is already
   checked out elsewhere and refuse the operation.

In cases 1 and 3, if a rebase is ongoing, "HEAD" will be in detached
mode, find_shared_symref() fails to detect it and declares "no branch i=
s
checked out here", which is incorrect.

This patch tightens the test. If the given symref is "HEAD", we try to
detect if rebase is ongoing. If so return the branch being rebased. Thi=
s
makes checkout and branch delete operations safer because you can't
checkout a branch being rebased in another place, or delete it.

Special case for checkout. If the current branch is being rebased,
git-rebase.sh may use "git checkout" to abort and return back to the
original branch. The updated test in find_shared_symref() will prevent
that and "git rebase --abort" will fail as a result.
find_shared_symref() and die_if_checked_out() have to learn a new
option ignore_current_worktree to loose the test a bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c                |  4 ++--
 branch.h                |  2 +-
 builtin/branch.c        |  2 +-
 builtin/checkout.c      |  2 +-
 builtin/notes.c         |  2 +-
 builtin/worktree.c      |  4 ++--
 t/t2025-worktree-add.sh | 38 ++++++++++++++++++++++++++++++++++++++
 worktree.c              | 32 +++++++++++++++++++++++++++++++-
 worktree.h              |  3 ++-
 9 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/branch.c b/branch.c
index a84fb2c..8e323d3 100644
--- a/branch.c
+++ b/branch.c
@@ -334,11 +334,11 @@ void remove_branch_state(void)
 	unlink(git_path_squash_msg());
 }
=20
-void die_if_checked_out(const char *branch)
+void die_if_checked_out(const char *branch, int ignore_current_worktre=
e)
 {
 	const struct worktree *wt;
=20
-	wt =3D find_shared_symref("HEAD", branch);
+	wt =3D find_shared_symref("HEAD", branch, ignore_current_worktree);
 	if (wt) {
 		skip_prefix(branch, "refs/heads/", &branch);
 		die(_("'%s' is already checked out at '%s'"),
diff --git a/branch.h b/branch.h
index d69163d..b2f9649 100644
--- a/branch.h
+++ b/branch.h
@@ -58,7 +58,7 @@ extern int read_branch_desc(struct strbuf *, const ch=
ar *branch_name);
  * worktree and die (with a message describing its checkout location) =
if
  * it is.
  */
-extern void die_if_checked_out(const char *branch);
+extern void die_if_checked_out(const char *branch, int ignore_current_=
worktree);
=20
 /*
  * Update all per-worktree HEADs pointing at the old ref to point the =
new ref.
diff --git a/builtin/branch.c b/builtin/branch.c
index bcde87d..bf91bbd 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,7 +221,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
=20
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =3D
-				find_shared_symref("HEAD", name);
+				find_shared_symref("HEAD", name, 0);
 			if (wt) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index efcbd8f..6041718 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1111,7 +1111,7 @@ static int checkout_branch(struct checkout_opts *=
opts,
 		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
-			die_if_checked_out(new->path);
+			die_if_checked_out(new->path, 1);
 		free(head_ref);
 	}
=20
diff --git a/builtin/notes.c b/builtin/notes.c
index c65b59a..f154a69 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -852,7 +852,7 @@ static int merge(int argc, const char **argv, const=
 char *prefix)
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		wt =3D find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
+		wt =3D find_shared_symref("NOTES_MERGE_REF", default_notes_ref(), 0)=
;
 		if (wt)
 			die(_("A notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d8e3795..12c0af7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -205,7 +205,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
 		 ref_exists(symref.buf)) { /* it's a branch */
 		if (!opts->force)
-			die_if_checked_out(symref.buf);
+			die_if_checked_out(symref.buf, 0);
 	} else { /* must be a commit */
 		commit =3D lookup_commit_reference_by_name(refname);
 		if (!commit)
@@ -349,7 +349,7 @@ static int add(int ac, const char **av, const char =
*prefix)
 		if (!opts.force &&
 		    !strbuf_check_branch_ref(&symref, opts.new_branch) &&
 		    ref_exists(symref.buf))
-			die_if_checked_out(symref.buf);
+			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
=20
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 3acb992..da54327 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -4,6 +4,8 @@ test_description=3D'test git worktree add'
=20
 . ./test-lib.sh
=20
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 test_expect_success 'setup' '
 	test_commit init
 '
@@ -225,4 +227,40 @@ test_expect_success '"add" worktree with --checkou=
t' '
 	test_cmp init.t swamp2/init.t
 '
=20
+test_expect_success 'put a worktree under rebase' '
+	git worktree add under-rebase &&
+	(
+		cd under-rebase &&
+		set_fake_editor &&
+		FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
+		git worktree list | grep "under-rebase.*detached HEAD"
+	)
+'
+
+test_expect_success 'add a worktree, checking out a rebased branch' '
+	test_must_fail git worktree add new-rebase under-rebase &&
+	! test -d new-rebase
+'
+
+test_expect_success 'checking out a rebased branch from another worktr=
ee' '
+	git worktree add new-place &&
+	test_must_fail git -C new-place checkout under-rebase
+'
+
+test_expect_success 'not allow to delete a branch under rebase' '
+	(
+		cd under-rebase &&
+		test_must_fail git branch -D under-rebase
+	)
+'
+
+test_expect_success 'check out from current worktree branch ok' '
+	(
+		cd under-rebase &&
+		git checkout under-rebase &&
+		git checkout - &&
+		git rebase --abort
+	)
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index b5ca78f..dc380a2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "worktree.h"
 #include "dir.h"
+#include "wt-status.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -207,8 +208,27 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+static int is_worktree_being_rebased(const struct worktree *wt,
+				     const char *target)
+{
+	struct wt_status_state state;
+	int found_rebase;
+
+	memset(&state, 0, sizeof(state));
+	found_rebase =3D wt_status_check_rebase(wt, &state) &&
+		((state.rebase_in_progress ||
+		  state.rebase_interactive_in_progress) &&
+		 state.branch &&
+		 starts_with(target, "refs/heads/") &&
+		 !strcmp(state.branch, target + strlen("refs/heads/")));
+	free(state.branch);
+	free(state.onto);
+	return found_rebase;
+}
+
 const struct worktree *find_shared_symref(const char *symref,
-					  const char *target)
+					  const char *target,
+					  int ignore_current_worktree)
 {
 	const struct worktree *existing =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
@@ -223,6 +243,16 @@ const struct worktree *find_shared_symref(const ch=
ar *symref,
 	for (i =3D 0; worktrees[i]; i++) {
 		struct worktree *wt =3D worktrees[i];
=20
+		if (ignore_current_worktree && wt->is_current)
+			continue;
+
+		if (wt->is_detached && !strcmp(symref, "HEAD")) {
+			if (is_worktree_being_rebased(wt, target)) {
+				existing =3D wt;
+				break;
+			}
+		}
+
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s",
diff --git a/worktree.h b/worktree.h
index 9d2463e..fb9f5cc 100644
--- a/worktree.h
+++ b/worktree.h
@@ -41,7 +41,8 @@ extern void free_worktrees(struct worktree **);
  * may be destroyed by the next call.
  */
 extern const struct worktree *find_shared_symref(const char *symref,
-						 const char *target);
+						 const char *target,
+						 int ignore_current_worktree);
=20
 /*
  * Similar to git_path() and git_pathdup() but can produce paths for a
--=20
2.8.0.rc0.210.gd302cd2
