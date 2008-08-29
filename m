From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] git-svn: match SVN 1.5 behaviour of info' on unknown item
Date: Fri, 29 Aug 2008 15:42:48 +0200
Message-ID: <1220017369-32637-2-git-send-email-trast@student.ethz.ch>
References: <20080829081654.GA6680@yp-box.dyndns.org>
 <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 15:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ4Gg-0001z5-8m
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 15:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbYH2Nm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 09:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYH2Nm4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 09:42:56 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37232 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855AbYH2Nmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 09:42:54 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:52 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:52 +0200
X-Mailer: git-send-email 1.6.0.1.98.g76a24
In-Reply-To: <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Aug 2008 13:42:52.0304 (UTC) FILETIME=[22343900:01C909DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously 'git svn info unknown-file' only announced its failure (in
the SVN 1.4 style, "not a versioned resource"), and exited
successfully.

It is desirable to actually exit with failure, so change the code to
exit(1) under this condition.  Since that is already halfway SVN 1.5
compatibility, also change the error output to match 1.5.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 11ff813..bc181e0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -832,8 +832,8 @@ sub cmd_info {
 	my ($file_type, $diff_status) = find_file_type_and_diff_status($path);
 
 	if (!$file_type && !$diff_status) {
-		print STDERR "$path:  (Not a versioned resource)\n\n";
-		return;
+		print STDERR "svn: '$path' is not under version control\n";
+		exit 1;
 	}
 
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
-- 
1.6.0.1.98.g76a24
