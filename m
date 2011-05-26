From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: git dies with sigseg due to enless recursion on broken repo
Date: Thu, 26 May 2011 03:33:16 +0200
Message-ID: <20110526013316.GA22589@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 03:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPPl8-0007RL-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 03:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab1EZBxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 21:53:06 -0400
Received: from uucp.gnuu.de ([83.246.114.63]:1170 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab1EZBxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 21:53:04 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id AF73F48802D; Thu, 26 May 2011 03:34:34 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.5.2 uucp.gnuu.de AF73F48802D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuu.de; s=banki;
	t=1306373674; i=@alea.gnuu.de; bh=yJKRCNDo2QA3Z+Vmxm409e1HVrLjGRi7q
	Fp8790G6oM=; h=Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type; b=uqQJedDralpsWxDv2C0DJqKvkPCpNxHvi1q57qMge03Uidp54W
	MyQDRr3DJUVWzPXtwYUHVta+V2UTRDGFLzE0OmjjwWdl6cuugfPi/DCsd3YrWzzzN2i
	WFWsysXf6j+v23pX/PHRLrMIO1PCEDUfHIOSiI1oONh2CtD4OVwnHQ=
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1QPPSD-0007uA-2r
	for git@vger.kernel.org; Thu, 26 May 2011 03:33:37 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.76)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1QPPRt-0000RD-8i
	for git@vger.kernel.org; Thu, 26 May 2011 03:33:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174486>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've a broken repository which causes git goes into an endless recursion
until it gets a segmentation fault. I can reproduce this problem with
version 1.7.5.2.353.g5df3e.

% gdb -batch -ex "run --git-dir=3D$HOME/broken-git fsck" -ex bt\ full git

[Thread debugging using libthread_db enabled]

Program received signal SIGSEGV, Segmentation fault.
use_pack (p=3DCannot access memory at address 0xbf7ffff8
) at sha1_file.c:837
837     {
#0  use_pack (p=3DCannot access memory at address 0xbf7ffff8
) at sha1_file.c:837
        win =3D <error reading variable win (Cannot access memory at addres=
s 0xbf7fffd8)>
#1  0x10140290 in get_delta_base (p=3D0x10222470, w_curs=3D0xbf800140, curp=
os=3D0xbf800100, type=3DOBJ_REF_DELTA, delta_o
        base_info =3D 0x0
        base_offset =3D 0
#2  0x1014131c in unpack_delta_entry (p=3D0x10222470, w_curs=3D0xbf800140, =
curpos=3D13082, delta_size=3D7, obj_offset=3D130
        delta_data =3D 0xbf800120
        result =3D 0x10140720
        base =3D 0x48054319
        base_size =3D 1208304409
        base_offset =3D -4647713764261494296
#3  0x1014173c in unpack_entry (p=3D0x10222470, obj_offset=3D13081, type=3D=
0xbfffe1a8, sizep=3D0xbf8001e8) at sha1_file.c
        w_curs =3D 0x1021a570
        curpos =3D 13082
        data =3D 0x48021018
#4  0x10140e48 in cache_or_unpack_entry (p=3D0x10222470, base_offset=3D1308=
1, base_size=3D0xbf8001e8, type=3D0xbfffe1a8,=20
        ret =3D 0x0
        hash =3D 2
        ent =3D 0x10201388
#5  0x10141394 in unpack_delta_entry (p=3D0x10222470, w_curs=3D0xbf800240, =
curpos=3D13102, delta_size=3D7, obj_offset=3D130
        delta_data =3D 0xbf800220
        result =3D 0x10140720
        base =3D 0x48054319
        base_size =3D 7
        base_offset =3D 13081
#6  0x1014173c in unpack_entry (p=3D0x10222470, obj_offset=3D13081, type=3D=
0xbfffe1a8, sizep=3D0xbf8002e8) at sha1_file.c
        w_curs =3D 0x0
        curpos =3D 13082
        data =3D 0x48021018
#7  0x10140e48 in cache_or_unpack_entry (p=3D0x10222470, base_offset=3D1308=
1, base_size=3D0xbf8002e8, type=3D0xbfffe1a8,=20
        ret =3D 0x0
        hash =3D 2
        ent =3D 0x10201388
#8  0x10141394 in unpack_delta_entry (p=3D0x10222470, w_curs=3D0xbf800340, =
curpos=3D13102, delta_size=3D7, obj_offset=3D130
        delta_data =3D 0xbf800320
        result =3D 0x10140720
        base =3D 0x48054319
        base_size =3D 7
        base_offset =3D 13081
#9  0x1014173c in unpack_entry (p=3D0x10222470, obj_offset=3D13081, type=3D=
0xbfffe1a8, sizep=3D0xbf8003e8) at sha1_file.c
        w_curs =3D 0x0
        curpos =3D 13082
        data =3D 0x48021018
#10 0x10140e48 in cache_or_unpack_entry (p=3D0x10222470, base_offset=3D1308=
1, base_size=3D0xbf8003e8, type=3D0xbfffe1a8,=20
        ret =3D 0x0
        hash =3D 2
        ent =3D 0x10201388
#11 0x10141394 in unpack_delta_entry (p=3D0x10222470, w_curs=3D0xbf800440, =
curpos=3D13102, delta_size=3D7, obj_offset=3D130
        delta_data =3D 0xbf800420
        result =3D 0x10140720
        base =3D 0x48054319
        base_size =3D 7
        base_offset =3D 13081
#12 0x1014173c in unpack_entry (p=3D0x10222470, obj_offset=3D13081, type=3D=
0xbfffe1a8, sizep=3D0xbf8004e8) at sha1_file.c
        w_curs =3D 0x0
        curpos =3D 13082
        data =3D 0x48021018
#13 0x10140e48 in cache_or_unpack_entry (p=3D0x10222470, base_offset=3D1308=
1, base_size=3D0xbf8004e8, type=3D0xbfffe1a8,=20
        ret =3D 0x0
        hash =3D 2
        ent =3D 0x10201388
#14 0x10141394 in unpack_delta_entry (p=3D0x10222470, w_curs=3D0xbf800540, =
curpos=3D13102, delta_size=3D7, obj_offset=3D130
        delta_data =3D 0xbf800520
        result =3D 0x10140720
        base =3D 0x48054319
        base_size =3D 7
        base_offset =3D 13081
#15 0x1014173c in unpack_entry (p=3D0x10222470, obj_offset=3D13081, type=3D=
0xbfffe1a8, sizep=3D0xbf8005e8) at sha1_file.c
        w_curs =3D 0x0
        curpos =3D 13082
        data =3D 0x48021018
#16 0x10140e48 in cache_or_unpack_entry (p=3D0x10222470, base_offset=3D1308=
1, base_size=3D0xbf8005e8, type=3D0xbfffe1a8,=20
        ret =3D 0x0
        hash =3D 2
        ent =3D 0x10201388

There are more than 133205 stack frames.

The problem is, this repository contains private data. I don't want to
put it in public, but I would send it to someone in the hope he doesn't
expose its contents. Or you tell me, what you are interested in and I dig
for it.

Bye, J=C3=B6rg.
--=20
Nichts ist so langweilig, wie die Wiederholung seinerselbst.
                                        (Marcel Reich=E2=80=90Ranicki)

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3drdwACgkQwe0mZwH1VICdxQCfRJxbp3ZxtGSB6aXgpB3VuKzx
wakAn0q1YQiTXhXzLrxoyr5Hw+jxeMBb
=JZbz
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
