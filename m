From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Thu, 29 Jan 2009 13:35:14 -0800
Message-ID: <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 22:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSev4-0000RK-FO
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 22:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZA2V6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 16:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZA2V6G
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 16:58:06 -0500
Received: from zion.cs.ucsb.edu ([128.111.52.118]:59774 "EHLO zion.cs.ucsb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbZA2V6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 16:58:04 -0500
X-Greylist: delayed 1368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jan 2009 16:58:04 EST
Received: by zion.cs.ucsb.edu (Postfix, from userid 401)
	id D46119D1BF8; Thu, 29 Jan 2009 13:35:14 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.3.g08dd8
In-Reply-To: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107732>

The implementation is trivial: ignore the 'noop' command
if it is sent. This command is issued by some CVS clients,
notably TortoiseCVS. Without this patch, TortoiseCVS will
choke when git-cvsserver complains about the unsupported
command.

Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
---

Since this change has no negative impact, is too simple to
be wrong, and improves interaction with some clients, it
seem to me like a no-brainer to apply it.

 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index fef7faf..c1e09ea 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -188,7 +188,7 @@ while (<STDIN>)
         # use the $methods hash to call the appropriate sub for this command
         #$log->info("Method : $1");
         &{$methods->{$1}}($1,$2);
-    } else {
+    } elsif ($1 ne 'noop') {
         # log fatal because we don't understand this function. If this happens
         # we're fairly screwed because we don't know if the client is expecting
         # a response. If it is, the client will hang, we'll hang, and the whole
-- 
1.6.0.3.3.g08dd8
