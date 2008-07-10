From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Yet another round of transport fixes
Date: Thu, 10 Jul 2008 02:13:18 -0400
Message-ID: <1215670403-19191-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQG-0004ug-OO
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYGJGN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYGJGNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:25 -0400
Received: from george.spearce.org ([209.20.77.23]:55183 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYGJGNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B738838196; Thu, 10 Jul 2008 06:13:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1BE8E38196;
	Thu, 10 Jul 2008 06:13:24 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87941>

Apparently tweaking minor details is never done.  This short
series improves minor issues I have with the transport code
in relation to error and progress reporting.  We also get a
small performance boost for tag fetching over SSH.

Shawn O. Pearce (5):
  Include a progress meter for large uploads to Amazon S3
  Don't display passwords on the console in fetch/push output
  Reuse the same SSH connection when automatically fetching tags
  Report remote SSH execution errors during push via TransportException
  Explicitly capture the stderr from a failed SSH fetch or push

 .../org/spearce/egit/core/op/CloneOperation.java   |   10 ++-
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |    5 +-
 .../egit/ui/internal/clone/SourceBranchPage.java   |    1 +
 .../spearce/jgit/transport/PushProcessTest.java    |    5 +
 .../org/spearce/jgit/transport/TransportTest.java  |   10 ++
 .../jgit/errors/NoRemoteRepositoryException.java   |   59 +++++++++++
 .../src/org/spearce/jgit/pgm/Fetch.java            |   19 +++--
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    1 +
 .../src/org/spearce/jgit/pgm/Push.java             |    2 +-
 .../src/org/spearce/jgit/transport/AmazonS3.java   |   29 +++++-
 .../spearce/jgit/transport/BasePackConnection.java |    3 +-
 .../jgit/transport/DefaultSshSessionFactory.java   |   30 ++++++-
 .../src/org/spearce/jgit/transport/Transport.java  |   10 ++
 .../spearce/jgit/transport/TransportAmazonS3.java  |   12 ++-
 .../spearce/jgit/transport/TransportBundle.java    |    5 +
 .../spearce/jgit/transport/TransportGitAnon.java   |    5 +
 .../spearce/jgit/transport/TransportGitSsh.java    |  103 +++++++++++++-------
 .../org/spearce/jgit/transport/TransportHttp.java  |    5 +
 .../org/spearce/jgit/transport/TransportLocal.java |    5 +
 .../org/spearce/jgit/transport/TransportSftp.java  |   57 ++++++-----
 .../spearce/jgit/transport/WalkPushConnection.java |    5 +-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   11 ++-
 22 files changed, 303 insertions(+), 89 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/NoRemoteRepositoryException.java
