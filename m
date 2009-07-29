From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit
	notes
Date: Wed, 29 Jul 2009 07:26:34 -0700
Message-ID: <20090729142634.GC1033@spearce.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <200907280343.56586.johan@herland.net> <7vskgg1bbt.fsf@alter.siamese.dyndns.org> <200907290441.08246.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 16:28:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWA7A-0007tb-56
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 16:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbZG2O0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZG2O0e
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 10:26:34 -0400
Received: from george.spearce.org ([209.20.77.23]:51771 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbZG2O0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 10:26:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A299381FD; Wed, 29 Jul 2009 14:26:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907290441.08246.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124354>

Johan Herland <johan@herland.net> wrote:
> On Wednesday 29 July 2009, Junio C Hamano wrote:
> > Johan Herland <johan@herland.net> writes:
> > > +
> > > +In both formats `<committish>` is any of the commit specification
> > > +expressions also accepted by `from` (see above).
> >
> > Doesn't this make fast-import language incapable of add notes to anything
> > other than commits?  As far as I remember, there is no such limitation in
> > the underlying data structure on git notes, even though the git-notes
> > sample Porcelain might have such a restriction.
> 
> It does (probably because the default notes tree is "refs/notes/commits").

Yea, it does have that limitation right now.  That limitation could
be relaxed in the code by just allowing the <committish> to be any
object and simply don't check its type.

But I've already stated with regards to the notes that I think we
should only allow noting commits and annotated tags, where we have
a timestamp we can use to split the notes in the note tree by time,
so that we can index recent notes much more quickly and can answer
`git log -20` much more efficiently.

I just don't see a lot of value in noting a blob or a tree, there
is too little context information on such things for it to really
be all that useful.

> > We recently hit a similar unintended limitation that we regret in the
> > fast-import language, didn't we?
> 
> I don't know. Must have slipped past my mailbox.

I remember something being raised, but I can't remember exactly
what it was either.

It might have had to do with the effects of rename commands, e.g. a
file rename takes place immediately when issued, and some frontends
wanted it to take place only after the commit was completed.
 
> > Although personally I do not think it is a big deal if we cannot tag or
> > add notes to trees, I am pointing it out in case other people care.
> 
> I copied the semantics from the 'tag' command, for no particular reason 
> (except following the git-notes procelain). Expanding 'notemodify' (and 
> 'tag') to cover all types of objects is fine by me, unless there are good 
> arguments otherwise. Shawn?

tag, there might be arguments for tagging trees, e.g. so you can
export the linux kernel repository with `git fast-export` and reload
it with fast-import.  But that's unrelated to this change.

See above about notes.

-- 
Shawn.
