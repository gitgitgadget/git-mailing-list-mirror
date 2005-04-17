From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sun, 17 Apr 2005 04:38:45 +0200
Message-ID: <4261CC35.4070108@khandalf.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
    <20050416233724.GP19099@pasky.ji.cz>	<20050416170221.38b3e66c.pj@sgi.com>
    <20050417003325.GA15608@redhat.com> <20050416174409.59f94c26.pj@sgi.com>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Jones <davej@redhat.com>, pasky@ucw.cz, git@vger.kernel.org,
	mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 04:35:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMzcp-0007MW-3d
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 04:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVDQCir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Apr 2005 22:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDQCir
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 22:38:47 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:51142 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261237AbVDQCin (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 22:38:43 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j3H2cgoK000630
	for <git@vger.kernel.org.>; Sun, 17 Apr 2005 04:38:42 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j3H2cmfV011411; Sun, 17 Apr 2005 04:38:50 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416174409.59f94c26.pj@sgi.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: cbf498374707e8458d92e0a1852d0393
X-Transmit-Date: Sunday, 17 Apr 2005 4:39:17 +0200
X-Message-Uid: 0000b49cec9dc56a00000002000000004261cc5500073c58000000010008cedf
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-07.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

No, you have to:
(a) create a unique, pid specific file name /var/tmp/myapp.$$.xyzzy
(b) create it in O_EXCL mode, so you wont smash another's held lock

(b-1) It worked, OK

(b-2) open failed, try ...xyzzz

repeat until (b-1)

There are thousands of examples of how to do this with bash.

Paul Jackson wrote:
> Dave wrote:
>=20
>>mktemp is being used here to provide randomness in the filename,
>>not just a uniqueness.
>=20
>=20
> Ok - useful point.
>=20
> How about:
>=20
> 	t=3D${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
>=20
>=20
>>all an attacker has to do is create 65535 symlinks in /usr/tmp

the point of the xyzzy seed is to make creating all possible files
in-feasable.

>=20
>=20
> And how about if I removed the tmp files at the top:
>=20
> 	t=3D${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
> 	trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
> 	rm -fr $t.?
>=20
> 	... rest of script ...
>=20
> How close does that come to providing the same level of safety, while
> remaining portable over a wider range of systems, and not requiring t=
hat
> a separate command be forked?
>=20
>=20
>>I'd suggest fixing your distributions ...
>=20
>=20
> It's not just my distro; it's the distros of all git users.
>=20
> If apps can avoid depending on inessential details of their
> environment, that's friendlier to all concerned.
>=20
> And actually my distro is fine - it's just that I am running an old
> version of it on one of my systems.  Newer versions of the mktemp -t
> option.
>=20

--=20
mit freundlichen Gr=FC=DFen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint =3D 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D=
5
