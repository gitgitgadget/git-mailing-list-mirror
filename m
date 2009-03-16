From: Dima Zavin <dima@android.com>
Subject: [PATCH] jgit: upload-pack: Force an fd flush after receiving flush pkt from client
Date: Mon, 16 Mar 2009 10:34:24 -0700
Message-ID: <1237224864-15649-1-git-send-email-dima@android.com>
Cc: spearce@spearce.org, Dima Zavin <dima@android.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 18:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGjL-0002NM-3m
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbZCPRef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZCPRee
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:34:34 -0400
Received: from smtp-out.google.com ([216.239.33.17]:32931 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbZCPRed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 13:34:33 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id n2GHYQbC003073;
	Mon, 16 Mar 2009 17:34:26 GMT
Received: from localhost (weppard.corp.google.com [172.18.103.134])
	by zps37.corp.google.com with ESMTP id n2GHYOTw009912;
	Mon, 16 Mar 2009 10:34:24 -0700
Received: by localhost (Postfix, from userid 17275)
	id 6B69DB38A7D; Mon, 16 Mar 2009 10:34:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.5
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113349>

Signed-off-by: Dima Zavin <dima@android.com>
---
 .../src/org/spearce/jgit/transport/UploadPack.java |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 71acda1..80c154b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -351,7 +351,7 @@ private void negotiate() throws IOException {
 			if (line.length() == 0) {
 				if (commonBase.isEmpty() || multiAck)
 					pckOut.writeString("NAK\n");
-
+				pckOut.flush();
 			} else if (line.startsWith("have ") && line.length() == 45) {
 				final ObjectId id = ObjectId.fromString(line.substring(5));
 				if (matchHave(id)) {
@@ -372,7 +372,6 @@ private void negotiate() throws IOException {
 			} else if (line.equals("done")) {
 				if (commonBase.isEmpty())
 					pckOut.writeString("NAK\n");
-
 				else if (multiAck)
 					pckOut.writeString("ACK " + last.name() + "\n");
 				break;
-- 
1.6.2
