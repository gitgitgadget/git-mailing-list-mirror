From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 2/2] add update 'none' flag to disable update of submodule by default
Date: Mon,  6 Jun 2011 22:57:32 +0200
Message-ID: <6d70cfcf08e7ff99d090a3d0e4f730e4f638d050.1307374519.git.hvoigt@hvoigt.net>
References: <cover.1307374519.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgsD-00060N-87
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab1FFU6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:58:02 -0400
Received: from darksea.de ([83.133.111.250]:38030 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751368Ab1FFU6B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:58:01 -0400
Received: (qmail 6150 invoked from network); 6 Jun 2011 22:57:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jun 2011 22:57:58 +0200
X-Mailer: git-send-email 1.7.5.1.219.g4c6b2
In-Reply-To: <cover.1307374519.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1307374519.git.hvoigt@hvoigt.net>
References: <cover.1307374519.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175167>

This is useful to mark a submodule as unneeded by default. When this
option is set and the user wants to work with such a submodule he
needs to configure 'submodule.<name>.update=checkout' or pass the
--checkout option. Then the submodule can be handled like a normal
submodule.

TODO: Documentation/Tests
---
 git-submodule.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 70dfc7b..77977b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -423,6 +423,9 @@ cmd_update()
 		--recursive)
 			recursive=1
 			;;
+		--checkout)
+			update="checkout"
+			;;
 		--)
 			shift
 			break
@@ -461,6 +464,12 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 		fi
 
+		if test "$update_module" = "none"
+		then
+			echo "Skipping submodule '$path'"
+			continue
+		fi
+
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
-- 
1.7.5.1.219.g4c6b2
