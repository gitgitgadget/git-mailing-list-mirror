From: Johan Herland <johan@herland.net>
Subject: [PATCH] git submodule foreach: Provide access to submodule name,
 as '$name'
Date: Sun, 16 Aug 2009 03:10:08 +0200
Message-ID: <200908160310.08459.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 03:10:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McUGM-0002sN-AL
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 03:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbZHPBKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 21:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbZHPBKM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 21:10:12 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54040 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753047AbZHPBKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 21:10:11 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOG00LRJ38XRB70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 16 Aug 2009 03:10:09 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOG00H8538WJB70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 16 Aug 2009 03:10:09 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.16.5716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126047>

The argument to 'git submodule foreach' already has access to the variables
'$path' (the path to the submodule, relative to the superproject) and '$sha1'
(the submodule commit recorded by the superproject).

This patch adds another variable -- '$name' -- which contains the name of the
submodule, as recorded in the superproject's .gitmodules file.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |    3 ++-
 git-submodule.sh                |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7dd73ae..97c32fe 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -131,7 +131,8 @@ summary::
 
 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $path and $sha1:
+	The command has access to the variables $name, $path and $sha1:
+	$name is the name of the relevant submodule section in .gitmodules,
 	$path is the name of the submodule directory relative to the
 	superproject, and $sha1 is the commit as recorded in the superproject.
 	Any submodules defined in the superproject but not checked out are
diff --git a/git-submodule.sh b/git-submodule.sh
index ebed711..d8ecdb9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -243,6 +243,7 @@ cmd_foreach()
 		if test -e "$path"/.git
 		then
 			say "Entering '$path'"
+			name=$(module_name "$path")
 			(cd "$path" && eval "$@") ||
 			die "Stopping at '$path'; script returned non-zero status."
 		fi
-- 
1.6.4.rc3.138.ga6b98.dirty
