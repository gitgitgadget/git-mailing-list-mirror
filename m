From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] Diff processing utilities
Date: Fri,  1 May 2009 19:08:41 -0700
Message-ID: <1241230127-28279-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fL-0003rn-NP
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZEBCJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZEBCJK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:10 -0400
Received: from george.spearce.org ([209.20.77.23]:48657 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbZEBCJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3E34F3809A; Sat,  2 May 2009 02:09:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 58E453807B;
	Sat,  2 May 2009 02:08:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118118>

Back in late 2008 Dscho started writing some basic diff routines
for JGit.  That work got partially shelved when he had to move onto
more important day-job topics.  This series is starting to revive
some portions of his work, and bring it into JGit.

In particular I want at least this much merged, so I can use it
in Gerrit Code Review to massage an existing patch file before I
display it.  Currently most of that logic is within Gerrit, and
I'd much rather push it down into JGit where anyone can reuse it.

To be clear, this series *does not* contain a way to create a diff.
Dscho wrote much more code which is not yet ready for inclusion.

After applying this series we have an EditList describing what
happened in an existing patch we parsed with the existing Patch
class, and a DiffFormatter which can be used to reflow a patch
script if the repository has both the pre and post image objects.

The formatter part is really only useful if the repository created
the patch script, or received the objects over a git native object
transport, like Gerrit Code Review does with SSH.

Dscho, can you give us yea-or-nay for SBO lines for the patches
I've attributed to you?


Johannes E. Schindelin (3):
  Add diff.Edit to describe an edit region within a file
  Add diff.RawText to index a file content for later compares
  Add diff.DiffFormatter to create Git style unified patch scripts

Shawn O. Pearce (3):
  Add set to IntList
  Add diff.EditList to provide for a list of Edit instances
  Teach FileHeader, HunkHeader how to create an EditList

 .../spearce/jgit/patch/testEditList_Types.patch    |   24 +++
 .../tst/org/spearce/jgit/diff/EditListTest.java    |  121 +++++++++++++
 .../tst/org/spearce/jgit/diff/EditTest.java        |  139 ++++++++++++++
 .../tst/org/spearce/jgit/diff/RawTextTest.java     |   93 ++++++++++
 .../tst/org/spearce/jgit/patch/EditListTest.java   |   95 ++++++++++
 .../tst/org/spearce/jgit/util/IntListTest.java     |   21 +++
 .../src/org/spearce/jgit/diff/DiffFormatter.java   |  187 +++++++++++++++++++
 .../src/org/spearce/jgit/diff/Edit.java            |  189 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/EditList.java        |   93 ++++++++++
 .../src/org/spearce/jgit/diff/RawText.java         |  172 ++++++++++++++++++
 .../src/org/spearce/jgit/diff/Sequence.java        |   78 ++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |    9 +
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   48 +++++
 .../src/org/spearce/jgit/util/IntList.java         |   17 ++
 14 files changed, 1286 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testEditList_Types.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditListTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/RawTextTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/EditListTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/Edit.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/EditList.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/Sequence.java
