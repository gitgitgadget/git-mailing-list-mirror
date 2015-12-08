From: Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Tue, 8 Dec 2015 11:05:34 +0100
Message-ID: <20151208100534.GA1504@pks-pc>
References: <20151202002450.GA27994@sigill.intra.peff.net>
 <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
 <20151202223114.GA20542@sigill.intra.peff.net>
 <20151207134014.GA1105@pks-xps.fritz.box>
 <xmqqvb8am58b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 11:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6F9Y-00030P-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 11:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbbLHKFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 05:05:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44250 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932533AbbLHKFk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2015 05:05:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1583620BEB
	for <git@vger.kernel.org>; Tue,  8 Dec 2015 05:05:37 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 08 Dec 2015 05:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=08/WNrOtbjQle/YQX/UsxxNbtzY=; b=MA0C1
	UCJ4Bf55mt2ecpBiIG/Blg6fzaTZEgpS9kKlSAaDQHz8bYpjou27+XkAd4VRURt4
	htY/vkoSfl9QkwsC/Ajwim8PLpnN49ugXLD1ZlkaOqnHcpUBW4tdgbtzfZSEREam
	sIrZqhSlWVe0XHH3kaegkdTmGxZI/HPH/W9iO0=
X-Sasl-enc: zkxpzcBjzXrAu+w/dtshyDrpXjvzBU9ZKSkJi7xb2j13 1449569136
Received: from localhost (f052129226.adsl.alicedsl.de [78.52.129.226])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7196C68016C;
	Tue,  8 Dec 2015 05:05:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqvb8am58b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282154>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2015 at 11:24:52AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Wed, Dec 02, 2015 at 05:31:14PM -0500, Jeff King wrote:
> >> On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:
> > [snip]
> >> > "--keep-empty" has always been about keeping an originally empty
> >> > commit, not a commit that becomes empty because of rebasing
> >> > (i.e. what has already been applied to the updated base).  The
> >> > documentation, if it leads to any other interpretation, needs to be
> >> > fixed.
> >> >=20
> >> > Besides, if "--keep-empty" were to mean "keep redundant ones that
> >> > are already in the updated base", the patch must do a lot more,
> >> > e.g. stop filtering with git-cherry patch equivalence.
> >> >=20
> >> > I'm inclined to eject this topic.
> >>=20
> >> That was my thinking too (and I notice it didn't get any review from
> >> anybody else).
> > [snip]
> >
> > Well, I kind of agree. The cherry-pick command has both
> > --allow-empty and --keep-redundant flags, where the second one is
> > the kind of behavior I want to achieve in my case. As an
> > alternative to the proposed change to `--keep-empty` I could
> > instead introduce a new flag `--keep-redundant-commits` to `git
> > rebase` which would then pass the flag through to the
> > cherry-pick.
> >
> > Any opinions on this?
>=20
> Honestly, I am not interested if that is only about passing that
> option and doing nothing else.
>=20
> Imagine that you have two changes from the branch being rebased
> already in the updated base, one was accepted verbatim, while the
> other one was accepted with a slight tweak.  Perhaps there were some
> conflicts in the context, or something.
>=20
> When you run your rebase, the former will not even be considered
> because command will notice, via patch equivalence, that you do not
> need it, even before it attempts to replay it.  But not the latter.
> The command will attempt to replay it, and only in this step it may
> notice, by seeing that the result becomes a no-op change, that the
> change has already been included in the updated base.
>=20
> I cannot quite see how adding "--keep-redundant-commits" to the
> command would help anybody by allowing the latter in the history but
> not the former.  That is primarily because you can imagine a future
> in which the patch equivalence determination becomes smarter.  With
> or without "--keep-redundant-commits", both of these two changes
> would not appear in the resulting history when that happens.
>=20
> The "--keep-redundant" option to "cherry-pick" makes sense, as the
> user will be the one who is deciding which commit to replay on top
> of a new base.  If the user fed a commit that is already in the new
> base, and the command is run with the option, that is a deliberate
> request to leave a no-op cruft.
>=20
> We cannot say the same thing for "rebase", as it tries to avoid
> redundant cruft, and it cannot do as good a job as humans in doing
> so.  The "--keep-redundant-commits" option will become a way to make
> a distinction between what got dropped by the command automatically
> and what didn't get dropped because the command did not look deeply
> enough.  That distinction is not at all useful, as that can change
> as the tool improves.
>=20
> A "--keep-redundant-commits" to "rebase" that also disables the
> patch equivalence filtering (not just keeping empty crufts in the
> resulting history) might make sense, but I do not see myself (or
> anybody sane) using it.  "In what situation would such a feature be
> useful?" is a question I cannot answer offhand.

The scenario I require this feature for is somewhat more exotic,
yes. We've got a CI where published branches can be rebased but
should not be modified in their commit history. That is, the CI
determines in a hook wether the branch that is being pushed drops
or re-orders commits and if so, rejects the branch.

So when a commit that is already included in origin/master gets
rebased `git-rebase` currently simply drops the commit, which
causes the CI to refuse the branch on a push.

So obviously you are right in your conclusion that
`--keep-redundant-commits` has to skip the patch equivalence
determination in order to not drop any commits. Otherwise my
change would only work for certain scenarios.

That said, I do not care too deeply about this patch, especially
as my scenario is rather uncommon. If you deem this to not have
any greater benefit you may simply drop it.

Patrick

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZqtuAAoJEBF8Z7aeq/Es1v8P+gIHfIdgttLee+cxN+W9JSRZ
l4lNEqnm8I+Qs3eJoTqIv8fuWazN3nOzF2NJptUlpWIN65BTCScJK2ZuFgaq4i9D
PR12mAksUjhcxxP3U1L9dLC8XkAVVy+bpjBFT2CGknHhy6WhRsgEK4L4rxdll2Lh
84fDcv6LEGCTtEh4VffOUvYSPhBGVlrrByBgI1W3oCx5xgQwXK6ooPPiOI8HHag1
LcapQgvwt1HBiQVE1XiYIZPx2fIhjY53iFFVyynvygXwjsZE7B+5BLUyKgeOdC9h
r8vNBECbyZQ+qNyLq5I/NStDHQThhT94riOiwgfgF7ReN1zZvxIiBIyPBTZ1eK0W
oGD0rza8CxoNLEVGLsEKX7/RDp1KAHFb6uPYfRp8DcXuzuOmV2s3BOsPdEeQ1BpU
aduKSSS/EnEx+2Qh2cWAsVuzjGxHM8nntVXbCDu7P8dSmMNLwCYdE4bCteePnBBi
rdkVQ4c2PudUetLIfsTCZD2NzEUtdcij3bQp9iBMEj1JAqjQHWWSWdsdgLrRt9yn
gouj0KZEBpaJFjJA3Bezn1TeWxWTiZSMpU0MsDbCUdCoBQfwbZlBPQk91J7jj+BP
/YA63PXsgNiP2Vpb80gK9NJ8j+a4bbTFqVdwF4O9zFJe9LI5YojZLUCzgqm2mpnh
2JlnR/n+//DNY5Mmbbfq
=LdGX
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
