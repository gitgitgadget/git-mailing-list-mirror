From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: handle array values correctly
Date: Mon, 03 Apr 2006 17:41:44 -0700
Message-ID: <11441113044087-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 04 02:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQZd6-0004Vn-GX
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 02:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWDDAmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 20:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWDDAmb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 20:42:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7406 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964883AbWDDAma (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 20:42:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D55FE2DC01A;
	Mon,  3 Apr 2006 17:42:29 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.0.rc1.gd3ce-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18364>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

0511c05c013dc4e6d17832fad043847c35a30c6d
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index e7fff46..7c44450 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -75,12 +75,11 @@ foreach my $o (keys %opts) {
 	my $arg = 'git-repo-config';
 	$arg .= ' --int' if ($o =~ /=i$/);
 	$arg .= ' --bool' if ($o !~ /=[sfi]$/);
-	$arg .= " svn.$key"; # $key only matches [a-z\-], always shell-safe
 	if (ref $v eq 'ARRAY') {
-		chomp(my @tmp = `$arg`);
+		chomp(my @tmp = `$arg --get-all svn.$key`);
 		@$v = @tmp if @tmp;
 	} else {
-		chomp(my $tmp = `$arg`);
+		chomp(my $tmp = `$arg --get svn.$key`);
 		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
 			$$v = $tmp;
 		}
-- 
1.3.0.rc1.gd3ce-dirty
