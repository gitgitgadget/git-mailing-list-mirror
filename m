From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] checkout: add --no-widen for restoring files in sparse checkout mode
Date: Sat, 30 Mar 2013 17:02:33 +0700
Message-ID: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
References: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirill.mueller@ivt.baug.ethz.ch,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 11:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsd6-0006sq-QB
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 11:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab3C3KCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 06:02:44 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53991 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab3C3KCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 06:02:43 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so666957pad.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=U3GCstjY6V6reuzBh5a1haIzFl61IuZEmxt5tMSn91E=;
        b=Jly/pF+5hzHMxlb7PQmzV0nfB0cFMur+lFxbRz2xK9i9Cr/FSPCASLwv9NXE1GhyaB
         n37kTblhGIhdWL9LpONUaxn12fvnI0mImWS+h2BQdiWzFiqXrJWLIWbsfC12k3Ejf6/v
         2l24WY89C/EpqwFJn7Q4CFHUc0pc/WJldUAYfo3GIBhssBWJW8xfLnBnxTeCMVWlQu2w
         MjHs7eYgmBHCqgx8d+ecJyULtlrxE52Oaipf/4Xkwo7UAe42YNM9J7G8LhbE7uw9gz5/
         q8BIKm78npagY4QLdIgxSkjTfiUXm3tefAQLJ9Lc669QWp8ASKAcQ2EzHVyRrl0jvZgW
         tvZg==
X-Received: by 10.66.88.105 with SMTP id bf9mr8620541pab.175.1364637762343;
        Sat, 30 Mar 2013 03:02:42 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id kt5sm6045651pbc.30.2013.03.30.03.02.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 03:02:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 17:02:47 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219585>

"git checkout -- <paths>" is usually used to restore all modified
files in <paths>. In sparse checkout mode, this command is overloaded
with another meaning: to add back all files in <paths> that are
excluded by sparse patterns.

Add "--no-widen" option to do what normal mode does: restore all
modified files and nothing else. The user can make it "default" by
putting it to an alias (e.g. "co =3D checkout --no-widen") and get back
to the original behavior with "git co --widen".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 --sparse -> --no-widen and git-checkout does not error out when the
 option is specified but has no effects. Let's see how it works out.
 We could change the default from --widen to --no-widen later.

 Documentation/git-checkout.txt       | 11 +++++++++++
 builtin/checkout.c                   |  7 +++++++
 t/t1011-read-tree-sparse-checkout.sh | 12 ++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 8edcdca..538b8b8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -180,6 +180,17 @@ branch by running "git rm -rf ." from the top leve=
l of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating t=
he
 working tree, by copying them from elsewhere, extracting a tarball, et=
c.
=20
+--no-widen::
+	In sparse checkout mode, `git checkout -- <paths>` would
+	update all entries matched by <paths> regardless of sparse
+	patterns. This option only updates entries matched by <paths>
+	and sparse patterns.
+
+--widen::
+	Revert the effect of `--no-widen` if specified and make
+	`git checkout -- <paths>` update all entries matched by
+	<paths> regardless of sparse patterns.
+
 -m::
 --merge::
 	When switching branches,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..246de33 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -35,6 +35,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int overwrite_ignore;
+	int widen_sparse;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -275,6 +276,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
+		if (!opts->widen_sparse && ce_skip_worktree(ce))
+			continue;
 		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
 	}
=20
@@ -315,6 +318,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
+		if (!opts->widen_sparse && ce_skip_worktree(ce))
+			continue;
 		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
@@ -1029,6 +1034,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOLEAN('p', "patch", &opts.patch_mode, N_("select hunks interac=
tively")),
+		OPT_BOOL(0, "widen", &opts.widen_sparse, N_("do not limit pathspecs =
to sparse entries only (default)")),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  N_("second guess 'git checkout no-such-branch'"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
@@ -1039,6 +1045,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore =3D 1;
 	opts.prefix =3D prefix;
+	opts.widen_sparse =3D 1;
=20
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 5c0053a..4a45714 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -250,4 +250,16 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'checkout --no-widen' '
+	echo "*" >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	test -f init.t &&
+	echo sub >.git/info/sparse-checkout &&
+	git checkout &&
+	echo modified >> sub/added &&
+	git checkout --no-widen . &&
+	! test -f init.t &&
+	git diff --exit-code HEAD
+'
+
 test_done
--=20
1.8.2.83.gc99314b
