From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 05:34:27 -0500
Message-ID: <20100510103427.GA4806@progeny.tock>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
 <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 12:34:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQK0-00041u-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab0EJKed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 06:34:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51841 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab0EJKeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 06:34:31 -0400
Received: by vws3 with SMTP id 3so1255670vws.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WAMktb6blnFLitAF00uK8BH36qPEJMrkrdhSGYGhnGs=;
        b=jSL3I57ZfOqLFIem0pRSC5cTEz68aTQwJnYJy+peUY7rxKngYj+3HvizrgwQg7gfk2
         X1lKiedGd6yqtn/0Q4ArH3eCwGu1rvLblfdqN2C6r2QzDPcyS5YggsMcHETQdLDvSFKP
         PQZU89nldLFMZt9usmFgIeKkZh5fqCTuNXgJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YqxhbGuCWBMwwMI/pJJFQVbspIW5Hn7vIOSr6MTTGuXmIfqR+H7CxEYxi8V40Zfdsa
         Cd9YEHywfBSIBah5y0GWiQu80aP2V0OxtpbDPK/H06XV/ZhosUH7GtEd5zBeTzGbOUAt
         9TbH761FJNu8MDNa6wNTLG+a+iyRp0aDfDVeI=
Received: by 10.220.88.81 with SMTP id z17mr3167747vcl.34.1273487669819;
        Mon, 10 May 2010 03:34:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3524647yxe.15.2010.05.10.03.34.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 03:34:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146793>

Sverre Rabbelier wrote:

> Don't we do this ('test_cmp' on expected output) in many other places
> as well? Why is this different?

The problem arises with test_cmp on expected output from stderr, since
sh -x will mingle the trace of a function with the standard error
stream.  bash provides BASH_XTRACEFD to work around this misdesign,
but other shells might not be so helpful.

Here=E2=80=99s a workaround, ugly as sin.  It overreaches a little beca=
use I
did not bother to check which tests grep and which tests test_cmp
their output.

 t/t0040-parse-options.sh       |    6 +++---
 t/t1300-repo-config.sh         |    2 +-
 t/t1450-fsck.sh                |    2 +-
 t/t1503-rev-parse-verify.sh    |   20 ++++++++++----------
 t/t1506-rev-parse-diagnosis.sh |   24 ++++++++++++------------
 t/t2204-add-ignored.sh         |    8 ++++----
 t/t3030-merge-recursive.sh     |    6 +++---
 t/t3400-rebase.sh              |    2 +-
 t/t3501-revert-cherry-pick.sh  |    2 +-
 t/t3800-mktag.sh               |    2 +-
 t/t4011-diff-symlink.sh        |    2 +-
 t/t4014-format-patch.sh        |    6 +++---
 t/t4120-apply-popt.sh          |    2 +-
 t/t4124-apply-ws-rule.sh       |    2 +-
 t/t4133-apply-filenames.sh     |    6 +++---
 t/t5300-pack-object.sh         |    2 +-
 t/t5400-send-pack.sh           |    2 +-
 t/t5406-remote-rejects.sh      |    4 +++-
 t/t5505-remote.sh              |    4 ++--
 t/t5510-fetch.sh               |    2 +-
 t/t5512-ls-remote.sh           |    2 +-
 t/t6024-recursive-merge.sh     |    2 +-
 t/t6030-bisect-porcelain.sh    |    6 +++---
 t/t7110-reset-merge.sh         |   10 +++++-----
 t/t7201-co.sh                  |    2 +-
 t/t7610-mergetool.sh           |    6 +++---
 t/t8003-blame.sh               |    4 ++--
 t/t9001-send-email.sh          |   14 +++++++-------
 t/t9108-git-svn-glob.sh        |    2 +-
 29 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 3d450ed..a2d53a9 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -45,7 +45,7 @@ Standard options
 EOF
=20
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	test_must_fail eval "test-parse-options -h >output 2>output.err" &&
 	test ! -s output &&
 	test_cmp expect.err output.err
 '
