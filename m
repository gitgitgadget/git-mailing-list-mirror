From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] git-gui: Don't select the wrong file if the last listed file is staged.
Date: Wed, 25 Jun 2008 16:06:50 +0530
Message-ID: <20080625103650.GA20492@toroid.org>
References: <1213308730-12707-1-git-send-email-ams@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 12:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBSNq-0008Hw-Qo
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbYFYKgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbYFYKgx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:36:53 -0400
Received: from fugue.toroid.org ([85.10.196.113]:43164 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbYFYKgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:36:53 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 918DA55869A;
	Wed, 25 Jun 2008 12:36:51 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id B0DC0ADC0DD; Wed, 25 Jun 2008 16:06:50 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <1213308730-12707-1-git-send-email-ams@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86268>

Johannes Sixt noticed that if the last file in the list was staged, my
earlier patch would display the diff for the penultimate file, but show
the file _before_ that as being selected.

This was due to my misunderstanding the lno argument to show_diff.

This patch fixes the problem: lno is not decremented in the special case
to handle the last item in the list (though we still need to use $lno-1
to find the right path for the next diff).

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 git-gui/git-gui.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23d7dfe..fe4a4c2 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1806,14 +1806,16 @@ proc toggle_or_diff {w x y} {
 		} else {
 			global next_diff_p next_diff_w next_diff_i
 
+			set next_diff_w $w
+
 			if {$i < $ll} {
 				set i [expr {$i + 1}]
+				set next_diff_i $i
 			} else {
+				set next_diff_i $i
 				set i [expr {$i - 1}]
 			}
 
-			set next_diff_i $i
-			set next_diff_w $w
 			set next_diff_p [lindex $file_lists($w) $i]
 
 			if {$next_diff_p ne {} && $current_diff_path ne {}} {
-- 
1.5.6
