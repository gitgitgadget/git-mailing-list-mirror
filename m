From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] tests: A SANITY test prereq for testing if we're root
Date: Fri,  6 Aug 2010 22:09:09 +0000
Message-ID: <1281132549-11587-1-git-send-email-avarab@gmail.com>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 00:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhV6a-0007WV-0W
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 00:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761884Ab0HFWJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 18:09:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51115 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761821Ab0HFWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 18:09:25 -0400
Received: by wwj40 with SMTP id 40so9620577wwj.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dvSjSaE0wUnTMARqmLOKS9F2H8HNq+ZqCiabmCqvsXU=;
        b=Dk4NETJYK43daDISu95H3EwO8sY6F1G+J0WR4wkB+wH2RM66NK/SnUQw1Hf2agTsmq
         7weWVoAAqor7SOauorNdi2lb+cwemLSS+ReHPC+5BfpnVcx51DjnQcVci0+x+232FcSl
         n2pJSmCKaZDQ4HueVPQKWHYQkj11rTDnBlu04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pQ8e+bWmLREJnT5EXaUjBUwg9Bj7F8mgtIoITVRhs/g/4pwpf/NupMIlFfwYETmDKK
         9tWl57bGiGCSl/aE9luCmG6RaFp+020lJYsMKQukQ398ZVXzC0ufk1kQ4tSIRnx8dJg2
         i0FOuvjKZVI6cHqf7b5hqhnMODgf95dsHwm5U=
Received: by 10.216.233.234 with SMTP id p84mr11081004weq.38.1281132563683;
        Fri, 06 Aug 2010 15:09:23 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w46sm1185612weq.19.2010.08.06.15.09.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 15:09:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280934026-25658-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152822>

Some tests depend on not being able to write to files after chmod
-w. This doesn't work when running the tests as root.

Change test-lib.sh to test if this works, and if so it sets a new
SANITY test prerequisite. The tests that use this previously failed
when run under root.

There was already a test for this in t3600-rm.sh, added by Junio C
Hamano in 2283645 in 2006. That check now uses the new SANITY
prerequisite.

Some of this was resurrected from the "Tests in Cygwin" thread in May
2009:

    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118385

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Here's a buch improved v2 of this patch. It goes on top of the
just-submitted "tests: Better prerequisite handling & documentation"
series (<1281129565-26124-1-git-send-email-avarab@gmail.com>).

