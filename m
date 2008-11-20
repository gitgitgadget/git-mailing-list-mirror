From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Require an argument to tg -r
Date: Thu, 20 Nov 2008 13:08:57 +0100
Message-ID: <1227182937-25056-1-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 20 13:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38Ma-0002cl-Bk
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbYKTMJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYKTMJK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:09:10 -0500
Received: from clegg.madduck.net ([193.242.105.96]:55515 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbYKTMJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:09:09 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 255CD1D40AF;
	Thu, 20 Nov 2008 13:08:59 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 055C69F350;
	Thu, 20 Nov 2008 13:08:58 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BC8D245F4; Thu, 20 Nov 2008 13:08:57 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101412>

Right now, if -r is passed to tg, an ugly shift error occurs. This patch
checks for that case and outputs the help message if it occurs.

Signed-off-by: martin f. krafft <madduck@debian.org>

---
 tg.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 4dcc15e..a5dc0a7 100644
--- a/tg.sh
+++ b/tg.sh
@@ -261,7 +261,13 @@ setup_hook "pre-commit"
 [ -z "$tg__include" ] || return 0
 
 if [ "$1" = "-r" ]; then
-	shift; base_remote="$1"; shift
+	shift
+        if [ -z "$1" ]; then
+		echo "Option -r requires an argument." >&2
+		do_help
+		exit 1
+	fi
+	base_remote="$1"; shift
 	tg="$tg -r $base_remote"
 fi
 
-- 
tg: (f17218e..) fixes/tg--r-require-arg (depends on: upstream)
