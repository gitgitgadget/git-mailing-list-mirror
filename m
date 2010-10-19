From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Wed, 20 Oct 2010 00:45:33 +0200
Message-ID: <20101020004533.b64d446c.ospite@studenti.unina.it>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
	<1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
	<7v4oci11k6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__20_Oct_2010_00_45_33_+0200_U95=mVC=PN.qARnl"
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 00:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Kwk-0005Vr-JU
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab0JSWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:46:12 -0400
Received: from smtp209.alice.it ([82.57.200.105]:60757 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777Ab0JSWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:46:11 -0400
Received: from jcn (82.57.81.162) by smtp209.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4C1A2759080F04A1; Wed, 20 Oct 2010 00:45:39 +0200
In-Reply-To: <7v4oci11k6.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159376>

--Signature=_Wed__20_Oct_2010_00_45_33_+0200_U95=mVC=PN.qARnl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Oct 2010 11:26:33 -0700
Junio C Hamano <gitster@pobox.com> wrote:

Thanks for commenting Junio.

> Antonio Ospite <ospite@studenti.unina.it> writes:
>=20
> > Make second and subsequent patches appear as replies to the first patch,
> > even when an initial In-Reply-To is supplied; this is the typical
> > behaviour we want when we send a series with cover letter in reply to
> > some discussion, and this is also what the man page says about
> > the --in-reply-to option.
>=20
> I am not so sure if that is what the documentation says.
>

Sorry, I meant the man page part about --[no-]chain-reply-to, I mistyped
that and generated more confusion than was "necessary".

>  1. When --in-reply-to gives $reply_to, the first one becomes a reply to
>     that message, with or without --chain-reply-to.
>

No doubts on that.

>  2. When --chain-reply-to is in effect, all the messages are strung
>     together to form a single chain.  The first message may be in reply to
>     the $reply_to given by --in-reply-to command line option (see
>     previous), or the root of the discussion thread.  The second one is a
>     response to the first one, and the third one is a response to the
>     second one, etc.
>

This is pretty clear as well.

>  3. When --chain-reply-to is not in effect:
>
>     a. When --in-reply-to is used, too, the second and the subsequent ones
>        become replies to $reply_to.  Together with the first rule, all
>        messages become replies to $reply_to given by --in-reply-to.
>=20
>     b. When --in-reply-to is not used, presumably the second and
>        subsequent ones become replies to the first one, which would be the
>        root.
>=20
> The documentation is reasonably clear about the 1., 2. and 3a. above, I
> think, even though I do not think 3b. is clearly specified.
>

In general, 3b. is specified in --[no-]chain-reply-to section, the
"problem" with 3a. is that --in-reply-to _overrides_ the behavior
specified by --no-chain-reply-to.

So I think that the whole issue really boils down to the question:
Should --in-reply-to apply _only_ to the first email?
The doc for the corresponding git-format-patch option gives _one_
answer, and you know that :)

By answering to this question with a YES also in git-send-email, we are
making --in-reply-to *independent* from --[no-]chain-reply-to, hence
the very simple test.

> If you are changing 3a. above so that the first message becomes a response
> to $reply_to, and the second one becomes a response to the first message
> (and the third and subsequent ones too when --chain-reply-to is not in
> effect), you would need to update the documentation as well.  Even if it
> might be of good kind, it would be a change of the established behaviour.
>

Right, the documentation needs be updated as well, thanks for pointing
this out. I think I am going to copy from the git-format-patch man
page.
So, do you agree to this change of behavior as long as it is documented?

> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index a298eb0..410b85f 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -295,6 +295,20 @@ test_expect_success $PREREQ 'Valid In-Reply-To whe=
n prompting' '
> >  	! grep "^In-Reply-To: < *>" msgtxt1
> >  '
> > =20
> > +test_expect_success $PREREQ 'In-Reply-To in second patch with --thread=
' '
> > +	clean_fake_sendmail &&
> > +	git send-email \
> > +		--from=3D"Example <nobody@example.com>" \
> > +		--to=3Dnobody@example.com \
> > +		--thread \
> > +		--in-reply-to=3D"<unique-message-id@example.com>" \
> > +		--smtp-server=3D"$(pwd)/fake.sendmail" \
> > +		$patches $patches \
> > +		2>errors
>=20
> You are breaking the && chain here.
>

Some other tests do that as well, the last line is a command by
itself not and-chained with the git-send-email invocation. I guess the
logic behind this is that the test succeeds if the _last_ command
succeeds. If this is wrong then some other tests are affected too.

> > +        # The second patch should be seen as reply to the first one
> > +        test $(sed -n -e "s/^In-Reply-To:\(.*\)/\1/p" msgtxt2) =3D $(s=
ed -n -e "s/^Message-Id:\(.*\)/\1/p" msgtxt1)
> > +'
>=20
> You would need to test the interaction with --chain-reply-to as well, so
> there should be another test, and you would probably need three messages
> fed to send-email not just two to see the effect of the interaction.
>=20

I saw the tests in the other mail, but under my interpretation
we should just ensure --in-reply-to is applying to the first
message only (so we check the second one), if so from the third one on
--[no-]chain-reply-to is totally unrelated to --in-reply-to.

I think I can make the test more explicit tho, like:
("In-Reply-To" of second message) !=3D $initial_reply_to

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__20_Oct_2010_00_45_33_+0200_U95=mVC=PN.qARnl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky+H40ACgkQ5xr2akVTsAHLWACgr/EyAvbbNZVWpgRKD7+5QvWQ
HvEAnjCYZdYe1fmnsThHj9smS08RiNJ3
=njwU
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Oct_2010_00_45_33_+0200_U95=mVC=PN.qARnl--