It uses the SANITY prerequisite suggested by Junio in 2009, and uses a
simpler `test -w /' test to check if we're the superuser.

 t/README                    |    5 +++++
 t/t0001-init.sh             |    2 +-
 t/t0004-unwritable.sh       |    8 ++++----
 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/t3600-rm.sh               |   16 ----------------
 t/t3700-add.sh              |   10 +++++-----
 t/t7300-clean.sh            |    7 +++----
 t/t7508-status.sh           |    2 +-
 t/test-lib.sh               |    4 ++++
 9 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/t/README b/t/README
index dc07939..28effb4 100644
--- a/t/README
+++ b/t/README
@@ -523,6 +523,11 @@ use these, and "test_set_prereq" for how to define=
 your own.
    The filesystem we're on supports symbolic links. E.g. a FAT
    filesystem doesn't support these. See 704a3143 for details.
=20
+ - SANITY
+
+   Test is not run by root user, and an attempt to write to an
+   unwritable file is expected to fail correctly.
+
 Tips for Writing Tests
 ----------------------
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7c0a698..7a75999 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -301,7 +301,7 @@ test_expect_success 'init notices EEXIST (2)' '
 	)
 '
=20
-test_expect_success POSIXPERM 'init notices EPERM' '
+test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
 	rm -fr newdir &&
 	(
 		mkdir newdir &&
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 2342ac5..385b126 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success POSIXPERM 'write-tree should notice unwritable rep=
ository' '
+test_expect_success POSIXPERM,SANITY 'write-tree should notice unwrita=
ble repository' '
=20
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -27,7 +27,7 @@ test_expect_success POSIXPERM 'write-tree should noti=
ce unwritable repository' '
=20
 '
=20
-test_expect_success POSIXPERM 'commit should notice unwritable reposit=
ory' '
+test_expect_success POSIXPERM,SANITY 'commit should notice unwritable =
repository' '
=20
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -39,7 +39,7 @@ test_expect_success POSIXPERM 'commit should notice u=
nwritable repository' '
=20
 '
=20
-test_expect_success POSIXPERM 'update-index should notice unwritable r=
epository' '
+test_expect_success POSIXPERM,SANITY 'update-index should notice unwri=
table repository' '
=20
 	(
 		echo 6O >file &&
@@ -52,7 +52,7 @@ test_expect_success POSIXPERM 'update-index should no=
tice unwritable repository'
=20
 '
=20
-test_expect_success POSIXPERM 'add should notice unwritable repository=
' '
+test_expect_success POSIXPERM,SANITY 'add should notice unwritable rep=
ository' '
=20
 	(
 		echo b >file &&
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index f19b4a2..eb8e3d4 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work=
 tree' '
=20
 '
=20
-test_expect_success SYMLINKS 'funny symlink in work tree, un-unlink-ab=
le' '
+test_expect_success SYMLINKS,SANITY 'funny symlink in work tree, un-un=
link-able' '
=20
 	rm -fr a b &&
 	git reset --hard &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b514cbb..b26cabd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -28,22 +28,6 @@ embedded' &&
      git commit -m 'add files with tabs and newlines'
 "
=20
-# Determine rm behavior
-# Later we will try removing an unremovable path to make sure
-# git rm barfs, but if the test is run as root that cannot be
-# arranged.
-: >test-file
-chmod a-w .
-rm -f test-file 2>/dev/null
-if test -f test-file
-then
-	test_set_prereq RO_DIR
-else
-	skip_all=3D'skipping removal failure test (perhaps running as root?)'
-fi
-chmod 775 .
-rm -f test-file
-
 test_expect_success \
     'Pre-check that foo exists and is in index before git rm foo' \
     '[ -f foo ] && git ls-files --error-unmatch foo'
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7d7140d..ec71083 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,7 +179,7 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
=20
-test_expect_success POSIXPERM 'git add should fail atomically upon an =
unreadable file' '
+test_expect_success POSIXPERM,SANITY 'git add should fail atomically u=
pon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -190,7 +190,7 @@ test_expect_success POSIXPERM 'git add should fail =
atomically upon an unreadable
=20
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add --ignore-errors' '
+test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -201,7 +201,7 @@ test_expect_success POSIXPERM 'git add --ignore-err=
ors' '
=20
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add (add.ignore-errors)' '
+test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
 	git config add.ignore-errors 1 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -212,7 +212,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-=
errors)' '
 '
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add (add.ignore-errors =3D false)' =
'
+test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors =3D f=
alse)' '
 	git config add.ignore-errors 0 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -223,7 +223,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-=
errors =3D false)' '
 '
 rm -f foo2
=20
-test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
+test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides con=
fig' '
        git config add.ignore-errors 1 &&
        git reset --hard &&
        date >foo1 &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7d8ed68..fe8abf6 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -388,16 +388,15 @@ test_expect_success 'core.excludesfile' '
=20
 '
=20
-test_expect_success 'removal failure' '
+test_expect_success SANITY 'removal failure' '
=20
 	mkdir foo &&
 	touch foo/bar &&
 	(exec <foo/bar &&
 	 chmod 0 foo &&
-	 test_must_fail git clean -f -d)
-
+	 test_must_fail git clean -f -d &&
+	 chmod 755 foo)
 '
-chmod 755 foo
=20
 test_expect_success 'nested git work tree' '
 	rm -fr foo bar &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a72fe3a..ee0e573 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -793,7 +793,7 @@ test_expect_success 'commit --dry-run submodule sum=
mary (--amend)' '
 	test_cmp expect output
 '
=20
-test_expect_success POSIXPERM 'status succeeds in a read-only reposito=
ry' '
+test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only r=
epository' '
 	(
 		chmod a-w .git &&
 		# make dir1/tracked stat-dirty
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e0a1c3..ace67a7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -894,3 +894,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
+
+# When the tests are run as root, permission tests will report that
+# things are writable when they shouldn't be.
+test -w / || test_set_prereq SANITY
--=20
1.7.1
