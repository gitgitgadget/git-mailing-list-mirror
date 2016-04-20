From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/12] worktree.c: make find_shared_symref() return struct worktree *
Date: Wed, 20 Apr 2016 20:24:44 +0700
Message-ID: <1461158693-21289-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass8v-0004mU-OC
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbcDTN0D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33985 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:01 -0400
Received: by mail-pa0-f49.google.com with SMTP id r5so16299548pag.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0eGrMTdcbGs8ApCK0DSGGF2wkpm4f1W5dBmpwjtCmQ=;
        b=Ynl4EfiiS0/BpQ/Q4CEpt1SeiHmT/ivLiWO8tTX0drVoxnqaJbY0IvXL4tewmjcQDp
         b0py3Jpu7y4SzedXVU4wixtoaUJn1GXmOtR+RWiibZAEC9frVRdW7Jk272VG89P19LFp
         tnRE4bUETFAYKuE4T3CJkKoEjeteKIuIYrlRYhhSqjES/5oyRMbg4qUtHNPF9jpcvqGr
         WkG1dN/8Ql8eHdGLGrZFMkABpUW/cXgrtQCPDnBmyv3KV+Qk6v7x5nt0yzkuGHX96ssQ
         QavyK6nLs0HCi2tLzM/tCEpjQooDxHPpGkgMtNdNNAC6KY12Ozt+WbIwAZDn+18cGCJG
         Tl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0eGrMTdcbGs8ApCK0DSGGF2wkpm4f1W5dBmpwjtCmQ=;
        b=KrMmGnMYJQ/+SyY2vhCw4UVCjgNHsN7Pgi33FUHsZix97Ifbxnq4xiOu/2Khqac31T
         cQ+2cIpr75wmYKsDvq8HleSxczZUvx09I0ffaXNcCM96sDeuYYC9OjUyo2hUYzR263iK
         qvEHr6LDH3AippXDi0ET+OxxjUUxzTysDVGScg5+Ro2XOVZngXX9kQRcn6iJtAohgKz/
         YHDCkwmRy9HADi+eMjuPLlcLyAgL5qjokkc2gzbx6qBGtaGp9Lv1FlEPJ3/J5xweP20h
         aNdVEfhe5iuAG8QClBm3xRIuZLCIa6r8FQCDAYAU6QDPzBo+jN46MbZyVE0MEq+GK5OT
         Av7Q==
X-Gm-Message-State: AOPr4FXEwV/m3vehVGYDe8JuQWV5+2puKY6UgFQAG2sj+i/05WUo/VGZfV4dWoX7JNedZw==
X-Received: by 10.66.235.129 with SMTP id um1mr12093866pac.17.1461158760376;
        Wed, 20 Apr 2016 06:26:00 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id fv10sm44625108pad.40.2016.04.20.06.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:25:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292013>

This gives the caller more information and they can answer things like,
"is it the main worktree" or "is it the current worktree". The latter
question is needed for the "checkout a rebase branch" case later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c         |  9 +++++----
 builtin/branch.c |  8 ++++----
 builtin/notes.c  |  8 ++++----
 worktree.c       | 14 +++++++++-----
 worktree.h       |  7 ++++---
 5 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 0674a99..a84fb2c 100644
--- a/branch.c
+++ b/branch.c
@@ -336,12 +336,13 @@ void remove_branch_state(void)
=20
 void die_if_checked_out(const char *branch)
 {
-	char *existing;
+	const struct worktree *wt;
=20
-	existing =3D find_shared_symref("HEAD", branch);
-	if (existing) {
+	wt =3D find_shared_symref("HEAD", branch);
+	if (wt) {
 		skip_prefix(branch, "refs/heads/", &branch);
-		die(_("'%s' is already checked out at '%s'"), branch, existing);
+		die(_("'%s' is already checked out at '%s'"),
+		    branch, wt->path);
 	}
 }
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 0adba62..bcde87d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -220,12 +220,12 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
 		name =3D mkpathdup(fmt, bname.buf);
=20
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
-			char *worktree =3D find_shared_symref("HEAD", name);
-			if (worktree) {
+			const struct worktree *wt =3D
+				find_shared_symref("HEAD", name);
+			if (wt) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
-				      bname.buf, worktree);
-				free(worktree);
+				      bname.buf, wt->path);
 				ret =3D 1;
 				continue;
 			}
diff --git a/builtin/notes.c b/builtin/notes.c
index 6fd058d..c65b59a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -847,15 +847,15 @@ static int merge(int argc, const char **argv, con=
st char *prefix)
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
-		char *existing;
+		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		existing =3D find_shared_symref("NOTES_MERGE_REF", default_notes_ref=
());
-		if (existing)
+		wt =3D find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
+		if (wt)
 			die(_("A notes merge into %s is already in-progress at %s"),
-			    default_notes_ref(), existing);
+			    default_notes_ref(), wt->path);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
 			    default_notes_ref());
diff --git a/worktree.c b/worktree.c
index 5ae54f0..360ba41 100644
--- a/worktree.c
+++ b/worktree.c
@@ -191,14 +191,19 @@ const char *get_worktree_git_dir(const struct wor=
ktree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
-char *find_shared_symref(const char *symref, const char *target)
+const struct worktree *find_shared_symref(const char *symref,
+					  const char *target)
 {
-	char *existing =3D NULL;
+	const struct worktree *existing =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
 	struct strbuf sb =3D STRBUF_INIT;
-	struct worktree **worktrees =3D get_worktrees();
+	static struct worktree **worktrees;
 	int i =3D 0;
=20
+	if (worktrees)
+		free_worktrees(worktrees);
+	worktrees =3D get_worktrees();
+
 	for (i =3D 0; worktrees[i]; i++) {
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
@@ -211,14 +216,13 @@ char *find_shared_symref(const char *symref, cons=
t char *target)
 		}
=20
 		if (!strcmp(sb.buf, target)) {
-			existing =3D xstrdup(worktrees[i]->path);
+			existing =3D worktrees[i];
 			break;
 		}
 	}
=20
 	strbuf_release(&path);
 	strbuf_release(&sb);
-	free_worktrees(worktrees);
=20
 	return existing;
 }
diff --git a/worktree.h b/worktree.h
index 3198c8d..d71d7ec 100644
--- a/worktree.h
+++ b/worktree.h
@@ -36,9 +36,10 @@ extern void free_worktrees(struct worktree **);
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
  * or any linked worktree, and return the path to the exising worktree
- * if it is.  Returns NULL if there is no existing ref.  The caller is
- * responsible for freeing the returned path.
+ * if it is. Returns NULL if there is no existing ref. The result
+ * may be destroyed by the next call.
  */
-extern char *find_shared_symref(const char *symref, const char *target=
);
+extern const struct worktree *find_shared_symref(const char *symref,
+						 const char *target);
=20
 #endif
--=20
2.8.0.rc0.210.gd302cd2
