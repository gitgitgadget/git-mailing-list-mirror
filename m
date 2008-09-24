Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 24250 invoked by uid 111); 24 Sep 2008 21:52:58 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYIXVww (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYIXVww
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 17:52:52 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:64798 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751651AbYIXVwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 17:52:51 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 9D2332AC8FA; Wed, 24 Sep 2008 23:52:39 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Subject: [PATCH] git-web--browse: Support for using /bin/start on MinGW
Date:	Wed, 24 Sep 2008 23:52:39 +0200
Message-Id: <1222293159-2068-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the future, I think we should also default to xdg-open on Linux instead
of having a KDE-specific hack.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 Documentation/git-web--browse.txt |    1 +
 git-web--browse.sh                |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 7f7a45b..278cf73 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -26,6 +26,7 @@ The following browsers (or commands) are currently supported:
 * lynx
 * dillo
 * open (this is the default under Mac OS X GUI)
+* start (this is the default under MinGW)
 
 Custom commands may also be specified.
 
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 384148a..78d236b 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open)
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -114,6 +114,10 @@ if test -z "$browser" ; then
     if test -n "$SECURITYSESSIONID"; then
 	browser_candidates="open $browser_candidates"
     fi
+    # /bin/start indicates MinGW
+    if test -n /bin/start; then
+	browser_candidates="start $browser_candidates"
+    fi
 
     for i in $browser_candidates; do
 	init_browser_path $i
@@ -157,7 +161,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx|open)
+    w3m|links|lynx|open|start)
 	eval "$browser_path" "$@"
 	;;
     dillo)
-- 
tg: (c427559..) t/web--browse/mingw (depends on: vanilla/master)
