From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/9] Repository change listeners
Date: Fri, 11 Jul 2008 00:40:42 +0200
Message-ID: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vS-0004Lo-JE
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbYGJWqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbYGJWqA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:00 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13104 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbYGJWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 29C188030BA;
	Fri, 11 Jul 2008 00:45:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NffhuiVA1O5z; Fri, 11 Jul 2008 00:45:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5F96C8027F7;
	Fri, 11 Jul 2008 00:45:57 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88029>

We want to make the UI react on changes to the repo, but the parts
of the code that makes the changes doesn't know who wants to react
on them. This adds a publish-subcribe mechanism, including detection
of externally made changes, e.g. by C Git.

-- robin

Robin Rosenberg (9):
  Create a listener structure for changes to refs and index
  Cached modification times for symbolic refs too
  Connect the history page to the refs update subscription mechanism
  Add a method to listen to changes in any repository
  Add a job to periodically scan for repository changes
  Change GitHistoryPage to listen on any repository.
  Add a job to refresh projects when the index changes.
  Make git dectected changes depend on the automatic refresh setting
  Attach the resource decorator to the repository change event
    mechanism

 .../src/org/spearce/egit/ui/Activator.java         |  155 ++++++++++++++++++++
 .../internal/decorators/GitResourceDecorator.java  |   29 ++++-
 .../egit/ui/internal/history/GitHistoryPage.java   |   43 +++++-
 .../src/org/spearce/jgit/lib/GitIndex.java         |    3 +
 .../org/spearce/jgit/lib/IndexChangedEvent.java    |   55 +++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   63 ++++++---
 .../src/org/spearce/jgit/lib/RefsChangedEvent.java |   55 +++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   74 ++++++++++
 .../org/spearce/jgit/lib/RepositoryAdapter.java    |   54 +++++++
 .../spearce/jgit/lib/RepositoryChangedEvent.java   |   64 ++++++++
 .../org/spearce/jgit/lib/RepositoryListener.java   |   63 ++++++++
 11 files changed, 635 insertions(+), 23 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/IndexChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefsChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryAdapter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryListener.java
