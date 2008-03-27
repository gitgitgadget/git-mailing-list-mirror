From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 1/7] cvsserver: Respond to the 'editors' and 'watchers' commands
Date: Thu, 27 Mar 2008 23:17:26 +0100
Message-ID: <ade0303c6104ad25bc4d846af2417a994cf9cf46.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0QH-0005l9-En
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759553AbYC0WRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759479AbYC0WRa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:17:30 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:59258 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759409AbYC0WR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:17:29 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A34CC24B05D;
	Thu, 27 Mar 2008 23:17:27 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 8C36A10786B;
	Thu, 27 Mar 2008 23:17:27 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9F1A467E09;
	Thu, 27 Mar 2008 23:17:26 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: ade0303c6104ad25bc4d846af2417a994cf9cf46 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78370>

These commands list users editing and watching locked files.  This trivial
implementation always returns an empty response, since git-cvsserver does not
implement file locking.

Without this, TkCVS hangs at startup, waiting forever for a response.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7f632af..2fe0a8a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -73,8 +73,8 @@ my $methods = {
     'status'          => \&req_status,
     'admin'           => \&req_CATCHALL,
     'history'         => \&req_CATCHALL,
-    'watchers'        => \&req_CATCHALL,
-    'editors'         => \&req_CATCHALL,
+    'watchers'        => \&req_EMPTY,
+    'editors'         => \&req_EMPTY,
     'annotate'        => \&req_annotate,
     'Global_option'   => \&req_Globaloption,
     #'annotate'        => \&req_CATCHALL,
@@ -199,6 +199,11 @@ sub req_CATCHALL
     $log->warn("Unhandled command : req_$cmd : $data");
 }
 
+# This method invariably succeeds with an empty response.
+sub req_EMPTY
+{
+    print "ok\n";
+}
 
 # Root pathname \n
 #     Response expected: no. Tell the server which CVSROOT to use. Note that
-- 
1.5.5.rc1.19.gfe7681
