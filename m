From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] send-email: respect in-reply-to regardless of threading
Date: Sun,  1 Mar 2009 23:45:41 +0100
Message-ID: <74fdbb84d14a6d39f1b61e18ab9588ca08926292.1235947339.git.trast@student.ethz.ch>
References: <200903012237.40891.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 23:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LduRa-00023n-LP
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbZCAWqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 17:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZCAWqF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:46:05 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:18230 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255AbZCAWqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 17:46:04 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 23:46:01 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 23:46:01 +0100
X-Mailer: git-send-email 1.6.2.rc2.341.g74fdbb
In-Reply-To: <200903012237.40891.trast@student.ethz.ch>
X-OriginalArrivalTime: 01 Mar 2009 22:46:01.0076 (UTC) FILETIME=[7EA23340:01C99ABF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111893>

git-send-email supports the --in-reply-to option even with
--no-thread.  However, the code that adds the relevant mail headers
was guarded by a test for --thread.

Remove the test, so that the user's choice is respected.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Thomas Rast wrote:
> But it also turns out, as you can see, that git-send-email happily
> ignores --in-reply-to if threading is disabled. :-(

This is the minimally intrusive fix.  It would be more consistent to
ask for the in-reply-to regardless of thread setting, but it would
also be less of a fix and more of a behaviour change.


 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index adf7ecb..09fe3d9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -821,7 +821,7 @@ sub get_patch_subject($) {
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
 ";
-	if ($thread && $reply_to) {
+	if ($reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
 		$header .= "References: $references\n";
-- 
1.6.2.rc2.340.g83918
