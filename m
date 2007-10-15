From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH resend] gitk: Do not pick up file names of "copy from" lines
Date: Mon, 15 Oct 2007 12:08:08 +0200
Message-ID: <47133C08.4050403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMs3-0008Lx-Ec
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbXJOKIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbXJOKIN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:08:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45208 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbXJOKIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:08:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhMrd-0004iG-VA; Mon, 15 Oct 2007 12:07:58 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4A4DD69F; Mon, 15 Oct 2007 12:08:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60975>

From: Johannes Sixt <johannes.sixt@telecom.at>

A file copy would be detected only if the original file was modified in the
same commit. This implies that there will be a patch listed under the
original file name, and we would expect that clicking the original file
name in the file list warps the patch window to that file's patch. (If the
original file was not modified, the copy would not be detected in the first
place, the copied file would be listed as "new file", and this whole matter
would not apply.)

However, if the name of the copy is sorted after the original file's patch,
then the logic introduced by commit d1cb298b0b (which picks up the link
information from the "copy from" line) would overwrite the link
information that is already present for the original file name, which was
parsed earlier. Hence, this patch reverts part of said commit.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
   I did not see this appear in http://git.kernel.org/?p=gitk/gitk.git
   so I assume it got lost in the noise, and resend it.

   -- Hannes

  gitk |    3 +--
  1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index b3ca704..1306382 100755
--- a/gitk
+++ b/gitk
@@ -5216,8 +5216,7 @@ proc getblobdiffline {bdf ids} {
  	    set diffinhdr 0

  	} elseif {$diffinhdr} {
-	    if {![string compare -length 12 "rename from " $line] ||
-		![string compare -length 10 "copy from " $line]} {
+	    if {![string compare -length 12 "rename from " $line]} {
  		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
  		if {[string index $fname 0] eq "\""} {
  		    set fname [lindex $fname 0]
-- 
1.5.3.716.gb8ce0-dirty
