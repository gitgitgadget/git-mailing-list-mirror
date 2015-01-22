From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 22 Jan 2015 23:41:17 +0000
Message-ID: <20150122234117.GD96498@vauxhall.crustytoothpaste.net>
References: <54BD3D14.90309@web.de>
 <20150122200702.GA96498@vauxhall.crustytoothpaste.net>
 <54C17429.1090403@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Cc: git@vger.kernel.org, lists@hcf.yourweb.de
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YERNR-0007nO-Gh
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbAVXl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:41:26 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43403 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752568AbbAVXlY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 18:41:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c8c4:ec20:e47c:f338])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A40C12808F;
	Thu, 22 Jan 2015 23:41:22 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
Content-Disposition: inline
In-Reply-To: <54C17429.1090403@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262893>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 11:05:29PM +0100, Torsten B=C3=B6gershausen wrote:
>We want to support ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.git/
>   because e.g. the Git shipped with Debian (1.7.10.4) (and a lot of other=
 installations) supports it.

I understand that this used to work, but it probably shouldn't have ever=20
been accepted.  It's nonstandard, and if we accept it for ssh, people=20
will want it to work for https, and due to libcurl, it simply won't.

I prefer to see our past acceptance of this format as a bug.  This is=20
the first that I've heard of anyone noticing this (since 2013), so it=20
can't be in common usage.

If we accept it, we should explicitly document it as being deprecated and=
=20
note that it's inconsistent with the way everything else works.

>We want to support ssh://bmc@[2001:470:1f05:79::1]/git/bmc/homedir.git/
>    because that is what other people may expect to work as well:
> ssh://bmc@[2001:470:1f05:79::1]:4444/git/bmc/homedir.git/

Everyone expects this to work properly, because it's the standard URL=20
form (RFC 2732).  I agree we should support it.

>>  git push 2001:470:1f05:79::1:1 master
>> when they mean
>>
>>  git push [2001:470:1f05:79::1]:1 master
>That I don't understand this, where is the path name in your example ?

The path in question is $HOME/1.  That's why the bracket notation is=20
obligatory in the short form.  I agree it's a bit bizarre.

>Everything after the first ':' is the path in the short form:
>bmc@hostxx:/git/bmc/homedir.git/
>
>If you really want to use a literal IPV6 with the short form, you must use=
 the brackets:
>bmc@[2001:470:1f05:79::1]:/git/bmc/homedir.git/
>(And you can not have a port number here)

Right.  In my experience, nobody uses the ssh:// form unless they have=20
to (i.e. they need to use a port number); it's extremely uncommon.  So=20
they've already become used to using the bracketed notation, because=20
it's already required for the usual form and it's required in the IPv6=20
URL standard.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwYqcAAoJEL9TXYEfUvaLhTUQAI+5KnyH+u4z0+Bb0ui2rbDk
DTGqrXc0i4fIswjxsJynSeUvwDx+B7hN+DU5Z7Iw4OdMfGVUJaP354z9ZoPb1DK5
M4F4QexxVwBM9SpQ2onU7gr/kxjaJnGA567cnauDIYmqdHSKwzNKs1FmZYqVe1lU
D02IdPq/p/362YaFDyS0rTI0Shu3q9PEit3ke45VFPZgU3IOyZMq18iV1kxqzfd3
uQjSK3Ea9k4m4TL03D0KhgTnVvuf3uodZ4Nsz1p5A8FvPPIEoBRnWpV/VFm2ge5D
k0H/mJ+sLvKm5IYMzCa9IAig0DxH11fo1ZDRhTHlW11UaF5a+SfE6PlJGKBshjBy
PbBvNeUZjZuMKl268m5Q9+BWpj/75jpGJxpWaMDnV7LL+5lMG5llMKduyL7L2+/t
CRkN7IEnB+oHtpqo5Qq7fUFao4OxzFsM/vAkx6bo7B7cKivgfdAA59lQu8GHzCRJ
dZAC3BwjAZfvDpL3BXAvOjYc5PKRc4bkNVWWR8BFQ/XvXMRXNQCyJvE/hqcASeES
mJj6JHOtWNVMcPbKkLomiBsWoFFDGmvaUoYoUJhhPQK7r0zrxlOg+0SXus2bZteo
B1Zg6HqDjOPzkNrBu87MMycpWve46YE5QlEGE88rBRN2UxfcLM1qqyUYjGsEKrqU
0xSmY6t4r110JrHCLR2o
=WFGl
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
