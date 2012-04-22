From: "Philippe Martens" <philippe.martens@metrum.lu>
Subject: bug: git fast-import should ignore configuration variable core.ignorecase (plain text format)
Date: Sun, 22 Apr 2012 20:12:12 +0200
Message-ID: <001e01cd20b3$70b72ce0$522586a0$@metrum.lu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01CD20C4.34413560"
To: <git@vger.kernel.org>, <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM1Gj-0000qu-R3
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 20:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab2DVSMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 14:12:13 -0400
Received: from mirapoint3.brutele.be ([212.68.199.148]:37375 "EHLO
	mirapoint3.brutele.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab2DVSMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 14:12:13 -0400
Received: from METRUMPHM (62-197-93-206.teledisnet.be [62.197.93.206])
	by mirapoint3.brutele.be (MOS 4.2.3-GA)
	with ESMTP id BHL51875;
	Sun, 22 Apr 2012 20:12:11 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac0gs22P/Lz5VCVPTzycvVnKHKm4Ag==
Content-Language: fr-be
X-Junkmail-Status: score=10/50, host=mirapoint3.brutele.be
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A0B0203.4F9449FB.00C8,ss=1,fgs=0,
	ip=0.0.0.0,
	so=2010-12-23 16:51:53,
	dmn=2009-09-10 00:05:08,
	mode=single engine
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196086>

This is a multipart message in MIME format.

------=_NextPart_000_001F_01CD20C4.34413560
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I=92m not quite sure if this is to be considered a Windows specific bug. =
I=92m
using Git-1.7.10-preview20120409 on Windows, but the problem exists in
previous versions.

When fast-exporting | fast-importing on Windows a repository with case =
only
renames, the resulting repository isn=92t a copy of the initial =
repository.
This is because Windows repositories are created with core.ignorecase =
=3D true
by default.

The included script shows the problem: it creates a repository with
SomeFile.txt renamed to SOMEFILE.txt, then fast-export it and =
fast-import it
in two different repositories, with core.ignorecase=3Dfalse and
core.ignorecase=3Dtrue. The sha-1 of the second commit in the repository =
with
core.ignorecase=3Dtrue is different from the initial repository because =
the
rename is ignored.
The situation is worse without rename detection on fast-export : the =
rename
becomes a delete.

I think the configuration variable core.ignorecase should be ignored by
fast-import, and case always taken into account in that case.

Kind regards,

Philippe Martens
Lead Architect

METRUM
Rue du Kiem, 163
L-8030 Strassen
T=E9l : +352 26 00 87 01
Fax : +352 26 00 87 02
GSM : +352 661 26 00 37
Email : philippe.martens@metrum.lu
Web : www.metrum.lu

------=_NextPart_000_001F_01CD20C4.34413560
Content-Type: application/octet-stream;
	name="test-fast-import.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test-fast-import.sh"

git init export=0A=
cd export=0A=
git config core.ignorecase true=0A=
echo "With some content in it..." > SomeFile.txt=0A=
git add .=0A=
git commit -m "Add some file"=0A=
git mv -f SomeFile.txt SOMEFILE.txt=0A=
git commit -m "Rename it (case only)"=0A=
git fast-export --all -M -C > ../git.fast-export=0A=
git log --oneline=0A=
=0A=
git init ../ignorecase.false=0A=
cd ../ignorecase.false=0A=
git config core.ignorecase false=0A=
git fast-import --quiet < ../git.fast-export=0A=
git log --oneline=0A=
=0A=
git init ../ignorecase.true=0A=
cd ../ignorecase.true=0A=
git config core.ignorecase true=0A=
git fast-import --quiet < ../git.fast-export=0A=
git log --oneline=0A=
cd ..=0A=

------=_NextPart_000_001F_01CD20C4.34413560--
