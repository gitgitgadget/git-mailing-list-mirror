From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 15:23:46 -0600
Organization: Red Hat
Message-ID: <4D9B8862.1050605@redhat.com>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com> <20110405194005.GA32427@elie> <201104052315.54375.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig5F2AE7F76DCEF26E24000980"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Dlt-0001TV-Gm
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab1DEVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:23:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39141 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab1DEVXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:23:51 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p35LNlq8028192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 5 Apr 2011 17:23:47 -0400
Received: from [10.3.113.117] (ovpn-113-117.phx2.redhat.com [10.3.113.117])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p35LNlSd024220;
	Tue, 5 Apr 2011 17:23:47 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.9
In-Reply-To: <201104052315.54375.j6t@kdbg.org>
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170918>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F2AE7F76DCEF26E24000980
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/05/2011 03:15 PM, Johannes Sixt wrote:
>>> @@ -87,7 +89,8 @@ PATTERN FORMAT
>>>
>>>   - Otherwise, git treats the pattern as a shell glob suitable
>>>     for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>>> -   wildcards in the pattern will not match a / in the pathname.
>>> +   wildcards in the pattern will not match a / in the pathname,
>>> +   and do not ignore files with a leading . in the pathname.
>=20
> I don't think this is correct. * matches .gitignore. I tried it.

That was my point.  * _does_ match .gitignore, even though for normal
shell globs, FNM_PERIOD is set and * does not match .gitignore.  That
is, while in the shell 'dir/*' only matches non-dot files, in .gitignore
it matches all files including dot-files.

Any ideas for a better way to word that?

> I propose a paragraph like this in the NOTES section:
>=20
> --- 8< ---
> When a directory is ignored, it is not possible to un-ignore a single f=
ile=20
> somewhere in the directory using another pattern. E.g., with the patter=
ns
>=20
> --------------
> /build/
> !/build/tests/results
> --------------
>=20
> the file "build/tests/results" is still ignored because when a director=
y is=20
> ignored, its contents are never investigated. In a situation where a fe=
w=20
> exceptions in an otherwise ignored hierarchy are needed, the recommende=
d=20
> procedure is to specify to ignore the root of the hierarchy and then to=
 'git=20
> add -f' the exceptional files. Subsequent changes to the files will not=
 be=20
> ignored.

Yeah, but then you have to 'git add -f path/to/file' them every time you
change them, or use the sledgehammer of 'git add .'.

Does it make any better sense to document:

  /build/*
  !/build/*/
  /build/*/*
  !/build/foo/baz

which ignores all files in build, then un-ignores directories, then
ignores all files in subdirectories of build except for the desired
multi-level file under build?  At which point you no longer need 'git
add -f', but can simply do 'git add build' to pick up /build/foo/baz in
one go without warning?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig5F2AE7F76DCEF26E24000980
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNm4hiAAoJEKeha0olJ0NqipQH/iuryTsKmT2PIpdnZL4jQ6hL
w2U8Khdj9yntsTv603ZBSk3EYb79ft7gNx17p3k+eWXxUmcfNVtRAOk5KW+4SIF8
0OIG2tp7Li1Bz11yVPiBORwuLyZDLru4rZxIZ2Lk9KeUPK9B13FAXCCa60q7HNHk
TszyiBI35wkcia4bmUsySoyO364xEFQZpwJfhYNJ3pt7Yh/5hUi0as+JX3Kn3nRN
qrE1n/QiCNci3D87T6QOAq3ak0tBobdiTUNMEn0jH3VQUJgYpgwv/uayBSmiiFOO
vBwFt3fQlgfvdUTnE6DmyqB2gb1VOVq0nAJVsRDd3Rxxov/9joo4NART8uHgh7U=
=IXon
-----END PGP SIGNATURE-----

--------------enig5F2AE7F76DCEF26E24000980--
