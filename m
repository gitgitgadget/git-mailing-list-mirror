From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH] [JGit] Fix parsing peeled line in packed-ref
Date: Fri,  6 Mar 2009 23:26:15 +0800
Message-ID: <1236353175-1570-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:28:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfbxo-0004x2-ST
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbZCFP0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZCFP0W
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:26:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:5827 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbZCFP0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:26:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so546024rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=HpTwKRn28VGMW9J9q4sIdGt04/urtTfbOGmzLM5G2zY=;
        b=UmgMmvngYYUNVooHAx0Xgx4a/hiXX6TPuVRY0ZI4aGF/cEB9L0M2/si1RLb+luzH4G
         D4ZSOHtYWFSueqVRj/C4ScH0h6gHDOxunN12y4hmbNAxqAi+eTYyQo7FQ22GHzDLjM7O
         rNzK+PaCD/JL15tEnj/kI2fh+TryAdUhl9zTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=sHIBHyhxMG1Zi0wT2C6ceJ7WfNhsqQqiyUOy4DfJP29O6D6fijPw8P+pU2KA0hvjVo
         I0mHZzmWCyyfW5tdH1p3QKUx1tN+FwaSoATBBMA8a3BR5obPw/7SxDFEU8sTWwS3AFow
         fd9gdjR+v7kNn61In3FAsUulYiGqYCe/drViQ=
Received: by 10.140.140.3 with SMTP id n3mr1342097rvd.111.1236353180200;
        Fri, 06 Mar 2009 07:26:20 -0800 (PST)
Received: from localhost.localdomain ([116.49.57.31])
        by mx.google.com with ESMTPS id g22sm1998376rvb.0.2009.03.06.07.26.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 07:26:19 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112447>

From: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@sdiz.net>

When doing a WalkTransport with packed-ref, peeled
line are not handled correctly. This patch fix the
issue.
---
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index a4f8961..d8e727b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -436,7 +436,7 @@ private void readPackedRefsImpl(final Map<String, Ref> avail,
 			if (line.charAt(0) == '^') {
 				if (last == null)
 					throw new TransportException("Peeled line before ref.");
-				final ObjectId id = ObjectId.fromString(line + 1);
+				final ObjectId id = ObjectId.fromString(line.substring(1));
 				last = new Ref(Ref.Storage.PACKED, last.getName(), last
 						.getObjectId(), id, true);
 				avail.put(last.getName(), last);
-- 
1.6.2.rc2
