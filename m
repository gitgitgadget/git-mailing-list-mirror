From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 00/10] Rename support
Date: Thu, 28 May 2009 00:08:47 +0200
Message-ID: <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJI-0005L4-S6
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353AbZE0WJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZE0WJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:09 -0400
Received: from mail.dewire.com ([83.140.172.130]:25335 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693AbZE0WJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D7064145D136;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUJeuMoxcPZU; Thu, 28 May 2009 00:08:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 8A21F145B3DA;
	Thu, 28 May 2009 00:08:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <20090520221651.GR30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120116>

This is basically a rewrite. While adding tests to handle some of
the case mentioned in Shawns comments, I had to give up the locking
strategy and go for something more like git, i.e. rename proceeds
in small steps and the I try to undo if a problem is encountered.

Add to that some small enchancments to ref support. Not the big
change we discussed earlier.

The branch command is touched by one of the patches, but it does
not include rename.

-- robin

Robin Rosenberg (10):
  Make sure we get the right storage for loose/pack/loose and packed
    refs
  Add a toString for debugging to RemoteRefUpdate
  Add a toString to LockFile
  Add more tests for RefUpdate
  Do not write to the reflog unless the refupdate logmessage is set
  Add a utility method for shortening long ref names to short ones.
  Set a nice reflog message in the branch command
  Add ref rename support to JGit
  Add ref rename support to the branch dialog
  Improve error reporting in the branch dialog

 .../src/org/spearce/egit/ui/UIText.java            |   18 +
 .../ui/internal/dialogs/BranchSelectionDialog.java |  133 +++++--
 .../src/org/spearce/egit/ui/uitext.properties      |    7 +
 .../src/org/spearce/jgit/pgm/Branch.java           |   15 +-
 .../org/spearce/jgit/test/resources/packed-refs    |    1 +
 .../tst/org/spearce/jgit/lib/RefTest.java          |   75 +++
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  483 ++++++++++++++++++--
 .../org/spearce/jgit/transport/TransportTest.java  |    2 +-
 .../src/org/spearce/jgit/lib/LockFile.java         |    5 +
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   60 +++-
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   34 ++-
 .../src/org/spearce/jgit/lib/RefRename.java        |  163 +++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   65 ++-
 .../src/org/spearce/jgit/lib/Repository.java       |   31 ++
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   13 +-
 15 files changed, 1015 insertions(+), 90 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
