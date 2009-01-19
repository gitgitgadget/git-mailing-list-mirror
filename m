From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: [PATCH] git-svn: Show UUID in svn info for added directories with svn 1.5.5
Date: Mon, 19 Jan 2009 03:02:01 +0100
Message-ID: <1232330521-50197-1-git-send-email-git-dev@marzelpan.de>
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 03:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjUP-0005Ks-Py
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbZASCCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbZASCCG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:02:06 -0500
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:58811 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbZASCCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:02:05 -0500
Received: from [80.145.229.139] (helo=localhost.localdomain)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1LOjSl-0004kw-45; Mon, 19 Jan 2009 03:02:03 +0100
X-Mailer: git-send-email 1.6.1.142.g76f25
X-Df-Sender: 893553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106301>

In svn 1.5.5 the output of "svn info" for added directories was changed
and now shows the repository UUID. This patch implements the same
behavior for "git svn info" and makes t9119-git-svn-info.17 pass if
svn 1.5.5 is used.

Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ad01e18..2f16a4e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -911,7 +911,8 @@ sub cmd_info {
 	if ($@) {
 		$result .= "Repository Root: (offline)\n";
 	}
-	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A";
+	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A" &&
+		($SVN::Core::VERSION le '1.5.4' || $file_type ne "dir");
 	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
 
 	$result .= "Node Kind: " .
-- 
1.6.1.142.g76f25
