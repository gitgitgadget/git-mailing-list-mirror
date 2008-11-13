From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK)] gitk: Make line origin search update the busy status.
Date: Thu, 13 Nov 2008 23:43:13 +0300
Organization: HOME
Message-ID: <200811132343.13910.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 21:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0j5N-0008Qw-Ae
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbYKMUpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbYKMUpS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:45:18 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:46318 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYKMUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:45:16 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1121445fkq.5
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Dz/NfPHo49FaAA6n+OAx5+RiyfHtv8c4suhOcYTV4X4=;
        b=Qf36f14N5g1YuJjlJdLhX/6Xv4Ogn4fOfdkDeN1UgAWICrTQbQ8SJoW29H9dSxqD+6
         SKf/VNVhPUDDwErz5/OV3eKuCDKf/Sljrm0aU7vc4YPjys0e3MK0etYDY6bLkqAKPOO/
         z0Yyz43MY6PS7sL8nNo9pS+JYIVIHlvdnVhCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=NrW9RETl0fKntZY7TXFOD6qzbRSJQ77ZytDq7KCr/hGmevOgeYgF+zv96HRQlTnNrK
         jY0DmiMo2pklO3d9ln2BT8PvbyEmEtcEnicXEH+GUCnvQ83K2BT5bg24HEBe3PoU2Ych
         KZ+2+zxP1E+LM0Snxtkc2Wz6cBJuCWCiefc8U=
Received: by 10.181.137.13 with SMTP id p13mr38079bkn.173.1226609114851;
        Thu, 13 Nov 2008 12:45:14 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm5342703fkh.11.2008.11.13.12.45.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 12:45:13 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100914>

Currently the 'show origin of this line' feature does
not update the status field of the gitk window, so it
is not evident that any processing is going on. It may
seem at first that clicking the item had no effect.

This commit adds calls to set and clear the busy
status with an appropriate title, similar to other
search commands.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index e4562d7..3fb9c44 100755
--- a/gitk
+++ b/gitk
@@ -3400,6 +3400,7 @@ proc show_line_source {} {
 	error_popup [mc "Couldn't start git blame: %s" $err]
 	return
     }
+    nowbusy blaming [mc "Blaming"]
     fconfigure $f -blocking 0
     set i [reg_instance $f]
     set blamestuff($i) {}
@@ -3413,6 +3414,7 @@ proc stopblaming {} {
     if {[info exists blameinst]} {
 	stop_instance $blameinst
 	unset blameinst
+	notbusy blaming
     }
 }
 
@@ -3427,6 +3429,7 @@ proc read_line_source {fd inst} {
     }
     unset commfd($inst)
     unset blameinst
+    notbusy blaming
     fconfigure $fd -blocking 1
     if {[catch {close $fd} err]} {
 	error_popup [mc "Error running git blame: %s" $err]
-- 
1.6.0.3.15.gb8d36
