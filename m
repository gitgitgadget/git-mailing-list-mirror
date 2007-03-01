From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/4] Documentation/build-docdep.perl: Fix dependencies for included asciidoc files
Date: Thu,  1 Mar 2007 22:41:14 +0300
Message-ID: <1172778077659-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMrAD-0004LH-Me
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965533AbXCATmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965538AbXCATmD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:42:03 -0500
Received: from master.altlinux.org ([62.118.250.235]:3396 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965533AbXCATmB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:42:01 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id D9D4FE4100; Thu,  1 Mar 2007 22:41:59 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.2.285.g5347
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41119>

Adding dependencies on included files to the generated man pages is
wrong - includes are processed by asciidoc, therefore the intermediate
Docbook XML files really depend on included files.  Because of these
wrong dependencies the man pages were not rebuilt properly if the
intermediate XML files were left in the tree.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/build-docdep.perl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.perl
index 489389c..ba4205e 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -41,10 +41,6 @@ while ($changed) {
 while (my ($text, $included) = each %include) {
     if (! exists $included{$text} &&
 	(my $base = $text) =~ s/\.txt$//) {
-	my ($suffix) = '1';
-	if ($base eq 'git') {
-	    $suffix = '7'; # yuck...
-	}
-	print "$base.html $base.$suffix : ", join(" ", keys %$included), "\n";
+	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
     }
 }
-- 
1.5.0.2.285.g5347
