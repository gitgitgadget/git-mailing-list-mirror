From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Add "jgit upload-pack" for fetch service
Date: Tue, 23 Dec 2008 14:56:42 -0800
Message-ID: <1230073007-17337-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGCX-0004fK-31
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYLWW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYLWW4u
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:56:50 -0500
Received: from george.spearce.org ([209.20.77.23]:51443 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYLWW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:49 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2952F38211; Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A704038197;
	Tue, 23 Dec 2008 22:56:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103849>

And uh, now we can act as a true git server, providing fetch and
clone support over git:// with our own daemon, or through the use of
"git fetch --upload-pack='jgit upload-pack'".

Roughly tested by cloning the Linux kernel and WebKit (both about
500 MB packed).  Kernel takes a while to enumerate the objects,
but eh, it works.  :-)


Shawn O. Pearce (5):
  Sort Ref objects by OrigName and not Name
  Permit subclass of ObjectId (e.g. RevObject) when calling PackWriter
  Implement "jgit upload-pack" to support fetching from jgit
  Fix BaseFetchPackConnection's output of selected capabilities
  Switch local fetch connection to use our own UploadPack

 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/UploadPack.java       |   67 +++
 .../src/org/spearce/jgit/lib/PackWriter.java       |   94 +++-
 .../src/org/spearce/jgit/lib/RefComparator.java    |    2 +-
 .../spearce/jgit/transport/BasePackConnection.java |    3 +-
 .../jgit/transport/BasePackFetchConnection.java    |    4 +
 .../jgit/transport/BasePackPushConnection.java     |    2 +-
 .../src/org/spearce/jgit/transport/Daemon.java     |   36 ++-
 .../org/spearce/jgit/transport/PacketLineOut.java  |   19 +-
 .../jgit/transport/SideBandInputStream.java        |    6 +-
 .../jgit/transport/SideBandOutputStream.java       |   93 ++++
 .../jgit/transport/SideBandProgressMonitor.java    |  150 ++++++
 .../org/spearce/jgit/transport/TransportLocal.java |   96 ++++-
 .../src/org/spearce/jgit/transport/UploadPack.java |  491 ++++++++++++++++++++
 14 files changed, 1018 insertions(+), 46 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/SideBandOutputStream.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/SideBandProgressMonitor.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
