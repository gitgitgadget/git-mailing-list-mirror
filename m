From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/5] Add selftest for new option '--rewrite-url' to 'git config'
Date: Mon, 04 Aug 2008 01:02:07 +0200
Message-ID: <200808040102.07499.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 01:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmbc-0001Ke-T2
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbYHCXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758236AbYHCXCP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:02:15 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41720 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758725AbYHCXCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:02:14 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100E03RZPMZ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:13 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100B5QRZM5920@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:11 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CXCRZMU8QL@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:10 +0200 (CEST)
In-reply-to: <200808040057.00221.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91286>

Simple check that URL rewriting functionality works as expected.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t1300-repo-config.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 64567fb..dcd04c2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -741,4 +741,18 @@ test_expect_success 'symlinked configuration' '
 
 '
 
+test_expect_success '--rewrite-url' '
+
+	git config url.ssh://example.com/foo/.insteadOf http://example.com/ &&
+	git config url.../.insteadOf git://example.com/ &&
+	a=$(git config --rewrite-url http://example.com/baz/xyzzy.git) &&
+	test "zssh://example.com/foo/baz/xyzzy.git" = "z$a" &&
+	b=$(git config --rewrite-url git://example.com/baz/xyzzy.git) &&
+	test "z../baz/xyzzy.git" = "z$b" &&
+	c=$(git config --rewrite-url ssh://example.com/foo/baz/xyzzy.git) &&
+	test "zssh://example.com/foo/baz/xyzzy.git" = "z$c" &&
+	d=$(git config --rewrite-url rsync://example.com/baz/xyzzy.git) &&
+	test "zrsync://example.com/baz/xyzzy.git" = "z$d"
+'
+
 test_done
-- 
1.6.0.rc1.34.g0fe8c
