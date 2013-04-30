From: Adam Spiers <git@adamspiers.org>
Subject: Re: improvements to checks for core.notesRef / GIT_NOTES_REF / --ref
Date: Tue, 30 Apr 2013 01:40:06 +0100
Message-ID: <20130430004006.GF8768@pacific.linksys.moosehall>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
 <20130429133205.GA4672@pacific.linksys.moosehall>
 <20130429163909.GA19014@pacific.linksys.moosehall>
 <7vmwshjm4j.fsf@alter.siamese.dyndns.org>
 <20130429214051.GA1704@pacific.linksys.moosehall>
 <CALKQrgdH_Oh122tGKeD+chk5f6PwUvsisXjRp68QD_KMQt-9Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 02:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWycD-0000WK-5v
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 02:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759395Ab3D3AkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 20:40:10 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:41206 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759379Ab3D3AkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 20:40:09 -0400
Received: from localhost (4.3.1.2.f.7.0.2.5.1.9.5.4.a.0.0.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:a4:5915:207f:2134])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CBF972EAD2;
	Tue, 30 Apr 2013 01:40:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALKQrgdH_Oh122tGKeD+chk5f6PwUvsisXjRp68QD_KMQt-9Bg@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222890>

On Tue, Apr 30, 2013 at 02:32:33AM +0200, Johan Herland wrote:
> On Mon, Apr 29, 2013 at 11:40 PM, Adam Spiers <git@adamspiers.org> wrote:

[snipped]

> > IMHO the more similar the merge's user experience is to a standard
> > merge, the better, since that would minimise the number of merging
> > workflows the user needs to learn.
> >
> > On this theme, I think ideally rebase should be supported too, and
> 
> IMHO the general discussion about rebase vs. merge is mostly about the
> shape of the resulting history. When it comes to notes, I have yet to
> see a use case where anybody really cares about the shape of the notes
> history, and hence I don't yet see how rebase would be useful for
> notes. In fact, it rather seems some people are more interested in
> storing their notes trees without any history at all (ISTR a
> discussion regarding the notes-cache feature, where we did NOT want to
> keep earlier versions of the cache alive).

That's a fair point; lack of rebase is certainly not a showstopper.
In contrast, in our use case, a total lack of history could be quite
annoying.

> > I also have to manually update the fake tracking "branch":
> >
> >     git update-ref refs/notes/$remote/$GIT_NOTES_REF refs/notes/$GIT_NOTES_REF
> >
> >     # or if I want to make really sure this only happens if the push worked
> >     git fetch $remote refs/notes/$GIT_NOTES_REF:refs/notes/$remote/$GIT_NOTES_REF
> >
> > That's pretty ugly.  Couldn't we instead just reuse the existing
> > mechanisms?
> >
> >     remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
> >     remote.origin.fetch=+refs/notes/*:refs/note-remotes/origin/*
> 
> The remote refs namespace idea aims to solve this by providing refspecs like
> 
>     remote.origin.fetch=+refs/heads/*:refs/remotes/origin/heads/*
>     remote.origin.fetch=+refs/tags/*:refs/remotes/origin/tags/*
>     remote.origin.fetch=+refs/notes/*:refs/remotes/origin/notes/*
>     remote.origin.fetch=+refs/replace/*:refs/remotes/origin/replace/*
>     etc.
> 
> I'm currently working on some patches to make git work well in repos
> with those kinds of refspecs. I see that as the first step on the way
> to properly supporting remote ref namespaces.
> 
> >     branch.notes/commits.remote=origin
> >     branch.notes/commits.merge=refs/notes/commits
> 
> This looks like an natural extension of the branch upstream mechanism
> for notes. Personally, I'd rather have it look more like this:
> 
>   [notes "commits"]
>         remote = origin
>         merge = refs/notes/commits
> 
> or, in your notation:
> 
>     notes.commits.remote=origin
>     notes.commits.merge=refs/notes/commits

Ahah yes, that's nicer.  Thanks for the reply!
