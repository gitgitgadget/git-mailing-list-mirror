From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 20:05:02 -0400
Message-ID: <1252800302-26560-1-git-send-email-nelhage@mit.edu>
Cc: Nelson Elhage <nelhage@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 02:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmceF-0004gx-SQ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 02:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbZIMAGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 20:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbZIMAGV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 20:06:21 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37606 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570AbZIMAGU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 20:06:20 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8D06INZ013849;
	Sat, 12 Sep 2009 20:06:22 -0400 (EDT)
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8D05LOX027100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 12 Sep 2009 20:05:21 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.499.ge7b8da
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128317>

'-n' is the standard way to specify a dry run for other git commands,
so make 'git-push' accept it as well.
---
 Documentation/git-push.txt |    3 ++-
 builtin-push.c             |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 58d2bd5..ba6a8a2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
@@ -82,6 +82,7 @@ nor in any Push line of the corresponding remotes file---see below).
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
+-n::
 --dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 787011f..5e5f3ad 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -182,7 +182,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
-		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
+		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
-- 
1.6.3.1.499.ge7b8da
