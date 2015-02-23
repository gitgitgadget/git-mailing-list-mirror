From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: AW: git blame swallows up lines in case of mixed line endings
Date: Mon, 23 Feb 2015 11:50:51 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F2D20FD@DEFTHW99EH3MSX.ww902.siemens.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
 <54E88BFA.9050900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 13:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPrkN-0007Up-RB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 13:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbbBWMET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2015 07:04:19 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:53741 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbbBWMES convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 07:04:18 -0500
X-Greylist: delayed 805 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Feb 2015 07:04:18 EST
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.14.3/8.14.3) with ESMTP id t1NBoq39010370;
	Mon, 23 Feb 2015 12:50:52 +0100
Received: from DEFTHW99ERGMSX.ww902.siemens.net (defthw99ergmsx.ww902.siemens.net [139.22.70.132])
	by mail1.sbs.de (8.14.3/8.14.3) with ESMTP id t1NBoqHv016182
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 23 Feb 2015 12:50:52 +0100
Received: from DENBGAT9ERFMSX.ww902.siemens.net (139.22.70.83) by
 DEFTHW99ERGMSX.ww902.siemens.net (139.22.70.132) with Microsoft SMTP Server
 (TLS) id 14.3.224.2; Mon, 23 Feb 2015 12:50:52 +0100
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.249]) by
 DENBGAT9ERFMSX.ww902.siemens.net ([139.22.70.83]) with mapi id
 14.03.0224.002; Mon, 23 Feb 2015 12:50:51 +0100
Thread-Topic: git blame swallows up lines in case of mixed line endings
Thread-Index: AdBMSq6uIhmDfLX5RVankGP+MpKSCQBiZeEAAGI4EiA=
In-Reply-To: <54E88BFA.9050900@web.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264252>

It's not that I want to use CR as line ending. We just had to process a=
 repository where it was the case. We use git blame as an automatic pro=
cessing step in a bigger system. So if a line does not exist for git bl=
ame but it does exist for other parts of the system (which read the sam=
e file) we run into consistency problems.=20

-----Urspr=FCngliche Nachricht-----
Von: Torsten B=F6gershausen [mailto:tboegi@web.de]=20
Gesendet: Samstag, 21. Februar 2015 14:46
An: Sokolov, Konstantin (ext); 'git@vger.kernel.org'
Betreff: Re: git blame swallows up lines in case of mixed line endings

On 2015-02-19 14.48, Sokolov, Konstantin (ext) wrote:
> Hi Folks,
>=20
> I encounter unexpected behavior in the following case:
>=20
> file content:
>=20
> line1<CR><LF>
> line2<CR>
> line3<CR><LF>
> line4
>=20
> This is what I get as console output (on Windows):
>=20
>> git blame -s file.txt
> 7db36436 1) line1
> line3436 2) line2
> 7db36436 3) line4
>=20
> This is the real content:
>=20
>> git blame -s file.txt > blame.txt
>=20
> blame.txt opened in Notepad++:
>=20
> 7db36436 1) line1 <CR><LF>
> 7db36436 2) line2 <CR>
> line3 <CR><LF>
> 7db36436 3) line4 <LF>
>=20
> Admittedly, very stupid editors, such as Windows Notepad, cannot hand=
le mixed line endings as well. But is this also the way git blame shoul=
d behave?
>=20
> Kind regards
> Konstantin
>
Git (and other tools) do not handle a single CR as a line ending.
A line ending in Git is either CRLF or LF.

A "mixed line ending" in Git sense is a mixture between CRLF and LF, bu=
t not a lone CR.
(And in this sense it is the expected behavior)

Are you sure you want to use it, or is it a typo ?
