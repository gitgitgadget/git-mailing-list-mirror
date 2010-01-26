From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-cvsserver: allow regex metacharacters in CVSROOT
Date: Tue, 26 Jan 2010 14:47:16 +0000
Message-ID: <20100126144716.15009.qmail@2f965a5eeec988.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 15:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZmnx-0001OQ-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 15:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab0AZOyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494Ab0AZOyE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 09:54:04 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:3946 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753190Ab0AZOyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 09:54:04 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2010 09:54:03 EST
Received: (qmail 15010 invoked by uid 1000); 26 Jan 2010 14:47:16 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138038>

When run in a repository with a path name containing regex metacharacters
(e.g. +), git-cvsserver failed to split the client request into CVSROOT
and module.  Now metacharacters are disabled for the value of CVSROOT in
the perl regex so that directory names containing metacharacters are
handled properly.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2804106..13751db 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -408,7 +408,7 @@ sub req_Directory
     $state->{localdir} = $data;
     $state->{repository} = $repository;
     $state->{path} = $repository;
-    $state->{path} =~ s/^$state->{CVSROOT}\///;
+    $state->{path} =~ s/^\Q$state->{CVSROOT}\E\///;
     $state->{module} = $1 if ($state->{path} =~ s/^(.*?)(\/|$)//);
     $state->{path} .= "/" if ( $state->{path} =~ /\S/ );
 
-- 
1.6.6
