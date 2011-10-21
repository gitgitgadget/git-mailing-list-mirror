From: Julien Muchembled <jm@jmuchemb.eu>
Subject: [PATCH] gitweb: fix regression when filtering out forks
Date: Fri, 21 Oct 2011 21:04:21 +0200
Message-ID: <1319223861-10803-1-git-send-email-jm@jmuchemb.eu>
Cc: Julien Muchembled <jm@jmuchemb.eu>
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 21:12:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKWF-0000bD-7G
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab1JUTMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 15:12:30 -0400
Received: from ble59-2-81-56-123-40.fbx.proxad.net ([81.56.123.40]:57331 "EHLO
	jmuchemb.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751660Ab1JUTM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:12:29 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Oct 2011 15:12:29 EDT
Received: from laptop (tecra [10.236.3.1])
	by jmuchemb.eu (Postfix) with SMTP id 3D88DC007A1;
	Fri, 21 Oct 2011 21:05:40 +0200 (CEST)
Received: by laptop (sSMTP sendmail emulation); Fri, 21 Oct 2011 21:05:39 +0200
X-Mailer: git-send-email 1.7.7.731.g3af63.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184078>

This fixes a condition in filter_forks_from_projects_list that failed if
process directory was different from project root: in such case, the subroutine
was a no-op and forks were not detected.

Signed-off-by: Julien Muchembled <jm@jmuchemb.eu>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 70a576a..206e2a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2875,7 +2875,7 @@ sub filter_forks_from_projects_list {
 		$path =~ s/\.git$//;      # forks of 'repo.git' are in 'repo/' directory
 		next if ($path =~ m!/$!); # skip non-bare repositories, e.g. 'repo/.git'
 		next unless ($path);      # skip '.git' repository: tests, git-instaweb
-		next unless (-d $path);   # containing directory exists
+		next unless (-d "$projectroot/$path"); # containing directory exists
 		$pr->{'forks'} = [];      # there can be 0 or more forks of project
 
 		# add to trie
-- 
1.7.7.731.g3af63.dirty
