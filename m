From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/12] branch: do not rename a branch under bisect or rebase
Date: Wed, 20 Apr 2016 20:24:53 +0700
Message-ID: <1461158693-21289-13-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 20 15:27:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9p-0005JX-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbcDTN05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:57 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35903 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbcDTN0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:55 -0400
Received: by mail-pa0-f43.google.com with SMTP id er2so17938277pad.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95cUSQsMwa3KplkFnGZXh2+YWzAsDLG+LXmx/oHnx/0=;
        b=JnvmrWVoGc9NRjfg/IpieRn0y+lr8eDpfcrjVMpePaSj9MmZJKhpwVH93v/nFpNdae
         5uMGOB0VGqr7KJ/lABQGmUa7sZLwLsjWSkbIzSa7UStPi3bX6apr0nmJTFVNbAsEh66d
         zFcxO92d/Rpv+1AhzmSu+Gmaxn+X/AxtNJxdU0QsdAdNVBhMzgG8GnKhRW6GInDb1Un/
         vTV7Pndsw7ZkUVc9fY5+4Nt+Pr79SaFZLhX8WhH3XiAY4D9S4FV+XKctw5MXfSjJwByc
         s5HrpK8l9Glbar8QiAkmNn5zXAEys+VbVL5WrvWM2RfyoRG1MqrdoWqTc4EghezqtZP2
         q42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95cUSQsMwa3KplkFnGZXh2+YWzAsDLG+LXmx/oHnx/0=;
        b=ju6EQSL+CwPjd3FINSxPFqpvhzhAOA+45UWBXGQpMHAOH+HH6cmApBvdWrThr28fLt
         5ocYgnhjIL2wAVQurxuvdGUPasJwwkm5rB7Y6cGVxCH4Wvr/Fn7d3GyQ2AQpPm7ecrk4
         eDHB2B8iV1Hjbwelk7bjG1iyPoAQ/WJk1acPFlxP9W2BUBN5aBwKmWnOXgodq4+2rUvS
         +lAEqp0XC5KilsdMfU+8e7KIaNSeXhteQ6POImHpQDTadCu5OSKTNGF4TNBXsVACVsSZ
         HtLb1Njsda9YSXK72BPOsc9dxPbqsgwnzRp48tYUt1/++Litl7fyKXLqdX+5WBH6shhF
         FH2A==
X-Gm-Message-State: AOPr4FXnbFd4Z2nZnyrREYTAovnuZ8qJRCWrtdEikSLLWGpEpQ5hi3Fhp19HdnSWM/rjrw==
X-Received: by 10.66.162.39 with SMTP id xx7mr12007308pab.97.1461158814985;
        Wed, 20 Apr 2016 06:26:54 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id t85sm13379228pfi.55.2016.04.20.06.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:27:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292022>

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
index bf91bbd..3a2eceb 100644
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
index 7b66071..8a3d394 100644
--- a/worktree.c
+++ b/worktree.c
@@ -208,8 +208,8 @@ const char *get_worktree_git_dir(const struct workt=
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
@@ -226,8 +226,8 @@ static int is_worktree_being_rebased(const struct w=
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
index fb9f5cc..d4a3534 100644
--- a/worktree.h
+++ b/worktree.h
@@ -44,6 +44,9 @@ extern const struct worktree *find_shared_symref(cons=
t char *symref,
 						 const char *target,
 						 int ignore_current_worktree);
=20
+int is_worktree_being_rebased(const struct worktree *wt, const char *t=
arget);
+int is_worktree_being_bisected(const struct worktree *wt, const char *=
target);
+
 /*
  * Similar to git_path() and git_pathdup() but can produce paths for a
  * specified worktree instead of current one
--=20
2.8.0.rc0.210.gd302cd2
