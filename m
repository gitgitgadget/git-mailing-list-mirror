From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/4] Misc. push transport fixes
Date: Wed,  9 Jul 2008 00:15:27 -0400
Message-ID: <1215576931-4174-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 06:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGR6V-0004EZ-AK
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbYGIEPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbYGIEPd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 00:15:33 -0400
Received: from george.spearce.org ([209.20.77.23]:46866 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYGIEPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 00:15:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 978EE38194; Wed,  9 Jul 2008 04:15:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 12B4038194;
	Wed,  9 Jul 2008 04:15:32 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87842>

Few minor bugs related to our push implementation.  A deadlock
is fixed in the local fetch case and pack generation to include
annotated tags is also fixed.

We also now do essentially "git init" on the remote repository
if we are creating it over a dumb transport during the first push
request made to it.


Shawn O. Pearce (4):
  Avoid deadlock while fetching from local repository
  Fix pushing of annotated tags to actually include the tag object
  Automatically initialize a new dumb repository during push
  Use a singleton for the NullProgressMonitor implementation

 .../org/spearce/jgit/lib/NullProgressMonitor.java  |    3 +
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   13 ++++-
 .../spearce/jgit/transport/BasePackConnection.java |    7 ++-
 .../jgit/transport/BasePackFetchConnection.java    |    1 +
 .../jgit/transport/BasePackPushConnection.java     |    1 +
 .../spearce/jgit/transport/WalkPushConnection.java |   54 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |    2 +-
 7 files changed, 77 insertions(+), 4 deletions(-)
