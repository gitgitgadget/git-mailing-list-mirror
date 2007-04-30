From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Remove pointless calls to access(2) when checking for .mailmap
Date: Tue, 1 May 2007 00:27:05 +0200
Message-ID: <20070430222705.GC5000@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieKw-0000H4-53
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946864AbXD3W1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946865AbXD3W1K
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:27:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:46384 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946864AbXD3W1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:27:09 -0400
Received: from tigra.home ([195.4.169.198] [195.4.169.198])
	by post.webmailer.de (fruni mo35) (RZmta 5.8)
	with ESMTP id E0633aj3UIPb6r ; Tue, 1 May 2007 00:27:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C89ED277BD;
	Tue,  1 May 2007 00:27:05 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C20C2D171; Tue,  1 May 2007 00:27:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmZRM0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45887>

read_mailmap already returns not 0 in case of error, and nothing
seem to be interested in it. It also is silent about the fact
(read_mailmap being to chatty would justify the call to access,
but there is no point for it to be and it isn't).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-blame.c    |    2 +-
 builtin-shortlog.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 682edba..3442d28 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2375,7 +2375,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
-	if (!no_mailmap && !access(".mailmap", R_OK))
+	if (!no_mailmap)
 		read_mailmap(&mailmap, ".mailmap", NULL);
 
 	assign_blame(&sb, &revs, opt);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b57a88a..8d3f742 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -283,8 +283,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
-	if (!access(".mailmap", R_OK))
-		read_mailmap(&mailmap, ".mailmap", &common_repo_prefix);
+	read_mailmap(&mailmap, ".mailmap", &common_repo_prefix);
 
 	if (rev.pending.nr == 0) {
 		if (isatty(0))
-- 
1.5.2.rc0.792.g7f4bd0
