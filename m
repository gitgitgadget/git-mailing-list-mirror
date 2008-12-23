From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Add jgit init, clone, receive-pack; transport fixes
Date: Tue, 23 Dec 2008 10:03:38 -0800
Message-ID: <1230055423-9944-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBct-0002sv-1r
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYLWSDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYLWSDp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:03:45 -0500
Received: from george.spearce.org ([209.20.77.23]:58216 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbYLWSDo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:03:44 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D78E238211; Tue, 23 Dec 2008 18:03:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 60DCB38197;
	Tue, 23 Dec 2008 18:03:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103843>

Define a "jgit init", "jgit clone" commands from the command line.

Add "jgit receive-pack".  This now works from C git:

  git push --receive-pack='jgit receive-pack' dst.git

Fix issue #22, causing jgit to fetch too many objects during an
initial clone/fetch of a repository.

Change "jgit daemon" so it can run outside of a repository, making
it slightly more useful.


Shawn O. Pearce (5):
  Add "jgit receive-pack" and permit commands to start not in a
    repository
  Add "jgit init" command to create a new repository
  Modify "jgit daemon" so it can run outside of a repository
  Add "jgit clone" to support cloning off URLs that are JGit specific
  Fix "fetch pulled too many objects" when auto-following tags

 .../services/org.spearce.jgit.pgm.TextBuiltin      |    3 +
 .../org/spearce/jgit/pgm/AbstractFetchCommand.java |  126 ++++++++++++++
 .../src/org/spearce/jgit/pgm/Clone.java            |  177 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/Daemon.java           |   33 +---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   83 +---------
 .../src/org/spearce/jgit/pgm/Init.java             |   60 +++++++
 .../src/org/spearce/jgit/pgm/Main.java             |   19 ++-
 .../src/org/spearce/jgit/pgm/ReceivePack.java      |   67 ++++++++
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   24 +++-
 .../jgit/transport/BaseFetchConnection.java        |   26 ++-
 .../jgit/transport/BasePackFetchConnection.java    |   25 +++-
 .../spearce/jgit/transport/FetchConnection.java    |   21 ++-
 .../org/spearce/jgit/transport/FetchProcess.java   |    6 +-
 .../spearce/jgit/transport/TransportBundle.java    |    3 +-
 .../jgit/transport/WalkFetchConnection.java        |   14 ++-
 15 files changed, 544 insertions(+), 143 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
