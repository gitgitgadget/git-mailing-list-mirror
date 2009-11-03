From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t1200: cleanup and modernize test style
Date: Tue,  3 Nov 2009 13:05:28 -0800
Message-ID: <1257282328-6491-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 22:05:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QZR-0006e0-3V
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbZKCVFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbZKCVFa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:05:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:47562 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbZKCVF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:05:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so735749fgg.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=9hq1U7BUgkPe76FxgJWssve9UJt6zryhUBZSzjFm/bk=;
        b=sJgfKDxmBajc12NjCJDmTd9EjZ2C93Lm+AFwyDcFCbYpWyd0JIXyKWOvbGrNQNexL8
         jGsqZ3M53OaOwBP0J6tx4znLpPhg/YTPG2UTWfECj8m4d7C/NkgjnGu0h8BirizwrxRf
         Rw3WgPr+nChXwHMyjGOd+gy7o1aX8RfAAmu3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eruDHPYYZ6Fta1HaoEA6plpZZn6uHUZ3V4r978apuOaYFOEBNk38hK0sDK3h0GAWOh
         2uM/eCc5KwREDtSb1k8TDNVmN7KIKXeVw6FUx6PvkjVFCHMg7pYJxzTCi2b2T0DeK7oO
         BYziy9iwZ8FS6wAfZu9TVWnQokwyVCBjKilqA=
Received: by 10.87.64.6 with SMTP id r6mr3447152fgk.48.1257282333781;
        Tue, 03 Nov 2009 13:05:33 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id l19sm423107fgb.21.2009.11.03.13.05.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:05:32 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Tue, 03 Nov 2009 13:05:28 -0800
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131994>

Many parts of the tests in t1200 are run outside the test harness,
circumventing the usefulness of -v and spewing messages to stdout when
-v isn't used. Fix these problems by modernizing the test a bit.

An extra test_done has existed since commit 6a74642 (git-commit --amend:
two fixes., 2006-04-20) leading to the last 6 tests never being run.
Remove it and teach the resolve merge test about fast-forward merges.

Finally, we remove the TODO notes, because fetch, push, and clone have
their own tests since t1200 was introduced and we're not going to add
them here 4 years later.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I saw some output when running this test and thought it could be modernized a
bit.

 t/t1200-tutorial.sh |  131 +++++++++++++++++++++++++++++----------------------
 1 files changed, 74 insertions(+), 57 deletions(-)

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 67e637b..16c5b6d 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -7,14 +7,18 @@ test_description='A simple turial in the form of a test case'
 
 . ./test-lib.sh
 
-echo "Hello World" > hello
-echo "Silly example" > example
+test_expect_success 'blob'  '
+	echo "Hello World" > hello &&
+	echo "Silly example" > example &&
 
-git update-index --add hello example
+	git update-index --add hello example &&
 
-test_expect_success 'blob' "test blob = \"$(git cat-file -t 557db03)\""
+	test blob = "$(git cat-file -t 557db03)"
+'
 
-test_expect_success 'blob 557db03' "test \"Hello World\" = \"$(git cat-file blob 557db03)\""
+test_expect_success 'blob 557db03' '
+	test "Hello World" = "$(git cat-file blob 557db03)"
+'
 
 echo "It's a new day for git" >>hello
 cat > diff.expect << EOF
@@ -26,25 +30,33 @@ index 557db03..263414f 100644
  Hello World
 +It's a new day for git
 EOF
-git diff-files -p > diff.output
-test_expect_success 'git diff-files -p' 'cmp diff.expect diff.output'
-git diff > diff.output
-test_expect_success 'git diff' 'cmp diff.expect diff.output'
-
-tree=$(git write-tree 2>/dev/null)
 
-test_expect_success 'tree' "test 8988da15d077d4829fc51d8544c097def6644dbb = $tree"
+test_expect_success 'git diff-files -p' '
+	git diff-files -p > diff.output &&
+	cmp diff.expect diff.output
+'
 
-output="$(echo "Initial commit" | git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master)"
+test_expect_success 'git diff' '
+	git diff > diff.output &&
+	cmp diff.expect diff.output
+'
 
-git diff-index -p HEAD > diff.output
-test_expect_success 'git diff-index -p HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'tree' '
+	tree=$(git write-tree 2>/dev/null)
+	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
+'
 