@@ -172,7 +172,7 @@ error: did you mean \`--boolean\` (with two dashes =
?)
 EOF
=20
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
+	test_must_fail eval "test-parse-options -boolean >output 2>output.err=
" &&
 	test ! -s output &&
 	test_cmp typo.err output.err
 '
@@ -240,7 +240,7 @@ Callback: "not set", 1
 EOF
=20
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err =
&&
+	test_must_fail eval "test-parse-options --no-length >output 2>output.=
err" &&
 	test_cmp expect output &&
 	test_cmp expect.err output.err
 '
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..2808b24 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -344,7 +344,7 @@ test_expect_success 'get bool variable with empty v=
alue' \
 	 cmp output expect'
=20
 test_expect_success 'no arguments, but no crash' '
-	test_must_fail git config >output 2>&1 &&
+	test_must_fail eval "git config >output 2>&1" &&
 	grep usage output
 '
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 49cae3e..9b9efb8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -87,7 +87,7 @@ EOF
 test_expect_success 'tag pointing to something else than its type' '
 	tag=3D$(git hash-object -t tag -w --stdin < wrong-tag) &&
 	echo $tag > .git/refs/tags/wrong &&
-	test_must_fail git fsck --tags 2>out &&
+	test_must_fail eval "git fsck --tags 2>out" &&
 	cat out &&
 	grep "error in tag.*broken links" out &&
 	rm .git/refs/tags/wrong
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index cc65394..b731a28 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -58,28 +58,28 @@ test_expect_success 'works with one good rev' '
 '
=20
 test_expect_success 'fails with any bad rev or many good revs' '
-	test_must_fail git rev-parse --verify 2>error &&
+	test_must_fail eval "git rev-parse --verify 2>error" &&
 	grep "single revision" error &&
-	test_must_fail git rev-parse --verify foo 2>error &&
+	test_must_fail eval "git rev-parse --verify foo 2>error" &&
 	grep "single revision" error &&
-	test_must_fail git rev-parse --verify HEAD bar 2>error &&
+	test_must_fail eval "git rev-parse --verify HEAD bar 2>error" &&
 	grep "single revision" error &&
-	test_must_fail git rev-parse --verify baz HEAD 2>error &&
+	test_must_fail eval "git rev-parse --verify baz HEAD 2>error" &&
 	grep "single revision" error &&
-	test_must_fail git rev-parse --verify $HASH2 HEAD 2>error &&
+	test_must_fail eval "git rev-parse --verify $HASH2 HEAD 2>error" &&
 	grep "single revision" error
 '
=20
 test_expect_success 'fails silently when using -q' '
-	test_must_fail git rev-parse --verify --quiet 2>error &&
+	test_must_fail eval "git rev-parse --verify --quiet 2>error" &&
 	test -z "$(cat error)" &&
-	test_must_fail git rev-parse -q --verify foo 2>error &&
+	test_must_fail eval "git rev-parse -q --verify foo 2>error" &&
 	test -z "$(cat error)" &&
-	test_must_fail git rev-parse --verify -q HEAD bar 2>error &&
+	test_must_fail eval "git rev-parse --verify -q HEAD bar 2>error" &&
 	test -z "$(cat error)" &&
-	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
+	test_must_fail eval "git rev-parse --quiet --verify baz HEAD 2>error"=
 &&
 	test -z "$(cat error)" &&
-	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
+	test_must_fail eval "git rev-parse -q --verify $HASH2 HEAD 2>error" &=
&
 	test -z "$(cat error)"
 '
=20
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnos=
is.sh
index af721f9..67dcb33 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -32,37 +32,37 @@ test_expect_success 'correct file objects' '
 '
=20
 test_expect_success 'incorrect revision id' '
-	test_must_fail git rev-parse foobar:file.txt 2>error &&
+	test_must_fail eval "git rev-parse foobar:file.txt 2>error" &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
-	test_must_fail git rev-parse foobar 2> error &&
+	test_must_fail eval "git rev-parse foobar 2>error" &&
 	grep "unknown revision or path not in the working tree." error
 '
=20
 test_expect_success 'incorrect file in sha1:path' '
-	test_must_fail git rev-parse HEAD:nothing.txt 2> error &&
+	test_must_fail eval "git rev-parse HEAD:nothing.txt 2>error" &&
 	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"=
'"'" error &&
-	test_must_fail git rev-parse HEAD:index-only.txt 2> error &&
+	test_must_fail eval "git rev-parse HEAD:index-only.txt 2>error" &&
 	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in=
 '"'"'HEAD'"'"'." error &&
 	(cd subdir &&
-	 test_must_fail git rev-parse HEAD:file2.txt 2> error &&
+	 test_must_fail eval "git rev-parse HEAD:file2.txt 2>error" &&
 	 grep "Did you mean '"'"'HEAD:subdir/file2.txt'"'"'?" error )
 '
=20
 test_expect_success 'incorrect file in :path and :N:path' '
-	test_must_fail git rev-parse :nothing.txt 2> error &&
+	test_must_fail eval "git rev-parse :nothing.txt 2>error" &&
 	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist (neither on di=
sk nor in the index)." error &&
-	test_must_fail git rev-parse :1:nothing.txt 2> error &&
+	test_must_fail eval "git rev-parse :1:nothing.txt 2>error" &&
 	grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor =
in the index)." error &&
-	test_must_fail git rev-parse :1:file.txt 2> error &&
+	test_must_fail eval "git rev-parse :1:file.txt 2>error" &&
 	grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
 	(cd subdir &&
-	 test_must_fail git rev-parse :1:file.txt 2> error &&
+	 test_must_fail eval "git rev-parse :1:file.txt 2>error" &&
 	 grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
-	 test_must_fail git rev-parse :file2.txt 2> error &&
+	 test_must_fail eval "git rev-parse :file2.txt 2>error" &&
 	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error &&
-	 test_must_fail git rev-parse :2:file2.txt 2> error &&
+	 test_must_fail eval "git rev-parse :2:file2.txt 2>error" &&
 	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error) &&
-	test_must_fail git rev-parse :disk-only.txt 2> error &&
+	test_must_fail eval "git rev-parse :disk-only.txt 2>error" &&
 	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in =
the index." error
 '
=20
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 24afdab..89052da 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -29,7 +29,7 @@ for i in ign dir/ign dir/sub dir/sub/*ign sub/file su=
b sub/*
 do
 	test_expect_success "complaints for ignored $i" '
 		rm -f .git/index &&
-		test_must_fail git add "$i" 2>err &&
+		test_must_fail eval "git add \"\$i\" 2>err" &&
 		git ls-files "$i" >out &&
 		! test -s out &&
 		grep -e "Use -f if" err &&
@@ -38,7 +38,7 @@ do
=20
 	test_expect_success "complaints for ignored $i with unignored file" '
 		rm -f .git/index &&
-		test_must_fail git add "$i" file 2>err &&
+		test_must_fail eval "git add \"\$i\" file 2>err" &&
 		git ls-files "$i" >out &&
 		! test -s out &&
 		grep -e "Use -f if" err &&
@@ -52,7 +52,7 @@ do
 		rm -f .git/index &&
 		(
 			cd dir &&
-			test_must_fail git add "$i" 2>err &&
+			test_must_fail eval "git add \"\$i\" 2>err" &&
 			git ls-files "$i" >out &&
 			! test -s out &&
 			grep -e "Use -f if" err &&
@@ -67,7 +67,7 @@ do
 		rm -f .git/index &&
 		(
 			cd sub &&
-			test_must_fail git add "$i" 2>err &&
+			test_must_fail eval "git add \"\$i\" 2>err" &&
 			git ls-files "$i" >out &&
 			! test -s out &&
 			grep -e "Use -f if" err &&
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 9929f82..589ab49 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -275,13 +275,13 @@ test_expect_success 'fail if the index has unreso=
lved entries' '
 	git checkout -f "$c1" &&
=20
 	test_must_fail git merge "$c5" &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail eval "git merge \"\$c5\" 2>out" &&
 	grep "not possible because you have unmerged files" out &&
 	git add -u &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail eval "git merge \"\$c5\" 2>out" &&
 	grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail eval "git merge \"\$c5\" 2>out" &&
 	grep "Your local changes to .* would be overwritten by merge." out
 '
=20
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index dbf7dfb..ee3314b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -123,7 +123,7 @@ test_expect_success 'rebase a single mode change' '
=20
 test_expect_success 'Show verbose error when HEAD could not be detache=
d' '
      : > B &&
-     test_must_fail git rebase topic 2> output.err > output.out &&
+     test_must_fail eval "git rebase topic 2>output.err >output.out" &=
&
      grep "Untracked working tree file .B. would be overwritten" outpu=
t.err
 '
=20
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 7f85815..6e0d521 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -65,7 +65,7 @@ test_expect_success 'revert forbidden on dirty workin=
g tree' '
=20
 	echo content >extra_file &&
 	git add extra_file &&
-	test_must_fail git revert HEAD 2>errors &&
+	test_must_fail eval "git revert HEAD 2>errors" &&
 	grep "Your local changes would be overwritten by " errors
=20
 '
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 8eb4794..b3d84ad 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description=3D'git mktag: tag object verify test=
'
 check_verify_failure () {
 	expect=3D"$2"
 	test_expect_success "$1" '
-		( test_must_fail git mktag <tag.sig 2>message ) &&
+		test_must_fail eval "git mktag <tag.sig 2>message" &&
 		grep "$expect" message
 	'
 }
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index e12fbea..09cce8b 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -91,7 +91,7 @@ test_expect_success \
     'diff symlinks with non-existing targets' \
     'ln -s narf pinky &&
     ln -s take\ over brain &&
-    test_must_fail git diff --no-index pinky brain > output 2> output.=
err &&
+    test_must_fail eval "git diff --no-index pinky brain >output 2>out=
put.err" &&
     grep narf output &&
     ! grep error output.err'
 test_done
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d21c37f..9d1a555 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -593,11 +593,11 @@ echo "fatal: --name-status does not make sense" >=
 expect.name-status
 echo "fatal: --check does not make sense" > expect.check
=20
 test_expect_success 'options no longer allowed for format-patch' '
-	test_must_fail git format-patch --name-only 2> output &&
+	test_must_fail eval "git format-patch --name-only 2>output" &&
 	test_cmp expect.name-only output &&
-	test_must_fail git format-patch --name-status 2> output &&
+	test_must_fail eval "git format-patch --name-status 2>output" &&
 	test_cmp expect.name-status output &&
-	test_must_fail git format-patch --check 2> output &&
+	test_must_fail eval "git format-patch --check 2>output" &&
 	test_cmp expect.check output'
=20
 test_expect_success 'format-patch --numstat should produce a patch' '
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index b463b4f..4b67cbd 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -23,7 +23,7 @@ test_expect_success 'apply git diff with -p2' '
 '
=20
 test_expect_success 'apply with too large -p' '
-	test_must_fail git apply --stat -p3 patch.file 2>err &&
+	test_must_fail eval "git apply --stat -p3 patch.file 2>err" &&
 	grep "removing 3 leading" err
 '
=20
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index d0af697..7a00095 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -248,7 +248,7 @@ test_expect_success 'blank at EOF with --whitespace=
=3Derror' '
 	git diff -- one >patch &&
=20
 	git checkout one &&
-	test_must_fail git apply --whitespace=3Derror patch 2>error &&
+	test_must_fail eval "git apply --whitespace=3Derror patch 2>error" &&
 	test_cmp expect one &&
 	grep "new blank line at EOF" error
 '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3421807..5a172f4 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -29,9 +29,9 @@ EOF
 '
=20
 test_expect_success 'apply diff with inconsistent filenames in headers=
' '
-	test_must_fail git apply bad1.patch 2>err
-	grep "inconsistent new filename" err
-	test_must_fail git apply bad2.patch 2>err
+	test_must_fail eval "git apply bad1.patch 2>err" &&
+	grep "inconsistent new filename" err &&
+	test_must_fail eval "git apply bad2.patch 2>err" &&
 	grep "inconsistent old filename" err
 '
=20
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7649b81..2d2cf26 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -411,7 +411,7 @@ test_expect_success \
=20
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
+    'test_must_fail eval "git index-pack -o bad.idx test-3.pack 2>msg"=
 &&
      grep "SHA1 COLLISION FOUND" msg'
=20
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index c718253..30da728 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -195,7 +195,7 @@ test_expect_success 'deny pushing to delete current=
 branch' '
 	rewound_push_setup &&
 	(
 	    cd child &&
-	    test_must_fail git send-pack ../parent :refs/heads/master 2>errs
+	    test_must_fail eval "git send-pack ../parent :refs/heads/master 2=
>errs"
 	)
 '
=20
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 59e80a5..e52f8e8 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -17,7 +17,9 @@ test_expect_success 'setup' '
 	git commit -a -m 2
 '
=20
-test_expect_success 'push reports error' 'test_must_fail git push 2>st=
derr'
+test_expect_success 'push reports error' '
+	test_must_fail eval "git push 2>stderr"
+'
=20
 test_expect_success 'individual ref reports error' 'grep rejected stde=
rr'
=20
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 230c0cd..400c7b6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -252,8 +252,8 @@ EOF
=20
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(cd test &&
-	 test_must_fail git remote set-head --auto two >output 2>&1 &&
-	test_cmp expect output)
+	 test_must_fail eval "git remote set-head --auto two >output 2>&1" &&
+	 test_cmp expect output)
 '
=20
 cat >test/expect <<EOF
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 721821e..c49fb33 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -242,7 +242,7 @@ test_expect_success 'fetch with a non-applying bran=
ch.<name>.merge' '
=20
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
-	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
+	test_must_fail eval "git fetch \"a\\\\!'\''b\" >result 2>&1" &&
 	cat result &&
 	grep "fatal: '\''a\\\\!'\''b'\''" result
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3cf1b3d..a922e78 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -102,7 +102,7 @@ test_expect_success 'confuses pattern as remote whe=
n no remote specified' '
=20
 	# We could just as easily have used "master"; the "*" emphasizes its
 	# role as a pattern.
-	test_must_fail git ls-remote refs*master >actual 2>&1 &&
+	test_must_fail eval "git ls-remote refs*master >actual 2>&1" &&
 	test_cmp exp actual
=20
 '
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index b3fbf65..253913f 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -92,7 +92,7 @@ test_expect_success 'refuse to merge binary files' '
 	printf "\0\0" > binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	test_must_fail git merge F > merge.out 2> merge.err &&
+	test_must_fail eval "git merge F >merge.out 2>merge.err" &&
 	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
 '
=20
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3b042aa..df98ed8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -368,7 +368,7 @@ test_expect_success 'bisect starting with a detache=
d HEAD' '
=20
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
-	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
+	test_must_fail eval "git bisect start $HASH2 $HASH4 2>rev_list_error"=
 &&
 	grep "mistake good and bad" rev_list_error &&
 	git bisect reset
 '
@@ -432,7 +432,7 @@ test_expect_success 'bad merge base when good and b=
ad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
 	grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
-	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
+	test_must_fail eval "git bisect bad >my_bisect_log.txt 2>&1" &&
 	grep "merge base $HASH4 is bad" my_bisect_log.txt &&
 	grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
 	git bisect reset
@@ -568,7 +568,7 @@ test_expect_success 'skipping away from skipped com=
mit' '
 '
=20
 test_expect_success 'erroring out when using bad path parameters' '
-	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error=
=2Etxt &&
+	test_must_fail eval "git bisect start $PARA_HASH7 $HASH1 -- foobar 2>=
error.txt" &&
 	grep "bad path parameters" error.txt
 '
=20
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 70cdd8e..39eb677 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -172,7 +172,7 @@ test_expect_success 'reset --merge fails with chang=
es in file it touches' '
     git commit -m "add line 5" file1 &&
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
-    test_must_fail git reset --merge HEAD^ 2>err.log &&
+    test_must_fail eval "git reset --merge HEAD^ 2>err.log" &&
     grep file1 err.log | grep "not uptodate"
 '
=20
@@ -188,7 +188,7 @@ test_expect_success 'reset --keep fails with change=
s in file it touches' '
     git commit -m "add line 5" file1 &&
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
-    test_must_fail git reset --keep HEAD^ 2>err.log &&
+    test_must_fail eval "git reset --keep HEAD^ 2>err.log" &&
     grep file1 err.log | grep "not uptodate"
 '
=20
@@ -236,7 +236,7 @@ test_expect_success '"reset --merge HEAD^" is ok wi=
th pending merge' '
 test_expect_success '"reset --keep HEAD^" fails with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
-    test_must_fail git reset --keep HEAD^ 2>err.log &&
+    test_must_fail eval "git reset --keep HEAD^ 2>err.log" &&
     grep "middle of a merge" err.log
 '
=20
@@ -262,7 +262,7 @@ test_expect_success '"reset --merge HEAD" is ok wit=
h pending merge' '
 test_expect_success '"reset --keep HEAD" fails with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
-    test_must_fail git reset --keep HEAD 2>err.log &&
+    test_must_fail eval "git reset --keep HEAD 2>err.log" &&
     grep "middle of a merge" err.log
 '
=20
@@ -288,7 +288,7 @@ test_expect_success '--keep fails with added/delete=
d merge' '
     test -f file3 &&
     git diff --exit-code file3 &&
     git diff --exit-code branch3 file3 &&
-    test_must_fail git reset --keep HEAD 2>err.log &&
+    test_must_fail eval "git reset --keep HEAD 2>err.log" &&
     grep "middle of a merge" err.log
 '
=20
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1337fa5..c2b7c7f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -607,7 +607,7 @@ test_expect_success 'switch out of non-branch' '
 	git reset --hard master &&
 	git checkout master^0 &&
 	echo modified >one &&
-	test_must_fail git checkout renamer 2>error.log &&
+	test_must_fail eval "git checkout renamer 2>error.log" &&
 	! grep "^Previous HEAD" error.log
 '
=20
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index e768c3e..b710cc4 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -41,7 +41,7 @@ test_expect_success 'setup' '
=20
 test_expect_success 'custom mergetool' '
     git checkout -b test1 branch1 &&
-    test_must_fail git merge master >/dev/null 2>&1 &&
+    test_must_fail eval "git merge master >/dev/null 2>&1" &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
@@ -54,7 +54,7 @@ test_expect_success 'custom mergetool' '
 test_expect_success 'mergetool crlf' '
     git config core.autocrlf true &&
     git checkout -b test2 branch1
-    test_must_fail git merge master >/dev/null 2>&1 &&
+    test_must_fail eval "git merge master >/dev/null 2>&1" &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
@@ -69,7 +69,7 @@ test_expect_success 'mergetool crlf' '
 test_expect_success 'mergetool in subdir' '
     git checkout -b test3 branch1
     cd subdir && (
-    test_must_fail git merge master >/dev/null 2>&1 &&
+    test_must_fail eval "git merge master >/dev/null 2>&1" &&
     ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
     test "$(cat file3)" =3D "master new sub" )
 '
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 230143c..278db29 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -166,12 +166,12 @@ EOF
 '
=20
 test_expect_success 'blame -L with invalid start' '
-	test_must_fail git blame -L5 tres 2>errors &&
+	test_must_fail eval "git blame -L5 tres 2>errors" &&
 	grep "has only 2 lines" errors
 '
=20
 test_expect_success 'blame -L with invalid end' '
-	test_must_fail git blame -L1,5 tres 2>errors &&
+	test_must_fail eval "git blame -L1,5 tres 2>errors" &&
 	grep "has only 2 lines" errors
 '
=20
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 640b3d2..5e4202f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -216,12 +216,12 @@ test_expect_success 'reject long lines' '
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
 	echo $z512$z512 >>longline.patch &&
-	test_must_fail git send-email \
-		--from=3D"Example <nobody@example.com>" \
-		--to=3Dnobody@example.com \
-		--smtp-server=3D"$(pwd)/fake.sendmail" \
-		$patches longline.patch \
-		2>errors &&
+	test_must_fail eval "git send-email" \
+		"--from=3D\"Example <nobody@example.com>\"" \
+		"--to=3Dnobody@example.com" \
+		"--smtp-server=3D\"\$(pwd)/fake.sendmail\"" \
+		"\$patches" "longline.patch" \
+		"2>errors" &&
 	grep longline.patch errors
 '
=20
@@ -754,7 +754,7 @@ test_expect_success 'detects ambiguous reference/fi=
le conflict' '
 	echo master > master &&
 	git add master &&
 	git commit -m"add master" &&
-	test_must_fail git send-email --dry-run master 2>errors &&
+	test_must_fail eval "git send-email --dry-run master 2>errors" &&
 	grep disambiguate errors
 '
=20
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d732d31..4494940 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -104,7 +104,7 @@ test_expect_success 'test disallow multi-globs' '
 		poke tags/end/src/b/readme &&
 		svn_cmd commit -m "try to try"
 	) &&
-	test_must_fail git svn fetch three 2> stderr.three &&
+	test_must_fail eval "git svn fetch three 2>stderr.three" &&
 	test_cmp expect.three stderr.three
 	'
=20
--=20
1.7.1.82.g73d41.dirty
