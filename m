From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH 3/5] t3200 (branch): modernize style
Date: Wed, 29 Feb 2012 17:45:19 -0800
Message-ID: <1330566326-26075-4-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v60-00046e-FV
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290Ab2CABqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:46:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52025 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499Ab2CABpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:45:53 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so74765vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:45:52 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.21.168 as permitted sender) client-ip=10.52.21.168;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.21.168 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.21.168])
        by 10.52.21.168 with SMTP id w8mr4169649vde.77.1330566352988 (num_hops = 1);
        Wed, 29 Feb 2012 17:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=b9vdilE7vLqCJas0e65Ut2I6qUy1i5DuMqZjjopvthA=;
        b=wV3NQHps40ZGJQton1+D5C+36OkWp1YoTJXMmzE3OOtXmqq5yU9fOOg+2/2Q27VhZ0
         StVXyZ8YL6WNMIOfyA8jj4QkYKVuc15lrx8xPhjwPR7T+36vOZvpJFUG8q8Zij+x35BQ
         tClOJvQ2BY605ZlZBsS2DiGpYrY6FERLIDjf0=
Received: by 10.52.21.168 with SMTP id w8mr3562086vde.77.1330566352930;
        Wed, 29 Feb 2012 17:45:52 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.45.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:45:52 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
References: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191877>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks of < 80 cols
- Redirect unwanted output
- Use a "here" filter for expect generation

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t3200-branch.sh |  593 +++++++++++++++++++++++++++--------------------------
 1 files changed, 304 insertions(+), 289 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd1aceb..93c35cd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -5,125 +5,132 @@
 
 test_description='git branch assorted tests'
 
+if ! test -r test-lib.sh ; then
+	(cd ${0%/*} && ./${0##*/} $@)
+	exit $?
+fi
+
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare a trivial repository' \
-    'echo Hello > A &&
-     git update-index --add A &&
-     git commit -m "Initial commit." &&
-     echo World >> A &&
-     git update-index --add A &&
-     git commit -m "Second commit." &&
-     HEAD=$(git rev-parse --verify HEAD)'
+quiet () { "$@" >/dev/null; }
+silent () { "$@" >/dev/null 2>&1; }
+here () { sed 's/\\s/ /g; s/\\t/\t/g; s/\\n/\n/g' $@; }
+
+test_expect_success 'prepare a trivial repository' '
+	echo Hello >A &&
+	git update-index --add A &&
+	git commit -q -m "Initial commit." &&
+	echo World >>A &&
+	git update-index --add A &&
+	git commit -q -m "Second commit." &&
+	HEAD=$(git rev-parse --verify HEAD)
+'
 
-test_expect_success \
-    'git branch --help should not have created a bogus branch' '
-     test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
-     test_path_is_missing .git/refs/heads/--help
+test_expect_success 'git branch --help should not have created a bogus branch' '
+	silent test_might_fail git branch --help </dev/null &&
+	test_path_is_missing .git/refs/heads/--help
 '
 
 test_expect_success 'branch -h in broken repository' '
