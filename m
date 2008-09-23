From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH] Add OS X support to the pre-auto-gc example hook
Date: Tue, 23 Sep 2008 23:43:23 +0100
Message-ID: <1222209803-4401-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 00:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiGd5-000183-Ua
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 00:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYIWWoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 18:44:01 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYIWWoB
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 18:44:01 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:54718 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYIWWoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 18:44:00 -0400
Received: (qmail 24780 invoked from network); 23 Sep 2008 23:43:57 +0100
Received: from 87.114.140.15.plusnet.thn-ag1.dyn.plus.net (HELO localhost.localdomain) (87.114.140.15)
  by cumberland.bestbefore.tv with SMTP; 23 Sep 2008 23:43:57 +0100
X-Mailer: git-send-email 1.6.0.2.308.gd442a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96609>

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

Darwin / OS X has a pmset tool for getting power management information=
=2E  How about adding OS X support to the auto-gc hook?
Shell scripting isn't my fort=C3=A9, suggestions for improvements would=
 be welcome.

 contrib/hooks/pre-auto-gc-battery |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto=
-gc-battery
index 0096f57..0b7bcde 100644
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -1,9 +1,9 @@
 #!/bin/sh
 #
 # An example hook script to verify if you are on battery, in case you
-# are running Linux. Called by git-gc --auto with no arguments. The ho=
ok
-# should exit with non-zero status after issuing an appropriate messag=
e
-# if it wants to stop the auto repacking.
+# are running Linux or OS X. Called by git-gc --auto with no arguments=
=2E
+# The hook should exit with non-zero status after issuing an appropria=
te
+# message if it wants to stop the auto repacking.
 #
 # This hook is stored in the contrib/hooks directory. Your distributio=
n
 # may have put this somewhere else. If you want to use this hook, you
@@ -30,6 +30,9 @@ then
 elif grep -q '0x01$' /proc/apm 2>/dev/null
 then
 	exit 0
+elif test -x /usr/bin/pmset && (! /usr/bin/pmset -g batt | grep -q 'Ba=
ttery Power' )
+then
+	exit 0
 fi
=20
 echo "Auto packing deferred; not on AC"
--=20
1.6.0.2.308.gd442a.dirty
