From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] make "find_ref_by_name" a public function
Date: Sun, 18 Nov 2007 02:13:10 -0500
Message-ID: <20071118071308.GA18467@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 08:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IteLT-0000ZE-2r
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 08:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXKRHNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 02:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXKRHNN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 02:13:13 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3585 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXKRHNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 02:13:13 -0500
Received: (qmail 8651 invoked by uid 111); 18 Nov 2007 07:13:12 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 02:13:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 02:13:10 -0500
Content-Disposition: inline
In-Reply-To: <20071118055804.GA19313@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65344>

This was a static in remote.c, but is generally useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    2 ++
 refs.c   |    8 ++++++++
 remote.c |    8 --------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index ba9178f..1f3f113 100644
--- a/cache.h
+++ b/cache.h
@@ -521,6 +521,8 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
+extern struct ref *find_ref_by_name(struct ref *list, const char *name);
+
 #define CONNECT_VERBOSE       (1u << 0)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
diff --git a/refs.c b/refs.c
index ae53254..54ec98d 100644
--- a/refs.c
+++ b/refs.c
@@ -1433,3 +1433,11 @@ int update_ref(const char *action, const char *refname,
 	}
 	return 0;
 }
+
+struct ref *find_ref_by_name(struct ref *list, const char *name)
+{
+	for ( ; list; list = list->next)
+		if (!strcmp(list->name, name))
+			return list;
+	return NULL;
+}
diff --git a/remote.c b/remote.c
index 09b7aad..bb01059 100644
--- a/remote.c
+++ b/remote.c
@@ -696,14 +696,6 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return -errs;
 }
 
-static struct ref *find_ref_by_name(struct ref *list, const char *name)
-{
-	for ( ; list; list = list->next)
-		if (!strcmp(list->name, name))
-			return list;
-	return NULL;
-}
-
 static const struct refspec *check_pattern_match(const struct refspec *rs,
 						 int rs_nr,
 						 const struct ref *src)
-- 
1.5.3.5.1817.g37c1a-dirty
