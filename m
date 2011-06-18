From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] git-svn: Disambiguate rev-list arguments to improve error message
Date: Sat, 18 Jun 2011 08:47:59 +0200
Message-ID: <1308379680-17188-3-git-send-email-mhagger@alum.mit.edu>
References: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, bert.wesarg@googlemail.com,
	normalperson@yhbt.net, git@drmicha.warpmail.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 08:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXpLN-0001oz-2q
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 08:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab1FRGtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 02:49:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37971 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1FRGtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 02:49:10 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BE9EF0.dip.t-dialin.net [84.190.158.240])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5I6mO8i000405;
	Sat, 18 Jun 2011 08:49:02 +0200
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175966>

Add "--" in the "git rev-list" command line so that if there is a bug
and the revisions cannot be found, the error message is a bit less
cryptic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index da3fea8..2cc9242 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3141,9 +3141,9 @@ sub check_cherry_pick {
 	my $parents = shift;
 	my @ranges = @_;
 	my %commits = map { $_ => 1 }
-		_rev_list("--no-merges", $tip, "--not", $base, @$parents);
+		_rev_list("--no-merges", $tip, "--not", $base, @$parents, "--");
 	for my $range ( @ranges ) {
-		delete @commits{_rev_list($range)};
+		delete @commits{_rev_list($range, "--")};
 	}
 	for my $commit (keys %commits) {
 		if (has_no_changes($commit)) {
-- 
1.7.5.4
