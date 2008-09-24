Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 24416 invoked by uid 111); 24 Sep 2008 22:07:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYIXWHP (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYIXWHP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:07:15 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49267 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753286AbYIXWHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:07:13 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 4769D2AC8FA; Thu, 25 Sep 2008 00:07:02 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org
Subject: [PATCH] git-gui: gui.autoexplore makes explorer to pop up automatically after picking
Date:	Thu, 25 Sep 2008 00:07:02 +0200
Message-Id: <1222294022-14632-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Especially for Windows users used to work with the Windows Explorer,
it is very useful when after picking a repository (either opening
a local one or initializing/cloning a new one) in the "intro" window,
the explorer view of the working copy pops up along the standard
Git GUI window, so that the users can, well, actually work with
the repository.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 Documentation/config.txt |    4 ++++
 git-gui/git-gui.sh       |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bea867d..4f53584 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -767,6 +767,10 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+gui.autoexplore::
+	Whether to automatically open explorer window when a repository
+	is picked within linkgit:git-gui[1]. The default value is "false".
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index a64d34d..668aa49 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -959,6 +959,7 @@ citool {
 ##
 ## repository setup
 
+set picked 0
 if {[catch {
 		set _gitdir $env(GIT_DIR)
 		set _prefix {}
@@ -970,6 +971,7 @@ if {[catch {
 	load_config 1
 	apply_config
 	choose_repository::pick
+	set picked 1
 }
 if {![file isdirectory $_gitdir] && [is_Cygwin]} {
 	catch {set _gitdir [exec cygpath --windows $_gitdir]}
@@ -3213,3 +3215,7 @@ after 1 do_rescan
 if {[is_enabled multicommit]} {
 	after 1000 hint_gc
 }
+
+if {$picked && [is_config_true gui.autoexplore]} {
+	do_explore
+}
-- 
tg: (be2e370..) t/git-gui/autoexplore (depends on: t/git-gui/explore)
