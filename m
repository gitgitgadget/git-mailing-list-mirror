From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "--git-dir" flag to git-rev-parse
Date: Sun, 18 Sep 2005 11:18:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Sep 18 20:20:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3kN-0004Oe-Jw
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 20:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVIRSSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVIRSSh
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 14:18:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbVIRSSh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 14:18:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IIIVBo009084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 11:18:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IIIVdU024174;
	Sun, 18 Sep 2005 11:18:31 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8802>


Especially when you're deep inside the git repository, it's not all that
trivial for scripts to figure out where GIT_DIR is if it isn't set.

So add a flag to git-rev-parse to show where it is, since it will have 
figured it out anyway.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -191,6 +191,22 @@ int main(int argc, char **argv)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--git-dir")) {
+				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+				static char cwd[PATH_MAX];
+				if (gitdir) {
+					puts(gitdir);
+					continue;
+				}
+				if (!prefix) {
+					puts(".git");
+					continue;
+				}
+				if (!getcwd(cwd, PATH_MAX))
+					die("unable to get current working directory");
+				printf("%s/.git\n", cwd);
+				continue;
+			}
 			if (verify)
 				die("Needed a single revision");
 			show_flag(arg);
