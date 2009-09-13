From: mr.gaffo@gmail.com
Subject: [PATCH JGit 13/19] made the call update the object database's info cache
Date: Sun, 13 Sep 2009 13:44:29 -0500
Message-ID: <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4o-0003Gw-If
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbZIMSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbZIMSpU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:45:20 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47904 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZIMSoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:54 -0400
Received: by mail-yw0-f174.google.com with SMTP id 4so3391282ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TZToFEv4oPVNX1QPTF55XVhAsQgmDErNsAaCiCQn9RY=;
        b=mPjfXY/FE6z7xtO+XSBQROL9dBPbe0o6g4H+ZUoL7kEGk1vhogu5qY7w+VO+uG8oIn
         DKyUZJ6PfGv6lauc6T7J7qJED7KNWxJPjSggrvkI4PxSlwwl9aNPNLv+krZCp0A1Bd9m
         5Wc7GR2dAzRoqACTpoGxl4Hu84m8muXosF1/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=THcH1juEAsB2bRpm3cal48ioTjVmFeehUC237R8IJ4S3zSb2VfVYZljeY0BsBNv1+t
         z/wRrMYo20Uokjj+sIey4vcbGAowSEEcocSdU+Wr5LLpWj1OGwXszeM4/S29Zr/KH4pG
         +zcTE9npv02WEWeyRk2aLh0YgWy6rqWhBRiWk=
Received: by 10.101.191.17 with SMTP id t17mr5526672anp.87.1252867497697;
        Sun, 13 Sep 2009 11:44:57 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128396>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/transport/ReceivePack.java    |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index eb21254..5865736 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -521,6 +521,16 @@ void sendString(final String s) throws IOException {
 			}
 
 			postReceive.onPostReceive(this, filterCommands(Result.OK));
+			updateObjectInfoCache();
+		}
+	}
+
+	private void updateObjectInfoCache() {
+		try{
+			getRepository().getObjectDatabase().updateInfoCache();
+		} 
+		catch (IOException e){
+			sendMessage("error updating server info: " + e.getMessage());
 		}
 	}
 
-- 
1.6.4.2
