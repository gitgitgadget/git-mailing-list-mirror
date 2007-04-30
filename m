From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix read_mailmap to handle a caller uninterested in repo abbreviation
Date: Tue, 1 May 2007 00:26:36 +0200
Message-ID: <20070430222636.GB5000@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieKT-000096-Cl
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946861AbXD3W0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946864AbXD3W0m
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:26:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27396 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946861AbXD3W0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:26:41 -0400
Received: from tigra.home ([195.4.169.198] [195.4.169.198])
	by post.webmailer.de (mrclete mo36) (RZmta 5.8)
	with ESMTP id F04af5j3ULXVBg ; Tue, 1 May 2007 00:26:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B249D277BD;
	Tue,  1 May 2007 00:26:36 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8AED8D171; Tue,  1 May 2007 00:26:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmZRM0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45886>

The only such a caller builtin-blame.c would pass NULL as the place
where to store the abbreviation.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

No one seem to be using the feature. No wonder: it has exotic use
case, strange configuration, not documented, there is only one call
site (shortlog), and there, why does it not happen automatically anyway?

 mailmap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index c29e4e5..38359a2 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -17,6 +17,9 @@ int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev
 			int abblen = sizeof(abbrev) - 1;
 			int len = strlen(buffer);
 
+			if (!repo_abbrev)
+				continue;
+
 			if (len && buffer[len - 1] == '\n')
 				buffer[--len] = 0;
 			if (!strncmp(buffer, abbrev, abblen)) {
-- 
1.5.2.rc0.792.g7f4bd0
