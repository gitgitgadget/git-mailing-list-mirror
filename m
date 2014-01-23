From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 21:53:26 +0000
Message-ID: <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
 <20140123202645.GA329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6SDR-0006si-Bp
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbaAWVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:53:33 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51315 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbaAWVxc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 16:53:32 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 976DC28074;
	Thu, 23 Jan 2014 21:53:30 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140123202645.GA329@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240964>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 03:26:45PM -0500, Jeff King wrote:
> Looking over the format, I think the only thing preventing 4-byte
> alignment is the 1-byte XOR-offset and 1-byte flags field for each
> bitmap. If we ever have a v2, we could pad the sum of those out to 4
> bytes. Is 4-byte alignment enough? We do treat the actual data as 64-bit
> integers. I wonder if that would have problems on Sparc64, for example.

Yes, it will.  SPARC requires all loads be naturally aligned (4-byte to
an address that's a multiple of 4, 8-byte to a multiple of 8, and so
on).  In general, architectures that do not support unaligned access
require natural alignment for all quantities.

Also, even on architectures where the kernel can fix these alignment
issues up, the cost of doing so is a two context switches (in and out of
the kernel), servicing the trap, two loads, some shifts and rotates, and
a kernel message, so many people disable alignment fixups.  I know it
made things extremely slow on Alpha.  ARM is even more fun since if you
don't take the trap, it loads the data rotated, so the load happens, it
just silently returns the wrong data.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS4Y9VAAoJEL9TXYEfUvaLp/cP/i+tXVctna9rHS4OwHuHARdt
MnRwl9TLEJIw41XFREgs2D4b8sqb5ZkKTjWTk8h9yERrEvydrJ1uC2xTtX1mtO/d
zwop6/KbFWLuJI149fUSIuVLeNFLQlb8NBwD++2yDz2LX52AxQai5pHtD1GWF69x
4sGcN1HDOl2Xtr/eh4cFMXTPktvNwX/75m6PjH8rP2eXcJtRqjrHbdLvoGvATbpa
9pZLuy7XFmBSeORHu2XPxvr6kwBCY6zgGmvmxaPedcRS5Ekrv6hISwe8av48VeOb
H2OH1z4Lib5FhKD4PBYWNFqU/NxbTYFdQpahssJiO+kCJRfT6o2wmOg5/fuNhvTB
QsQJpHvUpGpnq5esaWo9FG3XI4neaZtR3XJCtelSE8/0MnnFK8qFmd+bio3Tm2pt
nazIJr2k9glDiYqooN+xIjBJRU4yVYLV6dYZsk75+xHHP+IHYjBxwFUq11NllaMl
SOSZjw4nBOSCFroverwZxZhb1ucX2h/1dyw0R+WkyVqiCioFEuXMUAen2n6ofKmp
l9RBHHy8G8cYSGaSjq0XCSgakp4q2FBVPIsmoyH6MzrRb8v2cQtkeu7DmFZYNOFe
ijk69i9saMNryt+BVV5ZLXJsM3Les344C3pa50tgdIvHR9EKxl6cgDcCB34YnQnC
oXbE0ZCqeqiVkbRxLTr1
=lKsf
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
