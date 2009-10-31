From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 03/28] pkt-line: Make packet_read_line easier to debug
Date: Fri, 30 Oct 2009 17:47:22 -0700
Message-ID: <1256950067-27938-5-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N428Z-0001cH-IY
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbZJaAru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbZJaArs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:47:48 -0400
Received: from george.spearce.org ([209.20.77.23]:36907 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbZJaArp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 17DFC38262; Sat, 31 Oct 2009 00:47:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 71A0338215
	for <git@vger.kernel.org>; Sat, 31 Oct 2009 00:47:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131783>

When there is an error parsing the 4 byte length component we now
display it as part of the die message, this may hint as to what
data was misunderstood by the application.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pkt-line.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index bd603f8..295ba2b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -129,7 +129,7 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	safe_read(fd, linelen, 4);
 	len = packet_length(linelen);
 	if (len < 0)
-		die("protocol error: bad line length character");
+		die("protocol error: bad line length character: %.4s", linelen);
 	if (!len)
 		return 0;
 	len -= 4;
-- 
1.6.5.2.181.gd6f41
