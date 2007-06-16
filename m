From: Jeff King <peff@peff.net>
Subject: [PATCH] Fix ALLOC_GROW calls with obsolete semantics
Date: Sat, 16 Jun 2007 18:43:40 -0400
Message-ID: <20070616224340.GA7362@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzgzf-0005qk-RZ
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbXFPWnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbXFPWnn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:43:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1273 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447AbXFPWnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:43:42 -0400
Received: (qmail 1409 invoked from network); 16 Jun 2007 22:43:57 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Jun 2007 22:43:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jun 2007 18:43:40 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50322>

ALLOC_GROW now expects the 'nr' argument to be "how much you
want" and not "how much you have". This fixes all cases
where we weren't previously adding anything to the 'nr'.

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the add-empty topic in next. Your other uses of
ALLOC_GROW are presumably OK since they were already adding in extra
space.

 dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 98e24ad..8d8faf5 100644
--- a/dir.c
+++ b/dir.c
@@ -286,7 +286,7 @@ struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int
 	if (cache_name_pos(pathname, len) >= 0)
 		return NULL;
 
-	ALLOC_GROW(dir->entries, dir->nr, dir->alloc);
+	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
@@ -295,7 +295,7 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname,
 	if (cache_name_pos(pathname, len) >= 0)
 		return NULL;
 
-	ALLOC_GROW(dir->ignored, dir->ignored_nr, dir->ignored_alloc);
+	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
 	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
-- 
1.5.2.2.1012.ge05f4
