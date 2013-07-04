From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] commit: reject invalid UTF-8 codepoints
Date: Thu, 4 Jul 2013 20:39:21 +0000
Message-ID: <20130704203921.GR862789@vauxhall.crustytoothpaste.net>
References: <cover.1372957719.git.sandals@crustytoothpaste.net>
 <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
 <51D5D3D0.3030102@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 04 22:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuqJe-0007sq-OR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 22:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab3GDUjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 16:39:35 -0400
Received: from qmta13.emeryville.ca.mail.comcast.net ([76.96.27.243]:33597
	"EHLO qmta13.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933192Ab3GDUj3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 16:39:29 -0400
Received: from omta11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by qmta13.emeryville.ca.mail.comcast.net with comcast
	id wLbQ1l0050mlR8UADLfVoZ; Thu, 04 Jul 2013 20:39:29 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta11.emeryville.ca.mail.comcast.net with comcast
	id wLfT1l00125wmie8XLfUu1; Thu, 04 Jul 2013 20:39:28 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C9C428057;
	Thu,  4 Jul 2013 20:39:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51D5D3D0.3030102@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372970369;
	bh=/bzoU3m6i+fqGIghX2px0ErK8a8LVUKxOysrelkoMqs=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=GC6EJXHtUSR3QvtYWWRf6sTpZLxOwxTQhknN7lYomAJ23sM3yzXJuivhhcSjLEuuk
	 OB4qmq2LMgWj3aB8I81KtIt/wj8ovkF2Scnma1ENGOfr49bXoaumCpULc+YqFZwMMz
	 C3u7EMAsnXhADNb4LvczLnPitrwxal8UKsCrUbeV+KihbtM3cLE1AjscGItInRPFvo
	 eYSvhajNmltoYGP+mRtfp9y7VJS0ZqIUk8aQEx8he7XluTAKRL0a6ljuTe8NXgOmsx
	 XQb9f3hrAmTpuviLqAC0ts3SNVBBF2wCjKBNqu1VCjBca50n7Uar47/GE/1u1t0cj/
	 q+BUCQdNdbLNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229618>


--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 09:58:08PM +0200, Torsten B=C3=B6gershausen wrote:
> On 2013-07-04 19.19, brian m. carlson wrote:
> > The commit code already contains code for validating UTF-8, but it does=
 not
> > check for invalid values, such as guaranteed non-characters and surroga=
tes.  Fix
> s/guaranteed non-characters/code points out of range/

The "such as" is meant to be illustrative, not all-inclusive, and my
patch does check for U+FFFE and U+FFFF, which are guaranteed
non-characters.

> > this by explicitly checking for and rejecting such characters.
> Do we really reject them, or do we (only) warn about them ?=20

Well, find_invalid_utf8 rejects them as invalid, and verify_utf8 fixes
them up as if they were Latin-1, and commit_tree_extended warns about
them.  My interpretation was from the point of view of the code that I
touched (find_invalid_utf8), not the binary.  It would be nice if the
binary actually rejected it, too, but that isn't within the scope of
this patch.

> Other question:
> Now that we have a check for codepoints out of range, beyond U+10FFFF,
> do we want to have an additional testcase ?

Sure, why not?

> > +test_expect_success 'UTF-8 invalid characters refused' '
> May be:
>  test_expect_success 'UTF-8 invalid surrogate' '

Since I'll be adding at least one more unit test, as you requested, I'll
change the name.  I suppose I might as well add a test for the
non-characters as well.

> Does it make sense to "grep on the fly", like this:
> git commit -a -F "$HOME/invalid" 2>&1  | grep "did not conform"

I am interested in making sure that git commit succeeds, and using a
pipe will cause any failure of git commit to be ignored.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1d15AAoJEL9TXYEfUvaL8AkP/37+SUXiqfV/XUFABvqzv9ha
pKaxV273Nbo6AC4ytMQbEIJoKrkoYg0PNCYgRQPt4hxbIoPQA/Al2yMYQMcO4DNb
HCHS7wWyqi84e5O1iQL/3NnbVPUXLzxLjzsJ6VqRSMkwX8sdqQ6RK21GDwI48e7o
VRPtK2PbwdM9l+zVCHK7rM3UvFdMY+C2EKGOIfudEq9iz7KF5GXHZ0Zr8CzeAUZ9
aX5xgSC4oEy4Wz+Zh93cO+cVgx/DG/dw/lGIbiujc/qJKAd+SgXlvB5aRqPt810s
Q71kWylt7z/f2xv8QKXRDKXqZ+PqpIL9vmpV7DsNDrNv4LMTRiMyb8FpqhKrOsi0
34uWfMf/mejyPxHhODUoqwYaJPlBFJAJKMcsoWBk/s/LRBvRnf3MC47JYtsG/im2
0LcpgIkcQF/cpXioSn1+liAKkkTDYWFQj8xMHrH1+c3ihyyO4W7OY10f8lXlxQJz
6e5CMBuZkM5rZwxvrkv+2Evo34CNlg/TNh0NInxDx0vdRS0hgyKwWz6tt3o4EC4B
/G+CUmdotk3JOBP/ms8A5dbV43jL6TeyCS8YOOJMK8Z4/ahw7oa270/q6UZQ+8sb
XqvkMBs8NRVXLmvyc3Oj4s22NT+y3VaAPs2fi/j6ckGpYhPV4k492pmqRYhwlbUI
tQIBCnhxE6TGBZgLHF89
=UtKc
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--
