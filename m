From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/3] Introduce AbbreviatedObjectId
Date: Wed, 10 Dec 2008 15:18:24 -0800
Message-ID: <1228951107-5546-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYLL-0005X0-LG
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYLJXS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYLJXS3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:18:29 -0500
Received: from george.spearce.org ([209.20.77.23]:41562 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYLJXS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:18:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5FBF638192; Wed, 10 Dec 2008 23:18:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DC72138192;
	Wed, 10 Dec 2008 23:18:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102735>

I'm using this new type to handle the "index" line of a git patch
file, where object ids are generally shorter than 40 characters
and thus aren't parsable by ObjectId.

Reading the short id is important because we can validate that a
patch applies correctly by computing the SHA-1 of the result and
testing it against the abbreviated id read in the "index" line.
If the base object SHA-1 matches the abbreviated line then the
result of applying the patch must also match; if it doesn't the
patch application logic is broken.

Shawn O. Pearce (3):
  Define an abstraction for handling abbreviated SHA-1 strings
  Add ObjectId.startsWith(AbbreviatedObjectId)
  Change AnyObjectId.abbreviate() to return AbbreviatedObjectId

 .../ui/internal/components/RefContentProposal.java |    2 +-
 .../egit/ui/internal/fetch/FetchResultTable.java   |   12 +-
 .../egit/ui/internal/push/PushResultTable.java     |   21 +-
 .../src/org/spearce/jgit/pgm/Branch.java           |    2 +-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    8 +-
 .../src/org/spearce/jgit/pgm/Push.java             |    5 +-
 .../spearce/jgit/lib/AbbreviatedObjectIdTest.java  |  285 ++++++++++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |  262 ++++++++++++++++++
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   39 +++-
 9 files changed, 608 insertions(+), 28 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
