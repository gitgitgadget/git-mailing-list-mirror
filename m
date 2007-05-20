From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:14:55 +0200
Message-ID: <20070520221455.GN5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 00:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hptg7-00057j-Lj
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbXETWO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757456AbXETWO5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:14:57 -0400
Received: from mail.admingilde.org ([213.95.32.147]:37506 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168AbXETWO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:14:57 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hptfz-0006mI-TA; Mon, 21 May 2007 00:14:55 +0200
Content-Disposition: inline
In-Reply-To: <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47936>


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 20, 2007 at 12:10:04PM -0700, Junio C Hamano wrote:
> The more important issue I think is at what point in the
> superproject operation does a recursive checkout in a subproject
> should happen, and how we should do the checkout.

we should really move from our big clone thing to a simple
fetch+checkout wrapper.

And then integrate all the submodule logic into the actual checkout
step where it belongs.

We might also want to expand fetch to also fetch newly reachable
submodule commits (of a configurable subset of modules).

> Issues I can think of offhand are (no way exhaustive):
>=20
>  - Do we checkout a branch? if so which one?

At least no off-the-shelf branch from the upstream repository of
the submodule.

To use some special branch allows to use normal git methods in
the submodule, too -- but I haven't been able to convince everybody
yet...  So let's get it to a state where people can play with it
in real projects and let's see.


>  - Do we detach HEAD if the commit named by the superproject
>    tree is not at the tip of the current branch of subproject?
>    do we detach always even if the commit is at the tip?

We must not mess with random upstream branches of the submodule
just because they happen to reference the same tip.
That would be too confusing.
Either use one special branch or detach.

>  - What would we do when the subproject working tree is not
>    clean?

The same as with normal files:
error out if something is changed which conflicts with the requested
update.

When we have a special managed-by-supermodule branch and the submodule
has another branch currently checked out we can entirely ignore this
issue.
This really allows the user to deliberately keep one module in an
unclean state.

>  - How can a user decide which subproject to descend into and
>    which subproject to ignore, and how does git remember the
>    earlier decision made by the user without asking the same
>    again, and how does a user express "now I want to also track
>    that subproject I've ignored so far" and "now I am not
>    interested in following that subproject anymore"?

I'd simply use explicit checkout of a submodule and removal of
the submodule to be a fine way to express the user's wish.
Of course we also need some way to say: populate everything
below "src/target" or similar.  But that is independent from
the rest.

--=20
Martin Waitz

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUMhfj/Eaxd/oD7IRAvvuAJ0aW8ZTR/EPRzEOGosmBdz02sL9nQCfcOp/
D8WLWRFAntzRgO+YA3W2N4w=
=BZf7
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
