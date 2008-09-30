From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Remove space from the end of aspell's reply before
 processing
Date: Tue, 30 Sep 2008 08:39:29 +0200
Message-ID: <48E1C9A1.2090409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 08:40:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkYuY-0001im-IX
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 08:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbYI3Gjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 02:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYI3Gjd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 02:39:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17866 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYI3Gjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 02:39:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkYtO-0005p5-6K; Tue, 30 Sep 2008 08:39:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E6C5F4FB; Tue, 30 Sep 2008 08:39:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97068>

From: Johannes Sixt <johannes.sixt@telecom.at>

When git gui processes a reply from aspell it explicitly ignores an empty
line. The Windows version of aspell, however, terminates lines with CRLF,
but TCL's 'gets' does not remove CR, hence, a "visibly" empty line was not
actually recognized as empty. With this change we explicitly trim off
whitespace before the line is further processed.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 There's probably a better solution by having TCL do the translation of
 line endings, but I don't know how to do that.

 -- Hannes

 lib/spellcheck.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index a479b2f..e612030 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
@@ -314,6 +314,7 @@ method _run {} {
 method _read {} {
 	while {[gets $s_fd line] >= 0} {
 		set lineno [lindex $s_pending 0 0]
+		set line [string trim $line]

 		if {$s_clear} {
 			$w_text tag remove misspelled "$lineno.0" "$lineno.end"
-- 
1.6.0.2.1262.ge466e
