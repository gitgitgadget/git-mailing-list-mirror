From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 04/11] dir.c: improve docs for match_pathspec() and match_pathspec_depth()
Date: Sun,  6 Jan 2013 16:58:06 +0000
Message-ID: <1357491493-11619-5-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYY-0007mE-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3AFQ6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:19 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45596 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab3AFQ6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:18 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9167D2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:17 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212815>

Fix a grammatical issue in the description of these functions, and
make it more obvious how and why seen[] can be reused across multiple
invocations.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 38 ++++++++++++++++++++++++++------------
 dir.h |  6 ++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index 46f362e..547b83f 100644
--- a/dir.c
+++ b/dir.c
@@ -167,12 +167,19 @@ static int match_one(const char *match, const char *name, int namelen)
 }
 
 /*
- * Given a name and a list of pathspecs, see if the name matches
- * any of the pathspecs.  The caller is also interested in seeing
- * all pathspec matches some names it calls this function with
- * (otherwise the user could have mistyped the unmatched pathspec),
- * and a mark is left in seen[] array for pathspec element that
- * actually matched anything.
+ * Given a name and a list of pathspecs, returns the nature of the
+ * closest (i.e. most specific) match of the name to any of the
+ * pathspecs.
+ *
+ * The caller typically calls this multiple times with the same
+ * pathspec and seen[] array but with different name/namelen
+ * (e.g. entries from the index) and is interested in seeing if and
+ * how each pathspec matches all the names it calls this function
+ * with.  A mark is left in the seen[] array for each pathspec element
+ * indicating the closest type of match that element achieved, so if
+ * seen[n] remains zero after multiple invocations, that means the nth
+ * pathspec did not match any names, which could indicate that the
+ * user mistyped the nth pathspec.
  */
 int match_pathspec(const char **pathspec, const char *name, int namelen,
 		int prefix, char *seen)
@@ -239,12 +246,19 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 }
 
 /*
- * Given a name and a list of pathspecs, see if the name matches
- * any of the pathspecs.  The caller is also interested in seeing
- * all pathspec matches some names it calls this function with
- * (otherwise the user could have mistyped the unmatched pathspec),
- * and a mark is left in seen[] array for pathspec element that
- * actually matched anything.
+ * Given a name and a list of pathspecs, returns the nature of the
+ * closest (i.e. most specific) match of the name to any of the
+ * pathspecs.
+ *
+ * The caller typically calls this multiple times with the same
+ * pathspec and seen[] array but with different name/namelen
+ * (e.g. entries from the index) and is interested in seeing if and
+ * how each pathspec matches all the names it calls this function
+ * with.  A mark is left in the seen[] array for each pathspec element
+ * indicating the closest type of match that element achieved, so if
+ * seen[n] remains zero after multiple invocations, that means the nth
+ * pathspec did not match any names, which could indicate that the
+ * user mistyped the nth pathspec.
  */
 int match_pathspec_depth(const struct pathspec *ps,
 			 const char *name, int namelen,
diff --git a/dir.h b/dir.h
index dd42a3a..136e838 100644
--- a/dir.h
+++ b/dir.h
@@ -116,6 +116,12 @@ struct dir_struct {
 	char basebuf[PATH_MAX];
 };
 
+/*
+ * The ordering of these constants is significant, with
+ * higher-numbered match types signifying "closer" (i.e. more
+ * specific) matches which will override lower-numbered match types
+ * when populating the seen[] array.
+ */
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
-- 
1.7.11.7.33.gb8feba5
