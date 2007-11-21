From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/4] Refactor patch_update_cmd
Date: Wed, 21 Nov 2007 13:36:38 +0100
Message-ID: <1195648601-21736-2-git-send-email-win@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuopR-0002kQ-Cp
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXKUMg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbXKUMg6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:36:58 -0500
Received: from wincent.com ([72.3.236.74]:54658 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbXKUMg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:36:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCagck013817;
	Wed, 21 Nov 2007 06:36:44 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195648601-21736-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65636>

Split patch_update_cmd into two functions, one to prompt the user for
a path to patch and another to do the actual work given that file path.
This lays the groundwork for a future commit which will teach
git-add--interactive to accept a path parameter and jump directly to
the patch subcommand for that path, bypassing the interactive prompt.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0317ad9..fb1e92a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -564,10 +564,12 @@ sub patch_update_cmd {
 				     IMMEDIATE => 1,
 				     HEADER => $status_head, },
 				   @mods);
-	return if (!$it);
+	patch_update_file($it->{VALUE}) if ($it);
+}
 
+sub patch_update_file {
 	my ($ix, $num);
-	my $path = $it->{VALUE};
+	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
 	for (@{$head->{TEXT}}) {
 		print;
-- 
1.5.3.5.737.gdee1b