-	mkdir broken &&
-	(
-		cd broken &&
-		git init &&
-		>.git/refs/heads/master &&
-		test_expect_code 129 git branch -h >usage 2>&1
-	) &&
-	grep "[Uu]sage" broken/usage
-'
-
-test_expect_success \
-    'git branch abc should create a branch' \
-    'git branch abc && test_path_is_file .git/refs/heads/abc'
-
-test_expect_success \
-    'git branch a/b/c should create a branch' \
-    'git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c'
-
-cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-EOF
-test_expect_success \
-    'git branch -l d/e/f should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git branch -l d/e/f &&
-	 test_path_is_file .git/refs/heads/d/e/f &&
-	 test_path_is_file .git/logs/refs/heads/d/e/f &&
-	 test_cmp expect .git/logs/refs/heads/d/e/f'
-
-test_expect_success \
-    'git branch -d d/e/f should delete a branch and a log' \
-	'git branch -d d/e/f &&
-	 test_path_is_missing .git/refs/heads/d/e/f &&
-	 test_path_is_missing .git/logs/refs/heads/d/e/f'
-
-test_expect_success \
-    'git branch j/k should work after branch j has been deleted' \
-       'git branch j &&
-        git branch -d j &&
-        git branch j/k'
-
-test_expect_success \
-    'git branch l should work after branch l/m has been deleted' \
-       'git branch l/m &&
-        git branch -d l/m &&
-        git branch l'
-
-test_expect_success \
-    'git branch -m dumps usage' \
-       'test_expect_code 129 git branch -m 2>err &&
-	grep "[Uu]sage: git branch" err'
-
-test_expect_success \
-    'git branch -m m m/m should work' \
-       'git branch -l m &&
-        git branch -m m m/m &&
-	test_path_is_file .git/logs/refs/heads/m/m'
-
-test_expect_success \
-    'git branch -m n/n n should work' \
-       'git branch -l n/n &&
+	git init -q broken &&
+	test_when_finished rm -rf broken usage &&
+	>broken/.git/refs/heads/master &&
+	>usage 2>&1 test_expect_code 129 git --git-dir=broken/.git branch -h &&
+	grep -q "[Uu]sage" usage
+'
+
+test_expect_success 'git branch abc should create a branch' '
+	git branch abc && test_path_is_file .git/refs/heads/abc
+'
+
+test_expect_success 'git branch a/b/c should create a branch' '
+	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
+'
+
+test_expect_success 'git branch -l d/e/f should create a branch and a log' '
+	id="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	date="1117150200 +0000"
+	msg="branch: Created from master"
+	here >expect <<-EOF
+		$_z40 $HEAD $id $date\t$msg
+	EOF
+	GIT_COMMITTER_DATE="2005-05-26 23:30" git branch -l d/e/f &&
+	test_path_is_file .git/refs/heads/d/e/f &&
+	test_path_is_file .git/logs/refs/heads/d/e/f &&
+	test_cmp expect .git/logs/refs/heads/d/e/f
+'
+
+test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
+	quiet git branch -d d/e/f &&
+	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_path_is_missing .git/logs/refs/heads/d/e/f
+'
+
+test_expect_success 'git branch j/k should work after branch j has been deleted' '
+	git branch j &&
+	quiet git branch -d j &&
+	git branch j/k
+'
+
+test_expect_success 'git branch l should work after branch l/m has been deleted' '
+	git branch l/m &&
+	quiet git branch -d l/m &&
+	git branch l
+'
+
+test_expect_success 'git branch -m dumps usage' '
+	test_expect_code 129 git branch -m 2>err &&
+	grep -q "[Uu]sage: git branch" err
+'
+
+test_expect_success 'git branch -m m m/m should work' '
+	git branch -l m &&
+	git branch -m m m/m &&
+	test_path_is_file .git/logs/refs/heads/m/m
+'
+
+test_expect_success 'git branch -m n/n n should work' '
+	git branch -l n/n &&
 	git branch -m n/n n &&
-	test_path_is_file .git/logs/refs/heads/n'
+	test_path_is_file .git/logs/refs/heads/n
+'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
-        git branch o/p &&
-	test_must_fail git branch -m o/o o
+	git branch o/p &&
+	silent test_must_fail git branch -m o/o o
 '
 
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-	test_must_fail git branch -m q r/q
+	silent test_must_fail git branch -m q r/q
 '
 
 test_expect_success 'git branch -M foo bar should fail when bar is checked out' '
 	git branch bar &&
-	git checkout -b foo &&
-	test_must_fail git branch -M bar foo
+	git checkout -q -b foo &&
+	silent test_must_fail git branch -M bar foo
 '
 
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
-	git checkout -b baz &&
+	git checkout -q -b baz &&
 	git branch bam &&
 	git branch -M baz bam
 '
 
 test_expect_success 'git branch -M master should work when master is checked out' '
