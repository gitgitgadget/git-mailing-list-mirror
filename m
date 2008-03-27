From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 2/7] cvsserver: Only print the file part of the filename in status header
Date: Thu, 27 Mar 2008 23:17:42 +0100
Message-ID: <333a7cfa26e71fe42a9b10cd4d7c1a6a5085aacd.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0QX-0005qZ-Av
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759568AbYC0WRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759306AbYC0WRp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:17:45 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:44887 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759479AbYC0WRp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:17:45 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id D01AE27B0C5;
	Thu, 27 Mar 2008 23:17:43 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id BE9702DAB35;
	Thu, 27 Mar 2008 23:17:43 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 1A60727EC4;
	Thu, 27 Mar 2008 23:17:43 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 333a7cfa26e71fe42a9b10cd4d7c1a6a5085aacd Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78371>

The "File:" header of CVS status output only includes the basename of
the file, even when generating a recursive listing; do the same.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2fe0a8a..444ec0d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1471,8 +1471,10 @@ sub req_status
 
         $status ||= "Unknown";
 
+        my ($filepart) = filenamesplit($filename);
+
         print "M ===================================================================\n";
-        print "M File: $filename\tStatus: $status\n";
+        print "M File: $filepart\tStatus: $status\n";
         if ( defined($state->{entries}{$filename}{revision}) )
         {
             print "M Working revision:\t" . $state->{entries}{$filename}{revision} . "\n";
-- 
1.5.5.rc1.19.gfe7681
