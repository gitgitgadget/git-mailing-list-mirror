From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix quick-install-doc
Date: Sat, 4 Aug 2007 22:32:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708042229130.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
 <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site>
 <46B4BDCF.9060809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 23:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRFD-0000wK-Bi
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 23:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762478AbXHDVdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762429AbXHDVdD
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 17:33:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:44857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761741AbXHDVdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 17:33:01 -0400
Received: (qmail invoked by alias); 04 Aug 2007 21:32:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 04 Aug 2007 23:32:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1938WotJk53eaXTpnxF0tGXZg/NWufUovxhsrBhZs
	+OeWReqTL07JL9
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4BDCF.9060809@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54909>


The recent work-tree cleanups exposed that the install-doc-quick
script was relying on a strange behaviour predating the work-tree
series: when setting a GIT_DIR, it was assumed that the current
working directory is the root of the working tree.

The recent work-tree series changed that behaviour: now that you can
set the work tree explicitely, the work tree root defaults to
$GIT_DIR/.. if $GIT_DIR has a /.git suffix when that is a parent
directory of the current working directory.

Noticed by Mark Levedahl. Diagnosed by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Junio, I did it slightly differently from what I said on IRC: 
	setting the work-tree with "--work-tree" does not work as 
	expected.  Will fix.

 Documentation/install-doc-quick.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index e6601bd..5c8b604 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -19,7 +19,7 @@ GIT_INDEX_FILE=`pwd`/.quick-doc.index
 export GIT_INDEX_FILE
 rm -f "$GIT_INDEX_FILE"
 git read-tree $head
-git checkout-index -a -f --prefix="$mandir"/
+(cd "$mandir"; git checkout-index -a -f)
 
 if test -n "$GZ"; then
 	cd "$mandir"
-- 
1.5.3.rc4.1.g7805
