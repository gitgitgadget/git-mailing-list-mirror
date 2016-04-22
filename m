From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/13] branch: do not rename a branch under bisect or rebase
Date: Fri, 22 Apr 2016 20:01:36 +0700
Message-ID: <1461330096-21783-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 22 15:03:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajk-0007oJ-3v
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcDVNDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:03:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35139 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbcDVNDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:03:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id r187so10137886pfr.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1wv8j4y1hA6cs0Y/AJTx28K8tXQBe1kmQjxWcGAbfs=;
        b=dRE7Glo560n6wlnkg8mSOn45pSAEIt4EXUy+BoBlIMOhcZV1ti4x4A2lAEWCO9w+fw
         7say0gxIWwCQG3w3roB2BkSJPojU1JmyfqkqTOFx7EiVQ5mvdbxCisbUquv+Mx5uf00I
         F9x20WlTDPsqvTHfk0Kj3AQmTr+NfIaEg4B0CMDWJ4DnILKTnqmDSgPwvefEcqd5SdjS
         oiF6NPr9vjXUQrSpg8JaBm7JkxFeLgkc0s0SvaMI42vxAxhjF7MaBb20/LJFNIsy6Xk6
         aVjWv4tdfRvBk73cG2bvqxN4S/wCLrYwSwC5Ek0RCLdviAMhYsRrlhdNY49BEOU9b57V
         7xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1wv8j4y1hA6cs0Y/AJTx28K8tXQBe1kmQjxWcGAbfs=;
        b=jrapvcDpeAp3G2E3GJXK5R6WHvI50kvbJyAvoLHCBsPeWA2zG6gjWVYhRKXwz0uUJM
         4sNTAEzOCR4GVcGq9SEsh2HgBJaah8fjlOl53AcHnMkX9f7IRKQlnFH1FIciUz4EKKkg
         o9cX9KrEy9ad9DFDfoFd38Hr294c4TNodrBm2qJlWB24Sk2VQ3D+g03BG8AAfRKTpf3U
         ljgGB/no1wNx4Q8N+wHsmi6H/r5vnJOwOZkKaazq5behyG47SxaffoCA3ktg+t51AATJ
         VDeQa2WdESDe8tFjpAL5t8TYPkL5PrW5a4r3hrza7YwWTsWwKsBaeb+24glJhzG5n++J
         Q8Uw==
X-Gm-Message-State: AOPr4FUqrEvUPDZtiq/DzA1Z1VsvZchNBazq/WvSyCBmlGDP/zlzDrG4Dwy5TQ0qZqoskQ==
X-Received: by 10.98.36.130 with SMTP id k2mr28320028pfk.128.1461330180043;
        Fri, 22 Apr 2016 06:03:00 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id ff2sm9663200pac.15.2016.04.22.06.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:03:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292202>

The branch name in that case could be saved in rebase's head_name or
bisect's BISECT_START files. Ideally we should try to update them as
well. But it's trickier (*). Let's play safe and see if the user
complains about inconveniences before doing that.

(*) If we do it, bisect and rebase need to provide an API to rename
branches. We can't do it in worktree.c or builtin/branch.c because
when other people change rebase/bisect code, they may not be aware of
this code and accidentally break it (e.g. rename the branch file, or
refer to the branch in new files). It's a lot more work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c        | 25 +++++++++++++++++++++++++
 t/t2025-worktree-add.sh |  8 ++++++++
 worktree.c              |  8 ++++----
 worktree.h              |  3 +++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bcde87d..b488c3f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -524,6 +524,29 @@ static void print_ref_list(struct ref_filter *filt=
er, struct ref_sorting *sortin
 	ref_array_clear(&array);
 }
=20
+static void reject_rebase_or_bisect_branch(const char *target)
+{
+	struct worktree **worktrees =3D get_worktrees();
+	int i;
+
+	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
+		if (!wt->is_detached)
+			continue;
+
+		if (is_worktree_being_rebased(wt, target))
+			die(_("Branch %s is being rebased at %s"),
+			    target, wt->path);
+
+		if (is_worktree_being_bisected(wt, target))
+			die(_("Branch %s is being bisected at %s"),
+			    target, wt->path);
+	}
+
+	free_worktrees(worktrees);
+}
+
 static void rename_branch(const char *oldname, const char *newname, in=
t force)
 {
 	struct strbuf oldref =3D STRBUF_INIT, newref =3D STRBUF_INIT, logmsg =
=3D STRBUF_INIT;
@@ -553,6 +576,8 @@ static void rename_branch(const char *oldname, cons=
t char *newname, int force)
=20
 	validate_new_branchname(newname, &newref, force, clobber_head_ok);
=20
+	reject_rebase_or_bisect_branch(oldref.buf);
+
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
=20
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 8f53944..3a22fc5 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -254,6 +254,10 @@ test_expect_success 'not allow to delete a branch =
under rebase' '
 	)
 '
=20
+test_expect_success 'rename a branch under rebase not allowed' '
+	test_must_fail git branch -M under-rebase rebase-with-new-name
+'
+
 test_expect_success 'check out from current worktree branch ok' '
 	(
 		cd under-rebase &&
@@ -276,4 +280,8 @@ test_expect_success 'checkout a branch under bisect=
' '
 	)
 '
=20
+test_expect_success 'rename a branch under bisect not allowed' '
+	test_must_fail git branch -M under-bisect bisect-with-new-name
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index aab4b95..4817d60 100644
--- a/worktree.c
+++ b/worktree.c
@@ -216,8 +216,8 @@ const char *get_worktree_git_dir(const struct workt=
ree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
-static int is_worktree_being_rebased(const struct worktree *wt,
-				     const char *target)
+int is_worktree_being_rebased(const struct worktree *wt,
+			      const char *target)
 {
 	struct wt_status_state state;
 	int found_rebase;
@@ -234,8 +234,8 @@ static int is_worktree_being_rebased(const struct w=
orktree *wt,
 	return found_rebase;
 }
=20
-static int is_worktree_being_bisected(const struct worktree *wt,
-				      const char *target)
+int is_worktree_being_bisected(const struct worktree *wt,
+			       const char *target)
 {
 	struct wt_status_state state;
 	int found_rebase;
diff --git a/worktree.h b/worktree.h
index 0da8c1f..1394909 100644
--- a/worktree.h
+++ b/worktree.h
@@ -42,6 +42,9 @@ extern void free_worktrees(struct worktree **);
 extern const struct worktree *find_shared_symref(const char *symref,
 						 const char *target);
=20
+int is_worktree_being_rebased(const struct worktree *wt, const char *t=
arget);
+int is_worktree_being_bisected(const struct worktree *wt, const char *=
target);
+
 /*
  * Similar to git_path() but can produce paths for a specified
  * worktree instead of current one
--=20
2.8.0.rc0.210.gd302cd2
