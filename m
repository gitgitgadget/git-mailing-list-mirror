Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F513D1AB5
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681047; cv=none; b=bY0bLxqmrUMDUvXXqy4STkBsGv1gmeUCiPN9hw/+TtQIHYQnkRlNoXig1J/NWuljZ/dCzaVL+9+a2dqaocLAHi8zNlPlCoH45i+qARIM/khGb/s08i0CGbLIjdH76aLSMq1E2iuEsMezyVcE9ZWwMQnoPcPBjeKZFQcYowwwZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681047; c=relaxed/simple;
	bh=Imsbb6Zs4v2cOFr3QNH9UGw4g6xVdgPzJuFybn58lrE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUl6ve24m0YjSNT8ZZkMHFFtCB+o2kbHy5vxKHB1a5t/ekA7S2QTmMzVTcmod21rmM9tKA8+H9I0nHXkKnooyc69oPiwyqO90Lpau2qxRs9VJaQmEg5wmlFvM5fQ0vOFYMUOf8yu73bvmJzldNz9yOBBibvdJtrl2WRWRF8AWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hfjFbubU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hfjFbubU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787681037; x=1788285837; i=l.s.r@web.de;
	bh=l10fY+sRAmkyHzlpuF8FdiaGpYttGl2zVhWEI8ese4Q=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hfjFbubU+NYrW5Vv0YrM8mXxNTd+AED0fiKvJSQb+IUYK0EYNI7jixV4nrg3miHB
	 vdjHaSZs5DrlALeMzZPAepgpVz+L5fQxrh/8k/6vvDLP5Auz4cuqHwcrPaAtSkpQ4
	 zBuyA3HMo6oq90fPfgcj5pwVT5xW+Q/vbuUqyhwpQgYZ622i0tuuNXTXf70BFxBvN
	 CXj5R16+18rBQGL/ii8cvfwK4qE+W9dHPcki2fGCm1f2Tk+H1rzgwBdEVXnZbfYSU
	 4/GD4jAs8wOeIQCPE8HLcZOtlXYTX9qn5sBdYeFB+Ocf7uxO5SoiglLr/SJGoLKd9
	 vzjrZNW1JmyLYz+4Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1x5pOY0Nqt-000dfH for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 20:03:57 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/4] worktree add: let worktree_basename() return string copy
Date: Tue, 25 Aug 2026 20:03:50 +0200
Message-ID: <20260825180350.2099-5-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825180350.2099-1-l.s.r@web.de>
References: <20260825180350.2099-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4QPOXDqjm00dDmgj9regK0WBDogJMBNtwNBrOgJzIYv21fIywa
 843wABH+LKOQq07PVW2IrD6D49rt+15JuBCV+YYL6fzvgTAUwsaMiqjoWTuOpMkbSQ9jc+j
 29VEBrwn59np5wl78DfUFMdgZ5izbKwcMczS7LkIGwKOovqOiu8ESsqJ40F9rknMypJdk9e
 Cj7fJKZRd/sL0h1gd8EZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8FYtBUu3944=;m8srIQ3+fra6l7rc/AyMHLzDV8a
 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
 XVDg1Wwg==

worktree_basename() requires callers to do pointer arithmetic to get the
actual basename.  Simplify them by doing the calculations in the
function and returning a copy of the basename directly.

Remind programmers to free the result by renaming the function to
worktree_basename_dup().  Two already do; convert the remaining one from
resetting a shared strbuf to freeing the allocated string, which
requires the same number of lines, but no arithmetic.  The added
allocation is negligible because it's small and there's only one per run
of "git worktree add".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 01c245778e..d95824b2fd 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -294,7 +294,7 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
=20
-static const char *worktree_basename(const char *path, int *olen)
+static char *worktree_basename_dup(const char *path)
 {
 	const char *name;
 	int len;
@@ -307,8 +307,7 @@ static const char *worktree_basename(const char *path,=
 int *olen)
 	while (name > path && !is_dir_sep(name[-1]))
 		name--;
=20
-	*olen =3D len;
-	return name;
+	return xmemdupz(name, path + len - name);
 }
=20
 /* check that path is viable location for worktree */
@@ -462,6 +461,7 @@ static int add_worktree(const char *path, const char *=
refname,
 	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *name;
+	char *name_to_free =3D NULL;
 	struct strvec child_env =3D STRVEC_INIT;
 	unsigned int counter =3D 0;
 	int len, ret;
@@ -489,14 +489,12 @@ static int add_worktree(const char *path, const char=
 *refname,
 	if (!commit && !opts->orphan)
 		die(_("invalid reference: %s"), refname);
=20
-	name =3D worktree_basename(path, &len);
-	strbuf_add(&sb, name, path + len - name);
-	if (!sb.len)
+	name =3D name_to_free =3D worktree_basename_dup(path);
+	if (!*name)
 		die(_("invalid path '%s'"), path);
-	sanitize_refname_component(sb.buf, &sb_name);
+	sanitize_refname_component(name, &sb_name);
 	if (!sb_name.len)
-		BUG("How come '%s' becomes empty after sanitization?", sb.buf);
-	strbuf_reset(&sb);
+		BUG("How come '%s' becomes empty after sanitization?", name);
 	name =3D sb_name.buf;
 	repo_git_path_replace(the_repository, &sb_repo, "worktrees/%s", name);
 	len =3D sb_repo.len;
@@ -630,6 +628,7 @@ static int add_worktree(const char *path, const char *=
refname,
 	strbuf_release(&sb_git);
 	strbuf_release(&sb_name);
 	free_worktree(wt);
+	free(name_to_free);
 	return ret;
 }
=20
@@ -766,10 +765,8 @@ static int dwim_orphan(const struct add_opts *opts, i=
nt opt_track, int remote)
=20
 static char *dwim_branch(const char *path, char **new_branch)
 {
-	int n;
 	int branch_exists;
-	const char *s =3D worktree_basename(path, &n);
-	char *branchname =3D xmemdupz(s, path + n - s);
+	char *branchname =3D worktree_basename_dup(path);
 	struct strbuf ref =3D STRBUF_INIT;
=20
 	branch_exists =3D !check_branch_ref(the_repository, &ref, branchname) &&
@@ -876,9 +873,7 @@ static int add(int ac, const char **av, const char *pr=
efix,
 	}
=20
 	if (opts.orphan && !new_branch) {
-		int n;
-		const char *s =3D worktree_basename(path, &n);
-		new_branch =3D new_branch_to_free =3D xmemdupz(s, path + n - s);
+		new_branch =3D new_branch_to_free =3D worktree_basename_dup(path);
 	} else if (opts.orphan) {
 		; /* no-op */
 	} else if (opts.detach) {
=2D-=20
2.55.0

