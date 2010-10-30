From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] diff: support --cached on unborn branches
Date: Sat, 30 Oct 2010 18:16:17 +0700
Message-ID: <1288437377-30405-1-git-send-email-pclouds@gmail.com>
References: <7vhbg56i9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 30 13:16:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC9QP-0003Wp-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 13:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0J3LQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 07:16:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0J3LQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 07:16:26 -0400
Received: by iwn10 with SMTP id 10so4855996iwn.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8AMQ8KW8GYHbh98Qf2YNPGnCixLVyy1rGuyCwstuC5Q=;
        b=ihpbxv/OlL+0BhZceU07XVqyZz0rhlT77AizqWc42fNTqyOAwMjrIzWQWsVfPJNzMy
         X/Sh0Z7kSqFQB83brVcDdeo8wlauFnWLl1JMDxeHdg9YANthnE++1AUsOHpgVGYpJL01
         hvTqBErw41tKRtp54qOELRvFzMvC9dbCzW7Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kDw3R/n7fiACu6PIoBUb55k99kFN2Gks2GBI5eMT2RS9eJB06e3/d1nhDJiFnYeOxA
         AyiaKQV+l787cbJDxq7f73md4r8a+V2KIODQxsPp14NAlHNLutgNctr6p1VTfFzRItEt
         9qIEroUx2RZWmJtze+wdS5nKY5RNz2EbWYRrQ=
Received: by 10.42.208.75 with SMTP id gb11mr7548827icb.290.1288437384544;
        Sat, 30 Oct 2010 04:16:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w9sm5060076ibc.7.2010.10.30.04.16.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 04:16:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 30 Oct 2010 18:16:23 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <7vhbg56i9s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160399>

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
 "git diff --cached HEAD" does fail, but I don't really care.

 builtin/diff.c                      |    7 ++++-
 t/t4013-diff-various.sh             |   11 ++++++++++
 t/t4013/diff.diff_--cached          |   38 +++++++++++++++++++++++++++=
++++++++
 t/t4013/diff.diff_--cached_--_file0 |   15 +++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 t/t4013/diff.diff_--cached
 create mode 100644 t/t4013/diff.diff_--cached_--_file0

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..d8db957 100644
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
1.7.0.2.445.gcbdb3
