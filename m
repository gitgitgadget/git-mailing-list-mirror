From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] parse-opt: migrate builtin-apply.
Date: Sat, 27 Dec 2008 15:05:33 +0100
Message-ID: <20081227140533.GX21154@genesis.frugalware.org>
References: <1230351727-20116-1-git-send-email-vmiklos@frugalware.org> <7vtz8qgjo9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PqX6tBBuHl4HmZHK"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 15:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGZoh-0004xy-Lo
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 15:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYL0OFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 09:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbYL0OFi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 09:05:38 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35258 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbYL0OFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 09:05:37 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E368558091;
	Sat, 27 Dec 2008 15:05:33 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 737C64465E;
	Sat, 27 Dec 2008 15:05:33 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 60A8611B8630; Sat, 27 Dec 2008 15:05:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vtz8qgjo9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104005>


--PqX6tBBuHl4HmZHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2008 at 11:29:42PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > The only notable user-visible/incompatible change is that the
> > --build-fake-ancestor option now conforms to gitcli(7).
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> > ---
> >
> > I know that we do care about incompatible changes a lot, though I think
> > this is the right direction and probably --build-fake-ancestor is not a
> > heavily used switch, so I hope that part is OK.
>=20
> An acceptable justification for such a plumbing change is if (1) the old
> syntax is still supported the same way as the original implementation,
> *and* if (2) the new syntax is something that could not possibly have been
> a valid input to the original implementation with a different meaning.
>=20
> I think the condition (1) holds but (2) does not hold for your patch; even
> though I think the latter breakage is excusable in this particular case,
> it is not for the reason you cited.
>=20
> That is,
>=20
>  (1) The parseopt parser allows both of these forms:
>=20
> 	$ git apply --build-fake-ancestor file <input
>         $ git apply --build-fake-ancestor=3Dfile <input
>=20
>      The former has been how existing scripts that use the plumbing have
>      been feeding the file, and it is still supported.
>=20
>  (2) A script that used "git apply" and relied on the behaviour of=20
>      the original implementation could have fed a patch from a file
>      whose name is "--build-fake-ancestor=3Dsome-string", with this comma=
nd
>      line:
>=20
>         $ git apply --build-fake-ancestor=3Dfile
>=20
>      Now such a script would break with the new parser.
>=20
> The reason you are excused to break such an insane script is definitely
> not because --build-fake-ancestor is a rarely used option.  The whole
> defence depends on the fact that --build-fake-ancestor=3Dsomething is a v=
ery
> unlikely name for any sane script to be using for its temporary file.  It
> could still be an end user input, but at that point you could simply doubt
> the sanity of the end user and dismiss the issue away.
>=20
> I am not fundamentally opposed to using parseopt in git-apply, and I think
> the change to add a new and saner meaning to "--build-fake-ancestor=3Dfil=
e"
> on the command line is a good thing in the longer term.  But your
> justification for such a change should be given in such a way to show
> clearly that you have thought things through.  It has to be much better
> than "it is not a heavily used switch anyway".

I was not aware about parsepont allows both options, I just -
incorrectly - thought git-log uses paseopt and there I remember
--since=3Dfoo works, but not --since foo. So actually the commit message
is incorrect, the backwards-incompatible change is not to accept a patch
file named --build-fake-ancestor=3Dsomething without passing '--' first.

> The saddest part of the story that pisses me off about this patch is that
> you did not seem to have even run the test suite before sending it.  t4105
> and t4252 fail for me, at least.

Hm, I did:

$ ./t4105-apply-fuzz.sh
*   ok 1: setup
*   ok 2: unmodified patch
*   ok 3: minus offset
*   ok 4: plus offset
*   ok 5: big offset
*   ok 6: fuzz with no offset
*   ok 7: fuzz with minus offset
*   ok 8: fuzz with plus offset
*   ok 9: fuzz with big offset
* passed all 9 test(s)

$ ./t4252-am-options.sh
*   ok 1: setup
*   ok 2: interrupted am --whitespace=3Dfix
*   ok 3: interrupted am -C1
*   ok 4: interrupted am -p2
*   ok 5: interrupted am -C1 -p2
* passed all 5 test(s)

$ git show -s --pretty=3Doneline
05d26caf212b58998b7e559991f3a25fd8cbf3f0 parse-opt: migrate builtin-apply.

What testcases did fail for you?

> I did not look at the patch very closely, but do you really need that many
> option callbacks?  My gut feeling is that many of them should be just
> setting a boolean flag, and you can postprocess to get the correct "apply"
> behaviour.
>=20
> For example, you start with "apply" set to true, and let parseopt set
> "diffstat" upon seeing "--stat", and set "cmdline_apply" upon seeing
> "--apply".  After parseopt returns, you determine the final value of
> "apply" by using "diffstat" (and friends that would normally drop "apply")
> and "cmdline_apply" (which would override such droppages).  That way I
> think you can lose many callback functions whose sole purpose is to drop
> "apply" option, no?

Yes, you are right. I'll send an updated patch in a bit.

--PqX6tBBuHl4HmZHK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklWNi0ACgkQe81tAgORUJZVwQCgk3sEedVn92My7DPSl8ae66yw
XVcAnRBvByNG8XIouDmNdzgZzQvuFHZ/
=+GDc
-----END PGP SIGNATURE-----

--PqX6tBBuHl4HmZHK--
