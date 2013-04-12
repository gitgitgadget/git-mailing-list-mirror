From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] checkout: add --ignore-skip-worktree-bits in sparse checkout mode
Date: Sat, 13 Apr 2013 09:12:08 +1000
Message-ID: <1365808328-4191-1-git-send-email-pclouds@gmail.com>
References: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	kirill.mueller@ivt.baug.ethz.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 01:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQn91-0003WV-JV
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 01:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab3DLXM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 19:12:29 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:52469 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3DLXM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 19:12:27 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so1322924dak.34
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cBTHAnpJfZDVnBNbQlioaGViJ5agtz4yUs/J3DHG8PU=;
        b=E42xxqgRF7jEfjZTz9LZ8Hjsk08GhE1Jo1W/vXdcR5OtSWuHt7v3LEeXstBGCj5Ur1
         mAI+yKXoBNzOj+7WLpQYZeQOcwh5F4GlaKhCrM+gs73BVMjxdEetlzohPMYJP9Ut33rP
         8mhVy5hjg+/2xoyPln6HEIyPJABhtaTNvOWpZgjSSariDgQeZ31Ti5kOAjWCLnJyBhx6
         C4XN4RTlmcFxeW1a0E0pKZFmpYVXmZHWiQ1jTUrDLc2XYNV8NBi4DO85R6hExn7AR0OR
         FVsHVf6S8RvTHihXvQY8yvsAK5Ou1LPdpGfjb9uYFAI2xW2M/ZAH13bZeU+goCfP0s/A
         EmKQ==
X-Received: by 10.68.254.38 with SMTP id af6mr17059895pbd.157.1365808347002;
        Fri, 12 Apr 2013 16:12:27 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id cq1sm10206114pbc.13.2013.04.12.16.12.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 16:12:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 13 Apr 2013 09:12:09 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221038>

"git checkout -- <paths>" is usually used to restore all modified
files in <paths>. In sparse checkout mode, this command is overloaded
with another meaning: to add back all files in <paths> that are
excluded by sparse patterns.

As the former makes more sense for day-to-day use. Switch it to the
default and the latter enabled with --ignore-skip-worktree-bits.

While at there, add info/sparse-checkout to gitrepository-layout.txt

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt         |  6 ++++++
 Documentation/gitrepository-layout.txt |  4 ++++
 builtin/checkout.c                     |  5 +++++
 t/t1011-read-tree-sparse-checkout.sh   | 24 ++++++++++++++++++++++++
 t/t3001-ls-files-others-exclude.sh     |  2 +-
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 8edcdca..23a9413 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -180,6 +180,12 @@ branch by running "git rm -rf ." from the top leve=
l of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating t=
he
 working tree, by copying them from elsewhere, extracting a tarball, et=
c.
=20
+--ignore-skip-worktree-bits::
+	In sparse checkout mode, `git checkout -- <paths>` would
+	update only entries matched by <paths> and sparse patterns
+	in $GIT_DIR/info/sparse-checkout. This option ignores
+	the sparse patterns and adds back any files in <paths>.
+
 -m::
 --merge::
 	When switching branches,
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index f0eef76..817337f 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -184,6 +184,10 @@ info/exclude::
 	'git clean' look at it but the core Git commands do not look
 	at it.  See also: linkgit:gitignore[5].
=20
+info/sparse-checkout::
+	This file stores sparse checkout patterns.
+	See also: linkgit:git-read-tree[1].
+
 remotes::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via 'git fetch',
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f8033f4..4ed1ee7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -35,6 +35,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int overwrite_ignore;
+	int ignore_skipworktree;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -278,6 +279,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
 		ce->ce_flags &=3D ~CE_MATCHED;
+		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
+			continue;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			/*
 			 * "git checkout tree-ish -- path", but this entry
@@ -1058,6 +1061,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOLEAN('p', "patch", &opts.patch_mode, N_("select hunks interac=
tively")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
+			 N_("do not limit pathspecs to sparse entries only")),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  N_("second guess 'git checkout no-such-branch'"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 5c0053a..0c74bee 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -250,4 +250,28 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'checkout without --ignore-skip-worktree-bits' '
+	echo "*" >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	test_path_is_file init.t &&
+	echo sub >.git/info/sparse-checkout &&
+	git checkout &&
+	echo modified >> sub/added &&
+	git checkout . &&
+	test_path_is_missing init.t &&
+	git diff --exit-code HEAD
+'
+
+test_expect_success 'checkout with --ignore-skip-worktree-bits' '
+	echo "*" >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	test_path_is_file init.t &&
+	echo sub >.git/info/sparse-checkout &&
+	git checkout &&
+	echo modified >> sub/added &&
+	git checkout --ignore-skip-worktree-bits . &&
+	test_path_is_file init.t &&
+	git diff --exit-code HEAD
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index efb7ebc..2d274bf 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -103,7 +103,7 @@ test_expect_success \
      test_cmp expect output'
=20
 test_expect_success 'restore gitignore' '
-	git checkout $allignores &&
+	git checkout --ignore-skip-worktree-bits $allignores &&
 	rm .git/index
 '
=20
--=20
1.8.2.82.gc24b958
