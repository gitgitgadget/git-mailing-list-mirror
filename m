From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Thu, 11 Jun 2015 03:31:08 +0000
Message-ID: <20150611033107.GA789892@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
 <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
 <20150611000251.GB786544@vauxhall.crustytoothpaste.net>
 <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 05:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2tDJ-0004z1-9P
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 05:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbbFKDb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 23:31:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39883 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643AbbFKDb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 23:31:28 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-191-ip-static.hfc.comcastbusiness.net [107.1.110.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BF9842808F;
	Thu, 11 Jun 2015 03:31:24 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271374>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 05:21:33PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > [0] https://github.com/bk2204/git.git object-id-part2
>=20
> No approach other than just letting reviewers fetch from there and
> taking a look is reasonable, I would think.
>=20
> Did you create this manually, or is it a mechanical scripted rewrite
> followed by manual clean-up?  If the latter, it may help people by
> posting the mechanical recipe _and_ a patch that shows the manual
> clean-up.  That is something we can reasonably review and discuss.

It's mostly manual, but some pieces (the is_null_sha1 and sha1_to_hex
conversions) were scripted using the embedded Ruby interpreter in Vim.
The script I used to do that is below.

  def refactor(s)
    methods =3D %w(is_null_sha1 sha1_to_hex).map do |m|
      [m, m.sub('sha1', 'oid')]
    end.to_h
    s.sub(/\A(.*)(is_null_sha1|sha1_to_hex)\(([^)]+)(\.|->)sha1\)(.*)\z/) do
      [$1, methods[$2], "(&#{$3}#{$4}oid)", $5].join('')
    end
  end
 =20
  def replace_line(method)
    func =3D Object.method(method)
    VIM::Buffer.current.line =3D func.call(VIM::Buffer.current.line)
  end

It was invoked as replace_line(:refactor), so it basically modified each
relevant line by passing it through refactor.

Sorry for choosing a language that's less familiar to the list: if I had
known you'd want to see it, I would have used Perl.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVeQD7AAoJEL9TXYEfUvaLmowQAMJHpVYyGeUXXjJzUvE0O2v6
FmcSmMDhRniO5NfZoU3jsH0MACp75WzYl9QT+NatKXYLR4Mf0lv7iwEYyqPVFLIG
Jai+1iOhviSeF1wvDCUPLQ/jyT3ASoYWeOpwYJOV5ffFz1tdgBOVD8tLMeUwv51K
QEo0JIPHdC29S44KdzTUowgPnBmy4mPpQY7tK1JCORbfsuehoxBpgkvxWV/piw2i
Ogl/2P6C0TueMIgPNEYzMDqIdWqJwFXadZAviPYitDKCXQckhafDcllssPIFfPeC
mxr+PccSL5uUsma8OmUfRka0VETbk4BmwlipzjwdmEgWIxk3EfRzulBJN+GwM2Np
yEM98dOS7oP6HZo6lAFbtEWu/b49Req/1aa0G1K23Aiy6gx+Zbk8Ih6qT6PevwK9
n4ZViYGrvldN7k2kWjbEdhiMdXbAmEI6Dr8hxDXjxeWkjYgV9CsNLrNd6LKGl4tP
czPn9EPhjx1sIdDuTcUi6htkyZndThVYPnRwQb7boU6nUkMSIV8lLWHE88SUO8Es
IZmPgYYBWJ0fHNuJsvw+Lglkg4ZQbr0kHDMIfjvpKgTqvcPG+OdbWyvh8cbqJ5Gi
50IbyTFJ9Q9zB0CUHVyofMmf846Nw0UOPs9JAEL0RayagR9eDzqTZ3f5tvnCa5zj
ntzvTY45wEBCLgU7yFYH
=7FpL
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
