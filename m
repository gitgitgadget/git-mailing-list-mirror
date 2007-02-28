From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 8/9] Handle odd tag formats created by tools such as
	cvsimport.
Date: Wed, 28 Feb 2007 23:26:47 +0100
Message-ID: <20070228222647.12021.99818.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLf-0002xY-1u
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXB1Wc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbXB1WcY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1433 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932578AbXB1WcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9728C8033A5
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:04 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-06 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:04 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 003DA8033A4
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 673012987C
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id JG4BxA6L6APJ for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:48 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id F239E29878
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:47 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41013>

These lack a date and have a message without a newline

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/PersonIdent.java      |   68 +++++++++++++----------
 org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java |    8 +-
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index bfcb34d..50a6a3b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -24,7 +24,7 @@ public class PersonIdent {
 
 	private final String emailAddress;
 
-	private final long when;
+	private final Long when;
 
 	private final int tzOffset;
 
@@ -43,7 +43,7 @@ public class PersonIdent {
 	public PersonIdent(final PersonIdent pi, final Date aWhen) {
 		name = pi.getName();
 		emailAddress = pi.getEmailAddress();
-		when = aWhen.getTime();
+		when = new Long(aWhen.getTime());
 		tzOffset = pi.tzOffset;
 	}
 
@@ -51,22 +51,22 @@ public class PersonIdent {
 			final Date aWhen, final TimeZone aTZ) {
 		name = aName;
 		emailAddress = aEmailAddress;
-		when = aWhen.getTime();
-		tzOffset = aTZ.getOffset(when) / (60 * 1000);
+		when = new Long(aWhen.getTime());
+		tzOffset = aTZ.getOffset(when.longValue()) / (60 * 1000);
 	}
 
 	public PersonIdent(final String aName, final String aEmailAddress,
 			final long aWhen, final int aTZ) {
 		name = aName;
 		emailAddress = aEmailAddress;
-		when = aWhen;
+		when = new Long(aWhen);
 		tzOffset = aTZ;
 	}
 
 	public PersonIdent(final PersonIdent pi, final long aWhen, final int aTZ) {
 		name = pi.getName();
 		emailAddress = pi.getEmailAddress();
-		when = aWhen;
+		when = new Long(aWhen);
 		tzOffset = aTZ;
 	}
 
@@ -83,22 +83,23 @@ public class PersonIdent {
 		}
 		final int sp = in.indexOf(' ', gt + 2);
 		if (sp == -1) {
-			throw new IllegalArgumentException("Malformed PersonIdent string"
-					+ " (no time zone found): " + in);
-		}
-		final String tzHoursStr = in.substring(sp + 1, sp + 4).trim();
-		final int tzHours;
-		if (tzHoursStr.charAt(0) == '+') {
-			tzHours = Integer.parseInt(tzHoursStr.substring(1));
+			when = null;
+			tzOffset = -1;
 		} else {
-			tzHours = Integer.parseInt(tzHoursStr);
+			final String tzHoursStr = in.substring(sp + 1, sp + 4).trim();
+			final int tzHours;
+			if (tzHoursStr.charAt(0) == '+') {
+				tzHours = Integer.parseInt(tzHoursStr.substring(1));
+			} else {
+				tzHours = Integer.parseInt(tzHoursStr);
+			}
+			final int tzMins = Integer.parseInt(in.substring(sp + 4).trim());
+			when = new Long(Long.parseLong(in.substring(gt + 1, sp).trim()) * 1000);
+			tzOffset = tzHours * 60 + tzMins;
 		}
-		final int tzMins = Integer.parseInt(in.substring(sp + 4).trim());
 
 		name = in.substring(0, lt).trim();
 		emailAddress = in.substring(lt + 1, gt).trim();
-		when = Long.parseLong(in.substring(gt + 1, sp).trim()) * 1000;
-		tzOffset = tzHours * 60 + tzMins;
 	}
 
 	public String getName() {
@@ -110,11 +111,13 @@ public class PersonIdent {
 	}
 
 	public Date getWhen() {
-		return new Date(when);
+		if (when != null)
+			return new Date(when.longValue());
+		return null;
 	}
 
 	public int hashCode() {
-		return getEmailAddress().hashCode() ^ ((int) when);
+		return getEmailAddress().hashCode() ^ (when.intValue());
 	}
 
 	public boolean equals(final Object o) {
@@ -148,18 +151,19 @@ public class PersonIdent {
 		r.append(" <");
 		r.append(getEmailAddress());
 		r.append("> ");
-		r.append(when / 1000);
-		r.append(' ');
-		r.append(sign);
-		if (offsetHours < 10) {
-			r.append('0');
-		}
-		r.append(offsetHours);
-		if (offsetMins < 10) {
-			r.append('0');
+		if (when != null) {
+			r.append(when.longValue() / 1000);
+			r.append(' ');
+			r.append(sign);
+			if (offsetHours < 10) {
+				r.append('0');
+			}
+			r.append(offsetHours);
+			if (offsetMins < 10) {
+				r.append('0');
+			}
+			r.append(offsetMins);
 		}
-		r.append(offsetMins);
-
 		return r.toString();
 	}
 
@@ -176,7 +180,9 @@ public class PersonIdent {
 		r.append(", ");
 		r.append(getEmailAddress());
 		r.append(", ");
-		r.append(new Date(when + minutes * 60));
+		if (when != null) {
+			r.append(new Date(when.longValue() + minutes * 60));
+		}
 		r.append("]");
 
 		return r.toString();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
index d9e6990..cd59ee9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
@@ -94,11 +94,7 @@ public class Tag {
 				}
 				tagger = new PersonIdent(n.substring("tagger ".length()));
 
-				n = br.readLine();
-				if (n == null || !n.equals("")) {
-					throw new CorruptObjectException(tagId,
-							"malformed header");
-				}
+				// Message should start with an empty line, but
 				StringBuffer tempMessage = new StringBuffer();
 				char[] readBuf = new char[2048];
 				int readLen;
@@ -106,6 +102,8 @@ public class Tag {
 					tempMessage.append(readBuf, 0, readLen);
 				}
 				message = tempMessage.toString();
+				if (message.startsWith("\n"))
+					message = message.substring(1);
 			} catch (IOException e) {
 				e.printStackTrace();
 			} finally {
