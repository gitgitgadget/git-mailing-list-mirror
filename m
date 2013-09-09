From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 00:01:54 +0000
Message-ID: <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIovt-00021F-UE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab3IIACC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:02:02 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60153 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab3IIACB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 20:02:01 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6DA7328074;
	Mon,  9 Sep 2013 00:01:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234286>


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 05:38:50PM -0500, Felipe Contreras wrote:
> Yeah, but the key question at hand in this discussion is; what happens
> when 'git pull' stops working for them, and they don't know what to
> do, will they choose 'git pull --rebase' by mistake?

I agree, they will not choose git pull --rebase by mistake.

> I say the answer is no, because:
>=20
> 1) As you say in your scenario, somebody is telling these guys what to
> do, so when 'git pull' fails, somebody will figure out that they were
> doing a merge, so 'git pull --merge' is what they want to type from
> now on.

Yes, that would be me.  My hesitance here is that as the one usually
driving git updates (which so far have happened once a year), I will end
up retraining forty developers.  I don't think the current behavior is
broken or really problematic at all: merging has always been the
default, and people have come to expect that.  People using workflows
that don't want merge have always either needed to set a configuration
option or use --rebase.  As the man page says, --rebase is unsafe, and
that's why it's not the default.

I would be much less unhappy with your earlier change that did not
affect uses with arguments.  That would limit the number of use cases
affected.

> 2) Git itself would be warning them for months that a 'non
> fast-forward was found, and a merge will be done for them', so when
> the warning turns to an error, they'll know they want a merge, so
> they'll do 'git pull --merge', either because the warning told them
> that's git was doing all along, or because they figured that out by
> googling, or reading the man page, or whatever.

Again, you assume that git updates happen on a regular basis, and you
assume that most developers really know what happens under the hood.

I don't see a warning now; in fact, I see:

  vauxhall ok % git status
  # On branch master
  # Your branch and 'upstream/master' have diverged,
  # and have 1 and 128 different commits each, respectively.
  #   (use "git pull" to merge the remote branch into yours)
  #

The current behavior of git is to explicitly encourage this behavior,
and now you want to make it not work.  I think this change is a bad
idea, and I think the number of changes required to the test suite
indicates that.  If there's going to be a change here, it should have a
deprecation period with the above message changed and appropriate
warnings, not a flag day; your patches don't do that.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSLQ/xAAoJEL9TXYEfUvaL24EP/1Wk215d07rPPAR+4VTftt0u
0FkqfdKlUX0mQonchP5NIKr96W/7XoxamUC5LlLJvfh+BhUT8L/3Ai336iFAjbhw
o1VcvytXWmrZq1VqcwcSWq508VimmMWEb5tqi+B5ImL+sDkfVlDe1ijoPRrtk+Os
kkXy1/k8a5wMrnAO/phxQjBnqLkOBVLxJR9nrxCYbh7vWEtXz4PfIXFGL2UETcXl
62nVZNyNFgTvfCvCLfS3uYWB8asERuqw0FIbDS30lVi0TncbAYsek2Ie7NbHjmkz
fhZjhMD305mHeRxLhTOKsUiniKIQm4iQsTxl13v9+S4IF3/MyT7BRos/nnplWwEj
h6VmQvfg3JeWoKmVPNznyQs3X+AzkA/3rLffNfYzWD73mAa54v1bpxLJ+2//8gIE
soq9zoFkKYDVT6ET4Y6TIIY45vboV/dmTO5DLLpFkq+soj5pNDc0FfyYAnmkQDQa
h0jlPLkuJTrI6dnsnhTZdE6aDBzRPyVP9gdAGHDauBLYUkDNGiceK+zd2mkQxeKn
fkGmCVmpLgXkg7HwrjfkdHoJmcYb9YmQFdym+P+5i778QKLwlLPli3pUkjDwucbz
QeKmLZ22Z1r355AuMhbU/RJzCL6kMp3suBMyaQOZ8UBSpqcXKGASEj89Ni60B2jl
yKeizzq/Uscdb2w5MnEd
=K4ga
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
