From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fixup! pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Sun, 14 Jul 2013 16:03:18 +0100
Message-ID: <20130714150318.GB2239@serenity.lan>
References: <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130628080953.GD2232@serenity.lan>
 <7vli5up2tq.fsf@alter.siamese.dyndns.org>
 <20130628174252.GF2232@serenity.lan>
 <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 17:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyNpn-0001rq-S8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 17:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab3GNPDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 11:03:31 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:37473 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab3GNPD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 11:03:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4177B23A2A;
	Sun, 14 Jul 2013 16:03:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Mue2HDmtIuC; Sun, 14 Jul 2013 16:03:28 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 00DD0236A8;
	Sun, 14 Jul 2013 16:03:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230366>

---
On Fri, Jun 28, 2013 at 03:41:34PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > I don't think "git pull remote branch" falls into the same category as
> > plain "git pull" so I'm not convinced that defaulting to merge there is
> > unreasonable.  The original message about this [1] did talk about only
> > "git pull" with no arguments.
> 
> If you want to limit the scope to only "git pull" (without any
> command line argument), I actually do not have strong preference for
> or against it either way.  Perhaps a follow-up patch to be squashed?

Here is that patch.  The test changes here are all reverting changes in
ae2dab2 (pull: require choice between rebase/merge on non-fast-forward
pull, 2013-06-27) - with this change to git-pull.sh the only change
needed in the tests is in t5524-pull-msg:

    $ git diff ae2dab2^ -- t
    diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
    index 8cccecc..660714b 100755
    --- a/t/t5524-pull-msg.sh
    +++ b/t/t5524-pull-msg.sh
    @@ -25,7 +25,7 @@ test_expect_success setup '
     test_expect_success pull '
     (
            cd cloned &&
    -       git pull --log &&
    +       git pull --log --merge &&
            git log -2 &&
            git cat-file commit HEAD >result &&
            grep Dollar result

 git-pull.sh                            | 1 +
 t/annotate-tests.sh                    | 2 +-
 t/t4013-diff-various.sh                | 2 --
 t/t4200-rerere.sh                      | 2 --
 t/t5500-fetch-pack.sh                  | 6 +-----
 t/t5521-pull-options.sh                | 2 --
 t/t5700-clone-reference.sh             | 4 ++--
 t/t6022-merge-rename.sh                | 2 --
 t/t6026-merge-attr.sh                  | 2 +-
 t/t6029-merge-subtree.sh               | 1 -
 t/t6037-merge-ours-theirs.sh           | 2 --
 t/t9114-git-svn-dcommit-merge.sh       | 2 +-
 t/t9400-git-cvsserver-server.sh        | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 2 +-
 14 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 5ce67f9..0ff4a98 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -279,6 +279,7 @@ case "$merge_head" in
 	merge_head=${merge_head% }
 	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
+		test $# = 0 &&
 		! $(git merge-base --is-ancestor "$orig_head" "$merge_head")
 	then
 echo >&2 "orig-head was $orig_head"
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index af02c6d..c56a77d 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -79,7 +79,7 @@ test_expect_success \
 
 test_expect_success \
     'merge-setup part 3' \
-    'git pull --merge . branch1'
+    'git pull . branch1'
 
 test_expect_success \
     'Two lines blamed on A, one on B, two on B1, one on B2' \
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1ee2198..e77c09c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -12,8 +12,6 @@ LF='
 
 test_expect_success setup '
 
-	git config pull.rebase false &&
-
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 0563357..7f6666f 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,8 +25,6 @@ test_description='git rerere
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	git config pull.rebase false &&
-
 	cat >a1 <<-\EOF &&
 	Some title
 	==========
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 4be8877..fd2598e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -143,11 +143,7 @@ test_expect_success 'clone shallow depth 1 with fsck' '
 '
 
 test_expect_success 'clone shallow' '
-	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow &&
-	(
-		cd shallow &&
-		git config pull.rebase false
-	)
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
 
 test_expect_success 'clone shallow depth count' '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index d821fab..453aba5 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -91,8 +91,6 @@ test_expect_success 'git pull --force' '
 	[branch "master"]
 		remote = two
 		merge = refs/heads/master
-	[pull]
-		rebase = false
 	EOF
 	git pull two &&
 	test_commit A &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 306badf..6537911 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -94,7 +94,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd C &&
-git pull --merge origin'
+git pull origin'
 
 cd "$base_dir"
 
@@ -109,7 +109,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd D &&
-git pull --merge origin'
+git pull origin'
 
 cd "$base_dir"
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index e12d90b..c680f78 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -10,8 +10,6 @@ modify () {
 
 test_expect_success setup \
 '
-git config pull.rebase false &&
-
 cat >A <<\EOF &&
 a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5428f19..5e43997 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -172,7 +172,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git pull --merge ../repo2 master
+		git pull ../repo2 master
 	)
 '
 
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3ca29c4..73fc240 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -41,7 +41,6 @@ test_expect_success 'setup' '
 	mkdir git &&
 	cd git &&
 	git init &&
-	git config pull.rebase false &&
 	echo git >git.c &&
 	o2=$(git hash-object git.c) &&
 	git add git.c &&
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 41bf060..3889eca 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -66,8 +66,6 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git config pull.rebase false &&
-
 	git reset --hard master && git pull -s recursive -Xours . side &&
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index dfce024..f524d2f 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup git mirror and merge' '
 	echo friend > README &&
 	cat tmp >> README &&
 	git commit -a -m "friend" &&
-	git pull --merge . merge
+	git pull . merge
 	'
 
 test_debug 'gitk --all & sleep 1'
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 76b8640..0431386 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -46,7 +46,7 @@ test_expect_success 'setup' '
   touch secondrootfile &&
   git add secondrootfile &&
   git commit -m "second root") &&
-  git pull --merge secondroot master &&
+  git pull secondroot master &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 787c6cc..6fca193 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -328,7 +328,7 @@ test_expect_success \
 	 git add b &&
 	 git commit -a -m "On branch" &&
 	 git checkout master &&
-	 git pull --merge . b &&
+	 git pull . b &&
 	 git tag merge_commit'
 
 test_expect_success \
-- 
1.8.3.2.922.gc9d4734
