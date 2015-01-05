From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Mon, 5 Jan 2015 23:53:09 +0000
Message-ID: <20150105235308.GC1025060@vauxhall.crustytoothpaste.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <F91CD1B2-262C-4ED6-AE46-31B1333E0350@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 00:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8HSf-00045P-MU
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 00:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbbAEXxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 18:53:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56854 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359AbbAEXxT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2015 18:53:19 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C4E042808F;
	Mon,  5 Jan 2015 23:53:12 +0000 (UTC)
Mail-Followup-To: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <F91CD1B2-262C-4ED6-AE46-31B1333E0350@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262040>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 09:23:32PM +0000, Dan Langille (dalangil) wrote:
>I have tried both patches.  Neither succeeds here.  I patched git=20
>version 2.2.1 but I don=E2=80=99t think that affects this.

You are patching the client side, correct?  That's the side that needs=20
patching here.

Just so the list knows, I will be sending a reroll to the existing=20
patch, but the patches I've posted do indeed work in my testing.

>Before I flood the list with debug runs, I wanted to make sure I was=20
>testing with an appropriate configuration:
>
><Location /git>
> SSLOptions +StdenvVars
> Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
>
>   # By default, allow access to anyone.
>   Order allow,deny
>   Allow from All
>
>   # Enable Kerberos authentication using mod_auth_kerb.
>  AuthType           Kerberos
>  AuthName           =E2=80=9Cus.example.org"
>  KrbAuthRealms      us.example.org
>  # I have tried both with and without the following line:
>  KrbServiceName     HTTP/us.example.org
>  Krb5Keytab         /usr/local/etc/apache22/repo-test.keytab
>   KrbMethodNegotiate on
>   KrbSaveCredentials on
>   KrbVerifyKDC on
>   KrbServiceName Any
>  # I have tried with and without this line:
>  KrbMethodk5Passwd  on
>   Require valid-user
></Location>

I'm not sure why it's not working for you.  Here's a snippet from my=20
config:

  SetEnv GIT_HTTP_EXPORT_ALL 1
  SetEnv REMOTE_USER $REDIRECT_REMOTE_USER
  AuthType Kerberos
  AuthName "Kerberos Login"
  KrbMethodNegotiate on
  KrbMethodK5Passwd off
  KrbAuthRealms CRUSTYTOOTHPASTE.NET
  Krb5Keytab /etc/krb5.apache.keytab

When I was testing, I set KrbMethodK5Passwd to on and it did in fact=20
work.  I'm using Debian's Apache 2.4.10-9 with mod_auth_kerb 5.4-2.2.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUqyPkAAoJEL9TXYEfUvaLa9AQAJM1ylhCB8qgopQfRgh+8dN1
leBIiJFDoWZOtLYaAE1aI9pRyahoDtWHJ/0vx8kYUgrCSCLrpZoSEoLMaLzHC1va
6kaQKzv5szJ1JlZAGZ/SfNUAPGdqGMrN0XGLCsV2wvrEpQMB2uX307QnHl5c2cL0
zcT+HutKFD5GFF8G3J55Z48CD+PNVPz66O4H58iOki3O8VqZf3F+9SbmkEl9lzOH
qwk8KqtTu2GCj83iMkdEY5AnCTNxM1wGW3Az44aP0LIIMDYZ2k+irXm1juYqeL1R
djoPZcp9OutZH34Hd95i18euwsAsEskPQktF6oDzVzxBG8+PvWHkiTuUxq0kV7uO
pTBpamysnK3WdU1Qx3FYYxTQr0/7PRgDpM/ZL78GFSOFsICou+5/VqXZprdsYPB6
W4nLmpg73tsxu1yfwoX/ZYmpFEn+nFr+u7K3OYZUeSon+lHQtEsvjqwNxv3A3IWP
jEi5G7kXD61KolrSwDSwXViM40uFI/qBU1EVtcAjbeIiuta5ghQeRPz009zg+/H1
HemKA+abb7xackMdjMONttOfyVi83/fFxLZ+3YeIA8RXu59FdKreHXMAhCSwe98Z
Svu2g8ra+wlqYYQa1styu+4SqrKdpQj7NZfFNESITEpOFdavOKrR+03f3ri68WND
G7mVgKoimE2x3Wz8GPob
=ANN9
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
