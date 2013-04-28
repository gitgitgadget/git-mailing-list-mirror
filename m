From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Sun, 28 Apr 2013 13:32:10 +0200
Message-ID: <517D08BA.6060508@web.de>
References: <517C1BF9.2050604@ramsay1.demon.co.uk> <517CBB6E.205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 28 13:32:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWPqA-00057E-Af
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 13:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab3D1LcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Apr 2013 07:32:18 -0400
Received: from mout.web.de ([212.227.15.3]:54036 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3D1LcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 07:32:16 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MRlJB-1U3ddT2oVl-00Te9Y; Sun, 28 Apr 2013 13:32:11
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517CBB6E.205@web.de>
X-Provags-ID: V02:K0:b34JDE+IBbkpQItt47FCaGFrKHv7Zmj+3xPyQTqKWKO
 wLSxPs2TfWvCuJbdTmFvo9csE71Qhl5TyPK5QIvFFMoA1FVMGU
 7r+tYWbggQ96bNMNO6o76+4SB/SFfDWAs0WzWsZQcVmsS2X9UE
 yx3j9phBs5Va4qDd4vCih9p61nDC5OPs/czwu678DkwI+exZQJ
 FvWtkN132mMv0AY9lNEFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222735>

On 2013-04-28 08.02, Torsten B=F6gershausen wrote:
> On 2013-04-27 20.42, Ramsay Jones wrote:
>>
>> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
>> it be static?" warning. The MinGW and MSVC builds do not see the
>> declaration of this function, within git-compat-util.h, due to it's
>> placement within an preprocessor conditional. (So, one solution woul=
d
>> be to simply move the declaration to the top level of the header.)
>>
>> In order to suppress the warning, since this symbol does not need
>> more than file visibility, we simply remove the declaration from
>> the header and add the static modifier to the function definition.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  git-compat-util.h | 1 -
>>  path.c            | 2 +-
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index e955bb5..3a990b3 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -163,7 +163,6 @@
>>  typedef long intptr_t;
>>  typedef unsigned long uintptr_t;
>>  #endif
>> -int get_st_mode_bits(const char *path, int *mode);
>>  #if defined(__CYGWIN__)
>>  #undef _XOPEN_SOURCE
>>  #include <grp.h>
>> diff --git a/path.c b/path.c
>> index 04ff148..cc2e9ac 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -11,7 +11,7 @@
>>   * may return wrong permission bits. Most of the time we do not car=
e,
>>   * but the callsites of this wrapper do care.
>>   */
>> -int get_st_mode_bits(const char *path, int *mode)
>> +static int get_st_mode_bits(const char *path, int *mode)
>>  {
>>  	struct stat st;
>>  	if (lstat(path, &st) < 0)
>>
> Sorry for breaking the MiNGW/MSVC builds.
> It seams that the get_st_mode_bits is badly placed.
>=20
> It should be in git compat-util.h, so that both compat/cygwin.c and p=
ath.c can see it.
> So from my understanding, it should be placed here:
> (I will send an official patch later)
> /Torsten
> =20
>=20
> diff -C 3 git-compat-util.h.~9526aa461f6c6900cb892a6fe248150ad436c0d~=
 git-compat-util.h.new
> *** git-compat-util.h.~9526aa461f6c6900cb892a6fe248150ad436c0d~ 2013-=
04-28 07:53:28.000000000 +0200
> --- git-compat-util.h.new       2013-04-28 07:53:58.000000000 +0200
> ***************
> *** 127,132 ****
> --- 127,133 ----
>   #else
>   #include <poll.h>
>   #endif
> + int get_st_mode_bits(const char *path, int *mode);
>   #if defined(__MINGW32__)
>   /* pull in Windows compatibility stuff */
>   #include "compat/mingw.h"
> ***************
> *** 163,169 ****
>   typedef long intptr_t;
>   typedef unsigned long uintptr_t;
>   #endif
> - int get_st_mode_bits(const char *path, int *mode);
>   #if defined(__CYGWIN__)
>   #undef _XOPEN_SOURCE
>   #include <grp.h>

I probably change my mind:
  Declaring get_st_mode_bits() static in path.c makes sense.

  And for cygwin we have the re-define in compat/cygwin.h:
  int cygwin_get_st_mode_bits(const char *path, int *mode);
  #define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))

So, (besides the typo found by Eric),
Thanks. Reviewed,and tested OK here. In short:

Acked-By: Torsten B=F6gershausen <tboegi@web.de>
