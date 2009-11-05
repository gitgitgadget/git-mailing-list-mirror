From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] t1200: Make documentation and test agree
Date: Wed,  4 Nov 2009 22:33:53 -0800
Message-ID: <1257402833-4741-2-git-send-email-bebarino@gmail.com>
References: <1257282328-6491-1-git-send-email-bebarino@gmail.com>
 <1257402833-4741-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 07:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5vvA-0007tH-L9
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 07:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZKEGd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 01:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZKEGd6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 01:33:58 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:58956 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZKEGd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 01:33:57 -0500
Received: by gxk26 with SMTP id 26so5665329gxk.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 22:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=RH73XSi6yek2UbFNRKULoeklo9pnRBbiwI+lnyJWkCU=;
        b=OiCqR44q9sLbCSv+fVC60Azr3M96tlbO3/68Ww5RGKbX3ceYeVq1CjYftDv35ZM3Vn
         5saU0OvTVovdRE7qC1CtrfMf0J1UF1toGiLys6w977iF+feIiZK4t127whIv/UX53BIE
         mmiI0d9jK9MY3IDOdS5pO1T9KlI+Sw/SbjLFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FY4YaXgd8Emw4f4hiqbD1ve0WgE8v0ngE49HUW2jj3IcySuibo2/oz3tZ5XbRXAFnV
         2l1EPeijjFfQRFXVj/Y2DHrfCKCTnr+CS0hAdhZr4hwKar3ubxP7h191K3YdvEfj1CNz
         T0LKu1xt7NmJ4BOZAQBnEcYrTYh/gGEc/3ZYI=
Received: by 10.150.125.24 with SMTP id x24mr2269626ybc.5.1257402842105;
        Wed, 04 Nov 2009 22:34:02 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 16sm867907gxk.7.2009.11.04.22.33.59
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 22:34:01 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Wed, 04 Nov 2009 22:33:57 -0800
X-Mailer: git-send-email 1.6.5.2.143.g8cc62
In-Reply-To: <1257402833-4741-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132202>

There were some differences between t1200 and the gitcore-tutorial. Add
missing tests for manually merging two branches, and use the same
commands in both files.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 This is all new since v1

 Documentation/gitcore-tutorial.txt |   20 ++++----
 t/t1200-tutorial.sh                |   97 ++++++++++++++++++++++++++++++++---
 2 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index b3640c4..7bdf090 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -185,7 +185,7 @@ object is. git will tell you that you have a "blob" object (i.e., just a
 regular file), and you can see the contents with
 
 ----------------
-$ git cat-file "blob" 557db03
+$ git cat-file blob 557db03
 ----------------
 
 which will print out "Hello World". The object `557db03` is nothing
@@ -1188,7 +1188,7 @@ $ git show-branch
 --
  + [mybranch] Some work.
 *  [master] Some fun.
-*+ [mybranch^] New day.
+*+ [mybranch^] Initial commit
 ------------
 
 Now we are ready to experiment with the merge by hand.
@@ -1204,11 +1204,11 @@ $ mb=$(git merge-base HEAD mybranch)
 The command writes the commit object name of the common ancestor
 to the standard output, so we captured its output to a variable,
 because we will be using it in the next step.  By the way, the common
-ancestor commit is the "New day." commit in this case.  You can
+ancestor commit is the "Initial commit" commit in this case.  You can
 tell it by:
 
 ------------
-$ git name-rev $mb
+$ git name-rev --name-only --tags $mb
 my-first-tag
 ------------
 
@@ -1237,8 +1237,8 @@ inspect the index file with this command:
 ------------
 $ git ls-files --stage
 100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
+100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
+100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
 100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
 ------------
 
@@ -1253,8 +1253,8 @@ To look at only non-zero stages, use `\--unmerged` flag:
 
 ------------
 $ git ls-files --unmerged
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
+100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
+100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
 100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
 ------------
 
