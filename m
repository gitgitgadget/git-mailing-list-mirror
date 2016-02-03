From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/20] worktree: refactor add_worktree()
Date: Wed,  3 Feb 2016 16:35:48 +0700
Message-ID: <1454492150-10628-19-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsd-0006Xp-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbcBCJhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:39 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35715 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbcBCJhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:33 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so11071843pfd.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b9Vl71WuH6jh/TOREU09dL7KOPx77ZNkvfLaLyjoAbc=;
        b=DotrxiqD3csrFlJonHvVGfTQ1AqXBuEY+piZB878Rh3ZEVVIaPzPnH3J5XYpkin8ZO
         dCnQLI8jtk49sSRXhR/01COcQ8m2I+4JWYb0+/Vxu0v6rEYkVhVhdr4Jj5Rd/VCKnJBF
         /NT9Ma0u1L0HlM8VuPgsyKcYq/BlC6nZ+p/TgkJzjePnp0gBA1z4bQuXc6tgUbB/bUt4
         PSTWtwO1ZmkMzLHFp/aFngIUzJFDqkBORMQYYoGsDOHElrnj4tdE6sRLkSt4BcodmI9Z
         Y8aDSA3T+FRnx4urk/j/2riAeJKUAUWOYYLbEzbwupcfvQpjX4PZEmq/bQBADZrlZA4e
         wzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=b9Vl71WuH6jh/TOREU09dL7KOPx77ZNkvfLaLyjoAbc=;
        b=O56BMm53W7MhHigibRYENdk+IG834GGTTo1Q3Tgg4yI3pK7zuFXhZJvfHV6QAFT6df
         9GfaLVl3tpo4hpVcoE1+FQyvgPnh082PXRdLknfZsY+zAD+cMvQ7A+CIgFG38wwx77fQ
         ufqPOwxZ3tTBddLbn8a4kRrVZjd4DbOWWPiBGQ79aLeVXxQZGW6a8EOAivuQopFIhv0p
         QCEPMUgsbm6A+19qr+XbrMIixxRNuBUnF6ked5v1sKlBUxMxyTV142hk+L5bVBOkGCmU
         +jerogFO2j6dfURIpePOOvxA8od41q5QvIYCHaCnZ18qaaeV0lFRKydijUADu0I2BNEr
         180A==
X-Gm-Message-State: AG10YOST7MP7Luei2HvpEcjQP8RuwubLTjgq6zsI39Go00e+FWpIzsoeshAp1779xE/Tsg==
X-Received: by 10.98.13.195 with SMTP id 64mr731126pfn.164.1454492253415;
        Wed, 03 Feb 2016 01:37:33 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p9sm8451675pfa.11.2016.02.03.01.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:45 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285361>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 130 +++++++++++++++++++++++++++++++++------------=
--------
 1 file changed, 81 insertions(+), 49 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8d59199..3ebb9e9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -184,34 +184,15 @@ static const char *worktree_basename(const char *=
path, int *olen)
 	return name;
 }
=20
-static int add_worktree(const char *path, const char *refname,
-			const struct add_opts *opts)
+static void prepare_new_worktree(const char *path,
+				 struct worktree *wt,
+				 int create_gitdir_and_head)
 {
+	const char *name;
 	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *name;
 	struct stat st;
-	struct child_process cp;
-	struct argv_array child_env =3D ARGV_ARRAY_INIT;
-	int counter =3D 0, len, ret;
-	struct strbuf symref =3D STRBUF_INIT;
-	struct commit *commit =3D NULL;
-
-	if (file_exists(path) && !is_empty_dir(path))
-		die(_("'%s' already exists"), path);
-
-	/* is 'refname' a branch or commit? */
-	if (opts->force_new_branch) /* definitely a branch */
-		;
-	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) =
&&
-		 ref_exists(symref.buf)) { /* it's a branch */
-		if (!opts->force)
-			die_if_checked_out(symref.buf);
-	} else { /* must be a commit */
-		commit =3D lookup_commit_reference_by_name(refname);
-		if (!commit)
-			die(_("invalid reference: %s"), refname);
-	}
+	int counter =3D 0, len;
=20
 	name =3D worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
