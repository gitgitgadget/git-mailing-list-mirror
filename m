From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 00/23] Push implementation
Date: Sat, 28 Jun 2008 00:06:24 +0200
Message-ID: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM6m-0000cC-70
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbYF0WGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbYF0WGy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:06:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYF0WGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:06:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M5xg9Gqnn93yqe3j+8zK0v3LabRPznLHGbEp0omDyRc=;
        b=DKdkq8/OIlc+LB6s+tyHiafLPEGkbCNbloVBxSARQTMjoElFTipdAa20uzkbIa9NE1
         kaBWUfmerQJb4tNgv2NkfYUcZ98M0+9WykbPjEKQ0euswwO5GCkruotbMF5n6DptaVg9
         lH+2ERxhMEhvAsejKXRDvNYfppQI0cNYrranY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aju3ADf4gYTmTvghvEmVC93UwEwJTekquZbTHgeaiPalPO65QWbfN7EtwTVuDxa+DB
         1QF4tWbHVnbw9bYkmGwx0RjvWD9b3aRrrJ9a+Qfy4HVg7Okbwubjc7lob0PHK3JTYCW2
         9oIf3Md2K6QgqiSa0VfyOtRJepCoMB/S1J+zs=
Received: by 10.210.41.14 with SMTP id o14mr1588400ebo.137.1214604411032;
        Fri, 27 Jun 2008 15:06:51 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z33sm2454590ikz.0.2008.06.27.15.06.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:06:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86641>

Finally, series with push implementation. It has taken a "while" to
squash all bugs this time and polish the series, uhh.

Part of this series is signifficant refactor of .transport package to
support code reuse between fetch and push implementations + minor
fixes/improvements.

Needed push operation elements were created. Implementation provides
basis for different push protocols by common push process and its
dendendencies. Push over git-receive-pack based transports is
implemented. 
Shawn is now working on support for push over less git-inteligent
protocols. I'm moving into GUI stuff.

Beside of JUnit test cases for (IMO) 2 most complex classes that
revealed few bugs, I've tested manually pgm.Push extensively. 
Each protocol (SSH, local, git-daemon) was tested at least 1 time.


So now I can say, that this branch is available on 
http://repo.or.cz/w/egit/zawir.git?a=shortlog;h=refs/heads/push
and it was pushed with jgit push! :) Yeah!
It is based (together with packwriter stuff, not old packwrite branch)
on egit's master: 4cf736fdf3.

BTW, in case of any comments, requests, please consider that I'm
semi-off-line next ~2,5weeks, I can sync my laptop each few days,
but certainly not everyday.

PS I saw that Shawn's sftp-push branch also contains new 
TransportException constructors conversion, so we may have to 
resolve this duplication, I added it as last commit.

Marek Zawirski (23):
  Fix: let FetchProcess use fetch() instead of doFetch()
  RefUpdate: new possible result Result.IO_FAILURE
  Refactor TrackingRefUpdate to not hold RefSpec
  New constructor without RefSpec for TrackingRefUpdate
  Add RemoteRefUpdate class
  Refactor: extract superclass OperationResult from FetchResult
  Add PushResult class
  Support for fetchThin and pushThin options in Transport
  Big refactor: *Connection hierarchy
  Add ignoreMissingUninteresting option to PackWriter
  Add BasePackPushConnection implementing git-send-pack protocol
  Fix: let RevWalk reset correctly before isMergedInto()
  Add PushProcess class implementing git-send-pack logic
  Clarify Repository#resolve() documentation
  Add String versions of methods in RefSpec
  Transport* - general support for push() and implementations
  Test cases for PushProcess
  Test cases for RefSpec to RemoteRefUpdate conversions
  Repository search for command line tools
  Push command line utility
  Don't accept RefSpec with null source for fetch
  Add new handy constructors to TransportException,
    PackProtocolException
  Use new TransportException constructors

 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   45 ++-
 .../spearce/jgit/transport/PushProcessTest.java    |  407 ++++++++++++++++++++
 .../org/spearce/jgit/transport/TransportTest.java  |  181 +++++++++
 .../spearce/jgit/errors/PackProtocolException.java |   30 ++
 .../spearce/jgit/errors/TransportException.java    |   31 ++
 .../src/org/spearce/jgit/lib/PackWriter.java       |   37 ++-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   27 ++-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 .../src/org/spearce/jgit/pgm/Fetch.java            |   41 +--
 .../src/org/spearce/jgit/pgm/Main.java             |   24 +-
 .../src/org/spearce/jgit/pgm/Push.java             |  235 +++++++++++
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   21 +
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    2 +-
 .../org/spearce/jgit/transport/BaseConnection.java |  103 +++++
 .../jgit/transport/BaseFetchConnection.java        |   86 ++++
 .../spearce/jgit/transport/BasePackConnection.java |  217 +++++++++++
 ...onnection.java => BasePackFetchConnection.java} |  169 +--------
 .../jgit/transport/BasePackPushConnection.java     |  226 +++++++++++
 .../src/org/spearce/jgit/transport/Connection.java |  104 +++++
 .../spearce/jgit/transport/FetchConnection.java    |  127 +-----
 .../org/spearce/jgit/transport/FetchProcess.java   |    8 +-
 .../org/spearce/jgit/transport/FetchResult.java    |   74 +----
 .../spearce/jgit/transport/OperationResult.java    |  119 ++++++
 .../org/spearce/jgit/transport/PackTransport.java  |    3 +-
 .../org/spearce/jgit/transport/PushConnection.java |   56 +++-
 .../org/spearce/jgit/transport/PushProcess.java    |  224 +++++++++++
 .../src/org/spearce/jgit/transport/PushResult.java |   84 ++++
 .../src/org/spearce/jgit/transport/RefSpec.java    |   46 ++-
 .../spearce/jgit/transport/RemoteRefUpdate.java    |  315 +++++++++++++++
 .../spearce/jgit/transport/TrackingRefUpdate.java  |   19 +-
 .../src/org/spearce/jgit/transport/Transport.java  |  252 ++++++++++++-
 .../spearce/jgit/transport/TransportBundle.java    |    8 +-
 .../spearce/jgit/transport/TransportGitAnon.java   |   52 +++-
 .../spearce/jgit/transport/TransportGitSsh.java    |   67 +++-
 .../org/spearce/jgit/transport/TransportLocal.java |  114 ++++--
 .../org/spearce/jgit/transport/TransportSftp.java  |   12 +-
 .../jgit/transport/WalkFetchConnection.java        |    2 +-
 .../org/spearce/jgit/transport/WalkTransport.java  |    7 +
 38 files changed, 3103 insertions(+), 474 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BaseConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
 rename org.spearce.jgit/src/org/spearce/jgit/transport/{PackFetchConnection.java => BasePackFetchConnection.java} (75%)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/Connection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
