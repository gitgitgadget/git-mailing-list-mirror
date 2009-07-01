From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Support for delegating tree iterators
Date: Wed, 1 Jul 2009 15:34:48 -0700
Message-ID: <20090701223448.GT11191@spearce.org>
References: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM8OH-0004em-68
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZGAWeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbZGAWep
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:34:45 -0400
Received: from george.spearce.org ([209.20.77.23]:47174 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZGAWep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:34:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5FF1D381FD; Wed,  1 Jul 2009 22:34:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122609>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> This patch introduce some methods that simplify creation of tree
> iterators that wraps other iterators and which are located in
> other package. Such iterators need to efficiently access the
> name component of the path of wrapped iterator and wrapped bits.
> The patch also adds a method that ensuring that path buffer has
> a requried capacity when the required capacity is known in advance.
> 
> Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>

Thanks, two style nits, I fixed during apply:

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 2fe756e..50befbe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -264,15 +264,13 @@ protected void growPath(final int len) {
 	 *            the amount of live bytes in path buffer
 	 */
 	protected void ensurePathCapacity(final int capacity, final int len) {
-		if(path.length >= capacity) {
+		if (path.length >= capacity)
 			return;
-		}
 		final byte[] o = path;
 		int current = o.length;
 		int newCapacity = current;
-		while(newCapacity < capacity && newCapacity > 0) {
+		while (newCapacity < capacity && newCapacity > 0)
 			newCapacity <<= 1;
-		}
 		setPathCapacity(newCapacity, len);
 	}
 
> ---
> Note that WorkingTreeIterator.parseEntry is possibly might be a good 
> place to use ensurePathCapacity(...) instead or growPath(...).

Yes.  I'll send a change shortly.
   
-- 
Shawn.
