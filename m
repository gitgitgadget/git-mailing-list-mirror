From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Fri, 13 Nov 2015 13:08:52 +0100
Message-ID: <23C0ED03-3773-49AC-A03B-F5E35B9E12D0@gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com> <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com> <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com> <56437F96.2070209@ramsayjones.plus.com> <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com> <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com> <5645BC55.70504@web.de>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 13 13:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxDA4-00045c-4g
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 13:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbbKMMI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Nov 2015 07:08:56 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33566 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbbKMMIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2015 07:08:55 -0500
Received: by wmec201 with SMTP id c201so78147750wme.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MDQiU+AXmmTdqTL0wu0b2ctvoBCR/p82/sleVPC4yno=;
        b=ylPyANSOggIIBewR3pbYgiwF0ljiOXQ0Sxt6LHw9DCEMqZiInmJY2U8TDsheYmORM1
         L98yCh35FnlS41sR8Q+/AujHmABbiSCEX3uxpzqZw/k7GIwVCk7Jm7V48JKDIpMaMqSr
         vDNFVSi+84ls++RZvO8hMGrIkTpHfxZUZ/EmsLeHC4NAI94wGypdS8Ao3wrFv14Ol+ny
         M9bv4H3su953pUNDUZZ6Oxz4kqKcnNiz/WAZyNgVegyexLxl2flfuksw1peW/xFGQog5
         Vt1IdLpYUs+HLQU/XfmJXF3wzq9bzZksVjl3LOBs356uACHjTC2XBNa6JwY/8PyKtlfu
         NYiQ==
X-Received: by 10.194.94.100 with SMTP id db4mr21262286wjb.110.1447416533810;
        Fri, 13 Nov 2015 04:08:53 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e189sm3698254wma.4.2015.11.13.04.08.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 04:08:53 -0800 (PST)
In-Reply-To: <5645BC55.70504@web.de>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281248>


> On 13 Nov 2015, at 11:32, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>=20
> On 2015-11-13 09.57, Eric Sunshine wrote:
>> On Fri, Nov 13, 2015 at 3:46 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>> On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com=
> wrote:
>>>> On 11/11/15 02:00, Stefan Beller wrote:
>>>>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshine=
co.com> wrote:
>>>>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>>>>> 02-11-2015) changed the type of some variables from long to off=
_t.
>>>>>>> The 32-bit build, which enables the large filesystem interface
>>>>>>> (_FILE_OFFSET_BITS =3D=3D 64), defines the off_t type as a 64-b=
it
>>>>>>> integer, whereas long is a 32-bit integer. This results in a co=
uple
>>>>>>> of printf format warnings.
>>>>>>=20
>>>>>> My machine is 64-bit, though, so perhaps it's misleading to
>>>>>> characterize this as a fix for 32-bit builds. In particular, off=
_t is
>>>>>> 'long long' on this machine, so it complains about the "long" fo=
rmat
>>>>>> specifier.
>>>>>=20
>>>>> I wonder if 32 bit compilation can be part of travis.
>>>>=20
>>>> Did this warning show up on the OS X build?
>>>=20
>>> Yes, I added CFLAGS=3D"-Werror=3Dformat" to the my experimental Tra=
visCI
>>> build and it breaks the build on OS X.
>>> See here (you need to scroll all the way down):
>>> https://travis-ci.org/larsxschneider/git/jobs/90899656
>>>=20
>>> BTW: I tried to set "-Werror" but then I got a bunch of macro redef=
ined errors like this:
>>> ./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werro=
r]
>>>=20
>>> Is this a known issue? Is this an issue at all?
>>=20
>> Odd. I don't experience anything like that on my Mac.
>=20
> Could it be, that strlcpy is present on your system ?
> And where does it come from ?
>=20
> Which OS ?
> Which compiler ?
> What does `uname -r` say ?
> Do you have Macports, Fink, Brew... installed ?
>=20

Looks like this is a OS X only issue. Happens with clang and gcc on the=
 OS X Mavericks TravisCI machines [1]:
https://travis-ci.org/larsxschneider/git/jobs/90919078
https://travis-ci.org/larsxschneider/git/jobs/90919080

On Linux+gcc the following error happens if "-Werror" is present:
https://travis-ci.org/larsxschneider/git/jobs/90919076
Do you have an idea what that might be?

Linux+clang works fine:
https://travis-ci.org/larsxschneider/git/jobs/90919074

- Lars

[1] http://docs.travis-ci.com/user/ci-environment/