-	git checkout master &&
+	git checkout -q master &&
 	git branch -M master
 '
 
 test_expect_success 'git branch -M master master should work when master is checked out' '
-	git checkout master &&
+	git checkout -q master &&
 	git branch -M master master
 '
 
 test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
-	git checkout master &&
+	git checkout -q master &&
 	git branch master2 &&
 	git branch -M master2 master2
 '
@@ -131,7 +138,7 @@ test_expect_success 'git branch -M master2 master2 should work when master is ch
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	test_path_is_file .git/refs/heads/t &&
-	git branch -v -d t &&
+	quiet git branch -v -d t &&
 	test_path_is_missing .git/refs/heads/t
 '
 
@@ -141,188 +148,198 @@ test_expect_success 'git branch -v -m t s should work' '
 	git branch -v -m t s &&
 	test_path_is_missing .git/refs/heads/t &&
 	test_path_is_file .git/refs/heads/s &&
-	git branch -d s
+	quiet git branch -d s
 '
 
 test_expect_success 'git branch -m -d t s should fail' '
 	git branch t &&
 	test_path_is_file .git/refs/heads/t &&
-	test_must_fail git branch -m -d t s &&
-	git branch -d t &&
+	silent test_must_fail git branch -m -d t s &&
+	quiet git branch -d t &&
 	test_path_is_missing .git/refs/heads/t
 '
 
 test_expect_success 'git branch --list -d t should fail' '
 	git branch t &&
 	test_path_is_file .git/refs/heads/t &&
-	test_must_fail git branch --list -d t &&
-	git branch -d t &&
+	silent test_must_fail git branch --list -d t &&
+	quiet git branch -d t &&
 	test_path_is_missing .git/refs/heads/t
 '
 
-mv .git/config .git/config-saved
-
 test_expect_success 'git branch -m q q2 without config should succeed' '
+	mv .git/config .git/config-saved &&
+	test_when_finished mv .git/config-saved .git/config &&
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
 
-mv .git/config-saved .git/config
-
-git config branch.s/s.dummy Hello
-
-test_expect_success \
-    'git branch -m s/s s should work when s/t is deleted' \
-       'git branch -l s/s &&
+test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
+	git config branch.s/s.dummy Hello
+	git branch -l s/s &&
 	test_path_is_file .git/logs/refs/heads/s/s &&
-        git branch -l s/t &&
+	git branch -l s/t &&
 	test_path_is_file .git/logs/refs/heads/s/t &&
-        git branch -d s/t &&
-        git branch -m s/s s &&
-	test_path_is_file .git/logs/refs/heads/s'
-
-test_expect_success 'config information was renamed, too' \
-	"test $(git config branch.s.dummy) = Hello &&
-	 test_must_fail git config branch.s/s/dummy"
+	quiet git branch -d s/t &&
+	git branch -m s/s s &&
+	test_path_is_file .git/logs/refs/heads/s
+'
 
-test_expect_success 'renaming a symref is not allowed' \
+test_expect_success 'config information was renamed, too' '
+	test $(git config branch.s.dummy) = Hello &&
+	silent test_must_fail git config branch.s/s/dummy
 '
+
+test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
-	test_must_fail git branch -m master2 master3 &&
-	git symbolic-ref refs/heads/master2 &&
+	silent test_must_fail git branch -m master2 master3 &&
+	quiet git symbolic-ref refs/heads/master2 &&
 	test_path_is_file .git/refs/heads/master &&
 	test_path_is_missing .git/refs/heads/master3
 '
 
