From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH v2] Add OS X support to the pre-auto-gc example hook
Date: Tue, 30 Sep 2008 00:36:28 +0100
Message-ID: <1222731388-833-1-git-send-email-jon.delStrother@bestbefore.tv>
References: <57518fd10809270253s4c07318bjd54c7d86460ce7d7@mail.gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 01:38:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkSJq-0001R8-Hd
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 01:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYI2XhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 19:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYI2XhN
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 19:37:13 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:35444 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYI2XhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 19:37:12 -0400
Received: (qmail 11437 invoked from network); 30 Sep 2008 00:37:09 +0100
Received: from 87.114.30.223.plusnet.thn-ag3.dyn.plus.net (HELO localhost.localdomain) (87.114.30.223)
  by cumberland.bestbefore.tv with SMTP; 30 Sep 2008 00:37:09 +0100
X-Mailer: git-send-email 1.6.0.2.308.gd442a.dirty
In-Reply-To: <57518fd10809270253s4c07318bjd54c7d86460ce7d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97059>

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
Second attempt - this simplifies the test while making it more specific (it will only pack when on AC power, rather than, say, UPS).

 contrib/hooks/pre-auto-gc-battery |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index 0096f57..b0a8caa 100644
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -1,9 +1,9 @@
 #!/bin/sh
 #
 # An example hook script to verify if you are on battery, in case you
-# are running Linux. Called by git-gc --auto with no arguments. The hook
-# should exit with non-zero status after issuing an appropriate message
-# if it wants to stop the auto repacking.
+# are running Linux or OS X. Called by git-gc --auto with no arguments.
+# The hook should exit with non-zero status after issuing an appropriate
+# message if it wants to stop the auto repacking.
 #
 # This hook is stored in the contrib/hooks directory. Your distribution
 # may have put this somewhere else. If you want to use this hook, you
@@ -30,6 +30,10 @@ then
 elif grep -q '0x01$' /proc/apm 2>/dev/null
 then
 	exit 0
+elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt |
+	grep -q "Currently drawing from 'AC Power'"
+then
+	exit 0
 fi
 
 echo "Auto packing deferred; not on AC"
-- 
1.6.0.2.308.gd442a.dirty
