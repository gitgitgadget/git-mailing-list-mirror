From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon,  7 Feb 2011 09:27:23 +0700
Message-ID: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@gr
X-From: git-owner@vger.kernel.org Mon Feb 07 03:29:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmGqa-0007Ac-Po
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 03:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab1BGC24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 21:28:56 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62906 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab1BGC2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 21:28:55 -0500
Received: by pva4 with SMTP id 4so800930pva.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=yTmyNv9v1UN20cnSQJT23P8m/skqk5wU3XonZsEKWYA=;
        b=fY2G8NeaRb1DcisMkrFUwHd6xqPdFzKX14/4RgYP1xf480D6n9ogkKxN5wEJrJ7gKV
         CX3AVAZjpVJ8nKZWs5Mu4sZPirVwPb6fCMEZg6r0c0TImJlyjnRAb8ugMxCOkRRV1rI1
         1Dmt3u4ZyLHM1lX/gwPL+Kh9KKAbJdaCQFTNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Zp3XhalZStprRGTpKTCsMc/l+/kPYhSjEpVKm50KfkNOX3PLLVKA276vfIDRtfc6eT
         v2t/f3WB2U1valM+9Asj2ypEROkqziPg7aRhiC8vfiPt9ZI6fDZcCuBT257Up7v7Bc2a
         Xh6KRhuIOArcRdMG5A51ZDnU6Qx1lw1jW5oj0=
Received: by 10.142.50.5 with SMTP id x5mr14808837wfx.228.1297045734730;
        Sun, 06 Feb 2011 18:28:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id b11sm5238786wff.9.2011.02.06.18.28.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 18:28:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Feb 2011 09:27:25 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166223>

When -u was introduced in dfdac5d (git-add -u: match the index with
working tree., 2007-04-20), "add -u" (without pathspec) added
everything. Shortly after, 2ed2c22 (git-add -u paths... now works from
subdirectory, 2007-08-16) broke it while fixing something related.

This makes -u (and -A) inconsistent with some other options, namely -p.
It's been four years since the unintentional breakage and people are
probably used to "git add -u" updating only current directory. Perhaps
it's time to bring the original behavior back? Current behavior can
always be achieved with "git add -u ."

Migration plan:

I'm bad at this. Can we start with a patch that warns users to do "git
add -u ." when they do "git add -u"? Hopefully they would have their
fingers retraied by the time the behavior is changed in 1.8.0.

PS. What about -A?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/2/7 Sebastian Pipping <webmaster@hartwork.org>:
 >> git add -u was tree-wide when it was introduced in dfdac5d (git-add
 >> -u: match the index with working tree., 2007-04-20), but 2ed2c22
 >> (git-add -u paths... now works from subdirectory, 2007-08-16) broke=
 it
 >> while fixing something related.
 >
 > So my memory didn't fool me.  Thanks for digging this out.
 >
 > Can we have tree-wide "git add -u" back, please?

 Yup yup I like it too (and wanted the original behavior sometimes, eve=
n
 though I didn't know it was original behavior).

 Pulling Junio in for -A. It seems closely related to -u. In fact I rev=
ert
 one line from 1e5f764 (builtin-add.c: optimize -A option and "git add =
=2E"
 - 2008-07-22) but not fully understand why it was changed.

 builtin/add.c         |    7 +++++--
 t/t2200-add-update.sh |   13 +++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 12b964e..f1f8b5a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -389,7 +389,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		die("-A and -u are mutually incompatible");
 	if (!show_only && ignore_missing)
 		die("Option --ignore-missing can only be used together with --dry-ru=
n");
-	if ((addremove || take_worktree_changes) && !argc) {
+	if (addremove && !argc) {
 		static const char *here[2] =3D { ".", NULL };
 		argc =3D 1;
 		argv =3D here;
@@ -412,7 +412,10 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec =3D validate_pathspec(argc, argv, prefix);
+	if (take_worktree_changes && !argc)
+		pathspec =3D NULL;
+	else
+		pathspec =3D validate_pathspec(argc, argv, prefix);
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..2201242 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -69,15 +69,16 @@ test_expect_success 'cache tree has not been corrup=
ted' '
 test_expect_success 'update from a subdirectory' '
 	(
 		cd dir1 &&
-		echo more >sub2 &&
+		echo more >>sub2 &&
 		git add -u sub2
-	)
-'
-
-test_expect_success 'change gets noticed' '
-
+	) &&
 	test "$(git diff-files --name-status dir1)" =3D ""
+'
=20
+test_expect_success 'update without args from subdir' '
+	echo more >>top &&
+	( cd dir1 && git add -u ) &&
+	test "$(git diff-files --name-status top)" =3D ""
 '
=20
 test_expect_success SYMLINKS 'replace a file with a symlink' '
--=20
1.7.3.4.878.g439c7