-test_expect_success SYMLINKS \
-    'git branch -m u v should fail when the reflog for u is a symlink' '
-     git branch -l u &&
-     mv .git/logs/refs/heads/u real-u &&
-     ln -s real-u .git/logs/refs/heads/u &&
-     test_must_fail git branch -m u v
-'
-
-test_expect_success 'test tracking setup via --track' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my1 local/master &&
-     test $(git config branch.my1.remote) = local &&
-     test $(git config branch.my1.merge) = refs/heads/master'
-
-test_expect_success 'test tracking setup (non-wildcard, matching)' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my4 local/master &&
-     test $(git config branch.my4.remote) = local &&
-     test $(git config branch.my4.merge) = refs/heads/master'
-
-test_expect_success 'test tracking setup (non-wildcard, not matching)' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my5 local/master &&
-     ! test "$(git config branch.my5.remote)" = local &&
-     ! test "$(git config branch.my5.merge)" = refs/heads/master'
-
-test_expect_success 'test tracking setup via config' \
-    'git config branch.autosetupmerge true &&
-     git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch my3 local/master &&
-     test $(git config branch.my3.remote) = local &&
-     test $(git config branch.my3.merge) = refs/heads/master'
-
-test_expect_success 'test overriding tracking setup via --no-track' \
-    'git config branch.autosetupmerge true &&
-     git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --no-track my2 local/master &&
-     git config branch.autosetupmerge false &&
-     ! test "$(git config branch.my2.remote)" = local &&
-     ! test "$(git config branch.my2.merge)" = refs/heads/master'
-
-test_expect_success 'no tracking without .fetch entries' \
-    'git config branch.autosetupmerge true &&
-     git branch my6 s &&
-     git config branch.automsetupmerge false &&
-     test -z "$(git config branch.my6.remote)" &&
-     test -z "$(git config branch.my6.merge)"'
-
-test_expect_success 'test tracking setup via --track but deeper' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/o/o || git fetch local) &&
-     git branch --track my7 local/o/o &&
-     test "$(git config branch.my7.remote)" = local &&
-     test "$(git config branch.my7.merge)" = refs/heads/o/o'
-
-test_expect_success 'test deleting branch deletes branch config' \
-    'git branch -d my7 &&
-     test -z "$(git config branch.my7.remote)" &&
-     test -z "$(git config branch.my7.merge)"'
-
-test_expect_success 'test deleting branch without config' \
-    'git branch my7 s &&
-     sha1=$(git rev-parse my7 | cut -c 1-7) &&
-     echo "Deleted branch my7 (was $sha1)." >expect &&
-     git branch -d my7 >actual 2>&1 &&
-     test_i18ncmp expect actual'
-
-test_expect_success 'test --track without .fetch entries' \
-    'git branch --track my8 &&
-     test "$(git config branch.my8.remote)" &&
-     test "$(git config branch.my8.merge)"'
-
-test_expect_success \
-    'branch from non-branch HEAD w/autosetupmerge=always' \
-    'git config branch.autosetupmerge always &&
-     git branch my9 HEAD^ &&
-     git config branch.autosetupmerge false'
-
-test_expect_success \
-    'branch from non-branch HEAD w/--track causes failure' \
-    'test_must_fail git branch --track my10 HEAD^'
-
-test_expect_success \
-    'branch from tag w/--track causes failure' \
-    'git tag foobar &&
-     test_must_fail git branch --track my11 foobar'
+test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
+	git branch -l u &&
+	mv .git/logs/refs/heads/u real-u &&
+	ln -s real-u .git/logs/refs/heads/u &&
+	silent test_must_fail git branch -m u v
+'
+
+test_expect_success 'test tracking setup via --track' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track my1 local/master &&
+	test $(git config branch.my1.remote) = local &&
+	test $(git config branch.my1.merge) = refs/heads/master
+'
+
+test_expect_success 'test tracking setup (non-wildcard, matching)' '
+	git config remote.local.url . &&
+	git config remote.local.fetch \
+		refs/heads/master:refs/remotes/local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	quiet git branch --track my4 local/master &&
+	test $(git config branch.my4.remote) = local &&
+	test $(git config branch.my4.merge) = refs/heads/master
+'
+
+test_expect_success 'test tracking setup (non-wildcard, not matching)' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	quiet git branch --track my5 local/master &&
+	! test "$(git config branch.my5.remote)" = local &&
+	! test "$(git config branch.my5.merge)" = refs/heads/master
+'
+
+test_expect_success 'test tracking setup via config' '
+	git config branch.autosetupmerge true &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	quiet git branch my3 local/master &&
+	test $(git config branch.my3.remote) = local &&
+	test $(git config branch.my3.merge) = refs/heads/master
+'
+
+test_expect_success 'test overriding tracking setup via --no-track' '
+	git config branch.autosetupmerge true &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --no-track my2 local/master &&
+	git config branch.autosetupmerge false &&
+	! test "$(git config branch.my2.remote)" = local &&
+	! test "$(git config branch.my2.merge)" = refs/heads/master
+'
+
+test_expect_success 'no tracking without .fetch entries' '
+	git config branch.autosetupmerge true &&
+	git branch my6 s &&
+	git config branch.automsetupmerge false &&
+	test -z "$(git config branch.my6.remote)" &&
+	test -z "$(git config branch.my6.merge)"
+'
+
+test_expect_success 'test tracking setup via --track but deeper' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/o/o || git fetch local) &&
+	quiet git branch --track my7 local/o/o &&
+	test "$(git config branch.my7.remote)" = local &&
+	test "$(git config branch.my7.merge)" = refs/heads/o/o
+'
+
+test_expect_success 'test deleting branch deletes branch config' '
+	quiet git branch -d my7 &&
+	test -z "$(git config branch.my7.remote)" &&
+	test -z "$(git config branch.my7.merge)"
+'
+
+test_expect_success 'test deleting branch without config' '
+	git branch my7 s &&
+	sha1=$(git rev-parse my7 | cut -c 1-7) &&
+	echo "Deleted branch my7 (was $sha1)." >expect &&
+	git branch -d my7 >actual 2>&1 &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'test --track without .fetch entries' '
+	quiet git branch --track my8 &&
+	test "$(git config branch.my8.remote)" &&
+	test "$(git config branch.my8.merge)"
+'
+
+test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
+	git config branch.autosetupmerge always &&
+	git branch my9 HEAD^ &&
+	git config branch.autosetupmerge false
+'
+
+test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
+	silent test_must_fail git branch --track my10 HEAD^
+'
+
+test_expect_success 'branch from tag w/--track causes failure' '
+	git tag foobar &&
+	silent test_must_fail git branch --track my11 foobar
+'
 
 # Keep this test last, as it changes the current branch
-cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-EOF
-test_expect_success \
-    'git checkout -b g/h/i -l should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git checkout -b g/h/i -l master &&
-	 test_path_is_file .git/refs/heads/g/h/i &&
-	 test_path_is_file .git/logs/refs/heads/g/h/i &&
-	 test_cmp expect .git/logs/refs/heads/g/h/i'
+test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
+	id="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	date="1117150200 +0000"
+	msg="branch: Created from master"
+	here >expect <<-EOF
+		$_z40 $HEAD $id $date\t$msg
+	EOF
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+		git checkout -q -b g/h/i -l master &&
+	test_path_is_file .git/refs/heads/g/h/i &&
+	test_path_is_file .git/logs/refs/heads/g/h/i &&
+	test_cmp expect .git/logs/refs/heads/g/h/i
+'
 
 test_expect_success 'checkout -b makes reflog by default' '
-	git checkout master &&
+	git checkout -q master &&
 	git config --unset core.logAllRefUpdates &&
-	git checkout -b alpha &&
-	git rev-parse --verify alpha@{0}
+	git checkout -q -b alpha &&
+	quiet git rev-parse --verify alpha@{0}
 '
 
 test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout -q master &&
 	git config core.logAllRefUpdates false &&
-	git checkout -b beta &&
-	test_must_fail git rev-parse --verify beta@{0}
+	git checkout -q -b beta &&
+	silent test_must_fail git rev-parse --verify beta@{0}
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
-	git checkout -lb gamma &&
+	git checkout -q master &&
+	git checkout -q -lb gamma &&
 	git config --unset core.logAllRefUpdates &&
