From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/2] submodule: move update configuration variable further up
Date: Thu, 11 Aug 2011 19:51:45 +0200
Message-ID: <5dcb346470d84b03276ec1d3693ab21a48681952.1312923673.git.hvoigt@hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 19:52:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZQd-0007YC-FN
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1HKRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:52:17 -0400
Received: from darksea.de ([83.133.111.250]:57050 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752626Ab1HKRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:52:16 -0400
Received: (qmail 25982 invoked from network); 11 Aug 2011 19:52:14 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Aug 2011 19:52:14 +0200
X-Mailer: git-send-email 1.7.6.435.g741d34
In-Reply-To: <cover.1312923673.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1312923673.git.hvoigt@hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179113>

Lets always initialize the 'update_module' variable with the final
value. This way we allow code which wants to check this configuration
early to do so right in the beginning of cmd_update().

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f46862f..e544dbc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -461,7 +461,13 @@ cmd_update()
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
@@ -483,11 +489,6 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$path'")"
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
1.7.6.435.g741d34
