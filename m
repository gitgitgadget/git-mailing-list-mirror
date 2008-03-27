From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 3/7] cvsserver: Do not include status output for subdirectories if -l is passed
Date: Thu, 27 Mar 2008 23:17:53 +0100
Message-ID: <e9090852dc2f6e0f9aae5f7418b18be24374a4d9.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:18:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0Qi-0005ux-P5
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759662AbYC0WR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759573AbYC0WR4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:17:56 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:35952 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759306AbYC0WR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:17:56 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id E3B6631EA50;
	Thu, 27 Mar 2008 23:17:54 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id D17C02C6D1B;
	Thu, 27 Mar 2008 23:17:54 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3BBC027EC4;
	Thu, 27 Mar 2008 23:17:54 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: e9090852dc2f6e0f9aae5f7418b18be24374a4d9 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78372>

This effectively implements the -l switch by pruning the entries whose
filenames contain a path separator.  It was previously ignored.

Without this, TkCVS includes strange "ghost" entries in its directory
listings.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 444ec0d..89a4dac 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1428,6 +1428,8 @@ sub req_status
     {
         $filename = filecleanup($filename);
 
+        next if exists($state->{opt}{l}) && index($filename, '/', length($state->{prependdir})) >= 0;
+
         my $meta = $updater->getmeta($filename);
         my $oldmeta = $meta;
 
-- 
1.5.5.rc1.19.gfe7681
