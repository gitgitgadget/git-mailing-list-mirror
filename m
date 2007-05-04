From: Johan Herland <johan@herland.net>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 14:22:11 +0200
Message-ID: <200705041422.13975.johan@herland.net>
References: <loom.20070502T111026-882@post.gmane.org> <200705040921.33443.johan@herland.net> <20070504111057.GI4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5568633.R6xIv40G3i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 04 14:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjwoR-0006w1-IP
	for gcvg-git@gmane.org; Fri, 04 May 2007 14:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbXEDMWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 08:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbXEDMWb
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 08:22:31 -0400
Received: from sam.opera.com ([213.236.208.81]:41977 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbXEDMW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 08:22:29 -0400
Received: from pc052.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l44CMETh010824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2007 12:22:19 GMT
User-Agent: KMail/1.9.6
In-Reply-To: <20070504111057.GI4489@pasky.or.cz>
X-Virus-Scanned: ClamAV 0.90.1/3204/Thu May  3 18:46:39 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46176>

--nextPart5568633.R6xIv40G3i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 04 May 2007, Petr Baudis wrote:
> On Fri, May 04, 2007 at 09:21:29AM CEST, Johan Herland wrote:
> > On Friday 04 May 2007, Jakub Narebski wrote:
> > > Besides I think it would be better to teach blame to ignore reversion
> > > commits (for example based on first line of commit message) than to
> > > mess with the history.
> >
> > I'm starting to see a pattern where people would like to tell git about
> > more complicated relationships between commits, so that git can make
> > more intelligent decisions when doing merge, blame, pickaxe, etc.
> >
> > Adding these relationships as part of the commit message seems like a
> > really stupid idea because git suddenly has to make sense of something
> > it has never parsed before, thus making all future and former git
> > commit messages a potential target for pattern (mis)matching by git.
> > Also, we seem to forget that we already have the perfect place to put
> > such information: The header fields preceding the commit message.
> >
> > I therefore propose adding header field names to commit objects that
> > illustrate the relationships people want to tell git about.
>
>   So I've looked it up, and the Linus' writeup on this is at
>
> 	http://news.gmane.org/find-root.php?message_id=3D<Pine.LNX.4.64.06042507=
5800
>0.3701@g5.osdl.org>

Thanks a lot for the link. I hadn't seen that writeup.

=46or the record: I'm only interested in adding "machine-readable" headers =
in=20
cases where _both_ of the following holds:
1. The header has a _clear_ and _unambiguous_ _meaning_.
2. git can use the header in a well-defined manner to make informed and bet=
ter=20
decisions on how to behave.

In Linus' writeup, he's correct in that "prior" is too loosely defined.=20
However, if we can meet Linus' requirements for clearness and semantics, I=
=20
actually think the core idea is very good.

> > 1. "Reverts": Mark a commit as reverting another commit. This could be
> > used by git-log to cancel out pairs of commits, resulting in a cleaner
> > view of history. It can help blame/annotate. There are probably other
> > tools that can benefit from this information also.
>
>   Actually I think git-log is the one tool which shouldn't cancel it
> out. The number of reverts likely won't be overwhelming and reverting is
> actually pretty important event - it says "this has been tried and we
> decided it's not the way", also can have social meanings etc. It is an
> important piece of history. And people still want to actually see the
> change and possibly revive it. BTW, imagine their confusion if the
> history looks like
>
> 	1abcd5 Feature X
> 	37efab Release 2.3.1
> 	724b9c Revert feature X
>
> and git log would cancel out 1abcd5 and 724b9c. Feature X is part of
> 2.3.1 but not in the log..?!
>
>   The point is that the reverting/reverted commit pairs don't affect
> your current content (except maybe in an highly abstract way), and this
> is why pickaxe and blame should skip it (by default).

Of course git-log shouldn't skip reverted commit pairs _by_default_. But if=
=20
someone is interested in a cleaner view of history (e.g. when making a=20
changelog or whatnot), a command-line option for turning on this behaviour=
=20
might be useful. Or maybe we don't want git-log to be affected by "Reverts"=
=20
at all. But if pickaxe and blame can make real use of this header, that's=20
sufficient reason to add it, I think.

>   The question wrt. Linus' criteria is if "it has enough of a meaning",
> and I wonder about that too. I think it does, though.

As stated above, I don't want header fields unless they have clearly define=
d=20
meaning and semantics. I doubt that all of my examples will fulfill these=20
criteria, but some of them should, and that may be useful enough.

>   For the other suggested headers, it should be already mostly obvious
> from Linus' writeup why they shouldn't qualify, though.

I agree with Linus in that if we cannot define clear meaning and accompanyi=
ng=20
semantics, then adding a header is useless. I do, however, think that there=
=20
are cases where we _can_ define the meaning and semantics, and in those=20
cases, I do believe header fields to be a good idea.

As for "Cherry-Pick", it is of course not useful when the commit pointed to=
 is=20
not in the repo, but in the cases where it _is_, it might be very useful.=20
It's a tradeoff, and we might end up deciding that "Cherry-Pick" is not wor=
th=20
it, but we should at least consider the possibility.


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart5568633.R6xIv40G3i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGOyV1BHj4kl4fT1wRAuOqAJ9jShs4HUCvevFG2E9JT7A2WKZ5vACcDJQx
Lu4jA8CoV9QSpSVvyiZnB/U=
=/Ct0
-----END PGP SIGNATURE-----

--nextPart5568633.R6xIv40G3i--
