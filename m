From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Do not pick up file names of "copy from" lines
Date: Tue, 02 Oct 2007 16:21:00 +0200
Message-ID: <470253CC.8040305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 16:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icicc-0007Cu-2R
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 16:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbXJBOVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbXJBOVI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 10:21:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9373 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752405AbXJBOVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 10:21:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IcicP-0001bZ-Oz; Tue, 02 Oct 2007 16:21:02 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E47BE54D; Tue,  2 Oct 2007 16:21:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59692>

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
