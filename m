From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] t6030: add a bit more tests to git-bisect
Date: Thu, 05 Apr 2007 23:30:50 -0700
Message-ID: <7v648ako9x.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzm5pw7ju.fsf@assigned-by-dhcp.cox.net>
	<20070404071202.483030b8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZhye-0007Uu-IF
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 08:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbXDFGbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 02:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDFGbG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 02:31:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41491 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbXDFGav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 02:30:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406063051.FORT28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 02:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jiWq1W00D1kojtg0000000; Fri, 06 Apr 2007 02:30:51 -0400
In-Reply-To: <20070404071202.483030b8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 4 Apr 2007 07:12:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43903>

Verify that git-bisect does not start before getting one bad and
one good commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t6030-bisect-run.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-run.sh
index 455dc60..1c38f08 100755
--- a/t/t6030-bisect-run.sh
+++ b/t/t6030-bisect-run.sh
@@ -37,6 +37,42 @@ test_expect_success \
      HASH3=$(git rev-list HEAD | head -2 | tail -1) &&
      HASH4=$(git rev-list HEAD | head -1)'
 
+test_expect_success 'bisect does not start with only one bad' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect bad $HASH4 || return 1
+
+	if git bisect next
+	then
+		echo Oops, should have failed.
+		false
+	else
+		:
+	fi
+'
+
+test_expect_success 'bisect does not start with only one good' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 || return 1
+
+	if git bisect next
+	then
+		echo Oops, should have failed.
+		false
+	else
+		:
+	fi
+'
+
+test_expect_success 'bisect start with one bad and good' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect next
+'
+
 # We want to automatically find the commit that
 # introduced "Another" into hello.
 test_expect_success \
-- 
1.5.1.53.g77e6f
