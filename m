From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 1/2] git-svn: fix regex to remove "tail" from svn tags
Date: Sun, 15 Aug 2010 06:15:54 -0700
Message-ID: <1281878155-61937-1-git-send-email-ddkilzer@kilzer.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 18:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okfy8-0000sf-Ju
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 18:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438Ab0HOQVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 12:21:51 -0400
Received: from mail-out.apple.com ([17.254.13.22]:55887 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab0HOQVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 12:21:51 -0400
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out3.apple.com (Postfix) with ESMTP id 070B9A33B2D4;
	Sun, 15 Aug 2010 06:16:02 -0700 (PDT)
X-AuditID: 11807136-b7cc9ae000004162-38-4c67e8919d2a
Received: from pwmerge.apple.com (pwmerge.apple.com [17.202.36.35])
	by relay15.apple.com (Apple SCV relay) with SMTP id 18.63.16738.198E76C4; Sun, 15 Aug 2010 06:16:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.49.g98551
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153609>

Fix a regular expression used to remove the revision from the
end of an svn tag or branch name.  The regex did not account for
any "tail" (dashes) that may have been added to the end of the
tag name (which first appeared in v1.4.1-rc2~11).  If not fixed,
tags with names like "tags/mytag@5--@2" may be created.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 34884b8..39bcb45 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2959,7 +2959,7 @@ sub other_gs {
 	my $gs = Git::SVN->find_by_url($new_url, $url, $branch_from);
 	unless ($gs) {
 		my $ref_id = $old_ref_id;
-		$ref_id =~ s/\@\d+$//;
+		$ref_id =~ s/\@\d+-*$//;
 		$ref_id .= "\@$r";
 		# just grow a tail if we're not unique enough :x
 		$ref_id .= '-' while find_ref($ref_id);
-- 
1.7.2.1.49.g98551
