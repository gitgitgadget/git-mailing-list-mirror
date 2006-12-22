From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 4/4] gitweb: optimize git_summary.
Date: Fri, 22 Dec 2006 19:38:15 +0000
Message-ID: <11668162972414-git-send-email-robfitz@273k.net>
References: 200612191214.58474.jnareb@gmail.com <11668162952375-git-send-email-robfitz@273k.net> <11668162961084-git-send-email-robfitz@273k.net> <11668162963671-git-send-email-robfitz@273k.net> <11668162963240-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Fri Dec 22 20:39:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqEY-0003L4-82
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWLVTjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbWLVTjC
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:39:02 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:35573 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbWLVTjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:39:00 -0500
Received: from [194.125.117.173] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxqDH-0005n4-UN; Fri, 22 Dec 2006 19:37:52 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.g8aca-dirty
In-Reply-To: <11668162963240-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35200>

We don't need to call git_get_head_hash at all just pass in "HEAD" and
use the return id field.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d2ddac8..b0e6fdf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2911,9 +2911,9 @@ sub git_project_index {
 
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
-	my $head = git_get_head_hash($project);
-	my %co = parse_commit($head);
+	my %co = parse_commit("HEAD");
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
+	my $head = $co{'id'};
 
 	my $owner = git_get_project_owner($project);
 
@@ -2960,7 +2960,7 @@ sub git_summary {
 	# we need to request one more than 16 (0..15) to check if
 	# those 16 are all
 	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		git_get_head_hash($project), "--"
+		$head, "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
-- 
1.4.4.3.gc902c
