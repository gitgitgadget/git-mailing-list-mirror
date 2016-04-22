From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/13] worktree.c: check whether branch is rebased in another worktree
Date: Fri, 22 Apr 2016 20:01:33 +0700
Message-ID: <1461330096-21783-11-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajR-0007cb-C7
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcDVNCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:43 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34384 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbcDVNCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:42 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so6250327pac.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSGNrnSYuCrLqM5Vu1Iy+wr+YfZti00oiQ4Srb7oE9o=;
        b=owX3m2UROlSoND/VW0GCfTr+U0bS/fYpkccOgdCOL7C5rc7xER9+b9M4J2Cs7oVT0R
         vQWoRNn4+jGhXRRTgH9FdhSbXzZrPYeH726s2QVbQeZvjOBUwqrLQDMyKdNpbh8Jx86B
         q2WGJE/ZzzW7YPrVJXiB5FFQvYDtLgf50KIoG15ig3LE/RrHJiZZxe/M/pNHq5QPlsfo
         9KYkQyJTIrEiWgvAcB0zClrx4xF+dof1phFIbr/k8Au5WU3GzT8HX4TQDyG32C+sJHbo
         joeKYX3M7EXmo536B05EcZ71GCyNcGDAmXr1gJo0VVT6oxV6Npb9MdZqDo+6xIEFptZU
         +z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSGNrnSYuCrLqM5Vu1Iy+wr+YfZti00oiQ4Srb7oE9o=;
        b=KgQ9pbYZ34v/KZ5kVVzhhVIS6/vrdJJGUfXypwvioOq7XoMEW6ZpdXib4/UYHRyKJH
         TBCFfxyqqRXlnV/2Of48TRkZVc3GNRIYNgnOPE+np9x8bwIbPoGu3SebXvEL0SeWOsa0
         Qt+y39PKLDnwwlxq6EtuN4ZZ5LYYdpN/O8LR7bhTJEM1iu7eeAeviSjK7TU4ITRMxU8h
         oTE7xup+wYgvgLA0eU3uwNQ+ZooJ/05THfguY+/Y4Kt5Bbpu5PA1gPIET0rI2PH6bQAc
         fAlzPOlg7pTgdbZNitPG4QDrvYVr7MqlKVeJTdpZ0WCcDCNLpeRcUF7ywOGRNTv4KKXY
         UKRw==
X-Gm-Message-State: AOPr4FWvKKW/aP8kkNAMjlymyjjAM2qXAvUp/vV9gnGyLelz0Ivj37k7sJFgo84gUgIPyg==
X-Received: by 10.67.14.6 with SMTP id fc6mr27634650pad.55.1461330161175;
        Fri, 22 Apr 2016 06:02:41 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id 28sm8396374pfr.89.2016.04.22.06.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:55 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292199>

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
checked out here", which is not really what we want.

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
option ignore_current_worktree to loosen the test a bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c                |  4 ++--
 branch.h                |  2 +-
 builtin/checkout.c      |  2 +-
 builtin/worktree.c      |  4 ++--
 t/t2025-worktree-add.sh | 38 ++++++++++++++++++++++++++++++++++++++
 worktree.c              | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 1f1fbf5..a5a8dcb 100644
--- a/branch.c
+++ b/branch.c
@@ -334,12 +334,12 @@ void remove_branch_state(void)
 	unlink(git_path_squash_msg());
 }
=20
-void die_if_checked_out(const char *branch)
+void die_if_checked_out(const char *branch, int ignore_current_worktre=
e)
 {
 	const struct worktree *wt;
=20
 	wt =3D find_shared_symref("HEAD", branch);
-	if (!wt)
+	if (!wt || (ignore_current_worktree && wt->is_current))
 		return;
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
index 927905b..5043756 100644
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
@@ -215,6 +216,30 @@ const char *get_worktree_git_dir(const struct work=
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
+/*
+ * note: this function should be able to detect shared symref even if
+ * HEAD is temporarily detached (e.g. in the middle of rebase or
+ * bisect). New commands that do similar things should update this
+ * function as well.
+ */
 const struct worktree *find_shared_symref(const char *symref,
 					  const char *target)
 {
@@ -231,6 +256,13 @@ const struct worktree *find_shared_symref(const ch=
ar *symref,
 	for (i =3D 0; worktrees[i]; i++) {
 		struct worktree *wt =3D worktrees[i];
=20
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
--=20
2.8.0.rc0.210.gd302cd2
