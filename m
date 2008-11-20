From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Use the topological order when exporting explicitly listed branches.
Date: Thu, 20 Nov 2008 10:38:22 +0100
Message-ID: <1227173902-21180-1-git-send-email-madduck@debian.org>
Cc: Niko Tyni <ntyni@debian.org>,
	"martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 20 10:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L360x-0004eU-JK
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 10:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYKTJik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 04:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYKTJik
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 04:38:40 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47310 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYKTJij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 04:38:39 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id AAD201D40A9;
	Thu, 20 Nov 2008 10:38:24 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 54C179F34F;
	Thu, 20 Nov 2008 10:38:23 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0713E45F4; Thu, 20 Nov 2008 10:38:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101396>

From: Niko Tyni <ntyni@debian.org>

When exporting explicitly listed branches (tg export -b), the branch
dependencies were not taken into account.

Signed-off-by: martin f. krafft <madduck@debian.org>
Tested-by: martin f. krafft <madduck@debian.org>
---
Arguably, lines 178:189 need to be refactored due to the code duplication, but
the patch does what it should for now.

 tg-export.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 52af88d..037b991 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -181,9 +181,9 @@ if [ -z "$branches" ]; then
 	recurse_deps driver "$name"
 	(_ret=0; _dep="$name"; _name=""; _dep_is_tgish=1; driver)
 else
-	echo "$branches" | tr ',' '\n' | while read _dep; do
-		_dep_is_tgish=1
-		$driver
+	echo "$branches" | tr ',' '\n' | while read name; do
+		recurse_deps driver "$name"
+		(_ret=0; _dep="$name"; _name=""; _dep_is_tgish=1; driver)
 	done
 	name="$(echo "$branches" | sed 's/.*,//')"
 fi
-- 
1.5.6.5
