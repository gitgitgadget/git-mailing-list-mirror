From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 07/12] Add overload of fromRaw() in MutableObjectId accepting int[]
Date: Mon,  2 Jun 2008 23:24:38 +0200
Message-ID: <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXr-0006g0-8S
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbYFBVZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYFBVZK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:38434 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYFBVZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844322fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VtOGMlde0FOnL2FXKyCNhidKJvO6V5nQ4Nlv0l4jq9Q=;
        b=xXoZSLmCdNrprHCYPE8JZ6niu7Tr4m8H7NCLIO+4tCOWo13t8nqnR8Q5gG8ifAPGprtkNZvHZ2NpMZ+MgSijdcokbMswGwIID2Thce59o7efm+v15yppLr4YTYxZVFrOlDyq8BeKjdNWQ6WKeYjjvl3SRvJN16OSaHkIct1MtRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y438m2dGtQEMOxHE7FA/3baiF+MiWXxlUN1hDlG4MDGDv/TBA7V62+3Efwt6+Md3F9l2xDBY4+V1Mi4UaHdGr6DViSrDatNVU5xzNKir4yRirEmigeRbVlxlujTqvPNDP3ySXJnqMrHNyJM5klL34vtx7i80sEDUYAX8s07aDHQ=
Received: by 10.86.49.3 with SMTP id w3mr6161844fgw.4.1212441907982;
        Mon, 02 Jun 2008 14:25:07 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm5506062fga.2.2008.06.02.14.25.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83568>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   29 ++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index b23d36c..954380b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -74,6 +74,35 @@ public class MutableObjectId extends AnyObjectId {
 	}
 
 	/**
+	 * Convert an ObjectId from binary representation expressed in integers.
+	 * 
+	 * @param ints
+	 *            the raw int buffer to read from. At least 5 integers must be
+	 *            available within this integers array.
+	 */
+	public void fromRaw(final int[] ints) {
+		fromRaw(ints, 0);
+	}
+
+	/**
+	 * Convert an ObjectId from binary representation expressed in integers.
+	 * 
+	 * @param ints
+	 *            the raw int buffer to read from. At least 5 integers after p
+	 *            must be available within this integers array.
+	 * @param p
+	 *            position to read the first integer of data from.
+	 * 
+	 */
+	public void fromRaw(final int[] ints, final int p) {
+		w1 = ints[p];
+		w2 = ints[p + 1];
+		w3 = ints[p + 2];
+		w4 = ints[p + 3];
+		w5 = ints[p + 4];
+	}
+
+	/**
 	 * Convert an ObjectId from hex characters (US-ASCII).
 	 * 
 	 * @param buf
-- 
1.5.5.1
