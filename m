From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 00/15] config: make git_config_set die on failure
Date: Wed, 17 Feb 2016 11:35:48 +0100
Message-ID: <20160217103548.GC743@pks-xps.fritz.box>
References: <1455627402-752-1-git-send-email-ps@pks.im>
 <CAPig+cQav4AS6-RwUKGA2fmWxRL-2e2o72oYkk83emqz3z6q3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVzSd-0003X2-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 11:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbcBQKfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 05:35:52 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56279 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161075AbcBQKfu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 05:35:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C4F4214D6
	for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:35:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 17 Feb 2016 05:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=SbcF+zoKm7HASCza4KUfIFnBmsQ=; b=W6yw9
	mhHtpitK5V/dxFO9Wft/fhkl9GucH8PWueu/Ira4PPsERfZDwNq7DVi2DcJ2BN5g
	32ZogtdApF6oLMo/quGqFzc3OdH48DDd5bn9fKkA3qSh69Xhuc3jl/9MrUHLRB+M
	EwA5lOCm4N+bzORCBDGHQnX8px+iuPPCJk3N7E=
X-Sasl-enc: mH8rpKrPzTwAVcQ6SS6TvIJ+eeAmKdLL7FBNPApLE7qd 1455705349
Received: from localhost (p5088a9c6.dip0.t-ipconnect.de [80.136.169.198])
	by mail.messagingengine.com (Postfix) with ESMTPA id BA431C0001A;
	Wed, 17 Feb 2016 05:35:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAPig+cQav4AS6-RwUKGA2fmWxRL-2e2o72oYkk83emqz3z6q3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286494>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2016 at 12:15:35PM -0500, Eric Sunshine wrote:
> On Tue, Feb 16, 2016 at 7:56 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > [...]
> > Junio pointed out that it might not always be the most sensible
> > thing to die when install_branch_config fails. After thinking
> > about it I changed the behavior of the function to print an error
> > and advise message and return an error code. The error code is
> > then only used by the `git branch --set-upstream-to=3D` command to
> > abort early, as its main intent will usually be to set the
> > tracking information. The other callers (related to git-clone and
> > git-push) simply ignore the returned value while the messages are
> > still printed.
> >
> > I think it does make sense to not abort clones and pushes when
> > the function fails. Setting the upstream information is only a
> > small part of these commands and especially when cloning a large
> > repository it is harmful to die as this would delete everything
> > that has just been cloned. The user can still fix up the remote
> > tracking branch afterwards.
> >
> > Interdiff between v4 and v5:
> >
> > diff --git a/branch.c b/branch.c
> > @@ -49,7 +49,13 @@ static int should_setup_rebase(const char *origin)
> > +static const char tracking_advice[] =3D
> > +N_("\n"
> > +"After fixing the error cause you may try to fix up\n"
> > +"the remote tracking information by invoking\n"
> > +"\"git branch --set-upstream-to=3D\".");
>=20
> Do you have enough information at the point this message is emitted to
> make it even more useful for the user by showing the actual argument
> to --set-upstream-to=3D that the user would need to invoke once the
> issue is resolved?

Actually, yes. The message is invoked by `install_branch_config`
which naturally has to know what upstream we want to set to. Will
improve the message in the next revision, thanks.

Patrick

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxE0EAAoJEBF8Z7aeq/Es16EP/1AMX7qh+a9jP8kIrKvDNtHa
w5Iro6vWs1KtViNOZkOoA2l5W0+Aoo+bxK6/o/kLvnVy1TSE67lq+1xwxbRs9Jsr
SGx6ppyuWt3g3lEM1OZU1K1EfkDKhj9frMHB5FAWTyFFGhCWg1yC7m7y20zl5m7F
91evZ2BXgv2FDttqvs2/P6iZ0JhptygjDDfK8icbSDLq0l68BXSh7t4RZVD+UOOV
/NK4ur2MCqo4L4UZn4IxrNUv6PY+hyELxSuaRYVE7gtOJg6Vc01e8YdCTC2fiQmI
etbx2CwxN/WKvUceQpFH8ZnMQFIHhhcGypbvUkAQWrpEpVfrUAArmuCL0RcxRUQO
NhqUGTft2ML2uNkhqeEh8vuU5RZQEhRmkRSnMoJRcublWo6AP76xZ6VoeoIXlK9a
Mk0Q7JLP82MJMBpBPt4dRQmExUUmKWv/52C4qo12ARx7AsjoOZI6QDEh/L1LfvfY
zFKQhMU0igjltf0KjYwhwQ5iWwAPybe1S34QISKw9i7p9b2PJcgqesLtZx2wSNuq
ve7VZPu9TcBI+efL3e1khXCaYjLlfpXQdND86IXo90FztaJe+pSAodHu07sKQKEq
0VMB/0zqTHg1jDJVuHfLgfeieJPwur6ItxpCg/emZQkyvbCZhfhP1kwxAoew1RW6
dvSHLomAeX9Ox2lIio9O
=yicc
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
