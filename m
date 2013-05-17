From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 13:40:47 -0400
Message-ID: <CAPig+cSY=6abuqtayCvTjrUxBfMLQiZHqLKz26XR7kGTesdYUw@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOeE-0007FG-MF
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab3EQRku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 13:40:50 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:34334 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab3EQRkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 13:40:49 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so3316039lab.2
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GiSEEAngBvXZSsAC6Z/2FTxtMGE0cTzchWVqWdicUfk=;
        b=XWMdxeNBFrr7Pkvcp8MeBHBut5ZfWqPNoBPZfha4y69ij6UNqpsr8wCRnXqF5kCODB
         Xa0v4tnqYq30SeBy4ZLsISjiS/115VVO+QRLNJRmbq1BxRM90YpCUz7yfoLdzcH87wzy
         tXqto/U258hDw+TYDMIFR082VV4UDKCHUjyfHNeqClzrrJ5eFeRsl5jEDIS9SWyiz+xi
         IpidB2gFEiMohIbpjLp4l6UiKkQ1zHpf0OJIV1mhEs7Cp0vuVwO65Ji4Xka+R4H8JVyh
         npKWE4vFfhL14ag+X44zfvpuCvXijDnXSM9r4pfMJn8hpzuMu/xa5670F0065vKcEN+L
         Z7ng==
X-Received: by 10.152.121.105 with SMTP id lj9mr23399563lab.6.1368812447806;
 Fri, 17 May 2013 10:40:47 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 17 May 2013 10:40:47 -0700 (PDT)
In-Reply-To: <CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
X-Google-Sender-Auth: baXFEE4i4pAEoZh_QW_nMoQklnk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224720>

On Fri, May 17, 2013 at 4:21 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Thu, May 16, 2013 at 11:18 PM, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>> On Wed, May 15, 2013 at 1:56 PM, Torsten B=F6gershausen <tboegi@web.=
de> wrote:
>>> On 2013-05-15 09.11, David Aguilar wrote:
>>>> +     ifndef NO_APPLE_COMMON_CRYPTO
>>>> +             APPLE_COMMON_CRYPTO =3D YesPlease
>>>> +     endif
>>>>       NO_REGEX =3D YesPlease
>>>>       PTHREAD_LIBS =3D
>>>>  endif
>>>> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>>>>       LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
>>>>       LIB_H +=3D ppc/sha1.h
>>>>  else
>>>> +ifdef APPLE_COMMON_CRYPTO
>>>> +     BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
>>>> +     SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
>>>
>>> Would it make sense to replace APPLE_COMMON_CRYPTO
>>> with COMMON_DIGEST_FOR_OPENSSL ?
>>>
>>> In the spirit of other Makefile-defines becoming Compiler defines,
>>> a random picked example:
>>> ifdef NO_STRTOULL
>>>         COMPAT_CFLAGS +=3D -DNO_STRTOULL
>>> endif
>>
>> Not necessarily. Unlike NO_STRTOULL and cousins,
>> COMMON_DIGEST_FOR_OPENSSL is not a Git build tweak; it is merely a
>> (public) implementation detail of the Apple header [1] to magically
>> associate OpenSSL digest functions with CommonCrypto counterparts.
>> It's not the only such macro recognized by the Apple headers. For
>> instance, COMMON_DIGEST_FOR_RFC_1321 magically associates legacy MD5
>> digest functions with CommonCrypto counterparts.
>>
>> Further, as Junio noted elsewhere, David is using CommonCrypto for
>> HMAC replacements, not just for digest replacements, so a Makefile
>> knob with DIGEST in its name is not really appropriate. More
>> generally, David would like to find CommonCrypto replacements for al=
l
>> the OpenSSL functionality, so a Makefile knob named after DIGEST is
>> too specific.
>>
>> These considerations motivated the original suggestion for a single
>> Git Makefile knob to enable/disable, as a unit, all CommonCrypto
>> replacements. Such a knob would naturally have COMMON_CRYPTO as part
>> of its name.
>
> This is a nice justification for taking v5 of this series over v6.

You will consider this bike-shedding (I don't), but the above also is
good justification for revising your HMAC patch to _not_ rely on
COMMON_DIGEST_FOR_OPENSSL, which is an implementation detail of your
SHA patch, rather than a proper build knob.

Similar to NO_STRTOULL and cousins, you should have a #define (such as
NO_APPLE_COMMON_CRYPTO or NO_COMMON_CRYPTO) which is consulted by your
HMAC patch and any future patches you submit to map CommonCrypto
counterparts to OpenSSL functions. The fact that you also must #define
COMMON_DIGEST_FOR_OPENSSL for the SHA patch is just an implementation
detail of that one patch; it is not relevant to the other patches.

-- ES
