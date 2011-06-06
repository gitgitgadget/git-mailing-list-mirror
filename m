From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 1/2] submodule: move update configuration variable further up
Date: Mon,  6 Jun 2011 22:57:31 +0200
Message-ID: <4764d04d0faf6d71830094f91bd3743deb6e2d4e.1307374519.git.hvoigt@hvoigt.net>
References: <cover.1307374519.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgs7-0005wW-WD
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1FFU5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:57:54 -0400
Received: from darksea.de ([83.133.111.250]:38028 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884Ab1FFU5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:57:53 -0400
Received: (qmail 6139 invoked from network); 6 Jun 2011 22:57:49 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jun 2011 22:57:49 +0200
X-Mailer: git-send-email 1.7.5.1.219.g4c6b2
In-Reply-To: <cover.1307374519.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1307374519.git.hvoigt@hvoigt.net>
References: <cover.1307374519.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175166>

Lets always initialize the 'update_module' variable with the final
value. This way we allow code which wants to check this configuration
early to do so right in the beginning of cmd_update().
---
 git-submodule.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..70dfc7b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -454,7 +454,13 @@ cmd_update()
 		fi
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		update_module=$(git config submodule."$name".update)
+		if ! test -z "$update"
+		then
+			update_module=$update
+		else
+			update_module=$(git config submodule."$name".update)
+		fi
+
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -476,11 +482,6 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
-		if ! test -z "$update"
-		then
-			update_module=$update
-		fi
-
 		if test "$subsha1" != "$sha1"
 		then
 			subforce=$force
-- 
1.7.5.1.219.g4c6b2
