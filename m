From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: caching commit patch-ids for fast git-cherry
Date: Thu, 29 May 2008 23:19:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805292318040.13507@racer.site.net>
References: <7f9d599f0805291001mdbb4b42q6f3a1b79bc9bc4e9@mail.gmail.com>  <alpine.DEB.1.00.0805291809340.13507@racer.site.net> <7f9d599f0805291034l6c655ccbk219dd74964c65737@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri May 30 00:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1qVV-0005Zl-GR
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 00:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbYE2WVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 18:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbYE2WVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 18:21:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:37226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754323AbYE2WVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 18:21:06 -0400
Received: (qmail invoked by alias); 29 May 2008 22:21:04 -0000
Received: from R1bad.r.pppool.de (EHLO none.local) [89.54.27.173]
  by mail.gmx.net (mp009) with SMTP; 30 May 2008 00:21:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JN2QEbzxJwzocW/HNjmOYzVtgFZvUbJFnWQvbw2
	2HPmgWZHCRARjn
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0805291034l6c655ccbk219dd74964c65737@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83250>

Hi,

On Thu, 29 May 2008, Geoffrey Irving wrote:

> On Thu, May 29, 2008 at 10:13 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Thu, 29 May 2008, Geoffrey Irving wrote:
> >
> >> I'm planning to use cherry picking to manage long term syncing 
> >> between cvs/perforce and git repositories.  This means I'll have 
> >> scripts running git-cherry between branches with hundreds of uncommon 
> >> commits, and I want git-cherry to be much, much, faster.
> >>
> >> It looks like I can do this by caching commit->patch-id pairs from 
> >> commit_patch_id() in patch-ids.c to a file, say 
> >> $GIT_DIR/commit-patch-id-cache.  The file would be binary and append 
> >> only, and could be blown away if .  Any suggestions / concerns before 
> >> I write this?  Is there any reusable efficient map code for storing 
> >> the commit->patch-id map, or should I just mirror the blocked storage
> >> + binary search used for struct patch_ids?
> >
> > I would store the stuff sorted, so that the lookup is fast, generation 
> > less so.
> 
> The motivation for append-only was robustness, not speed, but I don't 
> think either concern is very significant.

I think that robustness comes from "write new file and rename if all 
succeeded", not from append-only.  Think of the case where you run out of 
disk space; with append-only, it is more complicated to get back to a 
known good state.
 
> > For inspiration, you might want to look at the "notes" branch in my 
> > personal fork:
> >
> > http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/notes
> 
> Cool.  I'd rather copy just that code entirely rather than use it for 
> inspiration, since it does exactly what I need.  It would be silly to 
> have two blocks of code implementing "persistent map from 20 byte hash 
> to 20 byte hash".

Hehe.  That's what I meant by "inspiration" ;-)

> I'll start by just copying the entire nodes-index implementation (with a 
> few name substitutions), and we (or I) can refactor it later if both end 
> up in the same respository.

Very nice!

Thanks,
Dscho
