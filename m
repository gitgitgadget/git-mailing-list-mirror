From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: No negotiation for repos on HTTP servers?
Date: Sun, 13 Sep 2015 21:19:22 +0000
Message-ID: <20150913211922.GF8394@vauxhall.crustytoothpaste.net>
References: <CAGHtn=oXUa2=n2aMWQKndDSfGZ2bPm-dxZ7jin7QOx8dRxp3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Cc: git@vger.kernel.org
To: Christoffer Haglund <christoffer.haglund@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:19:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbEgl-0004Do-5n
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 23:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbbIMVTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 17:19:30 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:35493 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274AbbIMVT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 17:19:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F00928094;
	Sun, 13 Sep 2015 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1442179167;
	bh=YuWIwj9/Wiio5QOA2DGLGzox8cofG3SwMEynbyLVAk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWa1Zh6A9VFjTsO/201BH3Fe1NVgwnIiBHr1ciCJcO7f8G/B30n8HXxdz2bYR/EHX
	 sar8i5m9IF0/NvQyATzGDRXivIMZ6pOvvDArwfBSFZ8z7eRuzCtXJ196sPDPUl4WkC
	 VvhnYLggzIW9oJHsXHXQTYKh5IbUug8Vz3rZf3rIfYSS+/E7P2mwtmK0iMbWvrR7rM
	 Wa0QApYH80KSa2zJqwJRBrorw8j5ZKzZ8j23pMIWj2uA8XLX14QotIWcBfN1qN+Za7
	 Gt6Y3OarEWyL5NZzHnh+xkC85vj73bvEGJJ2o+cd7fXReF2lxPd04HnJmpRCyNCXJd
	 4MMrApZK9j2tMp32ZhMJOWIoG/gsFD3KjAphv29AdwHye4CH6My8FS0RP18ZpsFjEQ
	 ABziE7Ox25PxI/di1Uf7IZiVKvpry1CNV3VSeGdLKa3Cle+49ItRAe/eakpW2bS9oG
	 4QfygedgU9Js3R9+D9qnYYyf96P6BsCcI86z/X/bQ6kUs4tO2ED
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christoffer Haglund <christoffer.haglund@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAGHtn=oXUa2=n2aMWQKndDSfGZ2bPm-dxZ7jin7QOx8dRxp3Kw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277794>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2015 at 09:31:54PM +0200, Christoffer Haglund wrote:
> Our team that use git repos hosted on a number of different
> environments, including HTTP servers using Kerberos or NTLM to
> authenticate users. Command-line git needs explicit credentials to
> work against these repos, while Visual Studio (i.e. libgit2) does not.
> The other day I noticed that when I give null credentials (i.e. empty
> username and password) normal command-line git works beautifully,
> authenticating as the currently signed-in user.
>=20
> I digged around a bit and found a potential bug in how libcurl is
> used; when using CURLAUTH_ANY, no handshaking will actually be done
> unless a user name is specified - even if it's a fake one.

Yes, this is correct.  My general strategy with Kerberos is to use the
actual username, but you could simply use a dummy (e.g. git@).  This
isn't really a bug in git so much as a limitation in libcurl.

libgit2 doesn't have this problem because it doesn't use libcurl.  Of
course, it has it's own problems, like its SSH support not doing
Kerberos.

> This is consistent with the documentation for curl itself,
> http://curl.haxx.se/docs/manpage.html#--negotiate , however I see no
> mention of this quirk in the libcurl API documentation.

It is present somewhere in there, but it's not easy to find, I'll admit.

> Against a server using Basic authentication the patch will cause git
> to fire off a redundant 'GET' with the empty username before asking
> the user for credentials. I'm not sure if that could cause problems
> for other users, I would expect that anyone working against a server
> with Basic authentication uses stored credentials anyway :-)

I don't see any problems with this.  I'd suggest sending the patch as
specified in Documentation/SubmittingPatches, and it's likely Junio will
pick it up.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.7 (GNU/Linux)

iQIcBAEBCgAGBQJV9ehaAAoJEL9TXYEfUvaLGuEP/A4Ckl8EtoeNGoMMND+W97W8
4CB2dIGg7T9hAJ2pxxd8c2Ds/1Tdw4121ifvfMrvcn1tx/FR/50fDZGm/cOKJ1VL
DEnOsbDk/VUuitY35QfRJFm0H7f+HguYsSTJDeFsKCLx33XaTf6PJ/26nStK0Ud1
Ooet8n8ulMPjKRpgNYIj54o8eADQo53TecNtzpVIIrmoiGlVCot+ygprkfb3xUA9
6/hTgi1XOZklmGt3p2YfSk/4l5h6JyjEbjnfn+L9Ovbub0BV1C5HI+vdXyXEaWwk
ZKABma30CCwvYEA6DX5gOOVU0zgduslcEl5UjaGn9aFK7xx63E4DUXXSMdB/llM9
P6fGJl++rYDg5Pe4c9BzqYZ9boTz7SOk4a6BaFoazdmF00/fkOAyvVnUsvHn0i+e
lcmNzrfEVq5++ZFR049LXTASieg/6dC9gPFnGxlXTUkj3Z3lxygG5P3GZYvogtfJ
ZpxyA2154sfPNnFuzE/63dV1hq82eOcFJWQGtv6sMOxxpeF92G63SAydZLERbocl
4dbOs89aSG6oISd9WKwohws9RWL666JbsShAqcrWdBWPL3JW3Fo+boUL3AewsPeB
dtsnVbhg/WpywP1wNBOFVDTaM1Jkkg66A4uYYJPGJu8NeSmDslGA5xZ3A56zzKPq
xrNdtcjXfDBmPo0CwkNU
=L0f0
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
