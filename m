From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a test for deleting remote branches
Date: Tue, 13 Nov 2007 20:49:09 +0100
Message-ID: <20071113194909.GD3268@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1m6-00041A-Mq
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759696AbXKMTtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbXKMTtM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:49:12 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:27189 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbXKMTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:49:11 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo62) (RZmta 14.0)
	with ESMTP id v02256jADGsA32 ; Tue, 13 Nov 2007 20:49:09 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2C6BC277AE;
	Tue, 13 Nov 2007 20:49:09 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 2559956D22; Tue, 13 Nov 2007 20:49:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071113194731.GC3268@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64840>

Check if the tracking and the remote branches are both actually deleted.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

As promised.

 t/t5404-tracking-branches.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 20718d4..f55143a 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup' '
 	git commit -m 1 &&
 	git branch b1 &&
 	git branch b2 &&
+	git branch b3 &&
 	git clone . aa &&
 	git checkout b1 &&
 	echo b1 >>file &&
@@ -19,6 +20,8 @@ test_expect_success 'setup' '
 	git commit -a -m b2
 '
 
+start_dir="$(pwd)"
+
 test_expect_success 'check tracking branches updated correctly after push' '
 	cd aa &&
 	b1=$(git rev-parse origin/b1) &&
@@ -37,4 +40,17 @@ test_expect_success 'check tracking branches updated correctly after push' '
 	test "$(git rev-parse origin/b2)" = "$b2"
 '
 
+test_expect_success 'delete remote branch' '
+	git push origin :refs/heads/b3 &&
+	{
+		git rev-parse origin/b3 --
+		test $? != 0
+        } &&
+	cd "$start_dir" &&
+	{
+		git rev-parse refs/heads/b3 --
+		test $? != 0
+        }
+'
+
 test_done
-- 
1.5.3.5.668.g22088
