From: Joachim Breitner <mail@joachim-breitner.de>
Subject: Re: git-note -C changes commit type?
Date: Wed, 12 Feb 2014 10:33:07 +0000
Message-ID: <1392201187.2546.13.camel@kirk>
References: <1392139407.12790.7.camel@kirk>
	 <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
	 <1392195218.2546.7.camel@kirk>
	 <CALKQrgfRD2_Z4u3QoqoONv_Ydp-YAv66oXrPda=YDBX-Dn145w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hNbNG/0aQTLrSp8WO6DZ"
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 11:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDX85-0004q5-38
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 11:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbaBLKdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 05:33:14 -0500
Received: from hermes.serverama.de ([78.47.178.158]:34432 "EHLO
	hermes.serverama.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaBLKdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 05:33:12 -0500
Received: from [10.254.1.12] (helo=kirk)
	by hermes.serverama.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDX7s-0002ev-4h; Wed, 12 Feb 2014 11:33:10 +0100
Received: from jojo by kirk with local (Exim 4.82)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDX7r-0003qp-9N; Wed, 12 Feb 2014 10:33:07 +0000
In-Reply-To: <CALKQrgfRD2_Z4u3QoqoONv_Ydp-YAv66oXrPda=YDBX-Dn145w@mail.gmail.com>
X-Mailer: Evolution 3.8.5-2+b1 
X-Spam-Score: -7.6 (-------)
X-Spam-Report: Status No, score=-7.6 required=5.0 bayes=0.0000 tests=ALL_TRUSTED=-1,BAYES_00=-6.599 autolearn=ham version=3.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241982>


--=-hNbNG/0aQTLrSp8WO6DZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Johan,

thanks for the patch!

Am Mittwoch, den 12.02.2014, 11:26 +0100 schrieb Johan Herland:
> Here's another way to solve your problem, which should be fairly
> transparent and performant:
>=20
> Whenever you want to reference "history" of a commit (I'm using quotes
> here, because we're not talking about the "regular" git sense of
> history, i.e. the commit graph), you perform the following two steps:
>=20
> 1. Append the "historical" commit SHA-1 (3d7de37 in your example) to a
> note on the "current" commit (e1bfac4). E.g.:
>=20
>     git notes --ref history append -m 3d7de37... e1bfac4...
>=20
> 2. Perform some automated merge into a "history"-tracking ref (e.g.
> refs/history), to keep the "historical" commits reachable.
>=20
> (You can easily wrap both steps into a script to automate things.)
>=20
> Step #1 encodes the "history" of a commit in a note, but does not keep
> the "history" reachable.
>=20
> Step #2 keeps all "historical" commits reachable by making them part
> of the history (in the git sense - without quotes) of a proper ref
> (refs/history). The actual result/outcome of the merge is not
> interesting. It only exists to insert the "historical" commit
> (3d7de37) into the ancestry for refs/history. Since the actual merge
> itself is uninteresting, you should probably use a merge strategy that
> never yields conflicts, e.g. "-s ours"
>=20
> You can now share the "history" by pushing/fetching the two refs
> refs/notes/history and refs/history.
>
> (In theory, you might even be able to combine the two refs, by
> performing the merge directly into refs/notes/history, always taking
> care to retain the notes tree contents as the result of the merge. In
> other words, after you do step #1 (append the note), you manually
> rewrite the just-created tip of refs/notes/history to include 3d7de37
> as a second parent. This keeps 3d7de37 reachable (and it will be
> shared when you share refs/notes/history), and it should not interfere
> with the notes infrastructure, as they only look at the current state
> of the notes tree.)

That is quite a good approximation. What it doesn=E2=80=99t do is dropping
history (in the refs/history sense) of commits that disappear, but the
same problem exists with notes. Thanks!


I guess there are no plans to make the commit object format itself
extensible, are they? Extensible in the sense that I can add a custom
field to it (e.g. history:). Git would not have to know anything about
the field besides its type, i.e. that it contains refs that it has to
follow. Very much like "parent:", just without the semantics of it wrt.
"git log" and the like.


Greetings,
Joachim
--=20
Joachim =E2=80=9Cnomeata=E2=80=9D Breitner
  mail@joachim-breitner.de =E2=80=A2 http://www.joachim-breitner.de/
  Jabber: nomeata@joachim-breitner.de  =E2=80=A2 GPG-Key: 0x4743206C
  Debian Developer: nomeata@debian.org

--=-hNbNG/0aQTLrSp8WO6DZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlL7TeMACgkQ9ijrk0dDIGyh7wCdHINJLq1vaJglauPksEAoCb4x
704AnipLTMJsuMl7rq93Jo7OzeN4wPXQ
=FxNZ
-----END PGP SIGNATURE-----

--=-hNbNG/0aQTLrSp8WO6DZ--
