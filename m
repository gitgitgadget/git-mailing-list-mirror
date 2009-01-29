From: Jan Kasprzak <kas@fi.muni.cz>
Subject: segfault when cloning over https
Date: Thu, 29 Jan 2009 19:45:23 +0100
Message-ID: <20090129184523.GI23133@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 19:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbuk-0004Y1-U3
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZA2Spb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jan 2009 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZA2Spa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:45:30 -0500
Received: from minas.ics.muni.cz ([147.251.4.40]:43520 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373AbZA2Sp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:45:27 -0500
Received: from anxur.fi.muni.cz (anxur.fi.muni.cz [147.251.48.3])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id n0TIjN3x001417
	for <git@vger.kernel.org>; Thu, 29 Jan 2009 19:45:24 +0100
Received: by anxur.fi.muni.cz (Postfix, from userid 11561)
	id 36ABB1F66B6; Thu, 29 Jan 2009 19:45:23 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (minas.ics.muni.cz [147.251.4.35]); Thu, 29 Jan 2009 19:45:24 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107711>

	Hello,

I am trying to use git for accessing the repository over https.
I can run

git clone --bare http://www.fi.muni.cz/~kas/tmp/git.git

without problems, but when I change http to https, it either segfaults
or fails with heap corruption detected:

$ git clone --bare https://www.fi.muni.cz/~kas/tmp/git.git
[...]
got f1a1aac6880f1c8f122c57c2380800ec54d10982
*** glibc detected *** git: double free or corruption (!prev): 0x00007f=
8455a90fe0 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib64/libc.so.6[0xf8bec8]
/lib64/libc.so.6(cfree+0x76)[0xf8e486]
/lib64/libnsspem.so[0x7f845f3f2a75]
/lib64/libnsspem.so[0x7f845f3e1a56]
/lib64/libnsspem.so[0x7f845f3e71a9]
/lib64/libnsspem.so[0x7f845f3ee9c4]
/lib64/libnss3.so[0x7f846210dc4d]
/lib64/libnss3.so(PK11_CreateGenericObject+0x42)[0x7f846210ded2]
/usr/lib64/libcurl.so.4[0x14b129]
/usr/lib64/libcurl.so.4(Curl_nss_connect+0x622)[0x14b9f2]
/usr/lib64/libcurl.so.4(Curl_protocol_connect+0xd2)[0x12bd72]
/usr/lib64/libcurl.so.4[0x13efd3]
/usr/lib64/libcurl.so.4(curl_multi_perform+0x8b)[0x13f2ab]
git[0x49de9f]
git[0x49df2f]
git[0x4a0499]
git[0x4a081e]
git[0x49aa36]
git[0x494b41]
git[0x4942f3]
git[0x415674]
git[0x4041a3]
git[0x4043bc]
/lib64/libc.so.6(__libc_start_main+0xe6)[0xf32576]
git[0x403c69]
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
00110000-00157000 r-xp 00000000 08:01 113025474                        =
  /usr/lib64/libcurl.so.4.1.0
00157000-00357000 ---p 00047000 08:01 113025474                        =
  /usr/lib64/libcurl.so.4.1.0
[...]

	I have tried this against various https servers hosting different
repositories, and from various distributions (including Fedora 7, Fedor=
a 8,
and Fedora 10, all x86_64), and from various git builds (1.6.0.6 from F=
edora 10,
1.6.1.2 built from the source, etc.

	Does anybody see the same problem? Do you use git over https at all?

It is possible to test against this repository:

http://www.fi.muni.cz/~kas/tmp/git.git
https://www.fi.muni.cz/~kas/tmp/git.git

You will have to add the following certificate to your ca-bundle.crt
to access the repository:

-----BEGIN CERTIFICATE-----
MIICsTCCAhoCAQAwDQYJKoZIhvcNAQEEBQAwgaAxCzAJBgNVBAYTAkNaMRcwFQYD
VQQIEw5DemVjaCBSZXB1YmxpYzENMAsGA1UEBxMEQnJubzEfMB0GA1UEChMWRmFj
dWx0eSBvZiBJbmZvcm1hdGljczEMMAoGA1UECxMDQ1ZUMRowGAYDVQQDExFBZG1p
bmlzdHJhdGl2YSBGSTEeMBwGCSqGSIb3DQEJARYPdW5peEBmaS5tdW5pLmN6MB4X
DTk3MTExMDEyMDQyOVoXDTI1MDMyODEyMDQyOVowgaAxCzAJBgNVBAYTAkNaMRcw
=46QYDVQQIEw5DemVjaCBSZXB1YmxpYzENMAsGA1UEBxMEQnJubzEfMB0GA1UEChMW
RmFjdWx0eSBvZiBJbmZvcm1hdGljczEMMAoGA1UECxMDQ1ZUMRowGAYDVQQDExFB
ZG1pbmlzdHJhdGl2YSBGSTEeMBwGCSqGSIb3DQEJARYPdW5peEBmaS5tdW5pLmN6
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMm0dLLgsMSwmYPZdYYDGNsdwK
04k9O5gTYk+S70+ygUsLQNL+VLYqprsfZkDelX2wea8oUkj69R8I+vF6N1E8Ubik
3c4RFqJB6tsnTJT1YplCFd7s1BZlGSEKHC3OzHYp19pnXc0IHgX404pgpmuXaq6R
Xu+D8iboFKi60ZpsVQIDAQABMA0GCSqGSIb3DQEBBAUAA4GBAD7842aqJRKlFDzk
LK8SpR8KZ/jYWSdzNrwCQfLAlAzo8wDTcC3hgnaiKHJq4ZvS9h2tnGWm+qEToQwB
oKjKyR87zaFeEWu/tNxBNPkAXfX9jdyJ5ozDTVDpFLoLEZ5ppIuh/ZDbPhjTQZrc
IFfjrlWlrKXmiH9hCSQ5R/lIlrnG
-----END CERTIFICATE-----

	Please Cc: me directly, I am not a member of this list.

	Thanks,

-Yenya

--=20
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - privat=
e}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18=
A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/bl=
og/ |
>>  If you find yourself arguing with Alan Cox, you=E2=80=99re _probabl=
y_ wrong.  <<
>>     --James Morris in "How and Why You Should Become a Kernel Hacker=
"  <<
