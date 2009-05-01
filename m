From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH EGIT 1/2] Implement "jgit rev-parse"
Date: Fri,  1 May 2009 18:36:11 +0800
Message-ID: <1241174172-19581-1-git-send-email-git@sdiz.net>
Cc: git@vger.kernel.org, "Daniel Cheng (aka SDiZ)" <git@sdiz.net>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 01 12:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzq6W-00040b-Vl
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 12:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbZEAKgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 06:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZEAKgT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 06:36:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:60732 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbZEAKgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 06:36:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1833305rvb.1
        for <git@vger.kernel.org>; Fri, 01 May 2009 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=NOfeUw4c3T6v6VgLDEFRgUsROafrCJY2PTklYRPon6g=;
        b=rY22+7ws0ZndPDVVOVv8MrK+Ystu8rXnTwv78D6gHuYMqe9wspFT76v4NRDkfI28LM
         7KReaJlLik/77+nL65pL3K59m1Ht3fOjMeiIlu7vPkGvwSNhKt51jREvpZX6kyKVmXqG
         1XuF2EKke58mPtPQUJ9H7ZnGKf4BwE5dCE09Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=fLAbB3JTYiDiIbIH1gSJ2F8LHJibhV3i2OBk90R+1T6HBtBG/N4c7GMph+Cbi5mtGz
         mGRdeCExWXsbSy/4JPj/nXZAmYqbOoGpdhRclqp8R/L06wyU3OkTCqxOrGuWfLOCRSCc
         lHe4p6htfBlUfiCFuB7zebCKqG1DNw5UArKcw=
Received: by 10.142.44.11 with SMTP id r11mr853131wfr.186.1241174177801;
        Fri, 01 May 2009 03:36:17 -0700 (PDT)
Received: from localhost.localdomain (n1164956087.netvigator.com [116.49.56.87])
        by mx.google.com with ESMTPS id 20sm8582236wfi.20.2009.05.01.03.36.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 03:36:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118073>


Signed-off-by: Daniel Cheng (aka SDiZ) <git@sdiz.net>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/RevParse.java         |   70 ++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 2fe6612..7e24516 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -13,6 +13,7 @@ org.spearce.jgit.pgm.MergeBase
 org.spearce.jgit.pgm.Push
 org.spearce.jgit.pgm.ReceivePack
 org.spearce.jgit.pgm.RevList
+org.spearce.jgit.pgm.RevParse
 org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java
new file mode 100644
index 0000000..9cd6e95
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2009, Daniel Cheng (aka SDiZ) <git@sdiz.net>
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
+package org.spearce.jgit.pgm;
+
+import java.util.ArrayList;
+import java.util.List;
+import java.util.Map;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.revwalk.RevWalk;
+
+class RevParse extends TextBuiltin {
+	RevWalk walk;
+
+	@Option(name = "--all")
+	boolean all = false;
+
+	@Argument(index = 0, metaVar = "commit-ish")
+	private final List<ObjectId> commits = new ArrayList<ObjectId>();
+
+	@Override
+	protected void run() throws Exception {
+		if (all) {
+			Map<String, Ref> allRefs = db.getAllRefs();
+			for (final Ref r : allRefs.values())
+				System.out.println(r.getObjectId().name());
+		} else {
+			for (final ObjectId o : commits)
+				System.out.println(o.name());
+		}
+	}
+}
-- 
1.6.2.1
