From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 0/5] Support linked resources in repositories
Date: Tue,  5 Aug 2008 20:09:35 -0700
Message-ID: <1217992180-5697-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQH-0005ZC-UQ
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYHFDJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYHFDJm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:42 -0400
Received: from george.spearce.org ([209.20.77.23]:47462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYHFDJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:41 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4A3B738368; Wed,  6 Aug 2008 03:09:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B02B238368;
	Wed,  6 Aug 2008 03:09:40 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91477>

Sometimes users need to create links inside of a project to point
back to their Git working directory.  This is sort of like a symlink
in POSIX, but its managed at the Eclipse workspace level.

If a resource is contained within a linked directory and that is
also within a Git repository we want to allow Git operations on
that linked resource to operate using the paths of the files as
they are in the repository working directory, and not the path of
the files in the Eclipse workspace.

Shawn O. Pearce (5):
  Remove the pointless GitProjectData resource change listener
  Don't crash the decorator update loop when resources are deleted
  Fix RepositoryMapping.getRepoRelativePath to honor linked resources
  Change GitProjectData.getRepositoryMapping to work on linked
    resources
  Correct getRepositoryMapping callers to use any IResource

 .../egit/core/op/ConnectProviderOperation.java     |   14 +---
 .../org/spearce/egit/core/op/UntrackOperation.java |    4 +-
 .../spearce/egit/core/project/GitProjectData.java  |  111 ++++++--------------
 .../egit/core/project/RepositoryFinder.java        |   11 +--
 .../egit/core/project/RepositoryMapping.java       |   79 ++++++--------
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 .../internal/decorators/GitResourceDecorator.java  |   11 ++-
 7 files changed, 81 insertions(+), 151 deletions(-)
