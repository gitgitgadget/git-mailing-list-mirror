From: John Goerzen <jgoerzen@complete.org>
Subject: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat,  8 Mar 2008 14:01:10 -0600
Message-ID: <1205006470-18882-1-git-send-email-jgoerzen@complete.org>
Cc: normalperson@yhbt.net, John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 21:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5FN-0000Bt-9Z
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYCHUBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYCHUBS
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:01:18 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:42301 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYCHUBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:01:18 -0500
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JY5EI-0006Gm-2U; Sat, 08 Mar 2008 14:01:16 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JY5EE-000846-Bz; Sat, 08 Mar 2008 14:01:10 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JY5EE-0004uu-4z; Sat, 08 Mar 2008 14:01:10 -0600
X-Mailer: git-send-email 1.5.4.2
X-Spam-Status: No (score 0.1): AWL=0.087
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sat, 08 Mar 2008 14:01:16 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76576>

Problem described here:

http://thread.gmane.org/gmane.comp.version-control.git/76561

Signed-off-by: John Goerzen <jgoerzen@complete.org>
---
 git-svn.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9e2faf9..1195569 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1540,9 +1540,14 @@ sub find_by_url { # repos_root and, path are optional
 			                    $remotes->{$repo_id}->{$_});
 		}
 		my $p = $path;
+		my $rwr = rewrite_root({repo_id => $repo_id});
 		unless (defined $p) {
 			$p = $full_url;
-			$p =~ s#^\Q$u\E(?:/|$)## or next;
+			my $z = $u;
+			if ($rwr) {
+				$z = $rwr;
+			}
+			$p =~ s#^\Q$z\E(?:/|$)## or next;
 		}
 		foreach my $f (keys %$fetch) {
 			next if $f ne $p;
-- 
1.5.4.2

