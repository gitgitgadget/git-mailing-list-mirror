From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/12] Clarify section and subsection values in Config code
Date: Tue, 21 Jul 2009 13:19:25 -0700
Message-ID: <1248207570-13880-8-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
 <1248207570-13880-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpw-0001jT-Re
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbZGUUTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbZGUUTk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:40 -0400
Received: from george.spearce.org ([209.20.77.23]:59242 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbZGUUTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DD95438239; Tue, 21 Jul 2009 20:19:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3B125381FF;
	Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123700>

When I first wrote this code I wasn't clear in my intent; the section
name was sometimes called "base" and the subsection name was somtimes
called "extendedBase".  This is nuts, everywhere else in our code we
use "section" and "subsection".  Renaming the fields makes the code
much easier to follow.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   84 ++++++++++----------
 1 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 4940cc2..a2934a2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -374,8 +374,8 @@ public String getString(final String section, String subsection,
 		ensureLoaded();
 
 		for (final Entry e : entries) {
-			if (section.equalsIgnoreCase(e.base) && e.extendedBase != null)
-				result.add(e.extendedBase);
+			if (section.equalsIgnoreCase(e.section) && e.subsection != null)
+				result.add(e.subsection);
 		}
 		if (baseConfig != null)
 			result.addAll(baseConfig.getSubsections(section));
@@ -582,8 +582,8 @@ public void setStringList(final String section, final String subsection,
 			byName.remove(key);
 		else if (values.size() == 1) {
 			final Entry e = new Entry();
-			e.base = section;
-			e.extendedBase = subsection;
+			e.section = section;
+			e.subsection = subsection;
 			e.name = name;
 			e.value = values.get(0);
 			byName.put(key, e);
@@ -591,8 +591,8 @@ else if (values.size() == 1) {
 			final ArrayList<Entry> eList = new ArrayList<Entry>(values.size());
 			for (final String v : values) {
 				final Entry e = new Entry();
-				e.base = section;
-				e.extendedBase = subsection;
+				e.section = section;
+				e.subsection = subsection;
 				e.name = name;
 				e.value = v;
 				eList.add(e);
@@ -639,15 +639,15 @@ else if (values.size() == 1) {
 				// so we must create a new section header at the end.
 				//
 				final Entry e = new Entry();
-				e.base = section;
-				e.extendedBase = subsection;
+				e.section = section;
+				e.subsection = subsection;
 				entries.add(e);
 				insertPosition = entries.size();
 			}
 			while (valueIndex < values.size()) {
 				final Entry e = new Entry();
-				e.base = section;
-				e.extendedBase = subsection;
+				e.section = section;
+				e.subsection = subsection;
 				e.name = name;
 				e.value = values.get(valueIndex++);
 				entries.add(insertPosition++, e);
@@ -686,17 +686,17 @@ protected void printConfig(final PrintWriter r) {
 			if (e.prefix != null) {
 				r.print(e.prefix);
 			}
-			if (e.base != null && e.name == null) {
+			if (e.section != null && e.name == null) {
 				r.print('[');
-				r.print(e.base);
-				if (e.extendedBase != null) {
+				r.print(e.section);
+				if (e.subsection != null) {
 					r.print(' ');
 					r.print('"');
-					r.print(escapeValue(e.extendedBase));
+					r.print(escapeValue(e.subsection));
 					r.print('"');
 				}
 				r.print(']');
-			} else if (e.base != null && e.name != null) {
+			} else if (e.section != null && e.name != null) {
 				if (e.prefix == null || "".equals(e.prefix)) {
 					r.print('\t');
 				}
@@ -740,7 +740,7 @@ public void load() throws IOException {
 				} else if ('\n' == in) {
 					// End of this entry.
 					add(e);
-					if (e.base != null) {
+					if (e.section != null) {
 						last = e;
 					}
 					e = new Entry();
@@ -750,18 +750,18 @@ public void load() throws IOException {
 				} else if (';' == in || '#' == in) {
 					// The rest of this line is a comment; put into suffix.
 					e.suffix = String.valueOf(in);
-				} else if (e.base == null && Character.isWhitespace(in)) {
+				} else if (e.section == null && Character.isWhitespace(in)) {
 					// Save the leading whitespace (if any).
 					if (e.prefix == null) {
 						e.prefix = "";
 					}
 					e.prefix += in;
 				} else if ('[' == in) {
-					// This is a group header line.
-					e.base = readBase(r);
+					// This is a section header.
+					e.section = readSectionName(r);
 					input = r.read();
 					if ('"' == input) {
-						e.extendedBase = readValue(r, true, '"');
+						e.subsection = readValue(r, true, '"');
 						input = r.read();
 					}
 					if (']' != input) {
@@ -770,10 +770,10 @@ public void load() throws IOException {
 					e.suffix = "";
 				} else if (last != null) {
 					// Read a value.
-					e.base = last.base;
-					e.extendedBase = last.extendedBase;
+					e.section = last.section;
+					e.subsection = last.subsection;
 					r.reset();
-					e.name = readName(r);
+					e.name = readKeyName(r);
 					if (e.name.endsWith("\n")) {
 						e.name = e.name.substring(0, e.name.length() - 1);
 						e.value = MAGIC_EMPTY_VALUE;
@@ -809,11 +809,11 @@ protected void clear() {
 	@SuppressWarnings("unchecked")
 	private void add(final Entry e) {
 		entries.add(e);
-		if (e.base != null) {
-			final String b = e.base.toLowerCase();
+		if (e.section != null) {
+			final String b = e.section.toLowerCase();
 			final String group;
-			if (e.extendedBase != null) {
-				group = b + "." + e.extendedBase;
+			if (e.subsection != null) {
+				group = b + "." + e.subsection;
 			} else {
 				group = b;
 			}
@@ -835,8 +835,9 @@ private void add(final Entry e) {
 		}
 	}
 
-	private static String readBase(final BufferedReader r) throws IOException {
-		final StringBuffer base = new StringBuffer();
+	private static String readSectionName(final BufferedReader r)
+			throws IOException {
+		final StringBuffer name = new StringBuffer();
 		for (;;) {
 			r.mark(1);
 			int c = r.read();
@@ -857,22 +858,23 @@ private static String readBase(final BufferedReader r) throws IOException {
 					} else if (' ' == c || '\t' == c) {
 						// Skipped...
 					} else {
-						throw new IOException("Bad base entry. : " + base + ","
-								+ c);
+						throw new IOException("Bad section entry. : " + name
+								+ "," + c);
 					}
 				}
 				break;
 			} else if (Character.isLetterOrDigit((char) c) || '.' == c
 					|| '-' == c) {
-				base.append((char) c);
+				name.append((char) c);
 			} else {
-				throw new IOException("Bad base entry. : " + base + ", " + c);
+				throw new IOException("Bad section entry. : " + name + ", " + c);
 			}
 		}
-		return base.toString();
+		return name.toString();
 	}
 
-	private static String readName(final BufferedReader r) throws IOException {
+	private static String readKeyName(final BufferedReader r)
+			throws IOException {
 		final StringBuffer name = new StringBuffer();
 		for (;;) {
 			r.mark(1);
@@ -1001,12 +1003,12 @@ private static String readValue(final BufferedReader r, boolean quote,
 		/**
 		 * The section name for the entry
 		 */
-		String base;
+		String section;
 
 		/**
 		 * Subsection name
 		 */
-		String extendedBase;
+		String subsection;
 
 		/**
 		 * The key name
@@ -1023,10 +1025,10 @@ private static String readValue(final BufferedReader r, boolean quote,
 		 */
 		String suffix;
 
-		boolean match(final String aBase, final String aExtendedBase,
-				final String aName) {
-			return eq(base, aBase) && eq(extendedBase, aExtendedBase)
-					&& eq(name, aName);
+		boolean match(final String aSection, final String aSubsection,
+				final String aKey) {
+			return eq(section, aSection) && eq(subsection, aSubsection)
+					&& eq(name, aKey);
 		}
 
 		private static boolean eq(final String a, final String b) {
-- 
1.6.4.rc1.186.g60aa0c
