From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: reduce stat() calls for a backwards compatibility check
Date: Wed, 13 Jun 2007 02:37:05 -0700
Message-ID: <11817274293330-git-send-email-normalperson@yhbt.net>
References: <11817274254011-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyPIC-0001YO-BF
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbXFMJhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbXFMJhN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:37:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49935 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756910AbXFMJhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:37:10 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7FBB87DC09D;
	Wed, 13 Jun 2007 02:37:09 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 02:37:09 -0700
X-Mailer: git-send-email 1.5.2.1.243.gbe00
In-Reply-To: <11817274254011-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50040>

Also, this fixes a bug where in an odd case a remote named
"config" could get renamed to ".metadata".

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 58f7dd0..0ae8d70 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1457,7 +1457,7 @@ sub tmp_config {
 	my (@args) = @_;
 	my $old_def_config = "$ENV{GIT_DIR}/svn/config";
 	my $config = "$ENV{GIT_DIR}/svn/.metadata";
-	if (-e $old_def_config && ! -e $config) {
+	if (! -f $config && -f $old_def_config) {
 		rename $old_def_config, $config or
 		       die "Failed rename $old_def_config => $config: $!\n";
 	}
-- 
1.5.2.1.243.gbe00