@@ -227,6 +208,10 @@ static int add_worktree(const char *path, const ch=
ar *refname,
 	}
 	name =3D strrchr(sb_repo.buf, '/') + 1;
=20
+	memset(wt, 0, sizeof(*wt));
+	wt->path =3D xstrdup(path);
+	wt->id =3D xstrdup(name);
+
 	junk_pid =3D getpid();
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
@@ -252,25 +237,81 @@ static int add_worktree(const char *path, const c=
har *refname,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
 	write_file(sb.buf, "%s", real_path(sb_git.buf));
-	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
-		   real_path(get_git_common_dir()), name);
-	/*
-	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Any value which
-	 * looks like an object ID will do since it will be immediately
-	 * replaced by the symbolic-ref or update-ref invocation in the new
-	 * worktree.
-	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, sha1_to_hex(null_sha1));
+	if (create_gitdir_and_head) {
+		write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
+			   real_path(get_git_common_dir()), name);
+
+		/*
+		 * This is to keep resolve_ref() happy. We need a valid HEAD
+		 * or is_git_directory() will reject the directory. Any value which
+		 * looks like an object ID will do since it will be immediately
+		 * replaced by the symbolic-ref or update-ref invocation in the new
+		 * worktree.
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+		write_file(sb.buf, sha1_to_hex(null_sha1));
+	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
=20
-	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
+	strbuf_release(&sb);
+	strbuf_release(&sb_repo);
+	strbuf_release(&sb_git);
+}
+
+static void new_worktree_complete(void)
+{
+	is_junk =3D 0;
+	free(junk_work_tree);
+	free(junk_git_dir);
+	junk_work_tree =3D NULL;
+	junk_git_dir =3D NULL;
+}
+
+static void cleanup_new_worktree(struct worktree *wt)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+
+	strbuf_git_common_path(&sb, "worktrees/%s/locked", wt->id);
+	unlink_or_warn(sb.buf);
+	strbuf_release(&sb);
+	clear_worktree(wt);
+}
+
+static int add_worktree(const char *path, const char *refname,
+			const struct add_opts *opts)
+{
+	struct worktree wt;
+	struct child_process cp;
+	struct argv_array child_env =3D ARGV_ARRAY_INIT;
+	int ret;
+	struct strbuf symref =3D STRBUF_INIT;
+	struct commit *commit =3D NULL;
+
+	/* is 'refname' a branch or commit? */
+	if (opts->force_new_branch) /* definitely a branch */
+		;
+	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) =
&&
+		 ref_exists(symref.buf)) { /* it's a branch */
+		if (!opts->force)
+			die_if_checked_out(symref.buf);
+	} else { /* must be a commit */
+		commit =3D lookup_commit_reference_by_name(refname);
+		if (!commit)
+			die(_("invalid reference: %s"), refname);
+	}
+
+	if (file_exists(path) && !is_empty_dir(path))
+		die(_("'%s' already exists"), path);
+
+	prepare_new_worktree(path, &wt, 1);
=20
-	argv_array_pushf(&child_env, "%s=3D%s", GIT_DIR_ENVIRONMENT, sb_git.b=
uf);
+	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, wt.id);
+
+	argv_array_pushf(&child_env, "%s=3D%s", GIT_DIR_ENVIRONMENT,
+			 get_worktree_git_dir(&wt));
 	argv_array_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, pa=
th);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd =3D 1;
@@ -292,21 +333,12 @@ static int add_worktree(const char *path, const c=
har *refname,
 	cp.env =3D child_env.argv;
 	ret =3D run_command(&cp);
 	if (!ret) {
-		is_junk =3D 0;
-		free(junk_work_tree);
-		free(junk_git_dir);
-		junk_work_tree =3D NULL;
-		junk_git_dir =3D NULL;
+		new_worktree_complete();
 	}
 done:
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	unlink_or_warn(sb.buf);
 	argv_array_clear(&child_env);
-	strbuf_release(&sb);
 	strbuf_release(&symref);
-	strbuf_release(&sb_repo);
-	strbuf_release(&sb_git);
+	cleanup_new_worktree(&wt);
 	return ret;
 }
=20
--=20
2.7.0.377.g4cd97dd
