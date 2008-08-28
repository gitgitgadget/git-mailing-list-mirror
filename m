From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 1/3] Give NoRemoteRepositoryException better message in BasePackConnection
Date: Thu, 28 Aug 2008 03:36:08 +0200
Message-ID: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWRu-0003Pc-3x
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYH1BgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbYH1BgS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:36:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:20135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYH1BgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:36:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so35073nfc.21
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hv9mXi5IWO2Hi+1ovvjPCmTYE+O7yyoEnUf1u3C0ymw=;
        b=WQp+CAlAcqPPRJBGXOTK2GUp8kmUTwMI52rRuoFArHopJ+mg55cPDS4y2PQoimp6F2
         w6ObJvCgyaPgJX3+thYbhsMqv5FoIYiToRG5vktQhBwwGhdRk1kDzIHaO70veixglllf
         o8T2TNYBohWIxbhDLEPQc2CulnU2hOS2wJ76k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L83t1ml2pZ0cbyr3skcZrR5xkyeutdLofD+BmwYnG2x3uYL2tQXcFWp3GavvfwRAQV
         btDqvR6l56kSiXwU5eWwa/FoSsPr2TfbAfU0WzLHWTRD3UeLYO3JppzFm+/X0LDtF0wR
         sI22+FMEdvPkDYZd5irbBTfIQxrCmNxiH43/s=
Received: by 10.103.221.5 with SMTP id y5mr447439muq.34.1219887376121;
        Wed, 27 Aug 2008 18:36:16 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id b9sm431133mug.13.2008.08.27.18.36.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 18:36:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94010>

Reported-by: Robert <robert_no.spam_m@yahoo.fr>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---

See http://code.google.com/p/egit/issues/detail?id=16

 .../spearce/jgit/transport/BasePackConnection.java |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 14fffc3..de0c7b6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -129,8 +129,15 @@ private void readAdvertisedRefsImpl() throws IOException {
 			try {
 				line = pckIn.readString();
 			} catch (EOFException eof) {
-				if (avail.isEmpty())
-					throw new NoRemoteRepositoryException(uri, "not found.");
+				if (avail.isEmpty()) {
+					String service = "unknown";
+					if (this instanceof PushConnection)
+						service = "push";
+					else if (this instanceof FetchConnection)
+						service = "fetch";
+					throw new NoRemoteRepositoryException(uri, service
+							+ " service not found.");
+				}
 				throw eof;
 			}
 
-- 
1.5.6.3
