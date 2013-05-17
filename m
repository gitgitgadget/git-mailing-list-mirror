From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 01:21:59 -0700
Message-ID: <CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 17 10:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdFvX-0008El-15
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab3EQIWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 04:22:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38167 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3EQIWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 04:22:00 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so3351753pab.17
        for <git@vger.kernel.org>; Fri, 17 May 2013 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=5gYulxU0AQ6t9VwKWJEfXpkf4VZQFyFpWE0EYqTsmeM=;
        b=Tot29mkzmWitIin/uos26OumVCN64fYwT23H71kyghVU1aMUL0IqJO5r0cfx2SglHo
         GON/8aol5/Zub32QKxQvpcIyN3e9grGXUHKa/eP7GvFBpol9uijJEyWTWRn3hG1VI2Wn
         ursJWxPm43t34SMUg8yo5Ad9UL4oD8BSvMnhBzzZTPVMo4zjdXxnoIqeRLKRy4Vieu09
         IBnImcIaJiUT7I75gWhi20FUih7W5Y2ZWwj2KRbSHy797jSziUpf/Ba+Dkr5qOz5hEoJ
         8Vt0Pf63pIPUx+Is5s6KNos065Ls3EPBb6o2DzT+dJnTLxNr4BWecBkVHfyB+JAjSUkr
         apIw==
X-Received: by 10.68.134.163 with SMTP id pl3mr47641515pbb.101.1368778919560;
 Fri, 17 May 2013 01:21:59 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Fri, 17 May 2013 01:21:59 -0700 (PDT)
In-Reply-To: <CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224657>

On Thu, May 16, 2013 at 11:18 PM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Wed, May 15, 2013 at 1:56 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 2013-05-15 09.11, David Aguilar wrote:
>>> +     ifndef NO_APPLE_COMMON_CRYPTO
>>> +             APPLE_COMMON_CRYPTO =3D YesPlease
>>> +     endif
>>>       NO_REGEX =3D YesPlease
>>>       PTHREAD_LIBS =3D
>>>  endif
>>> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>>>       LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
>>>       LIB_H +=3D ppc/sha1.h
>>>  else
>>> +ifdef APPLE_COMMON_CRYPTO
>>> +     BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
>>> +     SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
>>
>> Would it make sense to replace APPLE_COMMON_CRYPTO
>> with COMMON_DIGEST_FOR_OPENSSL ?
>>
>> In the spirit of other Makefile-defines becoming Compiler defines,
>> a random picked example:
>> ifdef NO_STRTOULL
>>         COMPAT_CFLAGS +=3D -DNO_STRTOULL
>> endif
>
> Not necessarily. Unlike NO_STRTOULL and cousins,
> COMMON_DIGEST_FOR_OPENSSL is not a Git build tweak; it is merely a
> (public) implementation detail of the Apple header [1] to magically
> associate OpenSSL digest functions with CommonCrypto counterparts.
> It's not the only such macro recognized by the Apple headers. For
> instance, COMMON_DIGEST_FOR_RFC_1321 magically associates legacy MD5
> digest functions with CommonCrypto counterparts.
>
> Further, as Junio noted elsewhere, David is using CommonCrypto for
> HMAC replacements, not just for digest replacements, so a Makefile
> knob with DIGEST in its name is not really appropriate. More
> generally, David would like to find CommonCrypto replacements for all
> the OpenSSL functionality, so a Makefile knob named after DIGEST is
> too specific.
>
> These considerations motivated the original suggestion for a single
> Git Makefile knob to enable/disable, as a unit, all CommonCrypto
> replacements. Such a knob would naturally have COMMON_CRYPTO as part
> of its name.
>
> [1]: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.plat=
form/Developer/SDKs/MacOSX10.8.sdk/usr/include/CommonCrypto/CommonDiges=
t.h

This is a nice justification for taking v5 of this series over v6.

Sorry for all the churn in this series, Junio.  I wrote v5 so I
certainly felt it was a good idea at the time, and I feel bad for not
having waited longer before sending out v6 (which is what was
eventually queued in "pu").

Do you have advice on how we should proceed?  :sigh: sorry for wasting
so much maintainer time on this series already.  If you need any
resends or anything please let me know.  This time I'll wait for a
strong opinion before firing off patches.

My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
we should have stopped painting.  Hindsight is 20/20.  Luckily it
never left "pu".
--
David
