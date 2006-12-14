X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Enable reflogs by default in all repositories.
Date: Thu, 14 Dec 2006 14:58:03 -0500
Message-ID: <20061214195803.GA25828@spearce.org>
References: <Pine.LNX.4.64.0612141251520.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 19:58:31 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Carl Worth <cworth@cworth.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612141251520.18171@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34389>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guwic-0006UB-JT for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751017AbWLNT6L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 14:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWLNT6L
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:58:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60136 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751017AbWLNT6K (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 14:58:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuwiL-0005lH-05; Thu, 14 Dec 2006 14:57:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6864220FB65; Thu, 14 Dec 2006 14:58:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

New and experienced Git users alike are finding out too late that
they forgot to enable reflogs in the current repository, and cannot
use the information stored within it to recover from an incorrectly
entered command such as `git reset --hard HEAD^^^` when they really
meant HEAD^^ (aka HEAD~2).

So enable reflogs by default in all future versions of Git, unless
the user specifically disables it with:

  [core]
    logAllRefUpdates = false

in their .git/config or ~/.gitconfig.

Documentation was also updated to indicate the new default behavior.
We probably should start to teach usuing the reflog to recover
from mistakes in some of the tutorial material, as new users are
likely to make a few along the way and will feel better knowing
they can recover from them quickly and easily, without fsck-objects'
lost+found features.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    3 ++-
 environment.c            |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a3587f8..e093bcd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -80,7 +80,8 @@ core.logAllRefUpdates::
 
 	This information can be used to determine what commit
 	was the tip of a branch "2 days ago".  This value is
-	false by default (no automated creation of log files).
+	true by default to activate automated creation of log
+	files for all branch heads.
 
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
diff --git a/environment.c b/environment.c
index 84d870c..98275b2 100644
--- a/environment.c
+++ b/environment.c
@@ -15,7 +15,7 @@ int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
-int log_all_ref_updates;
+int log_all_ref_updates = 1;
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
-- 
