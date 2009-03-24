From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [JGIT Test Case] This (incomplete) test case demo the index wrong CRC bug.
Date: Tue, 24 Mar 2009 19:13:30 +0800
Message-ID: <1237893210-23073-1-git-send-email-j16sdiz+freenet@gmail.com>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
Cc: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 12:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm4b8-0005QP-TG
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbZCXLNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 07:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbZCXLNi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:13:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:35941 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZCXLNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 07:13:37 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3370536wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ApgpEQVwofalme0/sB0kwpk5hxdw/R0cTyu/kyDlyxk=;
        b=NoPUGLKZFkDUAc+YXP/vYRbbw8A3Baf5c8wxdfKMXGbsaS6RxHVs895SdEGtpfR4EX
         9mT0kkEeHO+YnRCQ9seewVkGUYIfDfyYy7lz7FPM6b/sWdAv3br7jWOEjgMnysklogQt
         GvfEdHz6dQOWCjX+BCFD37RarFsgCyOP2nkAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=q6h7zcob6gQZvSa3LjVVQAPtKd9nyhj6qPZe0TzziATNC5joAjY51hly5QoHPcgcl/
         qxFDJr6b2g7TjvcNC0ygY26huZDL6sEgGDtEPb+vfp1PJIIczMHel/iqCnYeb8l4qXiP
         GuyYhAqxgWs+OaTtopBCYZmDTSmqT5lWt0nhw=
Received: by 10.142.77.7 with SMTP id z7mr3332606wfa.230.1237893215037;
        Tue, 24 Mar 2009 04:13:35 -0700 (PDT)
Received: from localhost.localdomain ([116.49.52.167])
        by mx.google.com with ESMTPS id 29sm13404003wfg.53.2009.03.24.04.13.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 04:13:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114449>

The PackIndex always give 0 for CRC.
I know this patch is ugly, but I am not familiar with the code to make a good test code.

Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index f7139fc..0279c6b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -40,6 +40,7 @@
 import java.io.ByteArrayInputStream;
 import java.io.ByteArrayOutputStream;
 import java.io.File;
+import java.io.FileOutputStream;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.ArrayList;
@@ -354,6 +355,19 @@ public void testWritePack4SizeThinVsNoThin() throws Exception {
 		assertTrue(sizePack4 > sizePack4Thin);
 	}
 
+	public void testWriteIndex() throws Exception {
+		testWritePack4();
+
+		File idxFile = File.createTempFile("temp", ".idx");
+		FileOutputStream ios = new FileOutputStream(idxFile);
+		writer.writeIndex(ios);
+		ios.close();
+
+		PackIndex idx = PackIndex.open(idxFile);
+		assertFalse(0 == idx.findCRC32(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7")));
+	}
+
 	// TODO: testWritePackDeltasCycle()
 	// TODO: testWritePackDeltasDepth()
 
-- 
1.6.2
