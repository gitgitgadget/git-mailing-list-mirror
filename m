From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/6] cache_tree_find(): remove redundant checks
Date: Wed,  5 Mar 2014 18:26:25 +0100
Message-ID: <1394040390-7954-2-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFah-0007LK-H7
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaCER0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:26:42 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52274 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751879AbaCER0l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:26:41 -0500
X-AuditID: 1207440d-f79d86d0000043db-83-53175e50746c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.FE.17371.05E57135; Wed,  5 Mar 2014 12:26:40 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7A022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:39 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqBsQJx5ssPeOqMXsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfG5ZYDLAXb
	2Sq271vL3MDYwNrFyMkhIWAi0XjtN5QtJnHh3nq2LkYuDiGBy4wSi3uesIMkhASOMkn0vswC
	sdkEdCUW9TQzgdgiAmoSE9sOsYDYzAJpEg+2XAGzhQWcJL7t3QzWyyKgKrF4QxPYAl4BZ4lL
	ex+wQSyTk5jyewFYDaeAi0Tj0g6gmRxAu5wlFu1nnsDIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrpFebmaJXmpK6SZGSOjw7mD8v07mEKMAB6MSDy9HoHiwEGtiWXFl7iFGSQ4mJVHe
	q9FAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8AZFAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0
	xJLU7NTUgtQimKwMB4eSBO+0WKBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBc
	xBcDIwMkxQO0txOknbe4IDEXKArReopRUUqcVxEkIQCSyCjNgxsLSwivGMWBvhTmnQlSxQNM
	JnDdr4AGMwENjuYDG1ySiJCSamCcn5+cU3z6t41V5sa7R83nbNs/48kLiWX2W1eH/dEMmOgm
	da/4GMcF8TutKTfbeD5PF/jbWLn8CWPGpsUd3ufrVqarGEjav8iYp8+i2fH18u79R5g3z3e4
	bu7wgSF3yZ9Cli0rRDiWvz+wcQ7D75wjjakSgbfYNRWOquazZSxgX3XyY+zBygmM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243446>

slash is initialized to a value that cannot be NULL.  So remove the
guards against slash == NULL later in the loop.

Suggested-by: David Kastrup <dak@gnu.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..4d439bd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -564,10 +564,9 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		if (!sub)
 			return NULL;
 		it = sub->cache_tree;
-		if (slash)
-			while (*slash && *slash == '/')
-				slash++;
-		if (!slash || !*slash)
+		while (*slash && *slash == '/')
+			slash++;
+		if (!*slash)
 			return it; /* prefix ended with slashes */
 		path = slash;
 	}
-- 
1.9.0
