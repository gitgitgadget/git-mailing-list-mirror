From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH] git-rm: add --quiet option to suppress "rm 'file'" messages
Date: Mon, 26 Mar 2007 03:28:24 -0700
Message-ID: <1174904904.5662.8.camel@localhost>
References: <11747590062554-git-send-email-tilman@code-monkey.de>
	 <7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
	 <20070325210418.GA29221@code-monkey.de>
	 <Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVmRO-0000ga-2o
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbXCZK2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbXCZK2h
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:28:37 -0400
Received: from smtp-2.smtp.ucla.edu ([169.232.47.136]:46110 "EHLO
	smtp-2.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbXCZK2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:28:36 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-2.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QASVI5025528;
	Mon, 26 Mar 2007 03:28:31 -0700
Received: from [192.168.1.7] (adsl-75-26-166-168.dsl.scrm01.sbcglobal.net [75.26.166.168])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QASUO5026417
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 26 Mar 2007 03:28:30 -0700
In-Reply-To: <Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43148>

Signed-off-by: Eric Lesh <eclesh@ucla.edu>

---

On Sun, 2007-03-25 at 23:36 +0200, Johannes Schindelin wrote:
> > Too bad, I find it rather annoying and irritating.
> 
> Why not do the common thing, and add a "--quiet" option? You can even add 
> a config variable to enable it by default (for git-rm). It's not like 
> git-rm is performance critical...
> 

Is something like this right?

 builtin-rm.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 00dbe39..d193fb0 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -114,7 +114,7 @@ static struct lock_file lock_file;
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int show_only = 0, force = 0, index_only = 0, recursive = 0;
+	int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 	const char **pathspec;
 	char *seen;
 
@@ -142,6 +142,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			force = 1;
 		else if (!strcmp(arg, "-r"))
 			recursive = 1;
+		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
+			quiet = 1;
 		else
 			usage(builtin_rm_usage);
 	}
@@ -197,7 +199,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	for (i = 0; i < list.nr; i++) {
 		const char *path = list.name[i];
-		printf("rm '%s'\n", path);
+		if (!quiet)
+			printf("rm '%s'\n", path);
 
 		if (remove_file_from_cache(path))
 			die("git-rm: unable to remove %s", path);
-- 
1.5.1-rc1.GIT
