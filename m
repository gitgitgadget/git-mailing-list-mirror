From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fix git-gui crash due to uninitialized variable
Date: Sat, 21 Jan 2012 18:57:28 +0100
Message-ID: <20120121175724.GA7319@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 19:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RofKI-0007Th-IB
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 19:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab2AUSFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 13:05:48 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:54095 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751323Ab2AUSFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 13:05:47 -0500
Received: from localhost (p5B22F10E.dip.t-dialin.net [91.34.241.14])
	by bsmtp.bon.at (Postfix) with ESMTP id 74188130044;
	Sat, 21 Jan 2012 19:05:44 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188926>

Recently, a clone initiated via git gui on Windows crashed on me due to
an "unknown variable cdone". It turns out that there is a code path
where this variable is used uninitialized.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Looking at the output of display(), it's not clear to me now the
function below could ever be called with total=0. But I can't delve into
it more deeply right now, and this seems like an obvious fix.

 git-gui/lib/status_bar.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
index 95cb449..02111a1 100644
--- a/git-gui/lib/status_bar.tcl
+++ b/git-gui/lib/status_bar.tcl
@@ -77,6 +77,7 @@ method start {msg uds} {
 
 method update {have total} {
 	set pdone 0
+	set cdone 0
 	if {$total > 0} {
 		set pdone [expr {100 * $have / $total}]
 		set cdone [expr {[winfo width $w_c] * $have / $total}]
-- 
1.7.8
