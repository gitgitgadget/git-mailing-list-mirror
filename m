From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: ignore lines from diff-tree which do not match the expected format
Date: Sun, 6 Aug 2006 17:55:05 +0200
Message-ID: <20060806155505.GA9548@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 06 17:55:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9ky9-0004Ga-Js
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 17:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHFPzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWHFPzJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 11:55:09 -0400
Received: from moooo.ath.cx ([85.116.203.178]:64441 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932094AbWHFPzH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 11:55:07 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24981>

The sha1 on the first line of git diff-tree -r --root sha1 does not
match the expected format and produces warnings.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f4b0f5..b0da0ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1772,7 +1772,9 @@ sub git_tree {
 	my $alternate = 0;
 	foreach my $line (@entries) {
 		#'100644	blob	0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+		if (!($line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/)) {
+			next;
+		}
 		my $t_mode = $1;
 		my $t_type = $2;
 		my $t_hash = $3;
@@ -2163,7 +2165,9 @@ sub git_commitdiff {
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
 		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M      rev-tree.c'
-		$line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/;
+		if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/)) {
+			next;
+		}
 		my $from_mode = $1;
 		my $to_mode = $2;
 		my $from_id = $3;
-- 
1.4.1.gfd699
