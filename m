From: jaysoffian+git@gmail.com
Subject: [PATCH] git-web--browse: improve browser support under OS X
Date: Sun, 10 Feb 2008 21:24:24 -0500
Message-ID: <1202696664-1565-1-git-send-email-jaysoffian+git@gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 03:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOLx-0002FL-Hd
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbYBKCY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbYBKCY3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:24:29 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:50298 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYBKCY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:24:28 -0500
Received: by an-out-0708.google.com with SMTP id d31so1102422and.103
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:sender;
        bh=ScuRh2MN2yn8vK7D4+IowDzpiWXwEA35fWfbK9aGF4U=;
        b=soEM8rF74BT1W62Y1KBk0736N63Eg7P48aLJlAfgnIj2H+gmsMjaCziZdtaUaHpRgtmWcxRb3cCSbDbi5zpt8opvSNhEjjMKJk3a7ZEAZKdYeSFcvdUNJvFOzL4TyAxqxofJ1uY6g2gi7YA7FpprFLALRqvi6UikTd0ti65rYww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:sender;
        b=tnopXBuU0UTZleK1fIK5dERB1HEmY7Fhg8KhNHV81vmnOBIyHDiVui7vyM5x17qwlycGZ5FBVmjj2M3ni4d7/+2vm6cMH8YDjniYTyahj6fffflvX4i1Egd4JYIFsp1rUZ7G7dsrmfalqQBmeh2Pcu0DxsRn6ujHkPX5LF8RE3M=
Received: by 10.100.252.16 with SMTP id z16mr33262287anh.36.1202696667409;
        Sun, 10 Feb 2008 18:24:27 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c37sm36486386ana.9.2008.02.10.18.24.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 18:24:26 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1221.gf32f1
In-Reply-To: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73457>

From: Jay Soffian <jaysoffian@gmail.com>

/usr/bin/open <document> is used under OS X to open a document as if the
user had double-clicked on the file's icon (i.e. HTML files are opened
w/the user's default browser).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-help.txt |    1 +
 git-web--browse.sh         |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ad41aab..897868a 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -68,6 +68,7 @@ The following browsers are currently supported by 'git-web--browse':
 * links
 * lynx
 * dillo
+* open (OS X only, where it is the default)
 
 CONFIGURATION VARIABLES
 -----------------------
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 8ed489d..1927c3b 100755
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
+    if test "$(uname)" = "Darwin" && test -n "$SECURITYSESSIONID"; then
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
1.5.4.1221.gf32f1
