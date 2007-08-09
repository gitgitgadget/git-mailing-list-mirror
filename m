From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] cvsserver: Fix for work trees
Date: Wed,  8 Aug 2007 23:26:10 -0500
Message-ID: <1186633570700-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 06:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIzmw-00020t-IM
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 06:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbXHIEiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 00:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbXHIEiS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 00:38:18 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:16016 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbXHIEiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 00:38:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aj1KAEI3ukZKhvbzRmdsb2JhbACBU4UlhxcBAQE1AZsM
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 09 Aug 2007 00:38:17 -0400
Received: from silvara (silvara.lavos.net [10.4.0.20])
	by mail.lavos.net (Postfix) with ESMTP id C27C2309F30;
	Wed,  8 Aug 2007 23:38:07 -0500 (CDT)
Received: by silvara (Postfix, from userid 1000)
	id 523DB50103; Wed,  8 Aug 2007 23:26:11 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55405>

git-cvsserver used checkout-index internally for commit and annotate.
Since a work tree is required for this to function now, this was
breaking.  Work around this by defining GIT_WORK_TREE=. in the
appropriate places.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 git-cvsserver.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ae7d511..13dbd27 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1196,6 +1196,7 @@ sub req_ci
     $log->info("Lockless commit start, basing commit on '$tmpdir', index file is '$file_index'");
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+    $ENV{GIT_WORK_TREE} = ".";
     $ENV{GIT_INDEX_FILE} = $file_index;
 
     # Remember where the head was at the beginning.
@@ -1721,6 +1722,7 @@ sub req_annotate
     $log->info("Temp checkoutdir creation successful, basing annotate session work on '$tmpdir', index file is '$file_index'");
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+    $ENV{GIT_WORK_TREE} = ".";
     $ENV{GIT_INDEX_FILE} = $file_index;
 
     chdir $tmpdir;
-- 
1.5.3.GIT
