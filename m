From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/12] Improve test coverage in revwalk
Date: Tue, 17 Mar 2009 18:40:39 -0700
Message-ID: <1237340451-31562-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjknU-0004bZ-JD
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbZCRBkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbZCRBky
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:40:54 -0400
Received: from george.spearce.org ([209.20.77.23]:56645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbZCRBky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:40:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2BD5738239; Wed, 18 Mar 2009 01:40:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9C168381D3;
	Wed, 18 Mar 2009 01:40:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113553>

Most of these patches are to improve the test coverage within the
revwalk package.


The last commit points out what I feared, which is that a RevWalk
with a PathFilter applied doesn't produce the same results that
git-core would produce in the same situation.  We're either missing
some functions necessary to implement it, or we flat out produce
a wrong graph in some cases.

The tests are commented out because JUnit doesn't have a notion of
"known broken".  But I did leave in TODO comments.  I'd like to
apply the test, and then work later to improve it, but I'm open
to suggestions.


Shawn O. Pearce (12):
  Fix copyright year in revwalk test file headers
  Mark non-overridable methods of RevObject final
  Change RevWalkTestCase to use RevCommit, not ObjectId
  Test that RevFilter.MERGE_BASE cannot use a TreeFilter
  Add unit tests for DateRevQueue
  Add unit tests for FIFORevQueue
  Add unit tests for LIFORevQueue
  Add unit tests for AbstractRevQueue.EMPTY_QUEUE
  Add tests for basic RevObject methods related to type, flags
  Add tests for ObjectWalk
  Add some basic logic tests for TreeFilter on RevWalk
  Implement git-core t/t6012-rev-list-simplify test case

 .../jgit/revwalk/AlwaysEmptyRevQueueTest.java      |   63 +++++++
 .../org/spearce/jgit/revwalk/DateRevQueueTest.java |  118 ++++++++++++
 .../org/spearce/jgit/revwalk/FIFORevQueueTest.java |   81 +++++++++
 .../org/spearce/jgit/revwalk/LIFORevQueueTest.java |   69 +++++++
 .../org/spearce/jgit/revwalk/ObjectWalkTest.java   |  190 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/RevFlagSetTest.java   |    2 +-
 .../org/spearce/jgit/revwalk/RevObjectTest.java    |  171 ++++++++++++++++++
 .../org/spearce/jgit/revwalk/RevQueueTestCase.java |   85 +++++++++
 .../org/spearce/jgit/revwalk/RevWalkCullTest.java  |   30 ++--
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |   93 +++++-----
 .../spearce/jgit/revwalk/RevWalkMergeBaseTest.java |   64 ++++---
 .../jgit/revwalk/RevWalkPathFilter1Test.java       |  176 ++++++++++++++++++
 .../jgit/revwalk/RevWalkPathFilter6012Test.java    |  162 +++++++++++++++++
 .../org/spearce/jgit/revwalk/RevWalkSortTest.java  |   66 ++++----
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |  110 ++++++++++--
 .../org/spearce/jgit/revwalk/AbstractRevQueue.java |    2 +-
 .../org/spearce/jgit/revwalk/BlockRevQueue.java    |    2 +-
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   20 +-
 18 files changed, 1353 insertions(+), 151 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/AlwaysEmptyRevQueueTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/DateRevQueueTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FIFORevQueueTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/LIFORevQueueTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/ObjectWalkTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevObjectTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevQueueTestCase.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter1Test.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter6012Test.java
