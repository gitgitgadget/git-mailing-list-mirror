From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diff-lib.c: don't strdup twice
Date: Sat, 07 Jul 2007 20:19:08 +0200
Message-ID: <468FD91C.7040506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 20:19:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7EsN-0005lp-Fi
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 20:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbXGGSTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 14:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXGGSTU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 14:19:20 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:56239
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbXGGSTU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2007 14:19:20 -0400
Received: from [10.0.1.201] (p508E3CFB.dip.t-dialin.net [80.142.60.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 192E616022;
	Sat,  7 Jul 2007 20:19:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51832>

The static function read_directory in diff-lib.c is only ever called
with struct path_list lists with .strdup_paths turned on, i.e.
path_list_insert will strdup the paths for us (again).  Let's take
advantage of that and stop doing it twice.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 diff-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 7fb19c7..92c0e39 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -24,7 +24,7 @@ static int read_directory(const char *path, struct path_list *list)
 
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			path_list_insert(xstrdup(e->d_name), list);
+			path_list_insert(e->d_name, list);
 
 	closedir(dir);
 	return 0;
