From: Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: Re: Porcelain support for daggy-fixes?
Date: Fri, 11 Jun 2010 14:25:09 +0300
Message-ID: <4C121D15.7030004@peda.net>
References: <4C10EEBE.5030400@peda.net> <AANLkTikbe_0GlSkXxiSeIQl0x0tfTYmoI5RuyJPzZioM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7408BFB2F96370B79301C8D2"
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 13:33:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON2UM-00048d-L3
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 13:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759450Ab0FKLdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 07:33:25 -0400
Received: from posti7.jyu.fi ([130.234.4.44]:45013 "EHLO posti7.jyu.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635Ab0FKLdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 07:33:24 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2010 07:33:24 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti7.jyu.fi (8.13.8/8.13.8) with ESMTP id o5BBPIlK012424;
	Fri, 11 Jun 2010 14:25:18 +0300
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti7.jyu.fi ([127.0.0.1])
	by localhost (posti7.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LK2tBj2aIASt; Fri, 11 Jun 2010 14:25:15 +0300 (EEST)
Received: from [130.234.78.125] (semyol-329-b.ktl.jyu.fi [130.234.78.125])
	(authenticated bits=0)
	by posti7.jyu.fi (8.13.8/8.13.8) with ESMTP id o5BBPCpA012419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jun 2010 14:25:13 +0300
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTikbe_0GlSkXxiSeIQl0x0tfTYmoI5RuyJPzZioM@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148937>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7408BFB2F96370B79301C8D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pascal Obry wrote:
> I would probably create a topic/fix branch:
>=20
> 1) figure out the proper parent for the bug fix
> 2) create the fix branch and move to it
>     $ git co -b fix-feature-whatever parent
> 3) implement the fix
> 4) commit the fix
> 5) checkout HEAD
> 6) merge with the commit from step 4
>=20
> And also merge on release branch if needed.

OK. I agree with this. The only problem is step 1 above (plus the other
repeated steps if this is done every time you find a bug).

I'm still wondering if it would be possible to figure the correct parent
automatically. How about the following:

Given: minimal patch to fix a bug committed to tip of the master.
Target: find proper parent for daggy-fix for the given bugfix (and then
later rewrite history to put the fix as daggy-fix and merge with the mast=
er)

Idea:

Compare the list of removed lines from latest commit (the bugfix) with
the output of the same lines from git blame --cc (immediately before the
bugfix). Proper parent for the bug fix is the commit that is newest for
any removed line from the parent of the bugfix in the tip of the master
(HEAD^).

Does it sound sensible to assume that the proper parent for the bug fix
is the newest commit that has modified any line that is removed or
replaced by the bug fix?


Why do I even think about this? I believe that daggy-fix style would be
beneficial for many software projects but for small fixes it requires
many little steps to implement and extra work to figure out the correct
parent. Small bugs are often easy to fix at the tip of the master so the
fixes usually end up there. It would be awesome if git were smart enough
to move the fix to the correct location (daggy-fix)  and do automatic
merge, once told that the last commit was really a bugfix. If this ends
up working well enough, then it should be a flag for commit (--bugfix)
which does the commit to proper parent and then does another merge
commit with the current branch. Then the other branches (or forks) could
merge the fix more easily (daggy-fixes should merge without conflicts if
done correctly).

--=20
Mikko



--------------enig7408BFB2F96370B79301C8D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwSHRUACgkQFNzRB1YxaOtumwCeNTdjd7uXyE6HcY+MHtTZPFaT
hZ8AnRy0yqmmGYYgwFjZSoNnrPzxHOZA
=u3MC
-----END PGP SIGNATURE-----

--------------enig7408BFB2F96370B79301C8D2--
