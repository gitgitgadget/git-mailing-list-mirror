From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH GIT] Fix parsing peeled line in packed-ref
Date: Sat,  7 Mar 2009 00:02:40 +0800
Message-ID: <1236355360-5454-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:04:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcX2-0002tR-Me
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbZCFQCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbZCFQCs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:02:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:6175 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbZCFQCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:02:47 -0500
Received: by rv-out-0506.google.com with SMTP id g37so559272rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=JyuLPurLNFnhrHb2jXBM03g276Nsq/pWitx3I5OZHyg=;
        b=pGil6BwiyQ1VTZnUQTYdHgTLylXAkcGDzG29qUgN838nytOWh47PqzhHFD9MoEoyC6
         RGz57SmaR4CCgNi4NrMHdq1WUhcODj5lOBznR9KDGKRd9/gXM7uDkABLff4clrhY2pYL
         2YBfyHHr+wkwjhVTO6pPaKtVD2tGb7VvtAb8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=WrFgr1EsPl47quq8X1ZLs5EqB6ekiI5MSDh93OAYCvhvMuJkcJfY5DztAUFxsyDdjP
         uQ+MEaxEeCg3RXzYdqnygotouLzPTvNVn4NrLErGRyVDZqr0Md5CsMSF1V0nYXaF+MNE
         yGbH34TQzWxIazZDnoIuiFEcLs1Z083MhcTMI=
Received: by 10.114.53.1 with SMTP id b1mr1611866waa.24.1236355364763;
        Fri, 06 Mar 2009 08:02:44 -0800 (PST)
Received: from localhost.localdomain ([116.49.57.31])
        by mx.google.com with ESMTPS id k14sm446591waf.23.2009.03.06.08.02.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 08:02:44 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112455>

From: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@sdiz.net>

When doing a WalkTransport with packed-ref, peeled
line are not handled correctly. This patch fix the issue.

Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
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
