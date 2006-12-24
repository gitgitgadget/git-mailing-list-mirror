From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 8/8] gitweb: Use rev-list --skip option.
Date: Sun, 24 Dec 2006 14:31:49 +0000
Message-ID: <11669707123843-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <11669707102678-git-send-email-robfitz@273k.net> <11669707101872-git-send-email-robfitz@273k.net> <116697071140-git-send-email-robfitz@273k.net> <1166970711394-git-send-email-robfitz@273k.net> <11669707111273-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:32:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUOP-0005W6-GZ
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWLXOb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLXOb5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:57 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32894 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbWLXObz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:55 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNt-0002v4-Bx; Sun, 24 Dec 2006 14:31:29 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <11669707111273-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=1, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35363>


Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f9994d9..65fcdb0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1391,35 +1391,13 @@ sub parse_commits {
 	$maxcount ||= 1;
 	$skip ||= 0;
 
-	# Delete once rev-list supports the --skip option
-	if ($skip > 0) {
-		open my $fd, "-|", git_cmd(), "rev-list",
-			($arg ? ($arg) : ()),
-			("--max-count=" . ($maxcount + $skip)),
-			$commit_id,
-			"--",
-			($filename ? ($filename) : ())
-			or die_error(undef, "Open git-rev-list failed");
-		while (my $line = <$fd>) {
-			if ($skip-- <= 0) {
-				chomp $line;
-				my %co = parse_commit($line);
-				push @cos, \%co;
-			}
-		}
-		close $fd;
-
-		return wantarray ? @cos : \@cos;
-	}
-
 	local $/ = "\0";
 
 	open my $fd, "-|", git_cmd(), "rev-list",
 		"--header",
 		($arg ? ($arg) : ()),
 		("--max-count=" . $maxcount),
-		# Add once rev-list supports the --skip option
-		# ("--skip=" . $skip),
+		("--skip=" . $skip),
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
-- 
1.4.4.3.ge655-dirty
