From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff: support --cached on unborn branches
Date: Thu,  3 Feb 2011 13:23:34 +0700
Message-ID: <1296714214-5165-1-git-send-email-pclouds@gmail.com>
References: <20101031032413.GA27346@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 07:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PksdE-0001ID-7I
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 07:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab1BCGZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 01:25:05 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45229 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1BCGZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 01:25:04 -0500
Received: by yxt3 with SMTP id 3so344735yxt.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=BwBLIZXULmB+o6nzlAfdWCVB6KLP97JpZui0FoFmgMw=;
        b=kGg6Anj0YAR4653GJFo83K3/CORYvvULa6oBrrSoS90ruTXE6dDRoSfObgqXuxUtu7
         k4Spj7yg5fJdskhD686AxNulJR9cuZrwfyP7ASINlT8Tjp4nWBLvm/rAzFJYSEGzI0lL
         XUI7tPoD2vxqaGzZTuMiYCD0CJd8DF3PIM/08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mATlh4mdJUT0bNiIXwD5hZ1UMmyFZvrVuHx59YlUnb0YULdwJZXwB9uWw1mjDU14RK
         +pAh8xrKBnUPZJUYSC3i4W7SrWo9cBuAgO2hv1n0PtudJRXmX4+eAKXPbIOio15gy+oe
         gc6vxE1DuH/T7XusBglZmTsG9zwblqxjSxK20=
Received: by 10.236.103.145 with SMTP id f17mr20524565yhg.47.1296714303013;
        Wed, 02 Feb 2011 22:25:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.206.39])
        by mx.google.com with ESMTPS id i56sm323701yhd.14.2011.02.02.22.24.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 22:25:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Feb 2011 13:23:35 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <20101031032413.GA27346@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165961>

"git diff --cached" (without revision) used to mean "git diff --cached
HEAD" (i.e. the user was too lazy to type HEAD). This "correctly"
failed when there was no commit yet. But was that correctness useful?

This patch changes the definition of what particular command means.
It is a request to show what _would_ be committed without further "git
add". The internal implementation is still the same "git diff
--cached HEAD" when HEAD exists, but when there is no commit yet, it
compares the index with an empty tree object to achieve the desired
result.

(Written by Junio)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 (Good) old stuff. I think it wasn't accepted because I was lazy in
 updating docs. Resend (with doc updates).

 Documentation/git-diff.txt          |    2 +
 builtin/diff.c                      |    7 ++++-
 t/t4013-diff-various.sh             |   11 ++++++++++
 t/t4013/diff.diff_--cached          |   38 +++++++++++++++++++++++++++=
++++++++
 t/t4013/diff.diff_--cached_--_file0 |   15 +++++++++++++
 5 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 t/t4013/diff.diff_--cached
 create mode 100644 t/t4013/diff.diff_--cached_--_file0

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f6ac847..4910510 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -38,6 +38,8 @@ directories. This behavior can be forced by --no-inde=
x.
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
+	If HEAD does not exist (e.g. unborned branches) and
+	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
=20
 'git diff' [--options] <commit> [--] [<path>...]::
diff --git a/builtin/diff.c b/builtin/diff.c
index 945e758..42822cd 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -330,8 +330,11 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 			else if (!strcmp(arg, "--cached") ||
 				 !strcmp(arg, "--staged")) {
 				add_head_to_pending(&rev);
-				if (!rev.pending.nr)
-					die("No HEAD commit to compare with (yet)");
+				if (!rev.pending.nr) {
+					struct tree *tree;
+					tree =3D lookup_tree((const unsigned char*)EMPTY_TREE_SHA1_BIN);
+					add_pending_object(&rev, &tree->object, "HEAD");
+				}
 				break;
 			}
 		}
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9a66520..b8f81d0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -290,4 +290,15 @@ test_expect_success 'log -S requires an argument' =
'
 	test_must_fail git log -S
 '
=20
+test_expect_success 'diff --cached on unborn branch' '
+	echo ref: refs/heads/unborn >.git/HEAD &&
+	git diff --cached >result &&
+	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached" result
+'
+
+test_expect_success 'diff --cached -- file on unborn branch' '
+	git diff --cached -- file0 >result &&
+	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
+'
+
 test_done
diff --git a/t/t4013/diff.diff_--cached b/t/t4013/diff.diff_--cached
new file mode 100644
index 0000000..ff16e83
--- /dev/null
+++ b/t/t4013/diff.diff_--cached
@@ -0,0 +1,38 @@
+diff --git a/dir/sub b/dir/sub
+new file mode 100644
+index 0000000..992913c
+--- /dev/null
++++ b/dir/sub
+@@ -0,0 +1,8 @@
++A
++B
++C
++D
++E
++F
++1
++2
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000..10a8a9f
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,9 @@
++1
++2
++3
++4
++5
++6
++A
++B
++C
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
diff --git a/t/t4013/diff.diff_--cached_--_file0 b/t/t4013/diff.diff_--=
cached_--_file0
new file mode 100644
index 0000000..b9bb858
--- /dev/null
+++ b/t/t4013/diff.diff_--cached_--_file0
@@ -0,0 +1,15 @@
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000..10a8a9f
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,9 @@
++1
++2
++3
++4
++5
++6
++A
++B
++C
--=20
1.7.3.4.878.g439c7
