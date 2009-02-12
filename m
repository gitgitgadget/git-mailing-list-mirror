From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] Add prune of stale tracking branches to fetch
Date: Thu, 12 Feb 2009 15:54:34 -0800
Message-ID: <1234482880-1316-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPk-0004ei-Af
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbZBLXyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbZBLXyn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:43 -0500
Received: from george.spearce.org ([209.20.77.23]:49146 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbZBLXym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:42 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id DA75C38215; Thu, 12 Feb 2009 23:54:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 672F33819E;
	Thu, 12 Feb 2009 23:54:41 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109688>

This series teaches "jgit fetch" how to prune stale tracking branches
that have been removed from the remote repository.  We can now do
both a fetch and a prune in a single network connection.

I wanted to also add this for push, but its going to be more complex.
The RefSpec data I need isn't available in the PushProcess code path,
and the Transport.push() method isn't doing me any favors at making
it available to me.

I need to move on to some other things today, so I'm posting this
fetch series now as this looks good as-is.

Shawn O. Pearce (6):
  Fix RefUpdate.delete to update the result status
  Add setBoolean, setInt to RepositoryConfig
  Add RefSpec.expandFromDestination for reverse mappings
  Add the remote.name.mirror flag to RemoteConfig
  Don't pass TagOpt to FetchProcess, get it from the Transport
  Teach fetch to prune stale tracking branches

 .../org/spearce/jgit/pgm/AbstractFetchCommand.java |    8 ++-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    9 +++
 .../spearce/jgit/transport/RefSpecTestCase.java    |   22 ++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    4 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   57 +++++++++++++++
 .../org/spearce/jgit/transport/FetchProcess.java   |   55 +++++++++++++--
 .../src/org/spearce/jgit/transport/RefSpec.java    |   73 ++++++++++++++------
 .../org/spearce/jgit/transport/RemoteConfig.java   |   40 +++++++++++-
 .../src/org/spearce/jgit/transport/Transport.java  |   29 ++++++++-
 9 files changed, 265 insertions(+), 32 deletions(-)
