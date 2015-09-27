From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 60/68] prefer memcpy to strcpy
Date: Sun, 27 Sep 2015 15:13:01 +0200
Message-ID: <5607EB5D.2050706@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210818.GE30946@sigill.intra.peff.net> <5607D0A9.4000506@web.de>
 <5607E9E4.4010209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 15:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgBlR-0006K0-U6
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 15:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbbI0NNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2015 09:13:07 -0400
Received: from mout.web.de ([212.227.15.3]:56484 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637AbbI0NNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 09:13:05 -0400
Received: from [192.168.178.36] ([79.253.148.147]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LvB6w-1aezZq0foY-010OCA; Sun, 27 Sep 2015 15:13:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <5607E9E4.4010209@web.de>
X-Provags-ID: V03:K0:04EdnVwmYBupMNksmzaA7HJ61/Ks8Y+GoGOVvSwokNya+EUI2GU
 LTC5Ymt2qpwCWakhnU9Wp52L0EzXjXLNTXtj4uQ5vSE03hpKmsNeie7PyF24V21uu+0J62C
 824AX+L1iKmfitJY8gVz7NgPWYsYnQEA8q1Q1l4j1PMVNC2Ikqp4k0LchGi3DlPJIx2py0l
 fYsZjMEFl+6pbFxumswww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IS+ani0HUPA=:PT0m4o1CGS4O2G61sSS5a8
 OWZFNZCEvjgr3dOGGluTlBbNFkfzgIiMWYHYAklcs+rxedeo6Pb19Y7BfaBKhNC0FQ6zyT0wG
 8wQZpuKANng5gNzgFDb8bJ5hw5V95Yn45Ehpv0QyRFw6CduJeK6obRNFOBcXjiTuQfwVkBWQT
 AHETk3/ipomKWwEpnQPg6VX8ySz0dQEzjzOoTzOngSyAYWaQux1CEBsUz1swTy7YXvrb+UkC+
 kBD5YHizem71B1aaS/iGetP3UBRgTCHGWO1VX9UmvFCgUNmmtImS69sqaBoig3tgDcO8fNut2
 V3nFJhMFGKj0ZSVQ3gQKtWl1fbYbasMGn+UVUF+5JIn4Iq5aQy5VY2FAVUJB9lOo+ekhn4tjz
 mogxjCP4GaTyd8R9SlCxXS+vQ9A1Wp7olo6mmxUwWxRcJFg7qpbf2Kj69MgdU3gKJ7Bdxslql
 zx9wwEP2mOtbsSsiBmpyBYhPewo7nBLCtX7HKGjVf/zN+8wegXueWnKHRTk0PqMhSqQrHGvTY
 W9h4nXyw22M/IOLhOIuly3obMSIeA7dl7utre8KuNUtnNQC3+TUPe7sFKQLYLAI7mE6CteLdE
 msRCrrUg/2jmhmVTt8VVgLcCREDJKXEPB+roLJ8yjm86x+2lOeHeQSdIT7fRtitzu+agmkq1n
 dxxbHD2+NegM4i3RQksMaABgF9o+nh3IbcWxeAspDhnnl/PV1g6olu8+c+vBjIQda3sYZYs5k
 I8UQrkokVdWDwuG/ZdOBROycbx6XP9cTtvzErg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278704>

Am 27.09.2015 um 15:06 schrieb Torsten B=C3=B6gershausen:
> On 2015-09-27 13.19, Ren=C3=A9 Scharfe wrote:
>> Am 24.09.2015 um 23:08 schrieb Jeff King:
>>> When we already know the length of a string (e.g., because
>>> we just malloc'd to fit it), it's nicer to use memcpy than
>>> strcpy, as it makes it more obvious that we are not going to
>>> overflow the buffer (because the size we pass matches the
>>> size in the allocation).
>>>
>>> This also eliminates calls to strcpy, which make auditing
>>> the code base harder.
>>>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>>    compat/nedmalloc/nedmalloc.c | 5 +++--
>>>    fast-import.c                | 5 +++--
>>>    revision.c                   | 2 +-
>>>    3 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmal=
loc.c
>>> index 609ebba..a0a16eb 100644
>>> --- a/compat/nedmalloc/nedmalloc.c
>>> +++ b/compat/nedmalloc/nedmalloc.c
>>> @@ -957,8 +957,9 @@ char *strdup(const char *s1)
>>>    {
>>>        char *s2 =3D 0;
>>>        if (s1) {
>>> -        s2 =3D malloc(strlen(s1) + 1);
>>> -        strcpy(s2, s1);
>>> +        size_t len =3D strlen(s1) + 1;
>>> +        s2 =3D malloc(len);
>>> +        memcpy(s2, s1, len);
>>
>> This leaves the last byte uninitialized; it was set to NUL by strcpy=
() before.
>
> len is =3D=3D strlen() +1, which should cover the NUL:
>
> 1 byte extra for NUL is allocated,
> and memcpy will copy NUL from source.
> (Or do I miss somethong ?)

No, you're right.  Sorry for the noise.

I fully blame this on lack of coffeine because my electric kettle just=20
broke. O_o

Ren=C3=A9
