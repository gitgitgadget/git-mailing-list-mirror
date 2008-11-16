From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/7 v3] Handle peeling of loose refs.
Date: Sun, 16 Nov 2008 14:37:23 -0800
Message-ID: <20081116223723.GJ2932@spearce.org>
References: <20081111183248.GR2932@spearce.org> <1226705099-18066-1-git-send-email-robin.rosenberg@dewire.com> <1226705099-18066-2-git-send-email-robin.rosenberg@dewire.com> <1226705099-18066-3-git-send-email-robin.rosenberg@dewire.com> <1226705099-18066-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 23:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1qGN-0001ie-VE
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 23:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYKPWhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYKPWhY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 17:37:24 -0500
Received: from george.spearce.org ([209.20.77.23]:50129 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYKPWhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 17:37:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 850F0381FF; Sun, 16 Nov 2008 22:37:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226705099-18066-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101170>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> For packed refs we got peeling automatically from packed-refs,
> but for loose tags we have to follow the tags and get the leaf
> object in order to comply with the documentation.

I merged your series, but I squashed the following into the patch
I am replying to:
 
 .../src/org/spearce/jgit/lib/Repository.java       |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5088150..c953531 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -942,13 +942,17 @@ public String getBranch() throws IOException {
 	}
 
 	/**
-	 * Peel a possibly unpeeled ref and updates it. If the ref cannot be peeled
-	 * the peeled id is set to {@link ObjectId#zeroId()}
+	 * Peel a possibly unpeeled ref and updates it.
+	 * <p>
+	 * If the ref cannot be peeled (as it does not refer to an annotated tag)
+	 * the peeled id stays null, but {@link Ref#isPeeled()} will be true.
 	 * 
 	 * @param ref
 	 *            The ref to peel
-	 * @return The same, an updated ref with peeled info or a new instance with
-	 *         more information
+	 * @return <code>ref</code> if <code>ref.isPeeled()</code> is true; else a
+	 *         new Ref object representing the same data as Ref, but isPeeled()
+	 *         will be true and getPeeledObjectId will contain the peeled object
+	 *         (or null).
 	 */
 	public Ref peel(final Ref ref) {
 		return refs.peel(ref);
-- 
1.6.0.4.969.g58a38

-- 
Shawn.