-git diff HEAD > diff.output
-test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git diff-index -p HEAD' '
+	echo "Initial commit" | \
+	git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master &&
+	git diff-index -p HEAD > diff.output &&
+	cmp diff.expect diff.output
+'
 
-#rm hello
-#test_expect_success 'git read-tree --reset HEAD' "git read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git update-index --refresh)\""
+test_expect_success 'git diff HEAD' '
+	git diff HEAD > diff.output &&
+	cmp diff.expect diff.output
+'
 
 cat > whatchanged.expect << EOF
 commit VARIABLE
@@ -69,39 +81,45 @@ index 0000000..557db03
 +Hello World
 EOF
 
-git whatchanged -p --root | \
-	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
+test_expect_success 'git whatchanged -p --root' '
+	git whatchanged -p --root | \
+		sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
 		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
-> whatchanged.output
-test_expect_success 'git whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
-
-git tag my-first-tag
-test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
+	> whatchanged.output &&
+	cmp whatchanged.expect whatchanged.output
+'
 
-# TODO: test git clone
+test_expect_success 'git tag my-first-tag' '
+	git tag my-first-tag &&
+	cmp .git/refs/heads/master .git/refs/tags/my-first-tag
+'
 
-git checkout -b mybranch
-test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
+test_expect_success 'git checkout -b mybranch' '
+	git checkout -b mybranch &&
+	cmp .git/refs/heads/master .git/refs/heads/mybranch
+'
 
 cat > branch.expect <<EOF
   master
 * mybranch
 EOF
 
-git branch > branch.output
-test_expect_success 'git branch' 'cmp branch.expect branch.output'
+test_expect_success 'git branch' '
+	git branch > branch.output &&
+	cmp branch.expect branch.output
+'
 
-git checkout mybranch
-echo "Work, work, work" >>hello
-git commit -m 'Some work.' -i hello
+test_expect_success 'git resolve now fails' '
+	git checkout mybranch &&
+	echo "Work, work, work" >>hello &&
+	git commit -m "Some work." -i hello &&
 
-git checkout master
+	git checkout master &&
 
-echo "Play, play, play" >>hello
-echo "Lots of fun" >>example
-git commit -m 'Some fun.' -i hello example
+	echo "Play, play, play" >>hello &&
+	echo "Lots of fun" >>example &&
+	git commit -m "Some fun." -i hello example &&
 
-test_expect_success 'git resolve now fails' '
 	test_must_fail git merge -m "Merge work in mybranch" mybranch
 '
 
@@ -112,10 +130,6 @@ Play, play, play
 Work, work, work
 EOF
 
-git commit -m 'Merged "mybranch" changes.' -i hello
-
-test_done
-
 cat > show-branch.expect << EOF
 * [master] Merged "mybranch" changes.
  ! [mybranch] Some work.
@@ -124,21 +138,26 @@ cat > show-branch.expect << EOF
 *+ [mybranch] Some work.
 EOF
 
-git show-branch --topo-order master mybranch > show-branch.output
-test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
-
-git checkout mybranch
+test_expect_success 'git show-branch' '
+	git commit -m "Merged \"mybranch\" changes." -i hello &&
+	git show-branch --topo-order master mybranch > show-branch.output &&
+	cmp show-branch.expect show-branch.output
+'
 
 cat > resolve.expect << EOF
-Updating from VARIABLE to VARIABLE
+Updating VARIABLE..VARIABLE
+Fast forward
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
 EOF
 
-git merge -s "Merge upstream changes." master | \
-	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" >resolve.output
-test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
+test_expect_success 'git resolve' '
+	git checkout mybranch &&
+	git merge -s resolve master | \
+		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" >resolve.output &&
+	cmp resolve.expect resolve.output
+'
 
 cat > show-branch2.expect << EOF
 ! [master] Merged "mybranch" changes.
@@ -147,12 +166,10 @@ cat > show-branch2.expect << EOF
 -- [master] Merged "mybranch" changes.
 EOF
 
-git show-branch --topo-order master mybranch > show-branch2.output
-test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
-
-# TODO: test git fetch
-
-# TODO: test git push
+test_expect_success 'git show-branch' '
+	git show-branch --topo-order master mybranch > show-branch2.output &&
+	cmp show-branch2.expect show-branch2.output
+'
 
 test_expect_success 'git repack' 'git repack'
 test_expect_success 'git prune-packed' 'git prune-packed'
-- 
1.6.5.2.181.gd6f41
