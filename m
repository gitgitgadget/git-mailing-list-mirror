From: Mark Struberg <struberg@yahoo.de>
Subject: [EGIT PATCH2/2] fixed-toString-for-CommitTimeRevFilter-wrote-JUnit-tests
Date: Mon, 15 Jun 2009 21:36:35 +0000 (GMT)
Message-ID: <168892.81103.qm@web27804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 23:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJrW-0004q2-Px
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935610AbZFOVgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935612AbZFOVgf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:36:35 -0400
Received: from web27804.mail.ukl.yahoo.com ([217.146.182.9]:35342 "HELO
	web27804.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S935581AbZFOVge convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:36:34 -0400
Received: (qmail 81582 invoked by uid 60001); 15 Jun 2009 21:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1245101796; bh=aRhDS1NKHcZff+lgG5/CiBZLLcTEMFZFXderuJq6cWw=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=fY9XHTE5GMNfXn3xuj8FrdBya7YulH66hOjHNU1+Ar29lE2Y12xl6tcZOhYyRfp4FpZI4OKspGMbJH+u4TK7kSDORfIVEsK0Bkgls/Ns7XRfMs/MLYtwaNH1TuHsDm6VCJgPKopA2DxTYT1RwIMIAz7omTEj7e/qw6ud68MOgkE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=At0MXSFy+ORW48cC1iQ/9/NjzLei2w+5ZsycF0rhnVnfBYXil2vZ9Hw/S61HLAnN5aPL6BuJeLWXtGaw49qvZh6Rr7exO7LeT+dSbUaUSkJLLMbzpiKaMkqN57+e8Giz2uN/6tL5PVRLC6zA7GXWgrPx8oz8izOFW1eAcfXheog=;
X-YMail-OSG: V4qat_cVM1k9TTwJybjsFk9_xTChy6I1Td9XvZvZ1kpjWZTtDvuml6ByxHxQeEQspEIyyjT1Dm0pEHcolEt_MjuNbv4PSOqoaVbVQdZK2EBgcAoYTN0QAMzyrkSTlHD1epGFR6ZhwRG27NfX6sh635xI_p1lWt3J032JNTD5ESbsti1LMZv1fUOCZqV3jJq6adMVBf7I1iRbKPz1L7CUbJORqiT4VW3xVlr5nPnZcb_T.yZDOnMPfdDfistjMN_piWHS9OdPNJ9B9_AarqTTz80ZOpy4Xjx8rgfJQZdh39mz2MtOzv5_ugb6KmPbT5cPYhzZ0sxmeB7djHrZT8a_TsVRlv9.68f3
Received: from [62.47.149.57] by web27804.mail.ukl.yahoo.com via HTTP; Mon, 15 Jun 2009 21:36:35 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121630>


>From 72dd9d071ce140f267b8b4effd34d122627135e6 Mon Sep 17 00:00:00 2001
From: Mark Struberg <struberg@yahoo.de>
Date: Mon, 15 Jun 2009 08:07:53 +0200
Subject: [PATCH] fixed toString for CommitTimeRevFilter + wrote JUnit tests for after, before and between walks

---
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |   62 ++++++++++++++++++++
 .../jgit/revwalk/filter/CommitTimeRevFilter.java   |   21 +++++--
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
index 6a26d2e..c9ed18c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
@@ -38,11 +38,13 @@
 package org.spearce.jgit.revwalk;
 
 import java.io.IOException;
+import java.util.Date;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.StopWalkException;
 import org.spearce.jgit.revwalk.filter.AndRevFilter;
+import org.spearce.jgit.revwalk.filter.CommitTimeRevFilter;
 import org.spearce.jgit.revwalk.filter.NotRevFilter;
 import org.spearce.jgit.revwalk.filter.OrRevFilter;
 import org.spearce.jgit.revwalk.filter.RevFilter;
@@ -215,6 +217,66 @@ public void testFilter_NO_MERGES() throws Exception {
 		assertCommit(a, rw.next());
 		assertNull(rw.next());
 	}
+	
+	public void testCommitTimeRevFilter() throws Exception {
+		final RevCommit a = commit();
+		tick(100);
+		
+		final RevCommit b = commit(a);
+		tick(100);
+		
+		Date since = new Date(nowTick);
+		final RevCommit c1 = commit(b);
+		tick(100);
+
+		final RevCommit c2 = commit(b);
+		tick(100);
+
+		Date until =  new Date(nowTick);
+		final RevCommit d = commit(c1, c2);
+		tick(100);
+
+		final RevCommit e = commit(d);
+
+		{
+			RevFilter after = CommitTimeRevFilter.after(since);
+			assertNotNull(after);
+			System.out.println(after.toString());
+			rw.setRevFilter(after);
+			markStart(e);
+			assertCommit(e, rw.next());
+			assertCommit(d, rw.next());
+			assertCommit(c2, rw.next());
+			assertCommit(c1, rw.next());
+			assertNull(rw.next());
+		}
+		
+		{
+			RevFilter before = CommitTimeRevFilter.before(until);
+			assertNotNull(before);
+			System.out.println(before.toString());
+			rw.reset();
+			rw.setRevFilter(before);
+			markStart(e);
+			assertCommit(c2, rw.next());
+			assertCommit(c1, rw.next());
+			assertCommit(b, rw.next());
+			assertCommit(a, rw.next());
+			assertNull(rw.next());
+		}
+
+		{
+			RevFilter between = CommitTimeRevFilter.between(since, until);
+			assertNotNull(between);
+			System.out.println(between.toString());
+			rw.reset();
+			rw.setRevFilter(between);
+			markStart(e);
+			assertCommit(c2, rw.next());
+			assertCommit(c1, rw.next());
+			assertNull(rw.next());
+		}
+	}
 
 	private static class MyAll extends RevFilter {
 		@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
index 0aaa78d..2af9862 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
@@ -93,11 +93,6 @@ public RevFilter clone() {
 		return this;
 	}
 
-	@Override
-	public String toString() {
-		return super.toString() + "(" + new Date(when * 1000) + ")";
-	}
-
 	private static class Before extends CommitTimeRevFilter {
 		Before(final long ts) {
 			super(ts);
@@ -109,6 +104,11 @@ public boolean include(final RevWalk walker, final RevCommit cmit)
 				IncorrectObjectTypeException, IOException {
 			return cmit.getCommitTime() <= when;
 		}
+
+		@Override
+		public String toString() {
+			return super.toString() + "(" + new Date(when * 1000L) + ")";
+		}
 	}
 
 	private static class After extends CommitTimeRevFilter {
@@ -128,6 +128,11 @@ public boolean include(final RevWalk walker, final RevCommit cmit)
 				throw StopWalkException.INSTANCE;
 			return true;
 		}
+
+		@Override
+		public String toString() {
+			return super.toString() + "(" + new Date(when * 1000L) + ")";
+		}
 	}
 
 	private static class Between extends CommitTimeRevFilter {
@@ -144,6 +149,12 @@ public boolean include(final RevWalk walker, final RevCommit cmit)
 				IncorrectObjectTypeException, IOException {
 			return cmit.getCommitTime() <= until && cmit.getCommitTime() >= when;
 		}
+
+		@Override
+		public String toString() {
+			return super.toString() + "(" + new Date(when * 1000L) + " - " + new Date(until * 1000L) + ")";
+		}
+
 	}
 
 }
-- 
1.6.0.6



      
