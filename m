From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 1/3] Fix push's RemoteRefUpdate to always force update local TrackingRefUpdate
Date: Thu, 28 Aug 2008 04:32:47 +0200
Message-ID: <1219890769-20119-2-git-send-email-marek.zawirski@gmail.com>
References: <1219890769-20119-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 04:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXKr-0007CB-3G
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbYH1CdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYH1CdD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:33:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:2777 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbYH1Cc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:32:59 -0400
Received: by mu-out-0910.google.com with SMTP id g7so125717muf.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pMfPgEel3RnLf4jCbeWezDfdYKa8jEGzXxyPMcKFmlY=;
        b=h52nxRNmXczY4npegIRlLRJXWig64YrljQOQaPHqJAtnOLOaUCgA/fk/qn00KUsonj
         SyHG39FM5b6Joy6V4IKF5YL0GQQrgT8NnCSTmI5B7XgoC6zaUcqI7Y+pmwZuJVMQyMke
         wJ6bXVAPTwfyHEm7OcE5ublF6b3yyRRmtJvTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xj7U27gJ6nK2M57add+W+auMVwpJ88dPV58vQkB5I9M03KvrYaqAPVmgWNGxj4vqR6
         VbbtvBOy/SXWoejkN0b46NyKfphGoXQ1Ug61U9+hpJ3aI5ur49li6Od3hMy6rs1zYc8w
         8gga5X3UGZllKcinkb5fW3nBYUjnQ63GPNEHA=
Received: by 10.103.16.16 with SMTP id t16mr438268mui.131.1219890778517;
        Wed, 27 Aug 2008 19:32:58 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id t10sm484159muh.16.2008.08.27.19.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:32:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219890769-20119-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94023>

Now, we force update local tracking ref even if we do not force remote
ref update. It seems to be sensible approach (C git one) assuming that our
repository may be out of sync with the remote one.
The potentially lost information  here isn't so valuable perhaps.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index fd19300..623599f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -189,7 +189,7 @@ public RemoteRefUpdate(final Repository localDb, final String srcRef,
 		this.forceUpdate = forceUpdate;
 		if (localName != null && localDb != null)
 			trackingRefUpdate = new TrackingRefUpdate(localDb, localName,
-					remoteName, forceUpdate, newObjectId, "push");
+					remoteName, true, newObjectId, "push");
 		else
 			trackingRefUpdate = null;
 		this.localDb = localDb;
-- 
1.5.6.3
