From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 01/23] Fix: let FetchProcess use fetch() instead of doFetch()
Date: Sat, 28 Jun 2008 00:06:25 +0200
Message-ID: <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM6n-0000cC-1p
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYF0WG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbYF0WG6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:06:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYF0WGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:06:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FzvkPeNQRsVZU/+uUc0X/m1Cq1lfXDytOWGRWjWIDX8=;
        b=pVVbmT8xu/q/I5tD96FUgmBzLJIIIZ+4iPteGA6C/t5W+9pNCHBaFizQgMRfjpopBj
         A9z7N/Mgm3s+3CHWkhxrnVGNjygibe76BvDy3yazn9F9UrDm13vra5wkNoTjRiM1Ng7h
         qOWijdfXmSjR+Kmy4O8Rzjtmkb0McFZUqizYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=heG2lHu4aaCTfr4wzWwc+A0xtz+lgLY2VRH7QFY5oL5SnzXSDKTJOckKO3zsT1kMQR
         cf8oMBKtxvf30Y8cifBelopJYoCf+baxD4mDLdPv42pLtoZ9TKr6f+NQkKi2zzQ/iuuJ
         dSVz1fxjg0wrtgOnjPh4sx6dXDhh0oi8clMJY=
Received: by 10.210.23.3 with SMTP id 3mr1602867ebw.97.1214604414936;
        Fri, 27 Jun 2008 15:06:54 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b33sm2445460ika.2.2008.06.27.15.06.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:06:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86640>

doFetch() call didn't check whether fetch() was already performed
(it is intended for internal use), while fetch() does.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/FetchProcess.java   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index afaf9e2..e33b35b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -139,7 +139,7 @@ class FetchProcess {
 				if (!askFor.isEmpty() && (!includedTags || !askForIsComplete())) {
 					reopenConnection();
 					if (!askFor.isEmpty())
-						conn.doFetch(monitor, askFor.values());
+						conn.fetch(monitor, askFor.values());
 				}
 			}
 		} finally {
-- 
1.5.5.3
