From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 3/7] cvsserver: Do not include status output for subdirectories if -l is passed
Date: Mon, 24 Mar 2008 23:49:22 +0100
Message-ID: <acabbce71725396ac8641b59197525fdfd8e8ae9.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvUV-0002YB-IE
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbYCXWtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYCXWtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:49:25 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:55821 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753145AbYCXWtY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:49:24 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 348401E4F79;
	Mon, 24 Mar 2008 23:49:23 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 10492ABE89;
	Mon, 24 Mar 2008 23:49:23 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id A07BD8C465;
	Mon, 24 Mar 2008 23:49:22 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: acabbce71725396ac8641b59197525fdfd8e8ae9 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78117>


This effectively implements the -l switch by pruning the entries whose
filenames contain a path separator.  It was previously ignored.

Without this, TkCVS includes strange "ghost" entries in its directory
listings.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9101eef..073a426 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1423,6 +1423,8 @@ sub req_status
     {
         $filename = filecleanup($filename);
 
+        next if exists($state->{opt}{l}) && index($filename, '/', length($state->{prependdir})) >= 0;
+
         my $meta = $updater->getmeta($filename);
         my $oldmeta = $meta;
 
-- 
1.5.5.rc1.6.gd183
