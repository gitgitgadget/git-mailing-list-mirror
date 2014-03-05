From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/6] cache_tree_find(): use path variable when passing over slashes
Date: Wed,  5 Mar 2014 18:26:30 +0100
Message-ID: <1394040390-7954-7-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFaq-0007UZ-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbaCER0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:26:50 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54521 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511AbaCER0s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:26:48 -0500
X-AuditID: 12074413-f79076d000002d17-49-53175e587482
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A0.30.11543.85E57135; Wed,  5 Mar 2014 12:26:48 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7F022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:46 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBsRJx5ssGgel8XsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAndGZ/8+poJX
	rBWr9t1mbGA8xNLFyMkhIWAi0XRqOzOELSZx4d56ti5GLg4hgcuMEpN/b2aEcI4ySbT+38MO
	UsUmoCuxqKeZCcQWEVCTmNgGMYlZIE3iwZYrYLawQJjEje5XbCA2i4CqxNTDT1lBbF4BZ4mV
	cz6xQ2yTk5jyewGYzSngItG4tANoJgfQMmeJRfuZJzDyLmBkWMUol5hTmqubm5iZU5yarFuc
	nJiXl1qka66Xm1mil5pSuokREjzCOxh3nZQ7xCjAwajEw8sZKB4sxJpYVlyZe4hRkoNJSZT3
	ajRQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvQCRQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9
	sSQ1OzW1ILUIJivDwaEkwbsqBqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ
	8cXA2ABJ8QDtFYkF2VtckJgLFIVoPcWoKCXOqwiSEABJZJTmwY2FpYRXjOJAXwrzvgDZzgNM
	J3Ddr4AGMwENjuYDG1ySiJCSamCcd4fz7z2WzqnMqxzaFQpvCyzY3Nu5o7Gq262dIdF+A+vv
	j3usr8bvnBhgsqx1Odc9jsznNVr3tx98p8TpzXEs7NdWvkSmxy9s33Ra1R1nuXtjQ/Pd8sXb
	z1XeYlZLYS/msui1+MQcomPaMEVknxO3x+Sy9isi9zecneEqqth2i9M4/ifPdUMl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243450>

The search for the end of the slashes is part of the update of the
path variable for the next iteration as opposed to an update of the
slash variable.  So iterate using path rather than slash.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 17db9f9..7f8d74d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -563,9 +563,10 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		if (!sub)
 			return NULL;
 		it = sub->cache_tree;
-		while (*slash == '/')
-			slash++;
+
 		path = slash;
+		while (*path == '/')
+			path++;
 	}
 	return it;
 }
-- 
1.9.0
