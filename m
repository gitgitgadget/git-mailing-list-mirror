From: arjen@yaph.org (Arjen Laarhoven)
Subject: [PATCH] t5300-pack-object.sh: portability issue using /usr/bin/stat
Date: Sat, 7 Apr 2007 01:49:03 +0200
Message-ID: <20070406234903.GJ3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyB4-0003Pv-4Y
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbXDFXtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933454AbXDFXtG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:49:06 -0400
Received: from regex.yaph.org ([193.202.115.201]:33934 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933455AbXDFXtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:49:05 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 728C75B7CA; Sat,  7 Apr 2007 01:49:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43945>

In the test 'compare delta flavors', /usr/bin/stat is used to get file size.
This isn't portable.  There already is a dependency on Perl, use its '-s'
operator to get the file size.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 t/t5300-pack-object.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 35e036a..a400e7a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -125,8 +125,8 @@ cd "$TRASH"
 
 test_expect_success \
     'compare delta flavors' \
-    'size_2=`stat -c "%s" test-2-${packname_2}.pack` &&
-     size_3=`stat -c "%s" test-3-${packname_3}.pack` &&
+    'size_2=`perl -e "print -s q[test-2-${packname_2}.pack]"` &&
+     size_3=`perl -e "print -s q[test-3-${packname_3}.pack]"` &&
      test $size_2 -gt $size_3'
 
 rm -fr .git2
-- 
1.5.1.rc3.29.gd8b6
