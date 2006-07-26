From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Extend testing git-mv for renaming of subdirectories
Date: Wed, 26 Jul 2006 15:44:08 +0200
Message-ID: <200607261544.08435.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 15:46:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5jhR-0003tA-K5
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 15:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGZNon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 09:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWGZNon
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 09:44:43 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:9131 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750726AbWGZNom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 09:44:42 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 3EE932742;
	Wed, 26 Jul 2006 15:44:41 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24212>

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

On Wednesday 26 July 2006 03:52, Johannes Schindelin wrote:
> 	There is no test for it, and I am quite certain the old script
> 	doesn't do it either: git-mv some_tracked_dir/ there/ will
> 	not work. t7001-mv passes, though.

Hmm... Renaming full subtrees worked since the old git-rename days.
I just checked it, and it works fine.

My bad, that there was no test for this, so what about this?

Josef

 t/t7001-mv.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 811a479..9270a41 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -38,4 +38,28 @@ test_expect_success \
     'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
     grep -E "^R100.+path1/COPYING.+path0/COPYING"'
 
+test_expect_success \
+    'adding another file' \
+    'cp ../../README path0/README &&
+     git-add path0/README &&
+     git-commit -m add2 -a'
+
+test_expect_success \
+    'moving whole subdirectory' \
+    'git-mv path0 path2'
+
+test_expect_success \
+    'commiting the change' \
+    'git-commit -m dir-move -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
+     grep -E "^R100.+path0/COPYING.+path2/COPYING" &&
+     git-diff-tree -r -M --name-status  HEAD^ HEAD | \
+     grep -E "^R100.+path0/README.+path2/README"'
+
 test_done
+
-- 
1.4.2.rc1.g791e
