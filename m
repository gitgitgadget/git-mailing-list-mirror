From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Avoid invoking diff drivers during git-stash
Date: Fri, 19 Oct 2007 02:13:51 -0400
Message-ID: <20071019061351.GL14735@spearce.org>
References: <20071019013350.GA14020@spearce.org> <471849D7.1020303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 08:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iil7W-0004z7-Uy
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXJSGN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXJSGN4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:13:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48598 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXJSGNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:13:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iil7I-0007Ob-GK; Fri, 19 Oct 2007 02:13:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 17CE720FBAE; Fri, 19 Oct 2007 02:13:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <471849D7.1020303@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61656>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > Johannes Sixt <j.sixt@viscovery.net> wrote:
> > > (1) Looking at git-stash.sh I see a few uses of 'git diff' in
> > > apply_stash(). Shouldn't these use one of git-diff-{tree,index,files)? 
> > The
> > > reason is that porcelain 'git diff' invokes custom diff drivers (that 
> > in my   > case run a UI program), whereas the plumbing does not.
> > >
> > > Is there a particular reason to use porcelain 'git diff'?
> >
> > Does this fix the problem?
> 
> It does!
> 
> >@@ -110,7 +110,7 @@ show_stash () {
> > 
> > 	w_commit=$(git rev-parse --verify "$s") &&
> > 	b_commit=$(git rev-parse --verify "$s^") &&
> >-	git diff $flags $b_commit $w_commit
> >+	git diff-tree $flags $b_commit $w_commit
> 
> However, this porcelain 'git diff' should actually remain because it's part 
> of show_stash().

Heh.  Damn.  I was just starting to prepare my evening push and
this patch is in maint, which I just merged to master, and I just
rebased all of my pu topic branches over that.  Junio's Meta toolkit
doesn't have an "unrebase" so I can go back and amend that damn
commit before pushing.

I'm feeling lazy and don't want to create an unRB right now.
I'll probably just throw another commit into maint to fix the
above hunk.  Thanks for catching it.

-- 
Shawn.
