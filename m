From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use strlcpy instead of strncpy in mailmap.c
Date: Tue, 1 May 2007 00:22:53 +0200
Message-ID: <20070430222253.GA5000@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieGq-00076A-EA
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946845AbXD3WW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946859AbXD3WW5
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:22:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32254 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946845AbXD3WW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:22:56 -0400
Received: from tigra.home ([195.4.169.198] [195.4.169.198])
	by post.webmailer.de (klopstock mo35) (RZmta 5.8)
	with ESMTP id E014d9j3ULoFaZ ; Tue, 1 May 2007 00:22:54 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B671C277BD;
	Tue,  1 May 2007 00:22:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BBD30D171; Tue,  1 May 2007 00:22:53 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmZRM0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45885>

strncpy does not NUL-terminate output in case of output buffer too short,
and map_email prototype (and usage) does not allow for figuring out
what the length of the name is.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 mailmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index af187a3..c29e4e5 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -80,7 +80,7 @@ int map_email(struct path_list *map, const char *email, char *name, int maxlen)
 		free(mailbuf);
 	if (item != NULL) {
 		const char *realname = (const char *)item->util;
-		strncpy(name, realname, maxlen);
+		strlcpy(name, realname, maxlen);
 		return 1;
 	}
 	return 0;
-- 
1.5.2.rc0.792.g7f4bd0
