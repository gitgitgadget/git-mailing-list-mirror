From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch FileHeaders
Date: Thu, 11 Dec 2008 21:39:29 +0100
Message-ID: <200812112139.29875.robin.rosenberg.lists@dewire.com>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <200812111934.13218.robin.rosenberg.lists@dewire.com> <20081211183954.GH32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsLD-0002z3-LY
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbYLKUjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757227AbYLKUje
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:39:34 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:33823 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757192AbYLKUje (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 15:39:34 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C501F380BA; Thu, 11 Dec 2008 21:39:31 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081211183954.GH32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102823>

torsdag 11 december 2008 19:39:54 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > +		assertEquals(572, fRepositoryConfigTest.startOffset);
> > > +		assertEquals(1490, fRepositoryConfig.startOffset);
> >
> > 1487 here
> 
> Really?  1490 is the only value that the test vector passes with.
> What's the 3 bytes you think I'm off by?

...Quick, quick, find something else to pick on..  :->

Yes. Very little of the code in TemporaryBuffer is covered by the unit tests
and number of conditionals in there are rather large. I tried messing with
the constants in there to improve that and then PatchTest started to fail.

Here are the changes I tried with. I think it should still work with thes
changes. Rather than changing the other tests, we might want to create
a special test for only the buffer class.

-- robin

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index 27f6444..556ab71 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -60,7 +60,7 @@
  * after this stream has been properly closed by {@link #close()}.
  */
 public class TemporaryBuffer extends OutputStream {
-       private static final int DEFAULT_IN_CORE_LIMIT = 1024 * 1024;
+       private static final int DEFAULT_IN_CORE_LIMIT = 1024;

        /** Chain of data, if we are still completely in-core; otherwise null. */
        private ArrayList<Block> blocks;
@@ -315,7 +315,7 @@ public void destroy() {
        }

        private static class Block {
-               static final int SZ = 8 * 1024;
+               static final int SZ = 512;

                final byte[] buffer = new byte[SZ];
