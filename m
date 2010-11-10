From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Wed, 10 Nov 2010 12:45:22 +0100
Message-ID: <20101110124522.0dff4076.ospite@studenti.unina.it>
References: <20101020004533.b64d446c.ospite@studenti.unina.it>
	<1288990769-13307-1-git-send-email-ospite@studenti.unina.it>
	<vpqtyjvo0tp.fsf@bauges.imag.fr>
	<7vy692kx8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__10_Nov_2010_12_45_23_+0100_LgUm_Nq3dy.GzKIg"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 12:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG97n-00080M-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0KJLpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:45:55 -0500
Received: from smtp205.alice.it ([82.57.200.101]:32874 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755508Ab0KJLpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 06:45:54 -0500
Received: from jcn (82.57.79.217) by smtp205.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4C1A26450A00CD1D; Wed, 10 Nov 2010 12:45:35 +0100
In-Reply-To: <7vy692kx8k.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161148>

--Signature=_Wed__10_Nov_2010_12_45_23_+0100_LgUm_Nq3dy.GzKIg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Nov 2010 13:23:07 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>=20
> > I've been biten by this behavior sending the v2 of
> > a patch serie --in-reply-to the cover letter for the v1. The two
> > versions of each patch appear as reply to the original cover letter,
> > it's kind of a mess. I was really expecting the patch serie to appear
> > as a separate subtree in the discussion.
>=20
> The above is much better description of what issue the patch is trying to
> address; something like that should go to the description.
>

Alright, I'll try mentioning the actual use case too.

> Antonio, I've already queued a few tests that document the established
> behaviour on ao/send-email-irt branch (54aae5e1), so could you rebase your
> patch on it, perhaps with an updated explanation in the log (and in the
> documentation)?
>

Junio, ao/send-email-irt seems to have been merged into origin/next, so
I am rebasing on that. About the tests, I am going to modify one of your
tests instead of adding another one, is that OK? This is a change of the
established behavior after all, so the relative test have to change too,
something along these lines:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 66e4852..c56787f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -324,9 +324,11 @@ test_expect_success $PREREQ 'In-Reply-To without --cha=
in-reply-to' '
                --smtp-server=3D"$(pwd)/fake.sendmail" \
                $patches $patches $patches \
                2>errors &&
-       # All the messages are replies to --in-reply-to
+       # The first message is a reply to --in-reply-to
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
        test_cmp expect actual &&
+        # Second and subsequent messages are replies to the first one
+       sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
        test_cmp expect actual &&
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&


Let me just stress out that 3a. as in 54aae5e1 is not well specified
either, that's what all this fuss is about. I notice you didn't comment
about my view of the "independence" of the --in-reply-to setting wrt.
--[no-]chain-reply-to but I guess that falls into the implicit/explicit
debate, so I am not pushing it and just follow your directions about
explicitly relating the two.

> Thanks, both.
>=20

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__10_Nov_2010_12_45_23_+0100_LgUm_Nq3dy.GzKIg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzahdMACgkQ5xr2akVTsAEIewCeOUVJNyUuEzXYxD5jO2nDqOKr
4RsAoK0WYRFnGcMkOyYkc0M4aP0Kl9+f
=XSIc
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Nov_2010_12_45_23_+0100_LgUm_Nq3dy.GzKIg--