-	git rev-parse --verify gamma@{0}
+	quiet git rev-parse --verify gamma@{0}
 '
 
 test_expect_success 'avoid ambiguous track' '
@@ -331,7 +348,7 @@ test_expect_success 'avoid ambiguous track' '
 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
 	git config remote.ambi2.url lilili &&
 	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
-	git branch all1 master &&
+	silent git branch all1 master &&
 	test -z "$(git config branch.all1.merge)"
 '
 
@@ -339,9 +356,9 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch -q local) &&
 	git branch mybase &&
-	git branch --track myr1 mybase &&
+	quiet git branch --track myr1 mybase &&
 	test "$(git config branch.myr1.remote)" = . &&
 	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
 	test "$(git config branch.myr1.rebase)" = true
@@ -351,9 +368,9 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase always &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch -q local) &&
 	git branch mybase2 &&
-	git branch --track myr2 mybase &&
+	quiet git branch --track myr2 mybase &&
 	test "$(git config branch.myr2.remote)" = . &&
 	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
 	test "$(git config branch.myr2.rebase)" = true
@@ -363,9 +380,9 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch -q local) &&
 	git branch mybase3 &&
-	git branch --track myr3 mybase2 &&
+	quiet git branch --track myr3 mybase2 &&
 	test "$(git config branch.myr3.remote)" = . &&
 	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
 	! test "$(git config branch.myr3.rebase)" = true
@@ -375,9 +392,9 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch -q local) &&
 	git branch mybase4 &&
-	git branch --track myr4 mybase2 &&
+	quiet git branch --track myr4 mybase2 &&
 	test "$(git config branch.myr4.remote)" = . &&
 	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
 	! test "$(git config branch.myr4.rebase)" = true
@@ -387,8 +404,8 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr5 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
 	test "$(git config branch.myr5.merge)" = refs/heads/master &&
 	! test "$(git config branch.myr5.rebase)" = true
@@ -398,8 +415,8 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr6 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
 	test "$(git config branch.myr6.merge)" = refs/heads/master &&
 	! test "$(git config branch.myr6.rebase)" = true
@@ -409,8 +426,8 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr7 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
 	test "$(git config branch.myr7.merge)" = refs/heads/master &&
 	test "$(git config branch.myr7.rebase)" = true
@@ -420,8 +437,8 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr8 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
 	test "$(git config branch.myr8.merge)" = refs/heads/master &&
 	test "$(git config branch.myr8.rebase)" = true
@@ -431,8 +448,8 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git config --unset branch.autosetuprebase &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr9 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --track myr9 local/master &&
 	test "$(git config branch.myr9.remote)" = local &&
 	test "$(git config branch.myr9.merge)" = refs/heads/master &&
 	test "z$(git config branch.myr9.rebase)" = z
@@ -441,9 +458,9 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch -q local) &&
 	git branch mybase10 &&
-	git branch --track myr10 mybase2 &&
+	quiet git branch --track myr10 mybase2 &&
 	test "$(git config branch.myr10.remote)" = . &&
 	test "$(git config branch.myr10.merge)" = refs/heads/mybase2 &&
 	test "z$(git config branch.myr10.rebase)" = z
@@ -452,8 +469,8 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr11 mybase2 &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
 	test "z$(git config branch.myr11.rebase)" = z
@@ -462,8 +479,8 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr12 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr12 local/master &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
 	test "z$(git config branch.myr12.rebase)" = z
@@ -473,8 +490,8 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr13 mybase2 &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
 	test "z$(git config branch.myr13.rebase)" = z
@@ -484,8 +501,8 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr14 mybase2 &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
 	test "z$(git config branch.myr14.rebase)" = z
@@ -495,8 +512,8 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr15 mybase2 &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
 	test "z$(git config branch.myr15.rebase)" = z
@@ -506,8 +523,8 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr16 mybase2 &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
 	test "z$(git config branch.myr16.rebase)" = z
