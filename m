From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/7] Misc. transport cleanup
Date: Thu,  4 Jun 2009 14:43:56 -0700
Message-ID: <1244151843-26954-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkF-0001OL-7a
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZFDVoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZFDVoD
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:03 -0400
Received: from george.spearce.org ([209.20.77.23]:35358 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbZFDVoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:01 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0BC79381FF; Thu,  4 Jun 2009 21:44:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 78AFE381CE;
	Thu,  4 Jun 2009 21:44:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120718>

After the dicussions with Jakub Narebski I realized we aren't as
lenient in parsing hex strings as C Git is.  So make it so.

I also added some tests for the lower level parts of the native
protocol, the pkt-line format.  Testing is still far from complete
in this area of the code, but we're slightly better now.

Shawn O. Pearce (7):
  Move hex parsing functions to RawParseUtil, accept upper case
  Disambiguate pkt-line "0000" from "0004"
  Move PacketLineIn hex parsing to RawParseUtils
  Add tests for RawParseUtil's hex string parsing
  Add tests for PacketLineIn
  Add tests for PacketLineOut
  Add tests for SideBandOutputStream

 .../tst/org/spearce/jgit/lib/T0001_ObjectId.java   |   10 +-
 .../spearce/jgit/transport/PacketLineInTest.java   |  262 ++++++++++++++++++++
 .../spearce/jgit/transport/PacketLineOutTest.java  |  175 +++++++++++++
 .../jgit/transport/SideBandOutputStreamTest.java   |  146 +++++++++++
 .../jgit/util/RawParseUtils_HexParseTest.java      |  158 ++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |    8 +-
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   36 ---
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   11 +-
 .../src/org/spearce/jgit/lib/ObjectId.java         |   19 +-
 .../spearce/jgit/transport/BasePackConnection.java |    5 +-
 .../jgit/transport/BasePackPushConnection.java     |    2 +-
 .../org/spearce/jgit/transport/DaemonClient.java   |    5 +-
 .../org/spearce/jgit/transport/PacketLineIn.java   |   44 +---
 .../org/spearce/jgit/transport/ReceivePack.java    |    6 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |    4 +-
 .../src/org/spearce/jgit/util/RawParseUtils.java   |  110 ++++++++-
 16 files changed, 893 insertions(+), 108 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineInTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineOutTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/SideBandOutputStreamTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_HexParseTest.java
