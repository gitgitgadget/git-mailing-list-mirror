From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 11:03:50 +0200
Message-ID: <20070610090350.GE2951@artemis>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net> <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net> <200706100325.32846.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ycz6tD7Th1CMF4v7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJLZ-0007rB-TI
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbXFJJDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbXFJJDw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:03:52 -0400
Received: from pan.madism.org ([88.191.52.104]:35025 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbXFJJDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:03:51 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 73434CA9F;
	Sun, 10 Jun 2007 11:03:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3191BA797; Sun, 10 Jun 2007 11:03:50 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706100325.32846.johan@herland.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49691>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 03:25:32AM +0200, Johan Herland wrote:
> On Sunday 10 June 2007, Junio C Hamano wrote:
> > It gets worse when you actually start using softrefs.  I do not
> > think you would have a limited set of softrefs, such as
> > "reverse-tag-lookup-softref", "bug-tracker-softref".  For
> > example, a typical bug tracking sheet may look like this:
> >=20
> >       - Hey I found a bug, you can reproduce like so... I am
> >         testing commit _A_.
> >       - It appears that commit _B_ introduced it; it does not
> >         reproduce with anything older.
> >       -	Here is a patch to fix it; please try.
> >       - Oh, it seems to fix.  Committed as _C_.
> >       - No, it does not work for me, and the approach to fix is
> >         wrong; reopening the bug.
> >       - Ok, take 2 with different approach.  Committed as _D_.
> >  	please try.
> >       - Thanks, it finally fixes it.  Closing the bug.
> >=20
> > The bug will be associated with commits A, B, C and D.  The
> > questions maintainers would want to ask are:
> >=20
> >  - What caused this bug?
> >  - Which versions (or earlier) have this bug?
> >  - Which versions (or later) have proper fix?
> >  - What alternate approaches were taken to fix this bug?
> >  - In this upcoming release, which bugs have been fixed?
> >  - What bugs are still open after this release?
> >=20
> > Depending on what you want to find out, you would need to ask
> > which commits are related to this bug tracking sheet object, and
> > the answer has to be different.  Some "softref" relation should
> > extend to its ancestry (when "this fixes" is attached to a
> > commit, its children ought to inherit that property), some
> > shouldn't ("this is what broke it" should not propagate to its
> > parent nor child).
>=20
> We're getting a little ahead of ourselves, aren't we? IMHO, it would be u=
p=20
> to the bug system to determine which (and how many) connections to make=
=20
> between the bug reports and the commits (or even if softrefs would be the=
=20
> correct mechanism for these connections at all). We shouldn't necessarily=
=20
> base the softrefs design on how we imagine a hypothetical bug system to=
=20
> work. But Pierre might have something to say on how he would want to use=
=20
> softrefs, and his system is hopefully _less_ hypothetical. :)

  To be fair, I'm still struggling with the storage backend yet, trying
to make things fast enough (My current import rate of mails is 10 per
second, wich is not that brilliant I guess), and also to design some
simple things like "answering" to a bug.

  For now, my design is the following, I've a 'bts' branch where the
bugs reports (plain mailboxes) go. Grit is able to manage as many branch
the user wants, bts is just the default name for it. Then, for a bts
branch, you have $GIT_DIR/grit/<branch>.index and
$GIT_DIR/grit/<branch>/. The former is the index of the tip of the bts
branch, and the latter contains some bits of the tip of the branch
checkouted (can be seen as some kind of cache, useful to run mutt -f on
a mbox e.g.).

  Bugs have the sha id of the hash of the first imported mail, and are
put in sha[:2]/sha[2:] files, =C3=A0 la .git/objects/. I also should have a
second file with annotations about the bug, format not really clear for
now, as "one file per bug" could be quite inefficient. OTOH if I mix too
many bugs in the same file, the merge risk is bigger (but I suppose I
could use a specific merge strategy on this).

  Here is the sole non hypothetical thing yet. My plans then was to use
"links" (softlinks or not, I'm speaking generically, I hope softrefs
will match my needs, I don't know yet) between specific commits, and
bugs. Links would somehow carry information on wether this is an
"opening" tag (like: this bug is present starting at that commit), an
informationnal tag (like: this commit helps fixing that bug, but is not
enough), or a closing/fixing tag (like: this commit fixes it). A fourth
kind may be also used aka a not-found tag (like: well this commit does
not fixes the bug, but for sure it's not there anymore at that commit).

  Though, softlinks do not need to "carry" the information for real,
they just need to be linked somehow to the bug, bug that would have the
annotations for those softlinks in them.

  What is somehow flawed for me, is that when someone "answers" to the
bug or changes a bit of information about it, it generate a "new"
commit, and I would need to move the softlinks to the new commit object
it generated to shorten the path and go directly to the last version of
the bug status file.

  So to be of use for me, yes, I guess I would really like the
versionning of softlinks. If I use them at all, I don't know yet.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGa752vGr7W6HudhwRArdWAJ99FVpDvKwBS/BK3vqkT+UmfivtXgCdH9r4
h6STv5Zbqu7THlku/aHlWx0=
=cFtQ
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
