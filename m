From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Thu, 18 Oct 2007 20:54:14 +0200
Message-ID: <20071018185414.GL26127@efreet.light.src>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com> <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 20:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiaVt-0004OG-70
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbXJRSyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758436AbXJRSyU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:54:20 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39310 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758279AbXJRSyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:54:20 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D5C56572A0;
	Thu, 18 Oct 2007 20:54:18 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id VhfSYzYx5Pzl; Thu, 18 Oct 2007 20:54:16 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 624BA5726F;
	Thu, 18 Oct 2007 20:54:15 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IiaVa-0007sM-5p; Thu, 18 Oct 2007 20:54:14 +0200
Content-Disposition: inline
In-Reply-To: <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61555>


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2007 at 11:16:34 -0400, Brian Gernhardt wrote:
>
> On Oct 17, 2007, at 10:39 AM, Morten Welinder wrote:
>
>>>  made it into your repo.  It fixes test failures on my machine that have
>>>  been plauging me for months.
>>
>> That sounds more like a reason to fix the test.  "die" is the perl
>> standard way of reporting an error.  It will print the error message
>> on stderr, not on stdout like your version does.
>>
>> IMHO, of course.
>
> The problem is that die can exit with varying exit codes, and exit codes =
>=3D=20
> 128 make the test suite assume something has gone wrong with the test.  I=
n=20
> particular, because $! (errcode) and $? (previous shell command return) a=
re=20
> both 0, it returns 255.  Or at least that's how it works out on my system=
=2E =20
> I'm not sure why it doesn't do that on others.
>
> But the test is expecting a failure here and it appears to be failing in=
=20
> the correct way, just with an error code test-lib.sh doesn't like.  I ask=
ed=20
> on list the best way to fix it and Frank Lichtenheld said (and nobody=20
> objected until now) that this was the best way to fix it.
>
> Also, the not printing on STRERR is identical to another section of code=
=20
> just below mine:
>
>>     unless ($line eq 'anonymous') {
>>        print "E Only anonymous user allowed via pserver\n";
>>        print "I HATE YOU\n";
>>        exit 1;
>>     }
>
> However, amending my patch to print to STDERR is not difficult.

Hm. There are two kinds of errors in git-cvsserver and they should be handl=
ed
differently.

If the error is an invalid request (like the quoted one), there should be
normal print, to STDOUT, starting with "E", because it's an error message
that should be sent to the client.

On the other hand if the error is internal error in the script or it's
configuration, than the error should probably be reported via die, *without*
E at the begining (it will be prefixed with location anyway). Such message
will probably end up in the log rather than sent to the client.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHF6vWRel1vVwhjGURAuNjAJ9s4CT62JUbVOdyxc/RkYVv4mgliwCg01DA
LQIl72NStCv/pz4Q6q3exmQ=
=cPXV
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--
