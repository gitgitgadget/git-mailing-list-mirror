From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/10] Merge API v2
Date: Thu, 22 Jan 2009 15:28:00 -0800
Message-ID: <1232666890-23488-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:29:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ8zV-0007uv-29
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZAVX2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZAVX2N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:28:13 -0500
Received: from george.spearce.org ([209.20.77.23]:55214 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbZAVX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:28:13 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 325E538215; Thu, 22 Jan 2009 23:28:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6EF763816F;
	Thu, 22 Jan 2009 23:28:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.399.g0d272
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106791>

2nd attempt at the merge API.  Changes from my prior posting last fall:

 - Fixed the bug Robin identified (the first patch in the series)
 - Rebased against current master
 - Basic smoke tests provided by Robin

Shawn O. Pearce (10):
  Fix TreeWalk.idEqual when both trees are missing the path
  Expose the raw path for the current entry of a TreeWalk
  Expose DirCacheEntry.getFileMode as a utility function
  Add writeTree support to DirCache
  Allow a DirCache to be created with no backing store file
  Allow CanonicalTreeParsers to be created with a UTF-8 path prefix
  Recursively load an entire tree into a DirCacheBuilder
  Allow DirCacheEntry instances to be created with stage > 0
  Define a basic merge API, and a two-way tree merge strategy
  Add a few simple merge test cases

 .../spearce/jgit/test/resources/create-second-pack |   13 +-
 ...ck-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx |  Bin 0 -> 1296 bytes
 ...k-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack |  Bin 0 -> 562 bytes
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 1088 -> 1100 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 2696 -> 2976 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 5956 -> 5901 bytes
 .../org/spearce/jgit/test/resources/packed-refs    |    4 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    3 +-
 .../org/spearce/jgit/merge/SimpleMergeTest.java    |   86 ++++++++
 .../org/spearce/jgit/transport/TransportTest.java  |    2 +-
 .../src/org/spearce/jgit/dircache/DirCache.java    |   37 ++++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |   65 ++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   61 +++++-
 .../org/spearce/jgit/dircache/DirCacheTree.java    |  115 +++++++++++
 .../spearce/jgit/errors/UnmergedPathException.java |   67 ++++++
 .../src/org/spearce/jgit/lib/FileMode.java         |    7 +
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   12 +-
 .../src/org/spearce/jgit/merge/MergeStrategy.java  |  134 ++++++++++++
 .../src/org/spearce/jgit/merge/Merger.java         |  213 ++++++++++++++++++++
 .../org/spearce/jgit/merge/StrategyOneSided.java   |   98 +++++++++
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |  179 ++++++++++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |   31 +++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   30 +++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   28 +++-
 24 files changed, 1170 insertions(+), 15 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
