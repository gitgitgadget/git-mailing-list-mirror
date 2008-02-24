From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/6] Use git-describe --exact-match in bash prompt on detached HEAD
Date: Sun, 24 Feb 2008 03:07:33 -0500
Message-ID: <20080224080733.GF22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBv4-0004Uj-6n
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbYBXIIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbYBXIIA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:08:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42992 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbYBXIHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtW-0001g6-4P; Sun, 24 Feb 2008 03:07:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC9FD20FBAE; Sun, 24 Feb 2008 03:07:33 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74911>

Most of the time when I am on a detached HEAD and I am not doing
a rebase or bisect operation the working directory is sitting on a
tagged release of the repository.  Showing the tag name instead of
the commit SHA-1 is much more descriptive and a much better reminder
of the state of this working directory.

Now that git-describe --exact-match is available as a cheap means
of obtaining the exact annotated tag or nothing at all, we can
favor the annotated tag name over the abbreviated commit SHA-1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4ea727b..8722a68 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -91,7 +91,10 @@ __git_ps1 ()
 			fi
 			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
 			then
-				b="$(cut -c1-7 $g/HEAD)..."
+				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
+				then
+					b="$(cut -c1-7 $g/HEAD)..."
+				fi
 			fi
 		fi
 
-- 
1.5.4.3.295.g6b554
