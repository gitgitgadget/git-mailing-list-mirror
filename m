From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH JGIT 2/2] Test case for pack index CRC
Date: Wed, 25 Mar 2009 14:21:55 +0800
Message-ID: <1237962115-22709-2-git-send-email-j16sdiz+freenet@gmail.com>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
 <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMWc-0003wL-8o
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbZCYGWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZCYGWH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:22:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:55964 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbZCYGWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:22:04 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3871151wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=XjHgUqno+TpR350q+qIga8Um0rn2vh9QmYBfPI1aw/4=;
        b=IqdeMrouQQ3Pag8pc+kPAoUSbpAHirVJFSusTVBoqo5r7lrGp1Dkv7jryeVehrVlC3
         0mcs+LKlQVjOD9uz/mTq1J7fiTl9KDXowsdyQ1PAbOXH1qZ7GnRWOr8azjMAGBoFSYEj
         bsSwuc1/qGl0Hb+kJbiaxoygOsoqazhlDFArA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=StQVL3y/UrLvevzgyA3RpfqANi02T98ZT3xTN5LmyL0aQPpdg8JG+xPpD43krtApWI
         vAcoGVuF+Mi+zHzlkkv7rbq+4KoAcD7URf2ihU8X+EbEDTAvw5XSG7CVJ1dI2MieuBFa
         vmJH8uLwmQ1tpW5P15Ep9jkUTKsLZKJXUfWqM=
Received: by 10.142.156.19 with SMTP id d19mr3770386wfe.6.1237962122795;
        Tue, 24 Mar 2009 23:22:02 -0700 (PDT)
Received: from localhost.localdomain ([116.49.52.167])
        by mx.google.com with ESMTPS id 30sm15182156wfg.54.2009.03.24.23.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 23:22:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114568>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index f7139fc..9a5513f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -354,6 +354,15 @@ public class PackWriterTest extends RepositoryTestCase {
 		assertTrue(sizePack4 > sizePack4Thin);
 	}
 
+	public void testWriteIndex() throws Exception {
+		writer.setIndexVersion(2);
+		writeVerifyPack4(true);
+		
+		PackIndex idx = PackIndex.open(indexFile);
+		assertEquals(0x4743F1E4L, idx.findCRC32(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7")));
+	}
+
 	// TODO: testWritePackDeltasCycle()
 	// TODO: testWritePackDeltasDepth()
 
@@ -470,6 +479,7 @@ public class PackWriterTest extends RepositoryTestCase {
 		final IndexPack indexer = new IndexPack(db, is, packBase);
 		indexer.setKeepEmpty(true);
 		indexer.setFixThin(thin);
+		indexer.setIndexVersion(2);
 		indexer.index(new TextProgressMonitor());
 		pack = new PackFile(indexFile, packFile);
 	}
-- 
1.6.2
