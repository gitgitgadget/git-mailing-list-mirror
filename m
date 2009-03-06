From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH JGIT] Fix parsing peeled line in packed-ref
Date: Sat,  7 Mar 2009 00:05:50 +0800
Message-ID: <1236355550-5764-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcaQ-0004Mi-Px
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbZCFQF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbZCFQF6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:05:58 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:5364 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbZCFQF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:05:57 -0500
Received: by wa-out-1112.google.com with SMTP id v33so305934wah.21
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=JyuLPurLNFnhrHb2jXBM03g276Nsq/pWitx3I5OZHyg=;
        b=huJ+j/xx24bEYWdv4APiDtIJ5YyVB13qoI/TPLJpiZvQiWEBA5rFlTSeEVD2C5eGla
         XAmL3gHzRfXkDhRnXw6WD0t10+qeJoJjz1kegeDAwcUBz7yY+p+lbjtHVZJLUrin0x/S
         fo2egg+ycOz7+ompS14NdpLczGJRMAPy8XzOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=T9hfgFYY1FgUilA2aZTEFh2jh8MPjIZBFTH8abkvn0TcH6XHguBtGBQ1uk6bnR7YDp
         rttklaQbkaZv8I8bx7dgs27O7u6WCNV8wUo9eG/aVTh7d9VXa0E2F8AuNkvLKswhnfXz
         Eyx+q6EzMVrsmdXbTrd5kxjv4aP5ScGR/3oLU=
Received: by 10.114.24.5 with SMTP id 5mr1599298wax.106.1236355556071;
        Fri, 06 Mar 2009 08:05:56 -0800 (PST)
Received: from localhost.localdomain ([116.49.57.31])
        by mx.google.com with ESMTPS id m25sm1266016waf.9.2009.03.06.08.05.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 08:05:55 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112457>

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
