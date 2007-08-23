From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Wed, 22 Aug 2007 22:30:09 -0700
Message-ID: <20070823053009.GC4978@muzzle>
References: <20070816085645.GA3159@soma> <7v4piri44r.fsf@gitster.siamese.dyndns.org> <853aybkwsc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 07:30:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5Gr-0000wP-ND
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 07:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbXHWFaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 01:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbXHWFaM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 01:30:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37587 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbXHWFaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 01:30:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CDA6A2DC08D;
	Wed, 22 Aug 2007 22:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <853aybkwsc.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56453>

David Kastrup <dak@gnu.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Eric Wong <normalperson@yhbt.net> writes:
> >
> >>   I've been meaning to do this for a while, hopefully this cuts
> >>   down on the redundant mailing list traffic about these subjects.
> >> ...
> >> +CAVEATS
> >> +-------
> >> +
> >> +For the sake of simplicity and interoperating with a less-capable system
> >> +(SVN), it is recommended that all git-svn users clone, fetch and dcommit
> >> +directly from the SVN server, and avoid all git-clone/pull/merge/push
> >> +operations between git repositories and branches.  The recommended
> >> +method of exchanging code between git branches and users is
> >> +git-format-patch and git-am, or just dcommiting to the SVN repository.
> >> +
> >> +Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
> >> +plan to dcommit from.  Subversion does not represent merges in any
> >> +reasonable or useful fashion; so users using Subversion cannot see any
> >> +merges you've made.
> >
> > Ok, my ruling before 1.5.3 is to take this patch, and encourage
> > interested parties to help Eric adding reliable support for the
> > feature after that, if such is possible.
> 
> Couldn't we at least get a _documentation_ of the current behavior
> when actually using git for branch work?  Knowing what will fail how
> and when is not as good as things just working as one would expect,
> but it certainly beats obscure warnings.
> 
> For example, I consider it rather unacceptable that nowhere is
> documented just _how_ git-svn chooses one Subversion branch to commit
> to.

dcommit always chooses the last SVN branch it branched off from.

> It also drastically misrepresents the consequences: the problem is
> _not_ that users using Subversion cannot see merges.  That is
> something that one can readily accept.  The problem is that git-svn
> will dcommit to a seemingly random branch.

Interesting, I've never considered it a problem (probably because
I know and trust the code I wrote :).  Good idea though.

Junio: could you please apply the following trivial patch?  Thanks.

>From a8ae91019a2ededd0e3d455fdd78655c086ea3b3 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 22 Aug 2007 22:14:31 -0700
Subject: [PATCH] git-svn: dcommit prints out the URL to be committed to

This will print out the URL that dcommit will operate on.
If used with --dry-run this will print out the URL without
making changes to the repository.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d162114..7a8ffd5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -370,6 +370,7 @@ sub cmd_dcommit {
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	print "Committing to $url ...\n";
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history\n";
-- 
Eric Wong
