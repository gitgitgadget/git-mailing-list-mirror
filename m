From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Mon, 3 Aug 2015 10:34:14 +0200
Message-ID: <20150803083414.GA23997@pks-xps.Speedport_W_723V_1_37_000>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
 <1438185076-28870-6-git-send-email-ps@pks.im>
 <xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
 <20150730121811.GA24635@pks-pc.localdomain>
 <xmqqk2th7gmq.fsf@gitster.dls.corp.google.com>
 <xmqqfv457fkc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 10:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMBCS-0008A0-67
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 10:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbbHCIeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 04:34:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40452 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbbHCIeS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2015 04:34:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 536FF203DB
	for <git@vger.kernel.org>; Mon,  3 Aug 2015 04:34:16 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 03 Aug 2015 04:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=86LBvgakc/0IrycDm3OE6hR5MuU=; b=nHW/N
	002zPvSH5IYaZTmXYQmTVVL/Ofs9vkusbzUQrFjaMDDK8XZJLhlS0v3ixX3aVTaI
	Mp2PGgmGpvqB+gT7KeC54Df5KvS6cyngEQNnzhsneKTCNAs4+5rCvUV4D3R6Z/Bf
	BLsLrJVRCB3jgFzbamdF/RCz0N779RMz7c4K40=
X-Sasl-enc: Pq8J9z5xbxUhn1X8GjOeyOegWCUjfbYTm9wo15ef4Nx9 1438590855
Received: from localhost (p4fc5cc70.dip0.t-ipconnect.de [79.197.204.112])
	by mail.messagingengine.com (Postfix) with ESMTPA id D264C680200;
	Mon,  3 Aug 2015 04:34:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqfv457fkc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275157>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 09:53:07AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Well, but there is the above "or we may not" ;-)
> >
> >> But actually you are right, currently I still have the old logic
> >> in place that splits on colons in the path component.=20
> >
> > Yes.  The reason why I suggested the simple route was exactly
> > because I noticed that you didn't seem to care about the above
> > "$site/foo:bar.git/" =3D> "$site/foo:bar" =3D> "bar" transform.
> >
> > And I think people might depend on that behaviour.  "Fixing" that
> > may even be seen as a regression.
> >
> > When was the last time you created a foo@bar.git repository?
>=20
> Actually, this was an unrelated question and a wrong one to ask at
> that.
>=20
> Even though I personally haven't created foo:bar.git repository,
> because it is no longer 2005, it is highly likely that somewhere
> there is such a person who depends on the current behaviour of
> turning that to "bar" on the cloned side.  Similarly, even if we the
> people who read the Git mailing list collectively do not know
> anybody who has foo@bar.git repository, it is highly likely that
> somewhere there is such a person who depends on the current
> behaviour of turning that to "foo@bar" on the cloned side.
>=20
> So the ideal would be to keep turning $site/foo:bar.git to bar,
> $site/foo@bar.git to foo@bar, and $scheme//u@p:$host/ to $host.
>=20
> And it would be ideal if we do so without much code churn.  "The
> whole site is dedicated to host a single repository at the root" is
> a highly unlikely set-up and it feels wasteful to spend too much
> effort on.

One more question for backwards compatibility remains then.
Currently when we clone something like 'http://example.com:2222/'
we'd create a git repository '2222' as we'd split on the first
occurrence of ':'. Should we remain backwards compatible here, as
well, or change the behavior to use 'example.com' as repository
name?

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVvyeEAAoJEBF8Z7aeq/EsTUYP/0vxwX2BHi1dJX2VjIfU1p/o
e1W9358sXOkD08ktWPaFxe7Ff+DkXDNamHhyANoXXeLNoDQLlejRLIGDLjW94MaB
G0ZpmQ7/RGgQoW+4UAXafkxZQOSdDuqbQXlXGYqVX8LKliFFzlDCCtXd8QYw7/Nh
cqOAbrQajywAb2zrnP8YURoM5MwPR351oQsOV1YPk7hibPQaT2XwXSTpDhCkKfYO
t+sDSQ4POarUszJw4ihqzkMiZ/53ub7FZ7WxoRaUhBA85zzIrXwR1KURnloT2i/x
hkt0n/UXi17E/EP9oWg6dsQbkhdKl8ZkhlglMWAWtuu7IQOi/8S9JUmZKbn5MPP8
7MHoOvwsqUMLRdcarr6RIKb1Umv9aehG9Rfiipy3zuItpIGc0wGUABYdE1OrsD0b
Qr6WgGt+GOnY17zIUtEx0S20rLSFKMoaTfisR7xmUd8/D0n7Oc8APwxlJWnmSRGE
1/yv9A+7p7yaZX8ToWdKF1teSlmijJtBdo/x1fwrSxniSlD50luokJ7p0ue6sFSl
PxBZKhvvyU7nOsk2WGzkNZKmLw6dSlJkLdM9XZdjXWSM/ihxcV9HVWpaizDMhHZ6
vyuAGUNzbaLo5YuUdw5O1wkSZejovoDP7XOTumUSzhgp90wKSp5bxdl/5o0jb95/
1G8xMvhrfrhusH+Skzml
=HpYv
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
