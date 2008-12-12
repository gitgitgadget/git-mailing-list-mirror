From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/41] JGIT patch api series
Date: Fri, 12 Dec 2008 14:09:43 -0800
Message-ID: <20081212220943.GS32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGDv-0005sp-Dv
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYLLWJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYLLWJp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:09:45 -0500
Received: from george.spearce.org ([209.20.77.23]:45857 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYLLWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:09:44 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id AB73238200; Fri, 12 Dec 2008 22:09:43 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102961>

I think I've finished my work on the basic patch API for JGit.
A full summary of all of the commits appears below, along with the
final diffstat relative to the current master branch. 41 commits
and 6,151 lines of code in 3 days.  Yikes.

  git://repo.or.cz/egit/spearce.git patchapi

Shawn O. Pearce (41):
      Define an abstraction for handling abbreviated SHA-1 strings
      Add ObjectId.startsWith(AbbreviatedObjectId)
      Change AnyObjectId.abbreviate() to return AbbreviatedObjectId
      Simplify RawParseUtils.nextLF invocations
      Simplify RawParseUtils next and nextLF loops
      Correct Javadoc of RawParseUtils next and nextLF methods
      Add QuotedString class to handle Git path style quoting rules
      Add Bourne style quoting for TransportGitSsh
      Add ~user friendly Bourne style quoting for TransportGitSsh
      Add toByteArray() to TemporaryBuffer
      Add copy(InputStream) to TemporaryBuffer
      Define FileHeader to parse the header block of a git diff
      Define Patch to parse a sequence of patch FileHeaders
      Add HunkHeader to represent a single hunk of a file within a patch
      Correct use of TemporaryBuffer in Patch
      Add tests for TemporaryBuffer
      Add IntList as a more efficient representation of List<Integer>
      Add lineMap computer to RawParseUtils to index locations of line starts
      Define FileHeader.PatchType to report the style of patch used
      Test for non-git binary files and mark them as PatchType.BINARY
      Set empty patches with no Git metadata to PatchType.BINARY
      Always use the FileHeader buffer during Patch.parseHunks
      Parse "GIT binary patch" style patch metadata
      Record patch parsing errors for later inspection by applications
      Fix Patch.parse to honor the end point passed in
      Correctly handle hunk headers such as "@@ -0,0 +1 @@"
      Patch parse test comparing "git log -p" output to "git log --numstat"
      Abstract the hunk header testing into a method
      Treat "diff --combined" the same as "diff --cc"
      Assert the HunkHeader.getFileHeader returns the right file
      Add tests to cover more methods of BinaryHunk
      Add a simple toString to FormatError to facilitate debugging
      Allow FileHeader to create its HunkHeader children
      Refactor the old/pre-image data in HunkHeader to support >1 ancestor
      Assert the ChunkHeader.OldImage.getId uses FileHeader.getOldImage
      Allow a stray LF at the end of a hunk
      Fix HunkHeader start line when parsing "@@ -1 +1 @@" style headers
      Add test cases for parsing "\ No newline at end of file" style patches
      Use FileMode.MISSING when a file is added or deleted rather than null
      Add a test for delta binary patch parsing and fix a bug in it
      Add support for parsing "diff --cc" style patches

 .../ui/internal/components/RefContentProposal.java |    2 +-
 .../egit/ui/internal/fetch/FetchResultTable.java   |   12 +-
 .../egit/ui/internal/push/PushResultTable.java     |   21 +-
 .../src/org/spearce/jgit/pgm/Branch.java           |    2 +-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    8 +-
 .../src/org/spearce/jgit/pgm/Push.java             |    5 +-
 .../spearce/jgit/patch/EGitPatchHistoryTest.java   |  221 ++++++++
 .../spearce/jgit/lib/AbbreviatedObjectIdTest.java  |  285 ++++++++++
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |  427 +++++++++++++++
 .../org/spearce/jgit/patch/PatchCcErrorTest.java   |   97 ++++
 .../tst/org/spearce/jgit/patch/PatchCcTest.java    |  200 +++++++
 .../tst/org/spearce/jgit/patch/PatchErrorTest.java |  174 ++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |  352 ++++++++++++
 .../spearce/jgit/patch/testError_BodyTooLong.patch |   17 +
 .../jgit/patch/testError_CcTruncatedOld.patch      |   24 +
 .../jgit/patch/testError_DisconnectedHunk.patch    |   30 +
 .../jgit/patch/testError_GarbageBetweenFiles.patch |   33 ++
 .../patch/testError_GitBinaryNoForwardHunk.patch   |   10 +
 .../jgit/patch/testError_TruncatedNew.patch        |   15 +
 .../jgit/patch/testError_TruncatedOld.patch        |   15 +
 .../jgit/patch/testParse_AddNoNewline.patch        |   20 +
 .../jgit/patch/testParse_CcDeleteFile.patch        |   12 +
 .../spearce/jgit/patch/testParse_CcNewFile.patch   |   14 +
 .../patch/testParse_ConfigCaseInsensitive.patch    |   67 +++
 .../jgit/patch/testParse_FixNoNewline.patch        |   20 +
 .../jgit/patch/testParse_GitBinaryDelta.patch      |   21 +
 .../jgit/patch/testParse_GitBinaryLiteral.patch    |  135 +++++
 .../spearce/jgit/patch/testParse_NoBinary.patch    |   83 +++
 .../spearce/jgit/patch/testParse_OneFileCc.patch   |   27 +
 .../tst/org/spearce/jgit/util/IntListTest.java     |  156 ++++++
 .../jgit/util/QuotedStringBourneStyleTest.java     |  111 ++++
 .../util/QuotedStringBourneUserPathStyleTest.java  |  130 +++++
 .../jgit/util/QuotedStringGitPathStyleTest.java    |  172 ++++++
 .../jgit/util/RawParseUtils_LineMapTest.java       |   88 +++
 .../org/spearce/jgit/util/TemporaryBufferTest.java |  374 +++++++++++++
 .../tst/org/spearce/jgit/util/TestRng.java         |   61 +++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |  262 +++++++++
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   39 ++-
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    4 +-
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |  127 +++++
 .../org/spearce/jgit/patch/CombinedFileHeader.java |  213 ++++++++
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |  191 +++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |  568 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/FormatError.java    |  109 ++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |  228 ++++++++
 .../src/org/spearce/jgit/patch/Patch.java          |  376 +++++++++++++
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    2 +-
 .../spearce/jgit/transport/TransportGitSsh.java    |   38 +--
 .../src/org/spearce/jgit/util/IntList.java         |  128 +++++
 .../src/org/spearce/jgit/util/QuotedString.java    |  362 +++++++++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   76 ++-
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |   72 +++-
 52 files changed, 6151 insertions(+), 85 deletions(-)
 create mode 100644 org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryLiteral.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringGitPathStyleTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java

-- 
Shawn.
