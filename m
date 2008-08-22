From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit Patch v2 5/7] Add script for adding second pack for test
	purpose
Date: Fri, 22 Aug 2008 09:06:51 -0700
Message-ID: <20080822160651.GI3483@spearce.org>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com> <1219288394-1241-2-git-send-email-imyousuf@gmail.com> <1219288394-1241-3-git-send-email-imyousuf@gmail.com> <1219288394-1241-4-git-send-email-imyousuf@gmail.com> <1219288394-1241-5-git-send-email-imyousuf@gmail.com> <20080821151252.GS3483@spearce.org> <9e85b2570808211952sa903434lacd575388ad2d2d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Imran M Yousuf <imran@smartitengineering.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZB6-00081u-8t
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYHVQGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYHVQGx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:06:53 -0400
Received: from george.spearce.org ([209.20.77.23]:44594 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYHVQGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:06:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D2FCB38375; Fri, 22 Aug 2008 16:06:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e85b2570808211952sa903434lacd575388ad2d2d8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93321>

Imran M Yousuf <imran@smartitengineering.com> wrote:
> On Thu, Aug 21, 2008 at 9:12 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > imyousuf@gmail.com wrote:
> >> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> >>
> >> Forgot to add it last time and thus adding it before removing duplicate
> >> resources.
> >
> > I would squash this to the one that copies the other resources.
> 
> I would gladly make the changes (in this patch and the other ones) if
> I am sure that this series does not break the build with Eclipse. I
> would be extremely grateful if you would please confirm this to me.

OK, so your series end result would be fine, if you squash this into
it as well.  The "tst" variable is no longe rused in one location due
to the introduction of JGitTestUtil, and you missed one location that
needed to be converted from "tst" to JGitTestUtil.  Otherwise the end
result looks good in Eclipse and in ./make_jgit.sh.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 310690a..270b90a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -143,7 +143,6 @@ public void run() {
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
 		};
-		final File tst = new File("tst");
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
 		for (int k = 0; k < packs.length; k++) {
 			copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".pack"), new File(packDir,
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index c036e79..3d81bc4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -41,9 +41,11 @@
 import java.io.File;
 import java.io.IOException;
 
+import org.spearce.jgit.util.JGitTestUtil;
+
 public class T0004_PackReader extends RepositoryTestCase {
 	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
-	private static final File TEST_PACK = new File(new File("tst"), PACK_NAME + ".pack");
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
 	private static final File TEST_IDX = new File(TEST_PACK.getParentFile(), PACK_NAME + ".idx");
 
 	public void test003_lookupCompressedObject() throws IOException {


-- 
Shawn.
