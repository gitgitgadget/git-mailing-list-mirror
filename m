From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 2/2] t: git-show: adapt tests to fixed 'git show'
Date: Tue, 13 May 2014 02:11:07 +0300
Message-ID: <20140512231107.GE32316@wheezy.local>
References: <20140512230943.GC32316@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 01:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjzNK-0006m1-9A
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 01:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaELXLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 19:11:10 -0400
Received: from p3plsmtpa08-05.prod.phx3.secureserver.net ([173.201.193.106]:51169
	"EHLO p3plsmtpa08-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770AbaELXLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 19:11:09 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa08-05.prod.phx3.secureserver.net with 
	id 1BB51o00K3gsSd601BB8kB; Mon, 12 May 2014 16:11:09 -0700
Content-Disposition: inline
In-Reply-To: <20140512230943.GC32316@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248742>

'git show' used to print extra newline after merge commit, and it was
recorded so into the test reference data. Now when the behavior is
fixed, the tests should be updated.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t1507-rev-parse-upstream.sh |  2 +-
 t/t7600-merge.sh              | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 2a19e79..672280b 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -100,7 +100,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -D new ;# can fail but is ok
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
-	git show -s --pretty=format:%s >actual &&
+	git show -s --pretty=tformat:%s >actual &&
 	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
 	test_cmp expect actual
 )
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 10aa028..b164621 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -57,11 +57,10 @@ create_merge_msgs () {
 		git log --no-merges ^HEAD c2 c3
 	} >squash.1-5-9 &&
 	: >msg.nologff &&
-	echo >msg.nolognoff &&
+	: >msg.nolognoff &&
 	{
 		echo "* tag 'c3':" &&
-		echo "  commit 3" &&
-		echo
+		echo "  commit 3"
 	} >msg.log
 }
 
@@ -71,7 +70,7 @@ verify_merge () {
 	git diff --exit-code &&
 	if test -n "$3"
 	then
-		git show -s --pretty=format:%s HEAD >msg.act &&
+		git show -s --pretty=tformat:%s HEAD >msg.act &&
 		test_cmp "$3" msg.act
 	fi
 }
@@ -620,10 +619,10 @@ test_expect_success 'merge early part of c2' '
 	git tag c6 &&
 	git branch -f c5-branch c5 &&
 	git merge c5-branch~1 &&
-	git show -s --pretty=format:%s HEAD >actual.branch &&
+	git show -s --pretty=tformat:%s HEAD >actual.branch &&
 	git reset --keep HEAD^ &&
 	git merge c5~1 &&
-	git show -s --pretty=format:%s HEAD >actual.tag &&
+	git show -s --pretty=tformat:%s HEAD >actual.tag &&
 	test_cmp expected.branch actual.branch &&
 	test_cmp expected.tag actual.tag
 '
-- 
1.8.5.2.421.g4cdf8d0
