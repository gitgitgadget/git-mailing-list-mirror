From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: [PATCH v3] wildmatch: properly fold case everywhere
Date: Wed, 29 May 2013 19:57:44 +0200
Message-ID: <BAB62C57-FE7D-476A-ACA7-5831BAF3E558@gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com> <1369749497-55610-1-git-send-email-n.oxyde@gmail.com> <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com> <4E816EBA-A22D-4507-BED0-0DE55D2E619C@gmail.com> <CACsJy8A61nYu9a-BhUiBhBEv-e6_CtYyZE3sG9iCiau+3EKVdw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkdF-0006Jx-IP
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876Ab3E2R5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 13:57:50 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:63256 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934981Ab3E2R5s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 13:57:48 -0400
Received: by mail-we0-f177.google.com with SMTP id n57so6589884wev.22
        for <git@vger.kernel.org>; Wed, 29 May 2013 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=djq1Vk19N/ZisKUa4JbM9eWqJN9RX1XrdzF2jpSXAuE=;
        b=AIAM8rgEoFlvK/hYCuwBO9/o1j1fpOWEsdH+ZocOdnfYvOW9FLMnfdN7AMDmKcBEDI
         SFK67Z46fi/HM0TlVCHvdFm2XOxYTvsFjvO+zRJH3C1/niUu/qKArmgzUdEP9UwiLGkd
         rt6QFMpFeVxh1ZahHpofuiBGlMsriIS36dfDPCSdV4CIYULmeFdx+C9AcaGU/KEotCF/
         YVbFtUPx0wmezUw0tE9W/IF4xxxFXqyZG1Jsj5dxAaWaEvDs2y+O2fVVDMJi7wlnmQE2
         6m47+gKGMwYejQDVyUWHSNkOgom0Rp6lDIC/kqXS7UnGQNTjrjF8ah+nXh04FeyItJFl
         NbYA==
X-Received: by 10.180.90.43 with SMTP id bt11mr2025467wib.30.1369850267437;
        Wed, 29 May 2013 10:57:47 -0700 (PDT)
Received: from [192.168.1.44] (vol75-16-88-182-187-128.fbx.proxad.net. [88.182.187.128])
        by mx.google.com with ESMTPSA id en3sm32830520wid.1.2013.05.29.10.57.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 10:57:46 -0700 (PDT)
In-Reply-To: <CACsJy8A61nYu9a-BhUiBhBEv-e6_CtYyZE3sG9iCiau+3EKVdw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225855>

Replied inline.

--=20
Anthony Ramine

Le 29 mai 2013 =E0 15:52, Duy Nguyen a =E9crit :

> On Wed, May 29, 2013 at 8:37 PM, Anthony Ramine <n.oxyde@gmail.com> w=
rote:
>> Le 29 mai 2013 =E0 15:22, Duy Nguyen a =E9crit :
>>=20
>>> On Tue, May 28, 2013 at 8:58 PM, Anthony Ramine <n.oxyde@gmail.com>=
 wrote:
>>>> Case folding is not done correctly when matching against the [:upp=
er:]
>>>> character class and uppercased character ranges (e.g. A-Z).
>>>> Specifically, an uppercase letter fails to match against any of th=
em
>>>> when case folding is requested because plain characters in the pat=
tern
>>>> and the whole string and preemptively lowercased to handle the bas=
e case
>>>> fast.
>>>=20
>>> I did a little test with glibc fnmatch and also checked the source
>>> code. I don't think 'a' matches [:upper:]. So I'm not sure if that'=
s a
>>> correct behavior or a bug in glibc. The spec is not clear (I think)=
 on
>>> this. I guess we should just assume that 'a' should match '[:upper:=
]'?
>>=20
>> I don't know, in my opinion if case folding is enabled we should say=
 [:upper:], [:lower:] and [:alpha:] are equivalent.
>>=20
>> This opinion is shared by GNU Flex [1]:
>>=20
>>>      =95 If your scanner is case-insensitive (the =91-i=92 flag), t=
hen =91[:upper:]=92 and =91[:lower:]=92 are equivalent to =91[:alpha:]=92=
=2E
>>=20
>> [1] http://flex.sourceforge.net/manual/Patterns.html
>=20
> Then we should do it too because of this precedent, I think.
>=20
>>>> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar=
 *text, unsigned int flags)
>>>>                                       }
>>>>                                       if (t_ch <=3D p_ch && t_ch >=
=3D prev_ch)
>>>>                                               matched =3D 1;
>>>> +                                       else if ((flags & WM_CASEF=
OLD) && ISLOWER(t_ch)) {
>>>> +                                               uchar t_ch_upper =3D=
 toupper(t_ch);
>>>> +                                               if (t_ch_upper <=3D=
 p_ch && t_ch_upper >=3D prev_ch)
>>>> +                                                       matched =3D=
 1;
>>>> +                                       }
>>>=20
>>> Or we could stick with to tolower. Something like this
>>>=20
>>> if ((t_ch <=3D p_ch && t_ch >=3D prev_ch) ||
>>>  ((flags & WM_CASEFOLD) &&
>>>     t_ch <=3D tolower(p_ch) && t_ch >=3D tolower(prev_ch)))
>>>  match =3D 1;
>>>=20
>>> I think it's easier to read if we either downcase all, or upcase al=
l, not both.
>>=20
>> If the range to match against is [A-_], it will become [a-_] which i=
s an empty range, ord('a') > ord('_'). I think it is simpler to reuse t=
oupper() after the fact as I did.
>>=20
>> Anyway maybe I should add a test for that corner case?
>=20
> Yeah I was thinking about such a case, but I saw glibc do it... I
> guess we just found another bug, at least in compat/fnmatch.c. Yes a
> test for it would be great, in case I change my mind 2 years from now
> and decide to turn it the other way ;)

Should I patch compat/fnmatch.c too? That would make it different from =
the glibc's one.

>>=20
>>>>                                       p_ch =3D 0; /* This makes "p=
rev_ch" get set to 0. */
>>>>                               } else if (p_ch =3D=3D '[' && p[1] =3D=
=3D ':') {
>>>>                                       const uchar *s;
>>>> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar =
*text, unsigned int flags)
>>>>                                       } else if (CC_EQ(s,i, "upper=
")) {
>>>>                                               if (ISUPPER(t_ch))
>>>>                                                       matched =3D =
1;
>>>> +                                               else if ((flags & =
WM_CASEFOLD) && ISLOWER(t_ch))
>>>> +                                                       matched =3D=
 1;
>>>>                                       } else if (CC_EQ(s,i, "xdigi=
t")) {
>>>>                                               if (ISXDIGIT(t_ch))
>>>>                                                       matched =3D =
1;
>>>=20
>>> If WM_CASEFOLD is set, maybe isalpha(t_ch) is enough then?
>>=20
>> Yes isalpha() is enought but I wanted to keep the two cases separate=
d, I can amend that if you want.
>=20
> Either way is fine. I don't think this code is performance critical. =
Your call.
> --
> Duy
