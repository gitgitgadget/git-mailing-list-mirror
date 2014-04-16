From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Wed, 16 Apr 2014 21:58:31 +0200
Message-ID: <534EE0E7.2030608@web.de>
References: <201404072130.15686.tboegi@web.de> <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se> <534E0B84.6070602@web.de> <534E60BF.5020602@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:58:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaVyp-0008Iv-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 21:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbaDPT6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 15:58:42 -0400
Received: from mout.web.de ([212.227.15.4]:61545 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaDPT6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 15:58:41 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LgYdx-1XLw8z1WgH-00nwPc; Wed, 16 Apr 2014 21:58:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <534E60BF.5020602@bracey.fi>
X-Provags-ID: V03:K0:6zxvP04V07CF6WsMjn60zHTWrh1iqYnrnWLZVY2pgaS6Ia7NIWa
 9U8mH65BqbysF1jURHIdhNiz/u8f3H2zbC6ODele4lkk2sqQSGE1iYzx/TeIYM04LI6jgIR
 UZZxeFlXngGOxCY7KQ3qgs88MLqhtBgJYKn72i/vkCtkDPudvmKbpnYG4+npgY2OBOXMD++
 YNONjtYGlePg1DbmPlXhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246380>

On 2014-04-16 12.51, Kevin Bracey wrote:
> On 16/04/2014 07:48, Torsten B=C3=B6gershausen wrote:
>> On 15.04.14 21:10, Peter Krefting wrote:
>>> Torsten B=C3=B6gershausen:
>>>
>>>> diff --git a/utf8.c b/utf8.c
>>>> index a831d50..77c28d4 100644
>>>> --- a/utf8.c
>>>> +++ b/utf8.c
>>> Is there a script that generates this code from the Unicode databas=
e files, or did you hand-update it?
>>>
>> Some of the code points which have "0 length on the display" are cal=
led
>> "combining", others are called "vowels" or "accents".
>> E.g. 5BF is not marked any of them, but if you look at the glyph, it=
 should
>> be combining (please correct me if that is wrong).
>=20
> Indeed it is combining (more specifically it has General Category "No=
nspacing_Mark" =3D "Mn").
>=20
>>
>> If I could have found a file which indicates for each code point, wh=
at it
>> is, I could write a script.
>>
>=20
> The most complete and machine-readable data are in these files:
>=20
> http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
> http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
>=20
> The general categories can also be seen more legibly in:
>=20
> http://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedGeneral=
Category.txt
>=20
> For docs, see:
>=20
> http://www.unicode.org/reports/tr44/
> http://www.unicode.org/reports/tr11/
> http://www.unicode.org/ucd/
>=20
> The existing utf8.c comments describe the attributes being selected f=
rom the tables (general categories "Cf","Mn","Me", East Asian Width "W"=
, "F"). And they suggest that the combining character table was origina=
lly auto-generated from UnicodeData.txt with a "uniset" tool. Presumabl=
y this?
>=20
> https://github.com/depp/uniset
>=20
> The fullwidth-checking code looks like it was done by hand, although =
apparently uniset can process EastAsianWidth.txt.
>=20
> Kevin
Excellent, thanks for the pointers.
Running the script below shows that=20
"0X00AD SOFT HYPHEN" should have zero length (and some others too).
I wonder if that is really the case, and which one of the last 2 lines=20
in the script is the right one.

What does this mean for us:
"Cf 	Format 	a format control character"


#!/bin/sh

if ! test -f UnicodeData.txt; then
  wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
fi &&
if ! test -f EastAsianWidth.txt; then
  wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
fi
if ! test -f DerivedGeneralCategory.txt; then
  wget http://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedGe=
neralCategory.txt
fi &&
if ! test -d uniset; then
  git clone https://github.com/tboegi/uniset.git
fi &&
(
  cd uniset &&
  if ! test -x uniset; then=20
    autoreconf -i &&
    ./configure --enable-warnings=3D-Werror CFLAGS=3D'-O0 -ggdb'
  fi &&
  make
) &&
UNICODE_DIR=3D. ./uniset/uniset --32 cat:Me,Mn,Cf
#UNICODE_DIR=3D. ./uniset/uniset --32 cat:Me,Mn










>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
