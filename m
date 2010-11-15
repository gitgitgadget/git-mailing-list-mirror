From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/10] checkout: add --full to fully populate working directory
Date: Mon, 15 Nov 2010 17:36:48 +0700
Message-ID: <1289817410-32470-9-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:40:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwU9-0002Vb-BQ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab0KOKkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:40:19 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:36066 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0KOKkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:40:17 -0500
Received: by mail-px0-f174.google.com with SMTP id 15so923789pxi.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XLE0aI480PFlfgRviJSGmxYKXXWNjmCc4T8QHMPLGro=;
        b=jODyJLopq+lR12gMXcCIPWaCzoqRiJ665A5RGTeZSgizlqg8psrhLJLrtlZcS+PlL5
         zjoIV2nneFu+odz3fkHAxSo03IpWZR8N/7Od09yCfM5ZnDMPXrsz7iqVbGgIrBUJ/6S0
         e8UKfGHfL0fMXvN79L7NPBXsceWQ0njlj8uLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q9xn/hwQWXL4ttYQUCMheSuYi3snurjScFZWUo8BY03bPo/ryjicfZwvDq4jzOa586
         akcWW9/m8FamBlYfnAvg+I2hIz3yPYDlIr5LKTNAl9rGBpxUUy3/THfdga/Hv22oCzL8
         INkizswR61R2eXF0FH2b/dZQZZNnNyQLRbDQo=
Received: by 10.142.179.21 with SMTP id b21mr3864045wff.432.1289817617581;
        Mon, 15 Nov 2010 02:40:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w14sm8576673wfd.18.2010.11.15.02.40.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:40:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:38:59 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161485>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt       |    6 +++++-
 builtin/checkout.c                   |   23 ++++++++++++++++++++---
 t/t1011-read-tree-sparse-checkout.sh |    7 +++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 478bfe7..1d82063 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_=
point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
-'git checkout' -S
+'git checkout' [-S|--full]
=20
 DESCRIPTION
 -----------
@@ -184,6 +184,10 @@ edits from your current working tree.
 	$GIT_DIR/info/sparse-checkout. The working directory is also
 	updated. An empty file will abort the process.
=20
+--full:
+	Reset $GIT_DIR/info/sparse-checkout to include everything and
+	update working directory accordingly.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 47847b3..f070930 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -710,7 +710,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	char *conflict_style =3D NULL;
 	int patch_mode =3D 0;
 	int dwim_new_local_branch =3D 1;
-	int update_sparse_checkout =3D 0;
+	int update_sparse_checkout =3D 0, full_checkout =3D 0;
 	struct option options[] =3D {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -732,6 +732,8 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
 		OPT_BOOLEAN('S', "update-sparse-checkout", &update_sparse_checkout,
 			    "open up editor to edit $GIT_DIR/info/sparse-checkout" ),
+		OPT_BOOLEAN(0, "full", &full_checkout,
+			    "reset $GIT_DIR/info/sparse-checkout to checkout everything" ),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
@@ -750,6 +752,9 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
+	if (full_checkout)
+		update_sparse_checkout =3D 1;
+
 	if (update_sparse_checkout && !core_apply_sparse_checkout)
 		die("core.sparseCheckout needs to be turned on");
=20
@@ -952,8 +957,20 @@ no_reference:
 	if (opts.writeout_stage)
 		die("--ours/--theirs is incompatible with switching branches.");
=20
-	if (update_sparse_checkout)
-		edit_info_sparse_checkout();
+	if (update_sparse_checkout) {
+		if (full_checkout) {
+			FILE *fp =3D fopen(git_path("info/sparse-checkout"), "w+");
+			if (!fp)
+				die_errno("Unable to reset %s", git_path("info/sparse-checkout"));
+			fprintf(fp, "# Specify what files are checked out in working direct=
ory\n");
+			fprintf(fp, "# Run \"git checkout\" after updating this file to upd=
ate working directory\n");
+			fprintf(fp, "# If this is opened by \"git checkout -S\", empty this=
 file will abort it.\n");
+			fprintf(fp, "*\n");
+			fclose(fp);
+		}
+		else
+			edit_info_sparse_checkout(full_checkout);
+	}
=20
 	return switch_branches(&opts, &new);
 }
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index fe4716c..055e858 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -202,4 +202,11 @@ EOF
 	test ! -f init.t
 '
=20
+test_expect_success 'git checkout --full' '
+	git checkout --full &&
+	grep "^\*$" .git/info/sparse-checkout &&
+	test -f sub/added &&
+	test -f init.t
+'
+
 test_done
--=20
1.7.3.2.210.g045198
