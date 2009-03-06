From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH] [JGit] Fix parsing peeled line in packed-ref
Date: Fri,  6 Mar 2009 23:25:38 +0800
Message-ID: <1236353138-1427-1-git-send-email-j16sdiz+freenet@sdiz.net>
Cc: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfbxL-0004iq-B3
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbZCFPZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZCFPZq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:25:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:6880 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbZCFPZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:25:45 -0500
Received: by rv-out-0506.google.com with SMTP id g37so545815rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=bk/FLJve7WW8tfWYQ3yLK7a07F1La/TjzAXY7xWqkjE=;
        b=q6YBLdbI+hJuKqqF9/rlVIs3UdroEKJWtSrDwgpcczYKJAh/FS30voOJNVNeMb0FWI
         //gkHRiflONyUl7p01Yp1JaRbpq3gPEpjy46iuk3kAeVBhzY3c6RoXrW4dRzCR3aO+CF
         f51mpL3TOp6BsE9DLrugI4s6cPTMb9eCv4jh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=udHLi+4vspL2QRIcDZvTx+Rjza0JMIma5HKJ5PEzCcG0DJLb496PUwyKc+xv4BnwXU
         2/EEViN/OJ3KGMubL6203vOlV3Cp3G4oATJfIdCqGwRxJjxmhWBGDBF/xa4tE+O4LBwW
         b6lFH9C75aJbcB8yO2uZvxrH0OSf1khZqVQvg=
Received: by 10.141.36.17 with SMTP id o17mr1345287rvj.50.1236353143300;
        Fri, 06 Mar 2009 07:25:43 -0800 (PST)
Received: from localhost.localdomain ([116.49.57.31])
        by mx.google.com with ESMTPS id l31sm3564813rvb.5.2009.03.06.07.25.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 07:25:42 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112446>

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
