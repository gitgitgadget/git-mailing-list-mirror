Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 24385 invoked by uid 111); 24 Sep 2008 22:06:30 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 18:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbYIXWGI (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYIXWGH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:06:07 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49214 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755181AbYIXWGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:06:06 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 32C732AC8FA; Thu, 25 Sep 2008 00:05:53 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org
Subject: [PATCH] git-gui: Add Explore Working Copy to the Repository menu
Date:	Thu, 25 Sep 2008 00:05:53 +0200
Message-Id: <1222293953-14320-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Especially when cloning is finished, the Git GUI window pops up,
but there is not really much one can do within it - there needs to be
a way to easily start exploring and working with the new working copy
using the standard system interface: explorer.exe on Windows, open on
MacOS/X and xdg-open as a fallback (all modern Linux desktops).

This might be also a post-clone option instead (possibly opening the window
automagically) but I believe that this might be useful also in other
situations, e.g. you don't have to keep the working copy window around
if you work in multiple repositories.

This operation will not make sense on bare repositories.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 10d8a44..a64d34d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1750,6 +1750,19 @@ proc do_gitk {revs} {
 	}
 }
 
+proc do_explore {} {
+	set explorer {}
+	if {[is_Cygwin] || [is_Windows]} {
+		set explorer "explorer.exe"
+	} elseif {[is_MacOSX]} {
+		set explorer "open"
+	} else {
+		# freedesktop.org-conforming system is our best shot
+		set explorer "xdg-open"
+	}
+	eval exec $explorer [file dirname [gitdir]] &
+}
+
 set is_quitting 0
 
 proc do_quit {} {
@@ -2089,6 +2102,11 @@ if {[is_enabled transport]} {
 menu .mbar.repository
 
 .mbar.repository add command \
+	-label [mc "Explore Working Copy"] \
+	-command {do_explore}
+.mbar.repository add separator
+
+.mbar.repository add command \
 	-label [mc "Browse Current Branch's Files"] \
 	-command {browser::new $current_branch}
 set ui_browse_current [.mbar.repository index last]
-- 
tg: (c427559..) t/git-gui/explore (depends on: vanilla/master)
