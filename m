From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn, remote tracking branch question
Date: Fri, 30 Mar 2007 17:32:19 -0700
Message-ID: <20070331003219.GA5145@muzzle>
References: <m2ps6usa9o.fsf@ziti.fhcrc.org> <20070327220015.GA16344@untitled> <20070329205824.GA19796@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 02:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXRW4-0006na-Oh
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 02:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbXCaAcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbXCaAcV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 20:32:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46720 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933165AbXCaAcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 20:32:21 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5D8F97DC094;
	Fri, 30 Mar 2007 17:32:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 30 Mar 2007 17:32:19 -0700
Content-Disposition: inline
In-Reply-To: <20070329205824.GA19796@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43514>

Eric Wong <normalperson@yhbt.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > I'll look into this more when/if I have time tonight.
> 
> Sorry, I tried to look into it this morning at 1-2am but wasn't
> successful in reproducing it.  I'm glad the workaround I provided
> worked, but I'll take another stab at solving the problem tonight
> or this weekend.

Alright, I'm still unable to figure it out.  Here's a patch
that should at least cause it to error out and tell you
which URL it was trying to lookup.

>From 4bf0314f4665b612cbd735fdfae45f84c1e21c04 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Fri, 30 Mar 2007 17:30:30 -0700
Subject: [PATCH] git-svn: fail on rebase if we are unable to find a ref to rebase against

If we're on an invalid HEAD, we should detect this and avoid
attempting to continue.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e0a48c2..adc976c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -435,6 +435,9 @@ sub cmd_rebase {
 	}
 
 	my $gs = Git::SVN->find_by_url($url);
+	unless ($gs) {
+		die "Unable to determine remote information from URL: $url\n";
+	}
 	if (command(qw/diff-index HEAD --/)) {
 		print STDERR "Cannot rebase with uncommited changes:\n";
 		command_noisy('status');
-- 
Eric Wong
