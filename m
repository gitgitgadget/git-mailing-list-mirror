From: Jeff King <peff@peff.net>
Subject: [PATCH] list_untracked_files: remove empty squashed directories
Date: Fri, 9 Jun 2006 01:41:34 -0400
Message-ID: <20060609054134.GA16026@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 09 07:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoZkb-000331-1B
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 07:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWFIFlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWFIFlg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 01:41:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:14742 "HELO
	peff.net") by vger.kernel.org with SMTP id S964870AbWFIFlg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 01:41:36 -0400
Received: (qmail 18582 invoked from network); 9 Jun 2006 01:41:32 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jun 2006 01:41:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  9 Jun 2006 01:41:34 -0400
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Mail-Followup-To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21527>

Signed-off-by: Jeff King <peff@peff.net>
---
This patch is for cogito.

Ordinarily, I would say if you have empty directories, you should remove
them. However, if you have a directory in which all files are excluded,
it will still appear in cg-status -w (even though cg-status -S is
empty!).

This, of course, means that actual empty directories will also be
ignored; there's no way around it without putting logic into
git-ls-files to distinguish between the two.

 cg-Xlib |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 839e9f8..3ec32b7 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -443,7 +443,7 @@ list_untracked_files()
 		fi
 	fi
 	local listdirs=
-	[ "$squashflag" != "squashdirs" ] || listdirs=--directory
+	[ "$squashflag" != "squashdirs" ] || listdirs="--directory --no-empty-directory"
 	git-ls-files -z --others $listdirs "${EXCLUDE[@]}"
 }
 
-- 
1.4.0.rc2
