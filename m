From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/4] Teach git-add--interactive to accept multiple file params
Date: Thu, 22 Nov 2007 01:02:51 +0100
Message-ID: <1195689773-28601-3-git-send-email-win@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
 <1195689773-28601-1-git-send-email-win@wincent.com>
 <1195689773-28601-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 01:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzXz-0004Wi-27
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbXKVADm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXKVADm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:03:42 -0500
Received: from wincent.com ([72.3.236.74]:56122 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbXKVADl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:03:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM02s0V030459;
	Wed, 21 Nov 2007 18:02:58 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195689773-28601-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65719>

As per Jeff King's suggestion, this commit teaches git-add--interactive
to accept multiple optional file parameters, which will be fed into the
"patch" subcommand one by one. After all parameters are processed we
drop back into the standard command loop.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 95e537c..2bba07d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -805,10 +805,9 @@ sub main_loop {
 	}
 }
 
-die "add --interactive may take only 1 optional parameter" if ($#ARGV > 0);
 refresh();
-if ($#ARGV == 0) {
-	patch_update_file($ARGV[0]);
+foreach my $file (@ARGV) {
+	patch_update_file($file);
 }
 status_cmd();
 main_loop();
-- 
1.5.3.6.867.g539b6-dirty
