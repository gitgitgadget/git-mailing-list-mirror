From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Check for help invocation before setup
Date: Wed, 19 Nov 2008 17:03:40 +0100
Message-ID: <1227110623-4474-2-git-send-email-madduck@debian.org>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 17:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pYs-0004Ic-Hb
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbYKSQEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYKSQEF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:04:05 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47993 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbYKSQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:03:58 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7198C1D40AF;
	Wed, 19 Nov 2008 17:03:47 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 074789F1B2;
	Wed, 19 Nov 2008 17:03:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 9D70543EF; Wed, 19 Nov 2008 17:03:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1227110623-4474-1-git-send-email-madduck@debian.org>
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101358>

The user ought to be able to call `tg help` from anywhere in the
filesystem, not just Git repositories, so the help parsing has to happen
before the calls to git git binary.

Debian bug: #501982

Signed-off-by: martin f. krafft <madduck@debian.org>
---
 tg.sh |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tg.sh b/tg.sh
index 2961106..40c4ab7 100644
--- a/tg.sh
+++ b/tg.sh
@@ -235,6 +235,20 @@ do_help()
 	fi
 }
 
+## Startup
+
+args_saved="$@"
+while [ -n "$1" ]; do
+	case "$1" in
+	help|--help|-h)
+		shift
+		do_help "$1"
+		exit 1;;
+	esac
+	shift
+done
+set -- $args_saved
+unset args_saved
 
 ## Initial setup
 
@@ -268,9 +282,6 @@ cmd="$1"
 shift
 
 case "$cmd" in
-help|--help|-h)
-	do_help "$1"
-	exit 1;;
 --hooks-path)
 	# Internal command
 	echo "@hooksdir@";;
-- 
1.6.0.2
