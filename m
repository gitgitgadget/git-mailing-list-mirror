From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Make t8001-annotate and t8002-blame more portable
Date: Sun, 18 Jun 2006 22:33:21 +0200
Message-ID: <20060618203321.G2e8b0080@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 18 22:33:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs3xo-0000lI-OT
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWFRUd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFRUd3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 16:33:29 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:47758 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751222AbWFRUd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 16:33:29 -0400
Received: from leonov.stosberg.net (p213.54.84.10.tisdip.tiscali.de [213.54.84.10])
	by ncs.stosberg.net (Postfix) with ESMTP id 1986CAEBA00A
	for <git@vger.kernel.org>; Sun, 18 Jun 2006 22:33:15 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 974DF10CDC5; Sun, 18 Jun 2006 22:33:21 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Sun, 18 Jun 2006 21:49:47 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22100>

These two tests assume that "sed" will not modify the final line of a
stream if it does not end with a newline character.  The assumption is
not true at least for FreeBSD and Solaris 9.  FreeBSD's "sed" appends
a newline character; "sed" in Solaris 9 even removes the incomplete
final line.  This patch makes the test use perl instead.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 t/annotate-tests.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 114938c..71d0f30 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -111,9 +111,7 @@ test_expect_success \
 
 test_expect_success \
     'some edit' \
-    'mv file file1 &&
-     sed -e 1d -e "5s/3A/99/" file1 >file &&
-     rm -f file1 &&
+    'perl -pi -e "s/^1A.*\n$//; s/^3A/99/" file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
 test_expect_success \
-- 
1.4.0
