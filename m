From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH updated] git-help--browse: improve browser support under OS X
Date: Thu, 14 Feb 2008 03:36:14 -0500
Message-ID: <1202978174-77648-1-git-send-email-jaysoffian@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 14 09:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPZae-0001bQ-ED
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 09:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbYBNIgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 03:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYBNIgW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 03:36:22 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:40998 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYBNIgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 03:36:21 -0500
Received: by an-out-0708.google.com with SMTP id d31so55863and.103
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 00:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jmfOnQTEYH/g6jzKvLjsDLnw23B5w35VS1leahpLlcg=;
        b=jZJt5f3XSA/+prXwAdbUfSduepWno2HRXehcfvvJUqSYOGXpQrmMRJLaQF7HciIo46jq2MLD3pReG/WNkXwhz9Wo4mBKU0Dcb74AcZXNzInF7ZdQSjy9mN0eo0j2pK2idO1yaHndwvUkxgRmXxkQhR6rHznGiOZ4PxSl81Ujqkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WKXGwQZ54WAsvJTVJNaNdSFg7+VWY9Xpt0ed979EcvpMlLquWYF7LRN5mzADZAcu1ejw0NmuJeFy9PYHh5SGoay1CR8neyB5Aev7nBbdZD8+VVnlYf92Wmfm5HghO2Y7eNmrf9btF9CM3oLvdiq1gpxEVlUDCV4b5RRe8pemla0=
Received: by 10.100.125.12 with SMTP id x12mr1105613anc.84.1202978178103;
        Thu, 14 Feb 2008 00:36:18 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c13sm4547856anc.20.2008.02.14.00.36.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 00:36:17 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73865>

/usr/bin/open <document> is used under OS X to open a document as if the
user had double-clicked on the file's icon (i.e. HTML files are opened
w/the user's default browser).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Acked-by: Christian Couder <chriscool@tuxfamily.org>
---
This is the original patch, but based off master (help--browse instead
of web--browse) per jh. I also added the comment about SECURITYSESSIONID
environment variable per cc.

 git-help--browse.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-help--browse.sh b/git-help--browse.sh
index 10b0a36..84e37ef 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -30,7 +30,7 @@ test -f "$html_dir/git.html" || die "No documentation directory found."
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo)
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open)
 			;; # happy
 		*)
 			return 1
@@ -94,6 +94,10 @@ if test -z "$browser" ; then
     else
 	browser_candidates="w3m links lynx"
     fi
+    # SECURITYSESSIONID indicates an OS X GUI login session
+    if test -n "$SECURITYSESSIONID"; then
+	browser_candidates="open $browser_candidates"
+    fi
 
     for i in $browser_candidates; do
 	init_browser_path $i
@@ -140,7 +144,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx)
+    w3m|links|lynx|open)
 	eval "$browser_path" $pages
 	;;
     dillo)
-- 
1.5.4.1.1281.g75df
