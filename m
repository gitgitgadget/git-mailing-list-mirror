From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: htonll, ntohll
Date: Thu, 31 Oct 2013 14:24:21 +0100
Message-ID: <52725A05.1050805@web.de>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <527158AF.3070204@ramsay1.demon.co.uk> <52716C58.3090507@web.de> <5271750D.5010801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 14:24:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbsEi-0006Gr-B6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 14:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab3JaNYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Oct 2013 09:24:25 -0400
Received: from mout.web.de ([212.227.15.4]:55967 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3JaNYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 09:24:24 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MgfFr-1VGcML0f71-00NvVE for <git@vger.kernel.org>;
 Thu, 31 Oct 2013 14:24:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5271750D.5010801@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:761zJcvTuProxaiiSa69Oanj0jtmxxTN8fQGx5b39w0U/dbwA/p
 lwnihY0H1bVSdCCL7i6V0y9NLkIbtnqLwekObIOkO2bSKyt18WcNr2WobVH1ZxoTBNLqqcu
 Te5jWGX5QncC8+5NeMsnNeuoFTGnCy+ycPvdQow5RGU2jDkY2TKYFsW/9b853hJAYLL4X69
 MZFfsHRI0kFpoBY4KrFrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237124>

On 2013-10-30 22.07, Ramsay Jones wrote:
> On 30/10/13 20:30, Torsten B=C3=B6gershausen wrote:
>> On 2013-10-30 20.06, Ramsay Jones wrote:
>>> On 30/10/13 17:14, Torsten B=C3=B6gershausen wrote:
>>>> On 2013-10-30 18.01, Vicent Mart=C3=AD wrote:
>>>>> On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboeg=
i@web.de> wrote:
>>>>>> There is a name clash under cygwin 1.7 (1.5 is OK)
>>>>>> The following "first aid hot fix" works for me:
>>>>>> /Torsten
>>>>>
>>>>> If Cygwin declares its own bswap_64, wouldn't it be better to use=
 it
>>>>> instead of overwriting it with our own?
>>>> Yes,
>>>> this will be part of a longer patch.
>>>> I found that some systems have something like this:
>>>>
>>>> #define htobe64(x) bswap_64(x)
>>>> And bswap_64 is a function, so we can not detect it by "asking"
>>>> #ifdef bswap_64
>>>> ..
>>>> #endif
>>>>
>>>>
>>>> But we can use
>>>> #ifdef htobe64
>>>> ...
>>>> #endif
>>>> and this will be part of a bigger patch.
>>>>
>>>> And, in general, we should avoid to introduce functions which may =
have a
>>>> name clash.
>>>> Using the git_ prefix for function names is a good practice.
>>>> So in order to unbrake the compilation error under cygwin 17,
>>>> the "hotfix" can be used.
>>>
>>> heh, my patch (given below) took a different approach, but ....
>>>
>>> ATB,
>>> Ramsay Jones
>>>
>>> -- >8 --
>>> Subject: [PATCH] compat/bswap.h: Fix redefinition of bswap_64 error=
 on cygwin
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=3DUTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> Since commit 452e0f20 ("compat: add endianness helpers", 24-10-2013=
)
>>> the cygwin build has failed like so:
>>>
>>>     GIT_VERSION =3D 1.8.4.1.804.g1f3748b
>>>         * new build flags
>>>         CC credential-store.o
>>>     In file included from git-compat-util.h:305:0,
>>>                      from cache.h:4,
>>>                      from credential-store.c:1:
>>>     compat/bswap.h:67:24: error: redefinition of 'bswap_64'
>>>     In file included from /usr/include/endian.h:32:0,
>>>                      from /usr/include/cygwin/types.h:21,
>>>                      from /usr/include/sys/types.h:473,
>>>                      from /usr/include/sys/unistd.h:9,
>>>                      from /usr/include/unistd.h:4,
>>>                      from git-compat-util.h:98,
>>>                      from cache.h:4,
>>>                      from credential-store.c:1:
>>>     /usr/include/byteswap.h:31:1: note: previous definition of \
>>> 	=E2=80=98bswap_64=E2=80=99 was here
>>>     Makefile:1985: recipe for target 'credential-store.o' failed
>>>     make: *** [credential-store.o] Error 1
>>>
>>> Note that cygwin has a defintion of 'bswap_64' in the <byteswap.h>
>>> header file (which had already been included by git-compat-util.h).
>>> In order to suppress the error, ensure that the <byteswap.h> header
>>> is included, just like the __GNUC__/__GLIBC__ case, rather than
>>> attempting to define a fallback implementation.
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>>  compat/bswap.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/compat/bswap.h b/compat/bswap.h
>>> index ea1a9ed..b864abd 100644
>>> --- a/compat/bswap.h
>>> +++ b/compat/bswap.h
>>> @@ -61,7 +61,7 @@ static inline uint32_t git_bswap32(uint32_t x)
>>>  # define ntohll(n) (n)
>>>  # define htonll(n) (n)
>>>  #elif __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
>>> -#	if defined(__GNUC__) && defined(__GLIBC__)
>>> +#	if defined(__GNUC__) && (defined(__GLIBC__) || defined(__CYGWIN_=
_))
>>>  #		include <byteswap.h>
>>>  #	else /* GNUC & GLIBC */
>>>  static inline uint64_t bswap_64(uint64_t val)
>>>
>>
>> Nice, much better.
>>
>> And here comes a patch for a big endian machine.
>> I tryied to copy-paste a patch in my mail program,
>> not sure if this applies.
>>
>> -- >8 --
>> Subject: [PATCH] compat/bswap.h: htonll and ntohll for big endian
>>
>> Since commit 452e0f20 ("compat: add endianness helpers", 24-10-2013)
>> the build on a Linux/ppc gave a warning like this:
>>     CC ewah/ewah_io.o
>> ewah/ewah_io.c: In function =E2=80=98ewah_serialize_to=E2=80=99:
>> ewah/ewah_io.c:81: warning: implicit declaration of function =E2=80=98=
htonll=E2=80=99
>> ewah/ewah_io.c: In function =E2=80=98ewah_read_mmap=E2=80=99:
>> ewah/ewah_io.c:132: warning: implicit declaration of function =E2=80=
=98ntohll=E2=80=99
>>
>> Fix it by placing the #endif for "#ifdef bswap32" at the right place=
=2E
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>>  compat/bswap.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/compat/bswap.h b/compat/bswap.h
>> index ea1a9ed..b4ddab0
>> --- a/compat/bswap.h
>> +++ b/compat/bswap.h
>> @@ -46,6 +46,7 @@ static inline uint32_t git_bswap32(uint32_t x)
>>  #undef htonl
>>  #define ntohl(x) bswap32(x)
>>  #define htonl(x) bswap32(x)
>> +#endif
>> =20
>>  #ifndef __BYTE_ORDER
>>  #      if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(=
BIG_ENDIAN)
>> @@ -82,4 +83,3 @@ static inline uint64_t bswap_64(uint64_t val)
>>  #      error "Can't define htonll or ntohll!"
>>  #endif
>> =20
>> -#endif
>>
>> .
>>
>=20
> Yep, this was the first thing I did as well! ;-) (*late* last night)
>=20
> I haven't had time today to look into fixing up the msvc build
> (or a complete re-write), so I look forward to seeing your solution.
> (do you have msvc available? - or do you want me to look at fixing
> it? maybe in a day or two?)
>=20
> ATB,
> Ramsay Jones
Ramsay,
I don't have msvc, so feel free to go ahead, as much as you can.

I'll send a patch for the test code I have made, and put bswap.h on hol=
d for a week
(to be able to continue with t5601/connect.c)

/Torsten
