From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Wed, 21 Nov 2007 13:36:39 +0100
Message-ID: <1195648601-21736-3-git-send-email-win@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
 <1195648601-21736-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuoqk-00039d-Ep
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbXKUMiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbXKUMiU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:38:20 -0500
Received: from wincent.com ([72.3.236.74]:54663 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756648AbXKUMiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:38:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCagcl013817;
	Wed, 21 Nov 2007 06:36:46 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195648601-21736-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65640>

If supplied a single file path parameter the git-add--interactive script
now bypasses the command loop and jumps straight to the patch subcommand
using the passed path. After returning from the subcommand the main
command loop is entered. If a non-resolvable path is supplied the
operation is a no-op and the command loop is entered.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb1e92a..8f21c03 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -803,6 +803,11 @@ sub main_loop {
 	}
 }
 
+die "add --interactive may take only 1 optional parameter" if ($#ARGV > 0);
 refresh();
+if ($#ARGV == 0) {
+	patch_update_file($ARGV[0]);
+}
 status_cmd();
 main_loop();
+
-- 
1.5.3.5.737.gdee1b
