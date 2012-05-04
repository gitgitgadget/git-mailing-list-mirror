From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 12:09:42 +0200
Message-ID: <1336126182.3490.28.camel@beez.lab.cmartin.tk>
References: <4F9F128C.5020304@palm.com>
	 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
	 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
	 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
	 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
	 <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>
	 <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
	 <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
	 <7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ic2+oovoLJ4uqCFh3CDq"
Cc: Michael Witten <mfwitten@gmail.com>,
	Nathan Gray <n8gray@n8gray.org>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 12:11:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQFUD-0000cL-V6
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 12:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab2EDKJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 06:09:49 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:58346 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab2EDKJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 06:09:48 -0400
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1ABEF46057;
	Fri,  4 May 2012 12:09:41 +0200 (CEST)
In-Reply-To: <7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197013>


--=-Ic2+oovoLJ4uqCFh3CDq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-03 at 22:25 -0700, Junio C Hamano wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>=20
> > As for a seemingly conservative suggestion, how about using a little
> > more structural white space:
> >
> >   To $uri_for_central_repo
> >    ! [rejected]        HEAD -> feature_0 (non-fast-forward)
> >
> >   error: failed to push some refs to '$uri_for_central_repo'
> >
> >   To prevent you from losing history, non-fast-forward updates were rej=
ected
> >   Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the
> >   'Note about fast-forwards' section of 'git push --help' for details.
> >
> > Alas! Error output like this is constructed in the code in a way that
> > potentially makes adding such white space non-trivial.
> >
> > Perhaps the error message system needs an overhall; rather than spittin=
g
> > out error messages from anywhere, they ought to be corralled and collat=
ed
> > by a dedicated subsystem.
>=20
> Didn't somebody recently rework these messages quite extensively?

If you're thinking of me, I only changed the pull/rebase side, which was
a ridiculously bad message. As this subthread looks like it might
actually have something actionable, let me look at this message with the
same critical eyes.

Most of the first sentence repeats what we can see above. Restating that
non-ff updates were rejected doesn't add information and doesn't help
people who don't already know what a non-ff update is, so it's either
redundant or not helpful[0]. So lets see if we can come up with a
friendlier way of saying it. Maybe something like:

    To $uri_for_central_repo
    ! [rejected]        HEAD -> feature_0 (non-fast-forward)

    error: failed to push some refs to '$uri_for_central_repo'

    Some updates which might rewrite history and lose someone else's
    changes were rejected. Merge those changes (e.g. 'git pull') to
    incorporate that history. See the 'Note about fast-forwards' section
    of 'git push --help' for details.

It may be a bit longer, but if you don't know what a non-ff is or why
it's a problem, this text should help you a lot more than the previous
one did. Not reading the documentation (specially when the error message
points you to a specific section for a longer explanation) is still no
excuse for not known what's going on, but if you've been working on your
own for a while, you might have forgotten what this is all about.[1]

If people don't have it, I'll try to find time to create a patch.

   cmn

[0] Or worse, as repeating jargon can leave the user thinking that they
don't understand anything and reduces the chanced they'd try to figure
out the missing parts. I'd qualify this with friendliness rather than
anything else, as the message isn't wrong or misleading, just rather
on-your-face.

[1] At least this is show I rationalise why doing saying "non-ff updates
rejected. Read the ff section of the push manpage for an explanation"
isn't the right thing to do.


--=-Ic2+oovoLJ4uqCFh3CDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPo6rmAAoJEHKRP1jG7ZzTCZ4H/1oHPIlPyhNwqkS3a8nj8uoj
2tNApfCAfg0hwP8Gxw4B+IH1CkgJfseRlVPMZaLad36GoZ1WNnDCQdPt8inR2kgv
eV+dpVz8uYX6bPbbzJKFwr1B9XEvRgOW3qZs3+uG5frOEsNLpAtaXAXmrBQIzxLg
A4yJpQxhVF3b+oqw7T0IzZFiGx/KIF5AL1fqqDpF89JybdSHmKOSjw88OQ019A3Y
vX5BsYVfoGgn/F0BavGnhB6NMQTjOqe5YF7+aMWSPqkApZckxsRSW7L1B6r6yaMn
0/wm1jOMCgBETQZyjAHZgb9RJJZ+iPx+j/l+agVLhxLG672/9NMxafelNzmKhv8=
=l4Lw
-----END PGP SIGNATURE-----

--=-Ic2+oovoLJ4uqCFh3CDq--
