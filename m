From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Support receive.fsckobjects
Date: Mon, 13 Oct 2008 09:52:25 -0700
Message-ID: <1223916746-11262-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQfv-0005ji-8x
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYJMQwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbYJMQw3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:52:29 -0400
Received: from george.spearce.org ([209.20.77.23]:56059 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbYJMQw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:52:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6784038368; Mon, 13 Oct 2008 16:52:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2F7893835F;
	Mon, 13 Oct 2008 16:52:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98122>

This series adds support for receive.fsckobjects, but on the fetch
side of the connection.  Perhaps it should be transfer.fsckobjects
or fetch.fsckobjects, but git.git doesn't support either of those
right now.

I mainly need this series because I'm fetching out of untrusted
bundles.  The content of the bundle has to pass git-fsck for it
to be considered safe.

The ObjectChecker class covers the same rules as git-fsck does, and
is perhaps even stricter on some of the things git-fsck lets slide.
I think git-fsck is too lenient in some areas, and I'd like to try
and improve the rules more in git.git, but I don't have time for
it right now.

Shawn O. Pearce (5):
  Expose RawParseUtils.match to application callers
  Fix UnpackedObjectLoader.getBytes to return a copy
  Object validation tests for "jgit fsck"
  Expose the critical receive configuration options to JGit
  Honor receive.fsckobjects during any fetch connection

 .../org/spearce/jgit/lib/ObjectCheckerTest.java    | 1294 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |  352 ++++++
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |    7 +-
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    7 -
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   10 +
 .../src/org/spearce/jgit/lib/TransferConfig.java   |   56 +
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |    4 -
 .../jgit/transport/BasePackFetchConnection.java    |    1 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |   60 +-
 .../src/org/spearce/jgit/transport/Transport.java  |   24 +
 .../spearce/jgit/transport/TransportBundle.java    |   10 +-
 .../jgit/transport/WalkFetchConnection.java        |   26 +-
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   23 +-
 13 files changed, 1842 insertions(+), 32 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
