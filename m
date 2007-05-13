From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't drop the username from URLs when dcommit is run
Date: Sun, 13 May 2007 00:53:16 -0700
Message-ID: <20070513075316.GA1168@muzzle>
References: <200705121824.14190.list-receive@mneisen.org> <20070512214035.GA18560@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Eisenhardt <martin.eisenhardt@mneisen.org>,
	Adam Roben <aroben@apple.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 09:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn8tR-0002bM-CH
	for gcvg-git@gmane.org; Sun, 13 May 2007 09:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbXEMHxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 03:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbXEMHxT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 03:53:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53270 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239AbXEMHxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 03:53:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3800F7DC0A3;
	Sun, 13 May 2007 00:53:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 00:53:17 -0700
Content-Disposition: inline
In-Reply-To: <20070512214035.GA18560@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47126>

Eric Wong <normalperson@yhbt.net> wrote:
> Martin Eisenhardt <list-receive@mneisen.org> wrote:
> 
> Thanks for the bug report.  I haven't tested the patch below, so
> let me know if it works:

Junio: I've confirmed this patch works, please apply.  Thanks.

>From 58af622c222514dc3da938ce6309e1ac927a9574 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 12 May 2007 14:36:20 -0700
Subject: [PATCH] git-svn: don't drop the username from URLs when dcommit is run

We no longer store usernames in URLs stored in git-svn-id lines
for dcommit, so we shouldn't rely on those URLs when connecting
to the remote repository to commit.
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3c4f490..d74e6d3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -393,7 +393,7 @@ sub cmd_dcommit {
 		} else {
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
-			                ra => Git::SVN::Ra->new($url),
+			                ra => Git::SVN::Ra->new($gs->full_url),
 			                tree_a => "$d~1",
 			                tree_b => $d,
 			                editor_cb => sub {
-- 
Eric Wong
