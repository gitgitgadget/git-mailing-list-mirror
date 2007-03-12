From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/7] Fix t5510-fetch's use of sed
Date: Mon, 12 Mar 2007 18:59:16 -0400
Message-ID: <20070312225916.GA16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 23:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtUC-0005cA-EL
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 23:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXCLW7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 18:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbXCLW7V
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 18:59:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58200 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbXCLW7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 18:59:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtTw-0004N9-MJ; Mon, 12 Mar 2007 18:59:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C30A20FBAE; Mon, 12 Mar 2007 18:59:17 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42086>

POSIX says sed may add a trailing LF if there isn't already
one there.  We shouldn't rely on it not adding that LF, as
some systems (Mac OS X for example) will add it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5510-fetch.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ee3f397..426017e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -134,7 +134,13 @@ test_expect_success 'bundle does not prerequisite objects' '
 	git add file2 &&
 	git commit -m add.file2 file2 &&
 	git bundle create bundle3 -1 HEAD &&
-	sed "1,4d" < bundle3 > bundle.pack &&
+	(
+		while read x && test -n "$x"
+		do
+			:;
+		done
+		cat
+	) <bundle3 >bundle.pack &&
 	git index-pack bundle.pack &&
 	test 4 = $(git verify-pack -v bundle.pack | wc -l)
 '
-- 
1.5.0.3.985.gcf0b4
