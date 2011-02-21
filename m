From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] rev-list: documentation and test for --left/right-only
Date: Mon, 21 Feb 2011 17:09:12 +0100
Message-ID: <c0fce67ba8ab8e4ead233950d74048a95d3b64a6.1298304396.git.git@drmicha.warpmail.net>
References: <4D625972.4090500@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 17:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrYNG-0003rd-EA
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 17:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab1BUQMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 11:12:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32787 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752237Ab1BUQM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 11:12:29 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 231C820416;
	Mon, 21 Feb 2011 11:12:29 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Feb 2011 11:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=5FuKifYj1DiLYsY4EcBpCyyqfpI=; b=dG98EysGOjOxIyHX9e49SZd+3wpPZ6b4BhQ4zXyGZYDeXlzHdNhXvcwmHBWw6PE9RHMCrOQWYPOrYSovmvXCocGTHEQnZ1fXbJTOJIAASTykXeSSl0Pp8lLrxzzHbdypCoZhLqODNcXxsiWDSSOE96ea6gHOSBu3C/zWB95SZ6o=
X-Sasl-enc: uZZrd5CscrGM5OovZJrJ+G+FME+U0y3uRjUSqyFTMAOt 1298304748
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72E5644A3F9;
	Mon, 21 Feb 2011 11:12:28 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D625972.4090500@drmicha.warpmail.net>
In-Reply-To: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net>
References: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167491>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    v2 adjusts to the new naming and tests both left and right.

 Documentation/git-rev-list.txt       |    2 ++
 Documentation/rev-list-options.txt   |   13 +++++++++++++
 t/t6007-rev-list-cherry-pick-file.sh |   32 ++++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 8e1e329..5f47a13 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -31,6 +31,8 @@ SYNOPSIS
 	     [ \--parents ]
 	     [ \--timestamp ]
 	     [ \--left-right ]
+	     [ \--left-only ]
+	     [ \--right-only ]
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 44a2ef1..1e67d95 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -319,6 +319,19 @@ from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
 
+--left-only::
+--right-only::
+
+	List only commits on the respective side of a symmetric range,
+	i.e. only those which would be marked `<` resp. `>` by
+	`--left-right`.
++
+For example, `--cherry-pick --right-only A...B` omits those
+commits from `B` which are in `A` or are patch-equivalent to a commit in
+`A`. In other words, this lists the `{plus}` commits from `git cherry A B`.
+More precisely, `--cherry-pick --right-only --ignore-merges` gives the
+exact list. 
+
 -g::
 --walk-reflogs::
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 64b72a3..cd089a9 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -4,14 +4,14 @@ test_description='test git rev-list --cherry-pick -- file'
 
 . ./test-lib.sh
 
-# A---B---D
+# A---B---D---F
 #  \
 #   \
 #    C---E
 #
 # B changes a file foo.c, adding a line of text.  C changes foo.c as
 # well as bar.c, but the change in foo.c was identical to change B.
-# D and C change bar in the same way, E differently.
+# D and C change bar in the same way, E and F differently.
 
 test_expect_success setup '
 	echo Hallo > foo &&
@@ -40,7 +40,12 @@ test_expect_success setup '
 	git add bar &&
 	test_tick &&
 	git commit -m "D" &&
-	git tag D
+	git tag D &&
+	echo Nello > bar &&
+	git add bar &&
+	test_tick &&
+	git commit -m "F" &&
+	git tag F
 '
 
 cat >expect <<EOF
@@ -83,11 +88,30 @@ test_expect_success 'bar does not come up empty' '
 '
 
 cat >expect <<EOF
+<tags/F
 >tags/E
 EOF
 
 test_expect_success '--cherry-pick bar does not come up empty (II)' '
-	git rev-list --left-right --cherry-pick D...E -- bar > actual &&
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+tags/E
+EOF
+
+test_expect_success '--cherry-pick --right-only' '
+	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+test_expect_success '--cherry-pick --left-only' '
+	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp actual.named expect
-- 
1.7.4.1.74.gf39475.dirty
