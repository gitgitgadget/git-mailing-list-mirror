From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Patch parsing API
Date: Wed, 10 Dec 2008 20:58:37 -0800
Message-ID: <1228971522-28764-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdef-000260-AV
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYLKE6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbYLKE6p
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:45 -0500
Received: from george.spearce.org ([209.20.77.23]:51647 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYLKE6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:44 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E91C838192; Thu, 11 Dec 2008 04:58:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 320FA38192;
	Thu, 11 Dec 2008 04:58:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102777>

This is an API to parse a Git style patch file and extract the
critical metadata from the header lines, including the hunk headers
and what lines they correspond to in the pre and post image files.

It requires the two other series I already sent out today for
QuotedString and AbbreviatedObjectId.

There's TODO markers left where we still need to insert code to
create some sort of warning object, and then hang the warnings off
the Patch class.  Given the size of the code I'm inclined to do that
as yet an additional patch, rather than squash it into this series.

My short-term roadmap related to this part of JGit:

 * Compute and collect warnings from malformed git-style patches
 * Correctly parse "git diff --cc" style output
 * Get it into egit.git

I'm stopping development once I have the diff --cc output parsing
correctly.  My rationale is right now I need the patch metadata
parsing in Gerrit 2, so that's what I'm teaching JGit to do.  Maybe
later in the month or early next I'll add patch application support,
because I also want that in Gerrit 2.  Patch application is not
currently a blocking item for me; but reading the patch metadata is.

Traditional patch support is really stubbed out too; there's a very
small subset of traditional (non-git) style patches this code can
scan the metadata from, but no tests to verify it.  Gerrit 2 gets
all of its data from a "git diff" process, so I only need support
for git diffs right now.  Yes, I'd like to add traditional patch
support too, but it won't be until later in 2009 that I would even
think about working on that myself.


Shawn O. Pearce (5):
  Add toByteArray() to TemporaryBuffer
  Add copy(InputStream) to TemporaryBuffer
  Define FileHeader to parse the header block of a git diff
  Define Patch to parse a sequence of patch FileHeaders
  Add HunkHeader to represent a single hunk of a file within a patch

 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |  395 ++++++++++++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |  155 +++++++
 .../patch/testParse_ConfigCaseInsensitive.patch    |   67 +++
 .../src/org/spearce/jgit/patch/FileHeader.java     |  480 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |  185 ++++++++
 .../src/org/spearce/jgit/patch/Patch.java          |  267 +++++++++++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |   51 ++
 7 files changed, 1600 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
