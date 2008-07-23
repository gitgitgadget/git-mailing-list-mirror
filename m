From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 07/12] tests for sparse checkout, worktree protection
Date: Wed, 23 Jul 2008 21:57:03 +0700
Message-ID: <20080723145703.GA29123@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfoA-0003Lc-FQ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbYGWO5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbYGWO52
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:57:28 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbYGWO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:57:24 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=qcuqC7ckDxheSOhM3XX0ZFVHD4wceINzA4Z5/RgDF/A=;
        b=sC/fGTpmGKX857l+sWswYYqDEBnbl32McwoA9qGv+7os5c+sS6Yor+1e/31qRA4wlK
         024B1wAlgwhLUhfuCwdEhAWbwUgWhUC3+pv4bUbLujmmV5eUNS1sXPnB9vCfMY8WA8CO
         HDsDA9EmTLphc4L0yQGrQn9PZayKT0I1f2g4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=k1qlTazENFnndfWkQJ8cxZj9sCcEQZeDuPaABnmcJ9kFRR41c0eenYC221IhipkLas
         1g8Gi2qZeiFW4I5Nu0tMRR92m+slgjZxDXinoxs/7tG0W2i5bT4wdzQlIcIdIXvo/12t
         eHEHuoo+N3Aw3vtdvegCw6SW3fZAoObm4iE8g=
Received: by 10.110.52.1 with SMTP id z1mr133482tiz.11.1216825043517;
        Wed, 23 Jul 2008 07:57:23 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id a4sm14727248tib.2.2008.07.23.07.57.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:57:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:57:03 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89680>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2302-sparse-worktree.sh                 |  113 ++++++++++++++
 t/t2302/add-u.expected                     |    1 +
 t/t2302/add.expected                       |    2 +
 t/t2302/commit.expected                    |   14 ++
 t/t2302/diff-1.expected                    |    7 +
 t/t2302/diff-cc.expected                   |    9 +
 t/t2302/grep-work.expected                 |    2 +
 t/t2302/grep.expected                      |    2 +
 t/t2302/ls-files.expected                  |    2 +
 t/t2303-sparse-worktree-apply.sh           |   62 ++++++++
 t/t2303/apply-initial.patch                |   14 ++
 t/t2303/apply-inside.patch                 |    7 +
 t/t2303/apply-leading-dirs.patch           |    3 +
 t/t2303/apply-outside.patch                |    7 +
 t/t2303/apply-remove.patch                 |    7 +
 t/t2303/apply-rename.expected              |   13 ++
 t/t2303/apply-rename.patch                 |    4 +
 t/t2304-sparse-worktree-merge-recursive.sh |  233 ++++++++++++++++++++=
++++++++
 18 files changed, 502 insertions(+), 0 deletions(-)
 create mode 100755 t/t2302-sparse-worktree.sh
 create mode 100644 t/t2302/add-u.expected
 create mode 100644 t/t2302/add.expected
 create mode 100644 t/t2302/commit.expected
 create mode 100644 t/t2302/diff-1.expected
 create mode 100644 t/t2302/diff-cc.expected
 create mode 100644 t/t2302/grep-work.expected
 create mode 100644 t/t2302/grep.expected
 create mode 100644 t/t2302/ls-files.expected
 create mode 100755 t/t2303-sparse-worktree-apply.sh
 create mode 100644 t/t2303/apply-initial.patch
 create mode 100644 t/t2303/apply-inside.patch
 create mode 100644 t/t2303/apply-leading-dirs.patch
 create mode 100644 t/t2303/apply-outside.patch
 create mode 100644 t/t2303/apply-remove.patch
 create mode 100644 t/t2303/apply-rename.expected
 create mode 100644 t/t2303/apply-rename.patch
 create mode 100755 t/t2304-sparse-worktree-merge-recursive.sh

