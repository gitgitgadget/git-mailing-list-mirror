From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
Subject: [PATCH] web--browse: support /usr/bin/cygstart on Cygwin
Date: Fri, 21 Jun 2013 02:24:32 -0500
Message-ID: <1371799472-11564-1-git-send-email-yselkowitz@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 09:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpviN-0000iQ-VB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 09:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758850Ab3FUHY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 03:24:56 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47583 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3FUHYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 03:24:55 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so7367436pbc.12
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:x-mailer;
        bh=5bgWV4S+E7UFu5dcMHcKoVTTzY/AQXitQauHZWE64RA=;
        b=a7UgiMlSXQjFzi0olhltV9OFgo0PRnZNxmsfZ/h7pe6Hrs2aVNKLGt9lpg8mMGv/Re
         t+uETUyZRiPcrkYnHMcG5Qw8GRo0kr9jHu5uyQKfIyPuxbD4aZmsgmQqTMaGcvqQLEUp
         D1P1GatONLcqmcWIvOuKhXlYt881mbuV2ZQVtyd6R2o/Q1PocqY+yvnpw+FktuUK3Xjd
         oquRkQiTlCxa9zQPZuFPu9V/DTpji3oWZL8T/XeFp0QwWztKKet8PXlFt1xBY9JZZHHc
         n/eDXo4rlmBgbDKXQ+2SSKldR+YUjK1DgTJO2TSnbTh6xxEthqTbNzbaYGUp85uVvh6U
         1tUg==
X-Received: by 10.66.161.41 with SMTP id xp9mr15053022pab.166.1371799494309;
        Fri, 21 Jun 2013 00:24:54 -0700 (PDT)
Received: from localhost.localdomain (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])
        by mx.google.com with ESMTPSA id dg3sm3724614pbc.24.2013.06.21.00.24.51
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 00:24:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228584>

From: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>

While both GUI and console Cygwin browsers do exist, anecdotal evidence
suggests most users rely on their native Windows browser.  cygstart,
which is a long-standing part of the base Cygwin installation, will
cause the page to be opened in the default Windows browser (the one
registered to open .html files).

Signed-off-by: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
---
 Documentation/git-web--browse.txt | 1 +
 git-web--browse.sh                | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index ba79cb4..5aec4ec 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -34,6 +34,7 @@ The following browsers (or commands) are currently supported:
 * dillo
 * open (this is the default under Mac OS X GUI)
 * start (this is the default under MinGW)
+* cygstart (this is the default under Cygwin)
 
 Custom commands may also be specified.
 
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 9f44679..9fc1dba 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -33,7 +33,8 @@ valid_tool() {
 	case "$1" in
 	firefox | iceweasel | seamonkey | iceape | \
 	chrome | google-chrome | chromium | chromium-browser |\
-	konqueror | opera | w3m | elinks | links | lynx | dillo | open | start)
+	konqueror | opera | w3m | elinks | links | lynx | dillo | open |\
+	start | cygstart)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
@@ -127,6 +128,10 @@ if test -z "$browser" ; then
 	if test -x /bin/start; then
 		browser_candidates="start $browser_candidates"
 	fi
+	# /usr/bin/cygstart indicates Cygwin
+	if test -x /usr/bin/cygstart; then
+		browser_candidates="cygstart $browser_candidates"
+	fi
 
 	for i in $browser_candidates; do
 		init_browser_path $i
@@ -174,7 +179,7 @@ konqueror)
 		;;
 	esac
 	;;
-w3m|elinks|links|lynx|open)
+w3m|elinks|links|lynx|open|cygstart)
 	"$browser_path" "$@"
 	;;
 start)
-- 
1.8.3
