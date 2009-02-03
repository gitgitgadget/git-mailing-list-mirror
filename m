From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [JGIT PATCH v2] Add a few test cases for AbstractTreeIterator's pathCompare
Date: Tue,  3 Feb 2009 18:20:23 +0100
Message-ID: <1233681623-22011-1-git-send-email-torarnv@gmail.com>
References: <49887A86.2040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOxy-0001Ig-A1
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZBCRUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbZBCRUP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:20:15 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:48845 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbZBCRUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:20:13 -0500
Received: by ewy14 with SMTP id 14so2614973ewy.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P8g3P4hOLoNsNbNPORHATBpBibyWGR8Z/sFkYeyWNcA=;
        b=X35kpSQSOzOkuvN//HH2fsgmTgJ6/R7fT67nyrj939Cd2rF6GPRdJ/2lXIPtUMGThW
         X2pPrn+1EbnuvR3G/7ifbSn4k2LGWAV8ZCG8o3RLQa3PZYzivnuqIEvVKEnyiW53WgfG
         D0oyuxCm+4GPZZ6EnRor0bBwnJy217TJXuZLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jCryFf6KXogIp+njoQZSGDDSlfAOuPppJuFlb4o9RjJkcdBJo2M3HmsXqx/zooQIlY
         edEfggf5b1RhK4CVjUxhAv8C0UDiVNb5Y2de0JzGjXf7AKe9ihBhiBqD0cfnQ9PRR5pN
         fVCGTnf8E8ka0f3Kc1JRzUgsPhPXtv//n1ZBM=
Received: by 10.103.160.10 with SMTP id m10mr2542725muo.50.1233681609379;
        Tue, 03 Feb 2009 09:20:09 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id u9sm370084muf.55.2009.02.03.09.20.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:20:08 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id A8EF1468001; Tue,  3 Feb 2009 18:20:23 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <49887A86.2040602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108222>

Tests that files sort before trees if the path is the same, and
that if both path and mode is the same, they are considered equal.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../jgit/treewalk/AbstractTreeIteratorTest.java    |   80 ++++++++++++=
++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/AbstractTreeIteratorTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/Abstra=
ctTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/tr=
eewalk/AbstractTreeIteratorTest.java
new file mode 100644
index 0000000..d45e22c
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeI=
teratorTest.java
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2009, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
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
+package org.spearce.jgit.treewalk;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+
+public class AbstractTreeIteratorTest extends RepositoryTestCase {
+
+
+	public class FakeTreeIterator extends WorkingTreeIterator {
+		public FakeTreeIterator(String path, FileMode fileMode) {
+			super(path);
+			mode =3D fileMode.getBits();
+			pathLen -=3D 1; // Get rid of extra '/'
+		}
+
+		@Override
+		public AbstractTreeIterator createSubtreeIterator(Repository repo)
+				throws IncorrectObjectTypeException, IOException {
+			return null;
+		}
+
+	}
+
+	public void testPathCompare() throws Exception {
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.TREE)) < 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) > 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.TREE)) =3D=3D 0);
+	}
+
+}
--=20
1.6.1.2.309.g2ea3
