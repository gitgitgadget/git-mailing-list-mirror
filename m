From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 3/4] Added test for RefUpdate branch deletion
Date: Sat, 23 Aug 2008 08:45:46 +1000
Message-ID: <1219445147-6801-4-git-send-email-charleso@charleso.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org>
 <1219445147-6801-2-git-send-email-charleso@charleso.org>
 <1219445147-6801-3-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfPq-0000Sb-PT
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbYHVWqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYHVWqL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:46:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40755 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYHVWqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:46:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so50960ywe.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=G03CnwRO9M9ivk8sQTtv8QiJCUjt+IB0XfHMbaGyv4E=;
        b=VSHtdxrl6+Zc8as0A1hygx8oQtS5P1QvCd9LLR99wNf8p+O16iLBC8jtU3S2/tPPdp
         ig6VpRjkp65pm4Js5GsGxIARb1kKGLXuT2VAuzV3/0DB2UgM9j+CLDtWJP5NEW8g4bhf
         +AUxmGbOvBVPq7IGXQjZPTd7C+w1X56bwj+4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=jpHos/cl0KBKcL7Nbq1ft7mHHJBjimyCPfM/KRsv2n5TYgbjVOTuJYt+G2XylF6nFm
         bHo/vx1tS5EX6mHxC5CsdCcEPT/hT7LvpsqJiYM2bNu7J0i0ICM0mbBY7voGlky44g8c
         1kZ1tstcwE9t33zaTmLWbsZWo/kzml2P7Ft1g=
Received: by 10.114.58.6 with SMTP id g6mr1636564waa.68.1219445167246;
        Fri, 22 Aug 2008 15:46:07 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id q18sm3549776pog.13.2008.08.22.15.46.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 15:46:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
In-Reply-To: <1219445147-6801-3-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93388>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  106 ++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
new file mode 100644
index 0000000..62a60c3
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2008, Charles O'Farrell <charleso@charleso.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+
+import org.spearce.jgit.lib.RefUpdate.Result;
+
+public class RefUpdateTest extends RepositoryTestCase {
+
+	private RefUpdate updateRef(final String name) throws IOException {
+		final RefUpdate ref = db.updateRef(name);
+		ref.setNewObjectId(db.resolve(Constants.HEAD));
+		return ref;
+	}
+
+	private void delete(final RefUpdate ref, final Result expected)
+			throws IOException {
+		delete(ref, expected, true, true);
+	}
+
+	private void delete(final RefUpdate ref, final Result expected,
+			final boolean exists, final boolean removed) throws IOException {
+		assertEquals(exists, db.getAllRefs().containsKey(ref.getName()));
+		assertEquals(expected, ref.delete());
+		assertEquals(!removed, db.getAllRefs().containsKey(ref.getName()));
+	}
+
+	public void testLooseDelete() throws IOException {
+		final String newRef = "refs/heads/abc";
+		RefUpdate ref = updateRef(newRef);
+		ref.update(); // create loose ref
+		ref = updateRef(newRef); // refresh
+		delete(ref, Result.NO_CHANGE);
+	}
+
+	public void testDeleteHead() throws IOException {
+		final RefUpdate ref = updateRef(Constants.HEAD);
+		delete(ref, Result.NOT_ATTEMPTED, true, false);
+	}
+
+	public void testLogDeleted() throws IOException {
+		final File log = new File(db.getDirectory(), Constants.LOGS
+				+ "/refs/heads/a");
+		log.getParentFile().mkdirs();
+		log.createNewFile();
+		assertTrue(log.exists());
+		final RefUpdate ref = updateRef("refs/heads/a");
+		delete(ref, Result.FAST_FORWARD);
+		assertFalse(log.exists());
+	}
+
+	public void testDeleteNotFound() throws IOException {
+		final RefUpdate ref = updateRef("refs/heads/xyz");
+		delete(ref, Result.NEW, false, true);
+	}
+
+	public void testDeleteFastForward() throws IOException {
+		final RefUpdate ref = updateRef("refs/heads/a");
+		delete(ref, Result.FAST_FORWARD);
+	}
+
+	public void testDeleteForce() throws IOException {
+		final RefUpdate ref = db.updateRef("refs/heads/b");
+		ref.setNewObjectId(db.resolve("refs/heads/a"));
+		delete(ref, Result.REJECTED, true, false);
+		ref.setForceUpdate(true);
+		delete(ref, Result.FORCED);
+	}
+}
-- 
1.6.0.49.gea35
