From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Skip nonmatching lines in difftree output, consistently
Date: Sun,  6 Aug 2006 17:59:52 +0200
Message-ID: <11548799921728-git-send-email-jnareb@gmail.com>
References: <20060806155505.GA9548@moooo.ath.cx>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 06 18:00:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9l30-00057b-Gd
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 18:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWHFP76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 11:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHFP76
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 11:59:58 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:26778 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932571AbWHFP75 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 11:59:57 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k76FwweE007098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Aug 2006 17:58:58 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k76FxqkC021530;
	Sun, 6 Aug 2006 17:59:52 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k76FxqqF021529;
	Sun, 6 Aug 2006 17:59:52 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <20060806155505.GA9548@moooo.ath.cx>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24982>

This fixes error for commitdiff on root commit (without parents).

Noticed-by: Matthias Lederhofer (matled)
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bbea21a..78ef13d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,7 +1983,7 @@ sub git_commit {
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
 		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M      rev-tree.c'
-		if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
+		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
 			next;
 		}
 		my $from_mode = $1;
@@ -2156,7 +2156,9 @@ sub git_commitdiff {
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
 		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M      rev-tree.c'
-		$line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/;
+		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/) {
+			next;
+		}
 		my $from_mode = $1;
 		my $to_mode = $2;
 		my $from_id = $3;
@@ -2230,7 +2232,9 @@ sub git_commitdiff_plain {
 	print "---\n\n";
 
 	foreach my $line (@difftree) {
-		$line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/;
+		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/) {
+			next;
+		}
 		my $from_id = $3;
 		my $to_id = $4;
 		my $status = $5;
-- 
1.4.1.1
