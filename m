From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Sun, 18 May 2008 16:57:27 +0200
Message-ID: <20080518145727.GA3058@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 16:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxkLZ-0006CU-Fx
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 16:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYERO5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYERO5b
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 10:57:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:65149 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYERO5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 10:57:31 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyXUdQ==
Received: from tigra.home (Fac65.f.strato-dslnet.de [195.4.172.101])
	by post.webmailer.de (mrclete mo33) (RZmta 16.34)
	with ESMTP id c00d1dk4IC4l22 ; Sun, 18 May 2008 16:57:28 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1B321277BD;
	Sun, 18 May 2008 16:57:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0964856D28; Sun, 18 May 2008 16:57:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82386>

The point of the test is not really to test the ability of the
filesystem to keep the given x-bit, but to check is merge-recursive
correctly handles it.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t6031-merge-recursive.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index c8310ae..f1c91c8 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -12,8 +12,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
 	git add dummy &&
 	git commit -m a &&
 	git checkout -b b1 master &&
-	chmod +x file1 &&
-	git add file1 &&
+	git update-index --chmod=+x file1 &&
 	git commit -m b1 &&
 	git checkout a1 &&
 	git merge-recursive master -- a1 b1 &&
@@ -25,8 +24,7 @@ test_expect_success 'mode change in both branches: expect conflict' '
 	git checkout -b a2 master &&
 	: >file2 &&
 	H=$(git hash-object file2) &&
-	chmod +x file2 &&
-	git add file2 &&
+	git update-index --add --chmod=+x file2 &&
 	git commit -m a2 &&
 	git checkout -b b2 master &&
 	: >file2 &&
-- 
1.5.5.1.354.g902c
