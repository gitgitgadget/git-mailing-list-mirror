From: jaysoffian+git@gmail.com
Subject: [PATCH] Improve git-help--browse browser support under OS X
Date: Fri,  8 Feb 2008 16:23:14 -0500
Message-ID: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 22:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNahQ-0004kI-8S
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbYBHVXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYBHVXY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:23:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:23969 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbYBHVXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:23:22 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1138931nfb.21
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        bh=z6xDSthBcvGgGxzwINkfG++T2ENZukCBuM2QXrvbpwo=;
        b=nzg4JmjUFlbwA+QQrics3jympnNgfdQTXEvUk/xvgn75Rc9DHvJ35yPdrdAPeGB53P7xphjJTC0H2LedajDARbWmLOSudCuiQYxMsrnAVFV6+tDo/92eaL6sTuA/tHq1JoW5K53yaypPDFMGtwqw86PUBnS3KlL4KxEFl2ys0wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=Z8kTx94Avc9iopDGCTC/8FvHroHLRFwji/yi0/Mj9USv7AlGEgcsK99H1RbzvLynkpu4Y4Z4wKzjTEb/3CnekVYClJoIfm3KEALFiXJTV82PYoVT1yGIMHKrYm6FMmo0x2cXllV02bc9ueKY0VGoUEagam5yHgAZlRJpy2PwVyk=
Received: by 10.78.138.14 with SMTP id l14mr23771892hud.57.1202505801013;
        Fri, 08 Feb 2008 13:23:21 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id 23sm3142384hud.3.2008.02.08.13.23.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 13:23:20 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1221.g7a7a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73149>

/usr/bin/open <document> is used under OS X to open a document just as if the
user had double-clicked on the file's icon. In other words, this will open HTML
files with the user's default browser. Note however that whether the document
opens in a new window, or in a new tab depends upon the browser configuration.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-web--browse.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 8ed489d..938293a 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -25,7 +25,7 @@ NONGIT_OK=Yes
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo)
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open)
 			;; # happy
 		*)
 			return 1
@@ -104,6 +104,9 @@ if test -z "$browser" ; then
     else
 	browser_candidates="w3m links lynx"
     fi
+    if test -n "$SECURITYSESSIONID"; then
+	browser_candidates="open $browser_candidates"
+    fi
 
     for i in $browser_candidates; do
 	init_browser_path $i
@@ -147,7 +150,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx)
+    w3m|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
     dillo)
-- 
1.5.4.1221.g7a7a1
