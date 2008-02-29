From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] gc: Add --quiet option
Date: Fri, 29 Feb 2008 22:53:39 +0100
Message-ID: <1204322019-17788-1-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDT1-00010b-JX
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185AbYB2WLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934177AbYB2WLy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:11:54 -0500
Received: from aiolos.lenk.info ([85.214.124.154]:45669 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934138AbYB2WLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:11:52 -0500
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Feb 2008 17:11:52 EST
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JVDAk-0005I8-9z; Fri, 29 Feb 2008 22:53:42 +0100
Received: from p57b244c6.dip.t-dialin.net ([87.178.68.198] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JVDAf-0002Ip-1s; Fri, 29 Feb 2008 22:53:37 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JVDAh-0004dJ-Sk; Fri, 29 Feb 2008 22:53:40 +0100
X-Mailer: git-send-email 1.5.4.3.340.g97b97.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75577>

Pass -q option to git-repack.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-gc.txt |    5 ++++-
 builtin-gc.c             |    5 +++++
 2 files changed, 9 insertions(+), 1 deletions(-)

I've decided to support -q since all other git commands that support --quiet
seem to support it, and many only support -q, but not --quiet.
It is currently not documented, though.

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 4b2dfef..310710a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune] [--aggressive] [--auto]
+'git-gc' [--prune] [--aggressive] [--auto] [--quiet]
 
 DESCRIPTION
 -----------
@@ -49,6 +49,9 @@ OPTIONS
 	required; if not, it exits without performing any work.
 	Some git commands run `git gc --auto` after performing
 	operations that could create many loose objects.
+
+--quiet::
+	Suppress all progress reports.
 +
 Housekeeping is required if there are too many loose objects or
 too many packs in the repository. If the number of loose objects
diff --git a/builtin-gc.c b/builtin-gc.c
index ad4a75e..3a42986 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -172,12 +172,14 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int prune = 0;
 	int aggressive = 0;
 	int auto_gc = 0;
+	int quiet = 0;
 	char buf[80];
 
 	struct option builtin_gc_options[] = {
 		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects"),
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
 		OPT_END()
 	};
 
@@ -197,6 +199,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			append_option(argv_repack, buf, MAX_ADD);
 		}
 	}
+	if (quiet) {
+		append_option(argv_repack, "-q", MAX_ADD);
+	}
 
 	if (auto_gc) {
 		/*
-- 
1.5.4.3

