From: Mike Hommey <mh@glandium.org>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Sat, 6 Dec 2014 08:31:06 +0900
Message-ID: <20141205233106.GA832@glandium.org>
References: <20141205205335.GA28935@glandium.org>
 <20141205221319.GK16345@google.com>
 <20141205225930.GA29256@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx2LJ-0006lI-G6
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbaLEXbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:31:15 -0500
Received: from [12.216.224.110] ([12.216.224.110]:51358 "EHLO glandium.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752738AbaLEXbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:31:13 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xx2L5-0000Kl-0D; Sat, 06 Dec 2014 08:31:07 +0900
Content-Disposition: inline
In-Reply-To: <20141205225930.GA29256@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260914>

On Fri, Dec 05, 2014 at 05:59:30PM -0500, Jeff King wrote:
> On Fri, Dec 05, 2014 at 02:13:19PM -0800, Jonathan Nieder wrote:
> 
> > Mike Hommey wrote:
> > 
> > > I'm currently evaluating what the final tool would look like. I'm *very*
> > > tempted to implement it in C, based on core git code, because there are
> > > many things that this helper does that would be so much easier to do
> > > with direct access to git's guts. And that wouldn't require more
> > > dependencies than git currently has: it would "just" need curl and ssh,
> > > and git already uses both.
> > >
> > > If I were to go in that direction, would you consider integrating it
> > > in git core?
> > 
> > Yes --- I would like this a lot.
> 
> I'm concerned that this tool will have drawbacks that Felipe's remote-hg
> does not. And I can well imagine that it may, as that tool builds on
> Mercurial's API, which will probably handle some corner cases
> differently.

FWIW, my tool only uses the mercurial code for the wire protocol. This
can (and if I go the C route, will) be implemented without using
mercurial code, it's really not a hard problem.

> This isn't to disparage Mike's attempt; it will probably
> have some upsides, too. But given that the approaches are so different,
> it does not seem obvious to me that one will always be better than the
> other.
> 
> One of the nice things about spinning remote-hg out of the core repo is
> that it means we do not have to endorse a particular implementation, and
> they can compete with each other on their merits.  I would very much
> hate to see Felipe's remote-hg project wither and die just because
> another implementation becomes the de facto standard by being included
> in git.git. It's a proven tool, and this new thing is not yet.

Note that I'm only talking about an hypothetical long term goal. If
there's not even a slim chance that this may end up in git core, or in
the git.git repo, I'm not sure it's worth writing the tool in C at all,
considering the burden for users. IOW, I'm only trying to assess if I
should follow my temptation or not. But I can probably reassess after I
actually get my prototype to do more than it does now. But maybe there
are ways to make it work for users outside of git.git even if it's in C.
I don't know.

> It's a shame that both squat on the name "remote-hg", because it makes
> it difficult to tell the two apart. But of course that is the only way
> to make "git clone hg::..." work. Maybe we need a layer of indirection?
> :)

Yeah, that's an unfortunate consequence of how remote helpers work.
There are already two different git-remote-hgs (there's felipe's, and
there's another one using hg-git under the hood) that I know of. I'm
adding a third one. For what it's worth, none of the existing one is
satisfying on repos the size of Mozilla's, and apparently noone at
Mozilla uses them because of that. Add to that the disk space
inefficiency of actually keeping a copy of the mercurial repo locally.
The existing tools can likely be improved to scale better, but that
wouldn't change the disk space problem.

Mike
