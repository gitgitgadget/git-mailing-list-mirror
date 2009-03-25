From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 16:38:37 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251611140.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org> <7vskl284bt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903251050430.19665@iabervon.org> <7vbprp5vko.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903251446180.19665@iabervon.org>
 <7vskl1xuez.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZtT-0000NF-Sq
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCYUil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZCYUik
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:38:40 -0400
Received: from iabervon.org ([66.92.72.58]:41749 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbZCYUik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:38:40 -0400
Received: (qmail 14777 invoked by uid 1000); 25 Mar 2009 20:38:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 20:38:37 -0000
In-Reply-To: <7vskl1xuez.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114660>

On Wed, 25 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 25 Mar 2009, Junio C Hamano wrote:
> >
> >> Suppose a project used to use subversion, but it migrated to git (not an
> >> unheard-of scenario these days, I hope).  The git repository now is the
> >> authoritative one, all the development happens on this side.
> >> 
> >> But in order to help:
> >> 
> >>  - people who have established their workflow to follow the project
> >>    (e.g. not necessarily contributing anything back, but just doing
> >>    regular "svn update");
> >> 
> >>  - people who have leftover local changes from the subversion days; and
> >> 
> >>  - other project infrastracture (e.g. trac) that the project hasn't
> >>    managed to interface to the new git repository yet;
> >> 
> >> the project decides to keep feeding recent updates to the subversion
> >> repository that used to be authoritative, even though it is now declared
> >> read-only (i.e. the only update comes from the git end).
> >
> > Actually, this is easy: just configure the git repo to not fetch anything 
> > from the no-longer-authoritative subversion repository. git-vcs-svn would 
> > waste a bunch of time reimporting what it exported, but it wouldn't 
> > actually do anything with it (since it doesn't even have tracking refs to 
> > update). It could, of course, be optimized to avoid reimporting if it 
> > doesn't need to.
> 
> I am afraid that won't fly; my comment that started this subthread was not
> about your "import" but was about your "export" part.  It is about sending
> the git branch to the other end, which is allowed to rewrite what we send
> and force us to modify our history.

It can rewrite what we send, but if we're not reimporting it, we don't 
care what it's done. All we care about is that when we ignore the 
rewriting, git-vcs-* can still export more changes from our version of the 
history.

That is, if we push X, which gets rewritten to X' (but we ignore that), 
and we then push Y, whose parent is X (not X'), a high-quality git-vcs 
backend will be reliably able to accept the second push, just as if we'd 
created a Y' based on X'. And by "high-quality", I mean some testable 
capability with a better name.

	-Daniel
*This .sig left intentionally blank*
