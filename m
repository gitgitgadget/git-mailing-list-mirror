From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] Eclipse (EGIT) Structured compare
Date: Sun, 18 Mar 2007 22:21:02 -0400
Message-ID: <20070319022102.GE20658@spearce.org>
References: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7Uk-0007Sl-7z
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632AbXCSCVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933660AbXCSCVJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:21:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48059 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933632AbXCSCVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:21:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT7UT-0004qL-GO; Sun, 18 Mar 2007 22:20:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1683D20FBAE; Sun, 18 Mar 2007 22:21:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070318220711.24742.90943.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42562>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Now Eclipse can compare two git version at the project level. Thanks
> to the SHA-1's the compare is very quick. There is some extra cost
> for version managed archives (zip/jars) as Eclipse insists on comparing
> the contents of those at the file level too. Not that I mind that. It
> is useful and cool. (No, it doesn't compare open office documents in
> any useful manner, unless you happen to have a plugin for it, in
> which case it might actually work.)
> 
> Along with this some experiments with caching and a minor bug fix in
> the commit reader.

Thanks for this series.  I have applied it and pushed it out, along
with a small fix on top.

It works nicely, at least the "NG" variant when comparing trees.
;-)

The non-NG variant shows the raw tree diff, which is uh, a little
uninteresting, unless you are a true core Git hacker...

I tested it on a small-ish repository. The history browser works
quite nicely once the cache starts to get filled.  I don't know
how well it works on bigger repositories.  ;-)

--'da small fix--
From 6c402714c5a1850b871877cefe465a6a40ccdd0f Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Sun, 18 Mar 2007 22:15:14 -0400
Subject: [PATCH] Move GitResourceNode to ui plugin

Because I am trying to keep the core plugin UI free, allowing it
to be used in headless workbenches, such as from an Eclipse based
build system, we don't want to depend on the org.eclipse.swt plugin.
Relocating GitResourceNode to the UI plugin lets us continue to avoid
that dependency.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.egit.core/META-INF/MANIFEST.MF         |    4 +---
 .../spearce/egit/ui/internal}/GitResourceNode.java |    3 ++-
 .../internal/actions/GitCompareRevisionAction.java |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)
 rename {org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping => org.spearce.egit.ui/src/org/spearce/egit/ui/internal}/GitResourceNode.java (96%)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index 8dc62d6..fd39ec6 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -10,9 +10,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.team.core,
  org.eclipse.core.resources,
  org.spearce.jgit,
- org.eclipse.core.filesystem,
- org.eclipse.compare,
- org.eclipse.swt
+ org.eclipse.core.filesystem
 Export-Package: org.spearce.egit.core.internal.mapping;x-friends:="org.spearce.egit.ui",
  org.spearce.egit.core,
  org.spearce.egit.core.internal.mapping,
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
similarity index 96%
rename from org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java
rename to org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
index 0bba684..bdf8902 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
@@ -1,4 +1,4 @@
-package org.spearce.egit.core.internal.mapping;
+package org.spearce.egit.ui.internal;
 
 import java.io.ByteArrayInputStream;
 import java.io.IOException;
@@ -11,6 +11,7 @@ import org.eclipse.compare.structuremergeviewer.IStructureComparator;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.swt.graphics.Image;
 import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.jgit.lib.FileTreeEntry;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectLoader;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
index 84eb506..9a0b378 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
@@ -32,8 +32,8 @@ import org.eclipse.ui.IReusableEditor;
 import org.eclipse.ui.IWorkbenchPage;
 import org.eclipse.ui.actions.BaseSelectionListenerAction;
 import org.spearce.egit.core.GitWorkspaceFileRevision;
-import org.spearce.egit.core.internal.mapping.GitResourceNode;
 import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+import org.spearce.egit.ui.internal.GitResourceNode;
 
 /**
  * Action to invoke a Git based compare on selected revivsions in the history window.
-- 
1.5.0.4.1023.gb3ae

-- 
Shawn.
