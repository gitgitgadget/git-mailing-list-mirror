From: Jeff King <peff@peff.net>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 12:29:07 -0500
Message-ID: <20140214172907.GA14610@sigill.intra.peff.net>
References: <20140213091037.GA28927@sigill.intra.peff.net>
 <CALkWK0mR=9ZD256bHx9d=W9ayqn5bOETWBQLW_kvRSy-GeQK4Q@mail.gmail.com>
 <20140214104139.GA28570@sigill.intra.peff.net>
 <CALkWK0nXbfoe7697m27o7b+vepkOWj+vpJJWRy9EkJeZkTyekw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 18:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEMZg-0007Sz-3r
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 18:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaBNR3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 12:29:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:50625 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbaBNR3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 12:29:10 -0500
Received: (qmail 16755 invoked by uid 102); 14 Feb 2014 17:29:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Feb 2014 11:29:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Feb 2014 12:29:07 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nXbfoe7697m27o7b+vepkOWj+vpJJWRy9EkJeZkTyekw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242114>

On Fri, Feb 14, 2014 at 10:30:28AM -0500, Ramkumar Ramachandra wrote:

> > Isn't the merge backend faster? I thought that was the point of it.
> 
> I suppose, but I thought git-rebase--am.sh (the default flavor) could
> be improved by leveraging relatively new cherry-pick features; I
> assumed that the reason it was using format-patch/ am was because it
> was written before cherry-pick matured.

I think that's somewhat the case. But the am technique also knows a lot
of tricks that cherry-pick doesn't. For example, there is currently a
bug where "git rebase --keep-empty --whitespace=fix" silently ignores
the latter option, because the former causes it to follow a cherry-pick
code path.

So I am a little hesitant in pushing more code paths down the
cherry-pick route (though it would be OK if we correctly identified
_when_ we could use cherry-pick for performance, and only kick in then).

> Alternatively, can you think of a project that involves working on the
> sequencer?

So yeah, obviously this is all tied up with the sequencer. In the spirit
of "let's not re-propose old projects", I shied away from suggesting
"finish up the sequencer". I know that the past projects did make
progress, and that is a good thing. But I also think it doesn't make for
a good bite-sized chunk.

> >> 3. Rewrite git-branch to use git-for-each-ref
> >
> > I actually have this about 95% done, waiting for the patches to be
> > polished. So I don't think it makes a good GSoC project (it would be
> > stupid to start from scratch, and polishing my patches is a lame
> > project).
> 
> Oh. I look forward to using a nicer git-branch soon.

Actually, it is mostly about making a nicer git-for-each-ref, as I am
pulling out the ref selection code (which is more advanced in "git tag"
and "git branch") and using it everywhere. So in that sense, maybe I am
not shooting for what you want. I think you want the follow-on to that,
which is to pull out the formatting code (which is more advanced in
for-each-ref), and let it be used everywhere.

I added this into the ideas page, but noting that there were two sides
to it, and that one would need to examine and build on existing work (I
know there was some discussion and experiments on the formatting side,
too).

> I was hoping you'd have more comments on "3. Invent new conflict
> style". Although I'm not sure the conflict style I proposed would be
> terribly useful in the general case, it'll give the student an
> opportunity to look at older/ lesser-known portions of the codebase.

I almost said more. :) I am not sure I have in my mind what a useful
new format would look like, and I would worry that we are leading the
student into a bit of a trap, as they need to both code, but also invent
a new and useful format.

But one thing I was really hoping for with these project descriptions
(and I think we got) is that they are not completed project proposals.
They are the kernels of ideas that the student will need to develop into
full proposals. I would much rather have a student who reads that and
says "I have a brilliant idea for a format" and proposes it, rather than
one who blindly says "OK, I'll implement your idea". Getting the former
is much less likely, but if we do, I think it will lead to a much higher
quality project.

So I included it as-is, and I am curious to see what proposals we get.
:)

Thanks again for your list. I marked you as a potential mentor for the
conflict-style project; given the right proposal, I'd be happy to mentor
it, too (and without the right proposal, I do not think we should do it
at all). I also listed both you and me as potential mentors for
@{publish}, since we have both looked at the problem space. If you can't
make the time commitment, that's fine; I can do it (and we don't need to
decide until later anyway).

-Peff