@@ -517,8 +534,8 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr17 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr17 local/master &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
 	test "z$(git config branch.myr17.rebase)" = z
@@ -528,8 +545,8 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr18 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr18 local/master &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
 	test "z$(git config branch.myr18.rebase)" = z
@@ -539,8 +556,8 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr19 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr19 local/master &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
 	test "z$(git config branch.myr19.rebase)" = z
@@ -550,8 +567,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr20 local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch -q local) &&
+	quiet git branch --no-track myr20 local/master &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
 	test "z$(git config branch.myr20.rebase)" = z
@@ -559,8 +576,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
 	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
-	git checkout HEAD^0 &&
+	test_when_finished git checkout -q master &&
+	git checkout -q HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
 	test -z "$(git config branch.my11.merge)"
@@ -568,20 +585,20 @@ test_expect_success 'autosetuprebase always on detached HEAD' '
 
 test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
 	git config branch.autosetuprebase garbage &&
-	test_must_fail git branch
+	silent test_must_fail git branch
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 	git config --unset branch.autosetuprebase &&
 	echo "[branch] autosetuprebase" >> .git/config &&
-	test_must_fail git branch &&
+	silent test_must_fail git branch &&
 	git config --unset branch.autosetuprebase
 '
 
 test_expect_success 'attempt to delete a branch without base and unmerged to HEAD' '
-	git checkout my9 &&
+	git checkout -q my9 &&
 	git config --unset branch.my8.merge &&
-	test_must_fail git branch -d my8
+	silent test_must_fail git branch -d my8
 '
 
 test_expect_success 'attempt to delete a branch merged to its base' '
@@ -589,32 +606,30 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	# we would not have allowed deleting my8 that is not merged
 	# to my9, but it is set to track master that already has my8
 	git config branch.my8.merge refs/heads/master &&
-	git branch -d my8
+	silent git branch -d my8
 '
 
 test_expect_success 'attempt to delete a branch merged to its base' '
-	git checkout master &&
+	git checkout -q master &&
 	echo Third >>A &&
-	git commit -m "Third commit" A &&
-	git branch -t my10 my9 &&
-	git branch -f my10 HEAD^ &&
+	git commit -q -m "Third commit" A &&
+	quiet git branch -t my10 my9 &&
+	quiet git branch -f my10 HEAD^ &&
 	# we are on master which is at the third commit, and my10
 	# is behind us, so traditionally we would have allowed deleting
 	# it; but my10 is set to track my9 that is further behind.
-	test_must_fail git branch -d my10
+	silent test_must_fail git branch -d my10
 '
 
 test_expect_success 'use set-upstream on the current branch' '
-	git checkout master &&
-	git --bare init myupstream.git &&
-	git push myupstream.git master:refs/heads/frotz &&
+	git checkout -q master &&
+	git --bare init -q myupstream.git &&
+	git push -q myupstream.git master:refs/heads/frotz &&
 	git remote add origin myupstream.git &&
-	git fetch &&
-	git branch --set-upstream master origin/frotz &&
-
+	git fetch -q &&
+	quiet git branch --set-upstream master origin/frotz &&
 	test "z$(git config branch.master.remote)" = "zorigin" &&
 	test "z$(git config branch.master.merge)" = "zrefs/heads/frotz"
-
 '
 
 test_expect_success 'use --edit-description' '
@@ -637,7 +652,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 	(
 		EDITOR=./editor &&
 		export EDITOR &&
-		test_must_fail git branch --edit-description no-such-branch
+		silent test_must_fail git branch --edit-description no-such-branch
 	)
 '
 
@@ -645,11 +660,11 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-	git checkout --orphan unborn &&
+	git checkout -q --orphan unborn &&
 	(
 		EDITOR=./editor &&
 		export EDITOR &&
-		test_must_fail git branch --edit-description
+		silent test_must_fail git branch --edit-description
 	)
 '
 
-- 
1.7.8
