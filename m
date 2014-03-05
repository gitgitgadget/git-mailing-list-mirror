From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/6] cache_tree_find(): initialize slash using strchrnul()
Date: Wed,  5 Mar 2014 18:26:26 +0100
Message-ID: <1394040390-7954-3-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFai-0007LK-2m
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbaCER0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:26:44 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52427 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751879AbaCER0m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:26:42 -0500
X-AuditID: 1207440f-f79326d000003c9f-d5-53175e516f57
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 53.FF.15519.15E57135; Wed,  5 Mar 2014 12:26:41 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7B022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:40 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqBsYJx5scLnfymL2jW1sFl1Xupks
	GnqvMFvcXjGf2YHF4+/7D0webdPMPC5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvj38J+9oL5
	rBVLF0k1ME5m6WLk5JAQMJFY/fkmG4QtJnHh3nowW0jgMqNE8wGpLkYuIPsok8T2TceZQBJs
	AroSi3qawWwRATWJiW2HwAYxC6RJPNhyBcjm4BAW8JVo6KkACbMIqEp0H17DDmLzCjhLPGg7
	wAyxS05iyu8FYHFOAReJxqUdTCCtQkA1i/YzT2DkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEv
	L7VI10QvN7NELzWldBMjJGz4dzB2rZc5xCjAwajEw8sZKB4sxJpYVlyZe4hRkoNJSZT3ajRQ
	iC8pP6UyI7E4I76oNCe1+BCjBAezkghvQCRQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1
	OzW1ILUIJivDwaEkwTstFqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQT8cXA
	qABJ8QDtPQnSzltckJgLFIVoPcWoKCXOqwiSEABJZJTmwY2FJYNXjOJAXwrzzgSp4gEmErju
	V0CDmYAGR/OBDS5JREgB43vx1flKrNyJAWWMr08znk7S/vXzgz5roesp5/YfexuWG1se0Pv3
	8/F29h4VAabHdpUlmzTq9pjPnKHJWSMWGDH99qmg7WEzN5zc/3KhZVzow6xFfuuUFeZdP893
	9M6ChRdNVrwqWJNn0bI70k9//s7XN9vsrWfe+yqqdObTP01hHbv3st2NPOeUWIoz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243447>

Suggested-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 4d439bd..d00f4ef 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -554,9 +554,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		const char *slash;
 		struct cache_tree_sub *sub;
 
-		slash = strchr(path, '/');
-		if (!slash)
-			slash = path + strlen(path);
+		slash = strchrnul(path, '/');
 		/* between path and slash is the name of the
 		 * subtree to look for.
 		 */
-- 
1.9.0