@@ -1283,8 +1283,8 @@ the working tree..  This can be seen if you run `ls-files
 ------------
 $ git ls-files --stage
 100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
+100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
+100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
 100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
 ------------
 
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index c57c9d5..299e724 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -47,8 +47,9 @@ test_expect_success 'tree' '
 '
 
 test_expect_success 'git diff-index -p HEAD' '
-	echo "Initial commit" | \
-	git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master &&
+	tree=$(git write-tree)
+	commit=$(echo "Initial commit" | git commit-tree $tree) &&
+	git update-ref HEAD $commit &&
 	git diff-index -p HEAD > diff.output &&
 	cmp diff.expect diff.output
 '
@@ -131,16 +132,18 @@ Work, work, work
 EOF
 
 cat > show-branch.expect << EOF
-* [master] Merged "mybranch" changes.
+* [master] Merge work in mybranch
  ! [mybranch] Some work.
 --
--  [master] Merged "mybranch" changes.
+-  [master] Merge work in mybranch
 *+ [mybranch] Some work.
+*  [master^] Some fun.
 EOF
 
 test_expect_success 'git show-branch' '
-	git commit -m "Merged \"mybranch\" changes." -i hello &&
-	git show-branch --topo-order master mybranch > show-branch.output &&
+	git commit -m "Merge work in mybranch" -i hello &&
+	git show-branch --topo-order --more=1 master mybranch \
+		> show-branch.output &&
 	cmp show-branch.expect show-branch.output
 '
 
@@ -160,10 +163,10 @@ test_expect_success 'git resolve' '
 '
 
 cat > show-branch2.expect << EOF
-! [master] Merged "mybranch" changes.
- * [mybranch] Merged "mybranch" changes.
+! [master] Merge work in mybranch
+ * [mybranch] Merge work in mybranch
 --
--- [master] Merged "mybranch" changes.
+-- [master] Merge work in mybranch
 EOF
 
 test_expect_success 'git show-branch (part 2)' '
@@ -171,6 +174,82 @@ test_expect_success 'git show-branch (part 2)' '
 	cmp show-branch2.expect show-branch2.output
 '
 
+cat > show-branch3.expect << EOF
+! [master] Merge work in mybranch
+ * [mybranch] Merge work in mybranch
+--
+-- [master] Merge work in mybranch
++* [master^2] Some work.
++* [master^] Some fun.
+EOF
+
+test_expect_success 'git show-branch (part 3)' '
+	git show-branch --topo-order --more=2 master mybranch \
+		> show-branch3.output &&
+	cmp show-branch3.expect show-branch3.output
+'
+
+test_expect_success 'rewind to "Some fun." and "Some work."' '
+	git checkout mybranch &&
+	git reset --hard master^2 &&
+	git checkout master &&
+	git reset --hard master^
+'
+
+cat > show-branch4.expect << EOF
+* [master] Some fun.
+ ! [mybranch] Some work.
+--
+ + [mybranch] Some work.
+*  [master] Some fun.
+*+ [mybranch^] Initial commit
+EOF
+
+test_expect_success 'git show-branch (part 4)' '
+	git show-branch --topo-order > show-branch4.output &&
+	cmp show-branch4.expect show-branch4.output
+'
+
+test_expect_success 'manual merge' '
+	mb=$(git merge-base HEAD mybranch) &&
+	git name-rev --name-only --tags $mb > name-rev.output &&
+	test "my-first-tag" = $(cat name-rev.output) &&
+
+	git read-tree -m -u $mb HEAD mybranch
+'
+
+cat > ls-files.expect << EOF
+100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
+100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
+100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
+100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
+EOF
+
+test_expect_success 'git ls-files --stage' '
+	git ls-files --stage > ls-files.output &&
+	cmp ls-files.expect ls-files.output
+'
+
+cat > ls-files-unmerged.expect << EOF
+100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
+100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
+100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
+EOF
+
+test_expect_success 'git ls-files --unmerged' '
+	git ls-files --unmerged > ls-files-unmerged.output &&
+	cmp ls-files-unmerged.expect ls-files-unmerged.output
+'
+
+test_expect_success 'git-merge-index' '
+	test_must_fail git merge-index git-merge-one-file hello
+'
+
+test_expect_success 'git ls-files --stage (part 2)' '
+	git ls-files --stage > ls-files.output2 &&
+	cmp ls-files.expect ls-files.output2
+'
+
 test_expect_success 'git repack' 'git repack'
 test_expect_success 'git prune-packed' 'git prune-packed'
 test_expect_success '-> only packed objects' '
-- 
1.6.5.2.143.g8cc62
