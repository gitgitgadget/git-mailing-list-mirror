From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: [PATCH] Fix prepare-commit-msg hook and replace in-place sed
Date: Wed, 21 May 2008 18:25:54 +0200
Message-ID: <1211387154-8792-1-git-send-email-git-dev@marzelpan.de>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 21 18:26:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyr9O-000225-K3
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763152AbYEUQZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759930AbYEUQZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 12:25:58 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:34936 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759619AbYEUQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 12:25:57 -0400
Received: from [80.145.234.245] (helo=localhost.localdomain)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1Jyr8V-0008GI-Ba; Wed, 21 May 2008 18:25:55 +0200
X-Mailer: git-send-email 1.5.5.1.316.g377d9
X-Df-Sender: 893553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82554>

The patterns to the case statement could never be matched, so the hook
was a noop. This patch also replaces the non-portable use of in-place sed.

Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
---
 templates/hooks--prepare-commit-msg |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg b/templates/hooks--prepare-commit-msg
index ff0f42a..d3c1da3 100644
--- a/templates/hooks--prepare-commit-msg
+++ b/templates/hooks--prepare-commit-msg
@@ -20,11 +20,11 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2 $3" in
-  merge)
-    sed -i '/^Conflicts:/,/#/!b;s/^/# &/;s/^# #/#/' "$1" ;;
+case "$2,$3" in
+  merge,)
+    perl -i -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
 
-# ""|template)
+# ,|template,)
 #   perl -i -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
-- 
1.5.5.1.316.g377d9
