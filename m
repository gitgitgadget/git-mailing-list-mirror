From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email: Do not send editor backup files in a directory
Date: Fri, 22 Jul 2011 00:29:14 -0700
Message-ID: <865ddd502d9ba4a19c33c69039ecb70ea12c0692.1311319658.git.joe@perches.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 09:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkAAi-00043O-Nt
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 09:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab1GVH3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 03:29:15 -0400
Received: from mail.perches.com ([173.55.12.10]:4231 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab1GVH3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 03:29:15 -0400
Received: from Joe-Laptop.home (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 55B2324368
	for <git@vger.kernel.org>; Fri, 22 Jul 2011 00:29:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.131.g99019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177635>

Sift out backup files that are commonly created by editors.

Signed-off-by: Joe Perches <joe@perches.com>
---
 git-send-email.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..a4558d9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -521,7 +521,9 @@ while (defined(my $f = shift @ARGV)) {
 		opendir my $dh, $f
 			or die "Failed to opendir $f: $!";
 
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		push @files, grep { !/#.+#$/ && !/~$/ &&
+					!/\.bak$/ && !/\.orig$/ &&
+					-f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
-- 
1.7.6.131.g99019
