From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] use java 5 like for loops
Date: Sat, 31 Jan 2009 15:19:30 +0100
Message-ID: <1233411570.7844.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTGiR-0007bY-Lq
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbZAaOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZAaOTg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:19:36 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:56756 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZAaOTg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:19:36 -0500
Received: by fk-out-0910.google.com with SMTP id f33so760266fkf.5
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=qxXGr8FD1CFWjg1rjv3UXekZSeVgnOx5fHYbiMD4JM8=;
        b=e9RiHhykeAk0M2lXhbn05woLpyo51u6v6xM2z0HHyQa9OCMad/PkS5n8b8ZutGJTHc
         UKfP4BvjFc+AY7iEgQKd7nFLVhbt4BY+OinJxmENDpZpW54doMN5uttMtWd5snU8IZ3+
         WIM+lL4Ot3B3mThtW8mYYlb6UXMpDddzEsfw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=N8gPFgaxWJ8Jp2apSKI2G/tjLJO3YGSJkiAkVGQf3bp0Fmngv0EfAMs6xyytjjshPv
         56Mfo/C+dKgLTirek7UsPA5hDjNAcJcIwRL3jkUtEHC8VQULR5Uyy1T6snnG8Muw6aVy
         hc7Z1gr0jc9OxzNJL39Bs/J1CXZnimgv/QfYM=
Received: by 10.103.49.12 with SMTP id b12mr1043712muk.98.1233411573109;
        Sat, 31 Jan 2009 06:19:33 -0800 (PST)
Received: from ?85.178.76.63? (e178076063.adsl.alicedsl.de [85.178.76.63])
        by mx.google.com with ESMTPS id e9sm1434510muf.21.2009.01.31.06.19.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 06:19:32 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107924>

in for loops that use an iterator or an index (int i), use instead a
loop like: for (Element e : elements)
Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    6 ++----
 .../src/org/spearce/jgit/lib/Repository.java       |    4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 6eeccff..920a9c9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -754,8 +754,7 @@ public Entry addEntry(TreeEntry te) throws
IOException {
 	 * @throws IOException
 	 */
 	public void checkout(File wd) throws IOException {
-		for (Iterator i = entries.values().iterator(); i.hasNext();) {
-			Entry e = (Entry) i.next();
+		for (Entry e : entries.values()) {
 			if (e.getStage() != 0)
 				continue;
 			checkoutEntry(wd, e);
@@ -808,8 +807,7 @@ public ObjectId writeTree() throws IOException {
 		Stack<Tree> trees = new Stack<Tree>();
 		trees.push(current);
 		String[] prevName = new String[0];
-		for (Iterator i = entries.values().iterator(); i.hasNext();) {
-			Entry e = (Entry) i.next();
+		for (Entry e : entries.values()) {
 			if (e.getStage() != 0)
 				continue;
 			String[] newName = splitDirPath(e.getName());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index e1c4049..038a869 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -231,8 +231,8 @@ public File toFile(final AnyObjectId objectId) {
 		String d=n.substring(0, 2);
 		String f=n.substring(2);
 		final File[] objectsDirs = objectsDirs();
-		for (int i=0; i<objectsDirs.length; ++i) {
-			File ret = new File(new File(objectsDirs[i], d), f);
+		for (File objectsDir : objectsDirs) {
+			File ret = new File(new File(objectsDir, d), f);
 			if (ret.exists())
 				return ret;
 		}
-- 
1.6.0.6
