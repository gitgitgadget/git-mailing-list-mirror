From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix a comparison bug in diff-delta.c
Date: Wed, 23 Aug 2006 11:17:55 +0200
Message-ID: <1156324675415-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 11:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFos6-0003xm-7z
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWHWJR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWHWJR7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:17:59 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:47266 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S1751469AbWHWJR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 05:17:58 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 102AAD8125;
	Wed, 23 Aug 2006 11:17:56 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id E4CC13FE07; Wed, 23 Aug 2006 11:17:55 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25904>

  (1 << i) < hspace is compared in the `int` space rather that in the
  unsigned one.  the result will be wrong if hspace is between 0x40000000
  and 0x80000000.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This is a replacement for <1156300368160-git-send-email-madcoder@debian.org>
  avoiding the ugly cast, and using 1u instead.

 diff-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7da9205..51e2e56 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -152,7 +152,7 @@ struct delta_index * create_delta_index(
 	   initialization in create_delta(). */
 	entries = (bufsize - 1)  / RABIN_WINDOW;
 	hsize = entries / 4;
-	for (i = 4; (1 << i) < hsize && i < 31; i++);
+	for (i = 4; (1u << i) < hsize && i < 31; i++);
 	hsize = 1 << i;
 	hmask = hsize - 1;
 
-- 
1.4.1.1
