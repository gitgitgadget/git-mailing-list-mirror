From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: cleanup: factor out longest_common_path() function
Date: Wed, 13 Jun 2007 02:37:03 -0700
Message-ID: <11817274261148-git-send-email-normalperson@yhbt.net>
References: <11817274254011-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyPIB-0001YO-CK
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923AbXFMJhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbXFMJhK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:37:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49928 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637AbXFMJhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:37:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E32317DC0A5;
	Wed, 13 Jun 2007 02:37:06 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 02:37:06 -0700
X-Mailer: git-send-email 1.5.2.1.243.gbe00
In-Reply-To: <11817274254011-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50038>

I hadn't looked at this code in a while and had to read this
again to figure out what it did.  To avoid having to do this
again in the future, I just gave gave the hunk a descriptive
name.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e350061..58f7dd0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3072,11 +3072,8 @@ sub gs_do_switch {
 	$editor->{git_commit_ok};
 }
 
-sub gs_fetch_loop_common {
-	my ($self, $base, $head, $gsv, $globs) = @_;
-	return if ($base > $head);
-	my $inc = $_log_window_size;
-	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
+sub longest_common_path {
+	my ($gsv, $globs) = @_;
 	my %common;
 	my $common_max = scalar @$gsv;
 
@@ -3108,6 +3105,15 @@ sub gs_fetch_loop_common {
 			last;
 		}
 	}
+	$longest_path;
+}
+
+sub gs_fetch_loop_common {
+	my ($self, $base, $head, $gsv, $globs) = @_;
+	return if ($base > $head);
+	my $inc = $_log_window_size;
+	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
+	my $longest_path = longest_common_path($gsv, $globs);
 	while (1) {
 		my %revs;
 		my $err;
-- 
1.5.2.1.243.gbe00
