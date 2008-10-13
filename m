From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/8] Crude merge support
Date: Mon, 13 Oct 2008 14:10:09 -0700
Message-ID: <1223932217-4771-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUhT-0001zY-LK
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbYJMVKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbYJMVKU
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:10:20 -0400
Received: from george.spearce.org ([209.20.77.23]:39763 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYJMVKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:10:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 250E038368; Mon, 13 Oct 2008 21:10:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 960AE3826E;
	Mon, 13 Oct 2008 21:10:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98148>

This series add some basic merge support to JGit.  Its more of a
"merge toolkit" than a merge implementation.  I have about 200
lines of code in another codebase that calls this stuff in JGit to
actually make a merge.  Eventually I hope to migrate a lot of that
code back into JGit, but for now its not here as I'm not entirely
sure what API merge applications need, and how much of that code
is application specific and how much of it should be core to JGit.

FWIW, that code will be open-sourced soon-ish too.  But I really
think a lot of it belongs in JGit, so it will probably migrate over.

No unit tests yet.  Yea, I know.  I've had this done and in use
for about 3 or 4 weeks now.  I just couldn't find the time to get
the Javadoc cleaned up to post to the list for comments, let alone
write unit tests.

But it does add the missing "write-tree" support to DirCache. :)

Shawn O. Pearce (8):
  Expose the raw path for the current entry of a TreeWalk
  Expose DirCacheEntry.getFileMode as a utility function
  Add writeTree support to DirCache
  Allow a DirCache to be created with no backing store file
  Allow CanonicalTreeParsers to be created with a UTF-8 path prefix
  Recursively load an entire tree into a DirCacheBuilder
  Allow DirCacheEntry instances to be created with stage > 0
  Define a basic merge API, and a two-way tree merge strategy

 .../src/org/spearce/jgit/dircache/DirCache.java    |   37 ++++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |   58 ++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   61 +++++-
 .../org/spearce/jgit/dircache/DirCacheTree.java    |  115 +++++++++++
 .../spearce/jgit/errors/UnmergedPathException.java |   67 +++++++
 .../src/org/spearce/jgit/lib/FileMode.java         |    7 +
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   12 +-
 .../src/org/spearce/jgit/merge/MergeStrategy.java  |  134 +++++++++++++
 .../src/org/spearce/jgit/merge/Merger.java         |  207 ++++++++++++++++++++
 .../org/spearce/jgit/merge/StrategyOneSided.java   |   98 +++++++++
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |  179 +++++++++++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |   31 +++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   28 +++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   17 ++-
 14 files changed, 1041 insertions(+), 10 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
