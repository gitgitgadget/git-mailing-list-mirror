From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Do not munge conflict marker lines in a normal diff
Date: Tue, 14 Oct 2008 13:48:37 +0200
Message-ID: <48F48715.9070105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 13:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpiPR-00085G-6y
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 13:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbYJNLsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 07:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755278AbYJNLsl
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 07:48:41 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33855 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbYJNLsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 07:48:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KpiOD-0000kY-Jo; Tue, 14 Oct 2008 13:48:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3258B6B7; Tue, 14 Oct 2008 13:48:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98182>

From: Johannes Sixt <johannes.sixt@telecom.at>

Previously, conflict markers were highlighted in two ways: (1) They
received a distinguishing color; and (2) they had the '+' removed at the
beginning of the line. However, by doing (2), a hunk that contained
conflict markers could not be staged or unstaged because the resulting
patch was corrupted. With this change we no longer modify the diff text
of a 2-way diff, so that "Stage Hunk" and friends work.

Note that 3-way diff of a conflicted file is unaffected by this change,
and '++' before conflict markers is still removed. But this has no negative
impact because in this mode staging hunks or lines is disabled anyway.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/diff.tcl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index bdcbbf8..94ee38c 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -377,7 +377,6 @@ proc read_diff {fd cont_info} {
 			{+} {
 				if {[regexp {^\+([<>]{7} |={7})} $line _g op]} {
 					set is_conflict_diff 1
-					set line [string replace $line 0 0 { }]
 					set tags d$op
 				} else {
 					set tags d_+
-- 
1.6.0.2.1493.g2969e
