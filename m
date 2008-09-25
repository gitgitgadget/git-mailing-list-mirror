From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Cleanup remove_path
Date: Thu, 25 Sep 2008 22:17:34 +0200
Message-ID: <20080925201734.GA18315@blimp.localhost>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 22:19:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KixIe-0004hM-7v
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbYIYURh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYIYURh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:17:37 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:45361 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYIYURg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 16:17:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81p7LJ
Received: from tigra.home (Fab79.f.strato-dslnet.de [195.4.171.121])
	by post.webmailer.de (klopstock mo64) (RZmta 17.4)
	with ESMTP id t004c2k8PIrcJh ; Thu, 25 Sep 2008 22:17:34 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 6289C277AE;
	Thu, 25 Sep 2008 22:17:34 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 5907F36D1E; Thu, 25 Sep 2008 22:17:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925201245.GB3959@blimp.localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96792>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

While at it, could we cleanup the remove_file routines a little?

 builtin-merge-recursive.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index a29b47f..dc9652d 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -418,12 +418,10 @@ static int update_stages(const char *path, struct diff_filespec *o,
 
 static int remove_path(const char *name)
 {
-	int ret;
 	char *slash, *dirs;
 
-	ret = unlink(name);
-	if (ret)
-		return ret;
+	if (unlink(name))
+		return -1;
 	dirs = xstrdup(name);
 	while ((slash = strrchr(name, '/'))) {
 		*slash = '\0';
@@ -431,7 +429,7 @@ static int remove_path(const char *name)
 			break;
 	}
 	free(dirs);
-	return ret;
+	return 0;
 }
 
 static int remove_file(int clean, const char *path, int no_wd)
-- 
1.6.0.2.328.g14651