diff --git a/t/t2302-sparse-worktree.sh b/t/t2302-sparse-worktree.sh
new file mode 100755
index 0000000..0aaee3e
--- /dev/null
+++ b/t/t2302-sparse-worktree.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout -- worktree update
+
+This test makes sure all commands that will not write
+worktree outside sparse prefix, once set.
+'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_tick &&
+	mkdir work &&
+	echo one > tracked &&
+	cp tracked work/tracked &&
+	cp tracked untracked &&
+	cp tracked work/untracked &&
+	cp tracked modified &&
+	cp tracked work/modified &&
+	git add tracked modified work/tracked work/modified &&
+	echo two >> modified &&
+	echo two >> work/modified &&
+	git commit -m initial &&
+	git config core.sparsecheckout work'
+
+test_expect_success 'rev-parse --show-sparse-prefix' '
+	test "$(git rev-parse --show-sparse-prefix)" =3D "work"
+'
+
+test_expect_success 'ls-files' '
+	git ls-files | cmp ../t2302/ls-files.expected &&
+	test "$(git ls-files -o)" =3D work/untracked &&
+	test "$(git ls-files -o .)" =3D work/untracked &&
+	test "$(git ls-files -m)" =3D work/modified
+
+'
+
+test_expect_success 'grep' 'git grep -l --no-external-grep one | cmp .=
=2E/t2302/grep.expected'
+
+test_expect_success 'grep' '
+	(
+	cd work &&
+	git grep -l --no-external-grep one | cmp ../../t2302/grep-work.expect=
ed
+	)
+'
+
+test_expect_success 'checkout-index' '! git checkout-index tracked'
+
+test_expect_success 'checkout-index -a' '
+	mv work/modified work/modified.old &&
+	git checkout-index -a &&
+	mv work/modified.old work/modified
+'
+
+test_expect_success 'checkout tracked' '! git checkout tracked'
+
+test_expect_success 'checkout work/tracked' 'rm work/tracked && git ch=
eckout work/tracked'
+
+test_expect_success 'clean' 'test "$(git clean -n)" =3D "Would remove =
work/untracked"'
+
+test_expect_success 'rm' '! git rm tracked && test -f tracked'
+
+test_expect_success 'add' '
+	git add -n . | cmp ../t2302/add.expected &&
+	git add -n -u | cmp ../t2302/add-u.expected &&
+	! git add -n modified
+'
+
+test_expect_success 'commit' '
+	test_tick &&
+	echo one > work/one &&
+	git add work/one
+	echo two >> work/one &&
+	git commit -m one work/one &&
+	git show HEAD > commit.result &&
+	cmp commit.result ../t2302/commit.expected &&
+	rm commit.result
+'
+
+null_sha1=3D0000000000000000000000000000000000000000
+one_sha1=3D$(echo one|git hash-object --stdin)
+onethree_sha1=3D$(echo -e "one\nthree"|git hash-object -w --stdin)
+onefour_sha1=3D$(echo -e "one\nfour"|git hash-object -w --stdin)
+
+diff_expected=3D":100644 100644 $one_sha1 $null_sha1 M	work/modified"
+external_diff_pattern=3D"^work/modified [^ ]* $one_sha1 100644 work/mo=
dified $null_sha1 100644\$"
+
+cat >index.info <<EOF
+0 $null_sha1	work/modified
+100644 $onethree_sha1 2	work/modified
+100644 $onefour_sha1 3	work/modified
+EOF
+
+test_expect_success 'diff-files' '
+	test "$(git diff-files)" =3D "$diff_expected" &&
+	test "$(git diff-files -- work/modified)" =3D "$diff_expected"
+	cp .git/index .git/index.save &&
+	git update-index --index-info < index.info &&
+	git diff-files --cc | diff - ../t2302/diff-cc.expected &&
+	mv .git/index.save .git/index
+'
+
+test_expect_success 'diff-index' '
+	test "$(git diff-index HEAD)" =3D "$diff_expected"
+'
+
+test_expect_success 'diff' '
+	git diff HEAD | cmp ../t2302/diff-1.expected &&
+	git diff | cmp ../t2302/diff-1.expected &&
+	GIT_EXTERNAL_DIFF=3Decho git diff --ext-diff HEAD | grep -q "$externa=
l_diff_pattern" &&
+	GIT_EXTERNAL_DIFF=3Decho git diff --ext-diff | grep -q "$external_dif=
f_pattern"=20
+'
+
+test_done
diff --git a/t/t2302/add-u.expected b/t/t2302/add-u.expected
new file mode 100644
index 0000000..e0d6f54
--- /dev/null
+++ b/t/t2302/add-u.expected
@@ -0,0 +1 @@
+add 'work/modified'
diff --git a/t/t2302/add.expected b/t/t2302/add.expected
new file mode 100644
index 0000000..4ee7b0d
--- /dev/null
+++ b/t/t2302/add.expected
@@ -0,0 +1,2 @@
+add 'work/modified'
+add 'work/untracked'
diff --git a/t/t2302/commit.expected b/t/t2302/commit.expected
new file mode 100644
index 0000000..7e629aa
--- /dev/null
+++ b/t/t2302/commit.expected
@@ -0,0 +1,14 @@
+commit 33ce2cea204feebac3994cd4520cca60657e65de
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    one
+
+diff --git a/work/one b/work/one
+new file mode 100644
+index 0000000..814f4a4
+--- /dev/null
++++ b/work/one
+@@ -0,0 +1,2 @@
++one
++two
diff --git a/t/t2302/diff-1.expected b/t/t2302/diff-1.expected
new file mode 100644
index 0000000..67be4fb
--- /dev/null
+++ b/t/t2302/diff-1.expected
@@ -0,0 +1,7 @@
+diff --git a/work/modified b/work/modified
+index 5626abf..814f4a4 100644
+--- a/work/modified
++++ b/work/modified
+@@ -1 +1,2 @@
+ one
++two
diff --git a/t/t2302/diff-cc.expected b/t/t2302/diff-cc.expected
new file mode 100644
index 0000000..8ca66dd
--- /dev/null
+++ b/t/t2302/diff-cc.expected
@@ -0,0 +1,9 @@
+diff --cc work/modified
+index 4c7442b,a9c7698..0000000
+--- a/work/modified
++++ b/work/modified
+@@@ -1,2 -1,2 +1,2 @@@
+  one
+- three
+ -four
+++two
diff --git a/t/t2302/grep-work.expected b/t/t2302/grep-work.expected
new file mode 100644
index 0000000..c081ddd
--- /dev/null
+++ b/t/t2302/grep-work.expected
@@ -0,0 +1,2 @@
+modified
+tracked
diff --git a/t/t2302/grep.expected b/t/t2302/grep.expected
new file mode 100644
index 0000000..4ddbe70
--- /dev/null
+++ b/t/t2302/grep.expected
@@ -0,0 +1,2 @@
+work/modified
+work/tracked
diff --git a/t/t2302/ls-files.expected b/t/t2302/ls-files.expected
new file mode 100644
index 0000000..4ddbe70
--- /dev/null
+++ b/t/t2302/ls-files.expected
@@ -0,0 +1,2 @@
+work/modified
+work/tracked
diff --git a/t/t2303-sparse-worktree-apply.sh b/t/t2303-sparse-worktree=
-apply.sh
new file mode 100755
index 0000000..4aeaf53
--- /dev/null
+++ b/t/t2303-sparse-worktree-apply.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description=3D'git-apply in subtree checkout'
+
+. ./test-lib.sh
+
+mkdir work
+
+test_apply() {
+	test_expect_success "$1" '
+		git checkout . &&
+		git config core.sparsecheckout work &&
+		git apply ../t2303/apply-'$2'.patch &&
+		git config --unset core.sparsecheckout &&
+		git diff > apply.result &&
+		cmp apply.result ../t2303/apply-'$2'.patch
+	'
+}
+
+test_expect_success 'apply on empty tree' '
+		git config core.sparsecheckout work &&
+		! git apply ../t2303/apply-initial.patch &&
+		git config --unset core.sparsecheckout
+'
+
+test_expect_success 'apply successfully without sparse checkout' '
+	git apply ../t2303/apply-initial.patch &&
+	git apply --cached ../t2303/apply-initial.patch
+'
+
+test_expect_success 'apply on modified tree outside' '
+	git checkout . &&
+	git config core.sparsecheckout work &&
+	! git apply ../t2303/apply-outside.patch &&
+	git config --unset core.sparsecheckout
+'
+
+test_apply 'apply on modified tree' inside
+
+test_apply 'apply removing file' remove
+
+test_expect_success 'apply creating leading directories' '
+	git config core.sparsecheckout work &&
+	git apply ../t2303/apply-leading-dirs.patch &&
+	git config --unset core.sparsecheckout &&
+	test -f work/for/me/now
+'
+
+test_expect_success 'apply renaming file' '
+	git checkout . &&
+	touch a &&
+	empty_sha1=3D$(git hash-object -w a) &&
+	rm a &&
+	git update-index --add --cacheinfo 100644 $empty_sha1 work/two &&
+	git config core.sparsecheckout work &&
+	git apply ../t2303/apply-rename.patch &&
+	git config --unset core.sparsecheckout &&
+	git diff > apply.result &&
+	cmp apply.result ../t2303/apply-rename.expected
+'
+
+test_done
diff --git a/t/t2303/apply-initial.patch b/t/t2303/apply-initial.patch
new file mode 100644
index 0000000..72bfd82
--- /dev/null
+++ b/t/t2303/apply-initial.patch
@@ -0,0 +1,14 @@
+diff --git a/one b/one
+new file mode 100644
+index 0000000..5626abf
+--- /dev/null
++++ b/one
+@@ -0,0 +1 @@
++one
+diff --git a/work/one b/work/one
+new file mode 100644
+index 0000000..da327ae
+--- /dev/null
++++ b/work/one
+@@ -0,0 +1 @@
++work/one
diff --git a/t/t2303/apply-inside.patch b/t/t2303/apply-inside.patch
new file mode 100644
index 0000000..4f5c310
--- /dev/null
+++ b/t/t2303/apply-inside.patch
@@ -0,0 +1,7 @@
+diff --git a/work/one b/work/one
+index da327ae..6317017 100644
+--- a/work/one
++++ b/work/one
+@@ -1 +1,2 @@
+ work/one
++more
diff --git a/t/t2303/apply-leading-dirs.patch b/t/t2303/apply-leading-d=
irs.patch
new file mode 100644
index 0000000..b55809f
--- /dev/null
+++ b/t/t2303/apply-leading-dirs.patch
@@ -0,0 +1,3 @@
+diff --git a/work/for/me/now b/work/for/me/now
+new file mode 100644
+index 0000000..e69de29
diff --git a/t/t2303/apply-outside.patch b/t/t2303/apply-outside.patch
new file mode 100644
index 0000000..8a8d625
--- /dev/null
+++ b/t/t2303/apply-outside.patch
@@ -0,0 +1,7 @@
+diff --git a/one b/one
+index 5626abf..9a72323 100644
+--- a/one
++++ b/one
+@@ -1 +1,2 @@
+ one
++more
diff --git a/t/t2303/apply-remove.patch b/t/t2303/apply-remove.patch
new file mode 100644
index 0000000..781c743
--- /dev/null
+++ b/t/t2303/apply-remove.patch
@@ -0,0 +1,7 @@
+diff --git a/work/one b/work/one
+deleted file mode 100644
+index da327ae..0000000
+--- a/work/one
++++ /dev/null
+@@ -1 +0,0 @@
+-work/one
diff --git a/t/t2303/apply-rename.expected b/t/t2303/apply-rename.expec=
ted
new file mode 100644
index 0000000..d19f719
--- /dev/null
+++ b/t/t2303/apply-rename.expected
@@ -0,0 +1,13 @@
+diff --git a/work/one b/work/one
+deleted file mode 100644
+index da327ae..0000000
+--- a/work/one
++++ /dev/null
+@@ -1 +0,0 @@
+-work/one
+diff --git a/work/two b/work/two
+index e69de29..da327ae 100644
+--- a/work/two
++++ b/work/two
+@@ -0,0 +1 @@
++work/one
diff --git a/t/t2303/apply-rename.patch b/t/t2303/apply-rename.patch
new file mode 100644
index 0000000..6f21947
--- /dev/null
+++ b/t/t2303/apply-rename.patch
@@ -0,0 +1,4 @@
+diff --git a/work/one b/work/two
+similarity index 100%
+rename from work/one
+rename to work/two
diff --git a/t/t2304-sparse-worktree-merge-recursive.sh b/t/t2304-spars=
e-worktree-merge-recursive.sh
new file mode 100755
index 0000000..b1708d4
--- /dev/null
+++ b/t/t2304-sparse-worktree-merge-recursive.sh
@@ -0,0 +1,233 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive backend test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup 1' '
+
+	echo hello >a &&
+	o0=3D$(git hash-object a) &&
+	cp a b &&
+	cp a c &&
+	mkdir d &&
+	cp a d/e &&
+
+	test_tick &&
+	git add a b c d/e &&
+	git commit -m initial &&
+	c0=3D$(git rev-parse --verify HEAD) &&
+	git branch noconflict &&
+	git branch conflict &&
+	git branch conflict-inside &&
+
+	echo hello >>a &&
+	cp a d/e &&
+	o1=3D$(git hash-object a) &&
+
+	git add a d/e &&
+
+	test_tick &&
+	git commit -m "master modifies a and d/e" &&
+	c1=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o1	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o1	d/e"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 2' '
+
+	rm -rf [abcd] &&
+	git checkout conflict &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	echo goodbye >>a &&
+	o2=3D$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "conflict modifies a" &&
+	c2=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o2	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o2 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 3' '
+
+	rm -rf [abcd] &&
+	git checkout noconflict &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	echo hello >>a &&
+	o3=3D$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "noconflict modifies a" &&
+	c3=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o3	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o3 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 4' '
+
+	rm -rf [abcd] &&
+	git checkout conflict-inside &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	mkdir d &&
+	echo goodbye >>d/e &&
+	o4=3D$(git hash-object d/e) &&
+
+	git add d/e &&
+
+	test_tick &&
+	git commit -m "conflict-inside modifies d/e" &&
+	c4=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o4	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o4 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+echo "gitdir: $(pwd)/.git" > gitfile
+
+test_expect_success 'merge-recursive conflict inside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c4" &&
+
+	cp gitfile d/.git && cd d/
+	git config core.sparsecheckout d
+	git-merge-recursive "$c0" -- "$c4" "$c1"
+	status=3D$?
+	git config --unset core.sparsecheckout
+	rm .git && cd ..
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive no conflict outside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c3" &&
+
+	cp gitfile d/.git && cd d
+	git config core.sparsecheckout d
+	git-merge-recursive "$c0" -- "$c3" "$c1"
+	status=3D$?
+	git config --unset core.sparsecheckout
+	rm .git && cd ..
+	case "$status" in
+	0)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive conflict outside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c2" &&
+
+	cp gitfile d/.git && cd d
+	git config core.sparsecheckout d
+	git-merge-recursive "$c0" -- "$c2" "$c1"
+	status=3D$?
+	git config --unset core.sparsecheckout
+	rm .git && cd ..
+	case "$status" in
+	128)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_done
--=20
1.5.5.GIT
