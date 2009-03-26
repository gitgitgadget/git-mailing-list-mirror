From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to EGit
Date: Thu, 26 Mar 2009 22:34:22 +0100
Message-ID: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:36:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxFC-0007np-3o
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZCZVel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756930AbZCZVej
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:39 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46223 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755564AbZCZVed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:33 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id B3AEC58BD89;
	Thu, 26 Mar 2009 22:34:27 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114825>

This is the first - early - code that adds ignore functionality to EGit.
Currently it reads in all ignore patterns upon workspace startup into an
ignore cache. From this cache the ignore state of a resource is evaluated
in the same fashion as git does.

The code does not yet react to changes in ignore files but I'm planning to add
that soon and I can share a lot of code for that.

I send this code to receive feedback and to give you insight into what I'm
doing with it. I'm new both to EGit programming and Eclipse programming so
there might be things that could be done more elegantly :-)

A few notes:
- The patches are rebased on the current master (e3440623)
- The order of the patches must be re-arranged, but that is rather easy. The
  correct order - once finished - would be:
    Build up the ignore patterns cache upon workspace startup.
    Use the ignore patterns cache to determine ignores
    Enable the ignore handling of the plugin
    Optimise ignore evaluation
    Do not set .git as a Team ignore pattern
- The core.excludesfile code is currently untested, the other code seems to be
  in a good state.
- There are a few FIXMEs in the code with questions and tasks. It's a work in
  progress and these will disappear.

Ferry Huberts (5):
  Build up the ignore patterns cache upon workspace startup.
  Enable the ignore handling of the plugin
  Optimise ignore evaluation
  Do not set .git as a Team ignore pattern
  Use the ignore patterns cache to determine ignores

 org.spearce.egit.core/META-INF/MANIFEST.MF         |    1 +
 org.spearce.egit.core/plugin.xml                   |    6 -
 .../src/org/spearce/egit/core/ignores/DType.java   |   44 ++
 .../src/org/spearce/egit/core/ignores/Exclude.java |  243 +++++++++
 .../spearce/egit/core/ignores/GitIgnoreData.java   |  180 +++++++
 .../org/spearce/egit/core/ignores/IgnoreFile.java  |   82 +++
 .../egit/core/ignores/IgnoreFileOutside.java       |  543 ++++++++++++++++++++
 .../egit/core/ignores/IgnoreProjectCache.java      |  245 +++++++++
 .../egit/core/ignores/IgnoreRepositoryCache.java   |  358 +++++++++++++
 .../org/spearce/egit/core/op/TrackOperation.java   |    7 +-
 .../spearce/egit/core/project/GitProjectData.java  |    8 +
 .../decorators/DecoratableResourceAdapter.java     |   11 +-
 org.spearce.jgit/META-INF/MANIFEST.MF              |    1 +
 13 files changed, 1712 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
