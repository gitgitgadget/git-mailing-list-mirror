From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Identical trees should not trigger error in cg-diff
Date: Tue, 16 Aug 2005 23:42:43 -0400
Message-ID: <1124250163.26240.19.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 17 05:43:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5EpI-0002lN-GJ
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 05:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVHQDmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 23:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVHQDmr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 23:42:47 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:23699 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750820AbVHQDmq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 23:42:46 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E5EmP-00026o-D3
	for git@vger.kernel.org; Tue, 16 Aug 2005 23:39:53 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E5EpA-0001Gi-1R; Tue, 16 Aug 2005 23:42:44 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7H3ghwj004877;
	Tue, 16 Aug 2005 23:42:43 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@ucw.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

cg-diff reports error when comparing identical trees.  It's not as
useless as it may seem.  For example, I make local changes, e-mail them
upstream and then get them back via cg-update with minor changes.  I
revert the minor differences between master and origin.  Here's what I
get when I want to make sure the trees are identical (their history is
not):

$ cg-diff -r origin:master
cg-diff: trying to diff b00f462cee5b02455abdbb476fa7c9e94a9fcb4c against
itself

What's worse, cg-diff exists with exit status 1, indicating an error.  I
don't see any reason for this to be an error.  No difference between
branches is OK.  This may be especially important when cg-diff is used
non-interactively in a script.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -167,7 +167,7 @@ fi
 id1=$(tree-id "$id1") || exit 1
 id2=$(tree-id "$id2") || exit 1
 
-[ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
+[ "$id1" = "$id2" ] && exit 0
 
 cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
 


-- 
Regards,
Pavel Roskin
