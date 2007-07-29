From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui ignores core.excludesFile
Date: Sun, 29 Jul 2007 03:22:47 -0400
Message-ID: <20070729072247.GM20052@spearce.org>
References: <20070723150700.GA17167@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 09:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF37A-0002EO-8d
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345AbXG2HWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757618AbXG2HWx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:22:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33623 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbXG2HWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:22:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IF372-0003RZ-Fa; Sun, 29 Jul 2007 03:22:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18BD320FBAE; Sun, 29 Jul 2007 03:22:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070723150700.GA17167@lars.home.noschinski.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54087>

Lars Noschinski <lars@public.noschinski.de> wrote:
> It seems git-gui (0.7.5 from git 1.5.2.4 tarball) ignores the global
> ignore file configured with the core.excludesfile option. My
> ~/.gitconfig contains
> 
> [core]
> excludesFile = /home/noschinski/.gitignore
> 
> which is honoured by git-status but not by git-gui.

Whoops.  Thanks.  git-gui 0.8.0 will include the following patch:

-->8--
From 94a4dd9bfda79a226f8dd57fd20c39c6603ec194 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Sun, 29 Jul 2007 03:22:27 -0400
Subject: [PATCH] git-gui: Honor core.excludesfile when listing extra files

Recent git versions have a git-status that honors the core.excludesfile
configuration option when it reports on untracked files.  Unfortunately
I missed the introduction of this configuration option in the core
porcelain implementation, so it was not reflected here in git-gui.

Found and reported by Lars Noschinski <lars@public.noschinski.de>.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d7fad46..4e3b58c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -872,6 +872,10 @@ proc rescan_stage2 {fd after} {
 	if {[file readable $info_exclude]} {
 		lappend ls_others "--exclude-from=$info_exclude"
 	}
+	set user_exclude [get_config core.excludesfile]
+	if {$user_exclude ne {} && [file readable $user_exclude]} {
+		lappend ls_others "--exclude-from=$user_exclude"
+	}
 
 	set buf_rdi {}
 	set buf_rdf {}
-- 
1.5.3.rc3.843.g25b4


-- 
Shawn.
