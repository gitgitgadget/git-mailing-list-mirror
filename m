From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v4 1/3] gitweb: add `status` headers to git_feed() responses.
Date: Mon, 26 Mar 2012 07:11:10 -0400
Message-ID: <20120326111110.GB2951@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <m3sjh2ay6j.fsf@localhost.localdomain>
 <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC7pv-0003aC-A5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab2CZLLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 07:11:39 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:12828 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab2CZLLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 07:11:38 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1H0084OOENL420@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Mar 2012 06:11:23 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 1E33A42DC1B; Mon,
 26 Mar 2012 07:11:10 -0400 (EDT)
Content-disposition: inline
In-reply-to: <20120326110943.GA2951@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193903>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git_feed() method was not setting a `Status` header unless it was
responding to an If-Modified-Since request with `304 Not Modified`.
Now, when it is serving successful responses, it sets status to `200
OK`.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..041da17 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7841,11 +7841,13 @@ sub git_feed {
 		print $cgi->header(
 			-type =3D> $content_type,
 			-charset =3D> 'utf-8',
-			-last_modified =3D> $latest_date{'rfc2822'});
+			-last_modified =3D> $latest_date{'rfc2822'},
+			-status =3D> '200 OK');
 	} else {
 		print $cgi->header(
 			-type =3D> $content_type,
-			-charset =3D> 'utf-8');
+			-charset =3D> 'utf-8',
+			-status =3D> '200 OK');
 	}
=20
 	# Optimization: skip generating the body if client asks only
--=20
1.7.3.4

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcE7NAAoJEPe7CdOcrcTZrK0IALT1079PVXKw8yaF8myOulnt
aaDyuzu61i8AkekdPbGpIL3yPVq2JXvjr73Y+GVirE7nPPQKD5rP6/ElvhfWFzsZ
ogfaLc6+FDzQC2ItkXx/8iX1CWPhBA5570bfWDxd0NATO/JvNs9JZKHrnXmZdDmR
HLS/6exVc3wY7LYbqbqmgUmB9oLh0WUr2Pm9y2Z2AdLL7VcxMsLZMMLZljL80Sij
pNrkXixQh85PhKVptosXrTuPVnYXEfjIKkESP14/2Pcb0vrDpgiuNxp+/5YVU1SU
LsS6yNfWI/M1qljW4KnLddLGxKOVfEdQ/JpayftiwbmF3UKaZXuBM9CXCNalcrQ=
=9ikj
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
