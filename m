From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: inline default_parse_extra()
Date: Wed, 13 Sep 2006 22:55:04 +0200
Message-ID: <45087028.2070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 22:55:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNblS-0004qn-PR
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 22:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWIMUzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIMUzS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 16:55:18 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:3805
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751092AbWIMUzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 16:55:17 -0400
Received: from [10.0.1.3] (p508E4A15.dip.t-dialin.net [80.142.74.21])
	by neapel230.server4you.de (Postfix) with ESMTP id 8F2B9805A;
	Wed, 13 Sep 2006 22:55:15 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26942>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/builtin-archive.c b/builtin-archive.c
index da3f714..6dabdee 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -145,17 +145,6 @@ void parse_treeish_arg(const char **argv
 	ar_args->time = archive_time;
 }
 
-static const char *default_parse_extra(struct archiver *ar,
-				       const char **argv)
-{
-	static char msg[64];
-
-	snprintf(msg, sizeof(msg) - 4, "'%s' format does not handle %s",
-		 ar->name, *argv);
-
-	return strcat(msg, "...");
-}
-
 int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 {
 	const char *extra_argv[MAX_EXTRA_ARGS];
@@ -208,7 +197,8 @@ int parse_archive_args(int argc, const c
 
 	if (extra_argc) {
 		if (!ar->parse_extra)
-			die("%s", default_parse_extra(ar, extra_argv));
+			die("'%s' format does not handle %s",
+			    ar->name, extra_argv[0]);
 		ar->args.extra = ar->parse_extra(extra_argc, extra_argv);
 	}
 	ar->args.verbose = verbose;
