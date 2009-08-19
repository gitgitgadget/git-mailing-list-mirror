From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 1/6] git submodule: Cleanup usage string and add option
 parsing to cmd_foreach()
Date: Wed, 19 Aug 2009 03:45:19 +0200
Message-ID: <1250646324-961-2-git-send-email-johan@herland.net>
References: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	mlevedahl@gmail.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaFS-0006td-OI
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZHSBpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZHSBpp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43415 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750960AbZHSBpn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:43 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL004CROW8VN10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:44 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:44 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126491>

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-submodule.sh |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bdd6ea..c58eca4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,9 +4,14 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE="[--quiet] [--cached|--files] \
-[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [--rebase|--merge]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
+dashless=$(basename "$0" | sed -e 's/-/ /')
+USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> <path>
+   or: $dashless [--quiet] status [--cached] [--] [<path>...]
+   or: $dashless [--quiet] init [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--] [<path>...]
+   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
+   or: $dashless [--quiet] foreach <command>
+   or: $dashless [--quiet] sync [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 . git-parse-remote
@@ -238,6 +243,23 @@ cmd_add()
 #
 cmd_foreach()
 {
+	# parse $args after "submodule ... foreach".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=1
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	module_list |
 	while read mode sha1 stage path
 	do
-- 
1.6.4.304.g1365c.dirty
