From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-checkout: Handle relative paths containing "..".
Date: Thu,  8 Nov 2007 13:33:12 +1100
Message-ID: <1194489192-20021-1-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 03:35:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpxEX-0001jM-CF
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 03:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760403AbXKHCd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 21:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757760AbXKHCd5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 21:33:57 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:26214 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760398AbXKHCdz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 21:33:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAFgCMkd5LBGK/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,387,1188743400"; 
   d="scan'208";a="223431170"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 08 Nov 2007 13:03:14 +1030
X-Mailer: git-send-email 1.5.3.5.1529.g69a1-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63926>

Based on gitte's idea.

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 git-checkout.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 8993920..b2c50aa 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -134,9 +134,10 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
 	fi
 
 	# Make sure the request is about existing paths.
-	git ls-files --error-unmatch -- "$@" >/dev/null || exit
-	git ls-files -- "$@" |
-	git checkout-index -f -u --stdin
+	git ls-files --full-name --error-unmatch -- "$@" >/dev/null || exit
+	git ls-files --full-name -- "$@" |
+		(cd "$(git-rev-parse --show-cdup)" &&
+		 git checkout-index -f -u --stdin)
 
         # Run a post-checkout hook -- the HEAD does not change so the
         # current HEAD is passed in for both args
-- 
1.5.3.5.1529.g69a1-dirty
