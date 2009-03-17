From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/4] Avoid using 1280 file descriptors
Date: Mon, 16 Mar 2009 18:16:06 -0700
Message-ID: <1237252570-8596-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjNwG-0003eC-EP
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbZCQBQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbZCQBQO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:16:14 -0400
Received: from george.spearce.org ([209.20.77.23]:47491 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZCQBQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:16:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C282438239; Tue, 17 Mar 2009 01:16:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4B971381D3;
	Tue, 17 Mar 2009 01:16:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113410>

This is a small series to teach WindowCache not to use 1280 file
descriptors by default.  Most JVMs won't have a ulimit that large,
resulting in out of file errors if the WindowCache actually tries
to fully populate itself.

Shawn O. Pearce (4):
  Refactor WindowCache.reconfigure() to take a configuration object
  Update EGit plugin to use WindowCacheConfig
  Cap the number of open files in the WindowCache
  Teach WindowCacheConfig to read core.packedgit* settings from config

 .../spearce/egit/core/project/GitProjectData.java  |   12 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    8 +-
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |    7 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  119 ++++++++++----
 .../org/spearce/jgit/lib/WindowCacheConfig.java    |  170 ++++++++++++++++++++
 5 files changed, 271 insertions(+), 45 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
