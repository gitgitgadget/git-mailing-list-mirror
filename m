From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] RawParseUtil improvements
Date: Wed, 10 Dec 2008 14:05:45 -0800
Message-ID: <1228946751-12708-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:07:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXDK-00031R-5d
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbYLJWFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755302AbYLJWFy
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:05:54 -0500
Received: from george.spearce.org ([209.20.77.23]:39005 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbYLJWFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:05:53 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6BAF538200; Wed, 10 Dec 2008 22:05:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9C89038200;
	Wed, 10 Dec 2008 22:05:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102725>

I'm working on patch parsing support for JGit, so I can rely on
it in Gerrit 2.  Currently Gerrit 1 uses a bastard chunk of code
I ripped out in an hour to scan the output of "git diff"; its not
suitable for long-term appliction.

This series improves RawParseUtils code clarity, and then adds
support for the C-style quoting rules used by git diff when file
names contain "special" characters like LF.

I'm working on patch parsing right now; but I wanted to send this
preliminary series out so you aren't drowning in code to review.


Shawn O. Pearce (6):
  Simplify RawParseUtils.nextLF invocations
  Simplify RawParseUtils next and nextLF loops
  Correct Javadoc of RawParseUtils next and nextLF methods
  Add QuotedString class to handle C-style quoting rules
  Add Bourne style quoting for TransportGitSsh
  Add ~user friendly Bourne style quoting for TransportGitSsh

 .../jgit/util/QuotedStringBourneStyleTest.java     |  111 ++++++
 .../util/QuotedStringBourneUserPathStyleTest.java  |  130 +++++++
 .../spearce/jgit/util/QuotedStringC_StyleTest.java |  144 ++++++++
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    4 +-
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    2 +-
 .../spearce/jgit/transport/TransportGitSsh.java    |   38 +--
 .../src/org/spearce/jgit/util/QuotedString.java    |  364 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   45 ++-
 8 files changed, 783 insertions(+), 55 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringC_StyleTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
