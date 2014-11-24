From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 22:27:48 +0000
Message-ID: <5473B0E4.9090900@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:28:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt272-0003rL-CN
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbaKXW17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 17:27:59 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:59952 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750848AbaKXW16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:27:58 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 8C3521280E9;
	Mon, 24 Nov 2014 22:27:56 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 3AD051280BF;
	Mon, 24 Nov 2014 22:27:56 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Nov 2014 22:27:55 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54726A8C.4040600@ramsay1.demon.co.uk>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260160>

On 23/11/14 23:15, Ramsay Jones wrote:
> On 23/11/14 18:53, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
>>>> gcc under cygwin reports several warnings like this:
>>>>  warning: implicit declaration of function 'memmem'
>>>>   [-Wimplicit-function-declaration]
>>>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>>>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>>>
>>> Heh, thanks for looking into this. Your email came at a good time,
>>> since I was just about to boot my old laptop into windows XP to
>>> test my patch on 32-bit cygwin! (If I had not been watching the
>>> F1 Grand Prix on TV, I would already have done so! ;-) ).
>>>
>>> It's been a while since I updated my 32-bit cygwin installation
>>> (about 6 months) but I'm a little surprised you found this issue
>>> with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
>>> just to see what versions of software it is running).
>>
>> So you have an old installation to check how well the patched
>> version is accepted by the old set of header files?
>=20
> ... I can, indeed, use this old installation to test this on
> 32-bit cygwin. sigh, I thought I had dodged that bullet! ;-)
>=20
> [I can't do this tonight and I'm pretty busy tomorrow, so it
> may have to wait until tomorrow evening at the earliest. sorry
> about that. :( ]

OK, so I had a look tonight and, as I told Jonathan earlier, my
theory for the cause of the issue has changed slightly.

=46irst, I simply re-built git to make sure this issue wasn't present
(I would have been shocked if it was, but ...) and it was fine.
The master branch was at commit 7b69fcb (aka Git 2.1.0-rc1).
I applied my patch to this commit and re-built, again with no
problem. I then fetched the current version of git (i.e. commit
652e759 aka Git 2.2.0-rc3) and re-built; no problem. Finally, after
applying my patch to this commit, once again the build was free
from problems.

Note that I have not run any tests (it takes far too long), simply
a full build (make clean; make).

Some other things to note:

  $ uname -a
  CYGWIN_NT-5.1 toshiba 1.7.30(0.272/5/3) 2014-05-23 10:36 i686 Cygwin

  $ gcc --version
  gcc (GCC) 4.8.3
  Copyright (C) 2013 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There =
is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE.

  $ ls -l /cygdrive/c/Documents\ and\ Settings/ramsay/Downloads/http%3a=
     %2f%2fmirrors.kernel.org%2fsourceware%2fcygwin%2f/x86/release/gcc/=
gcc-core/
  total 38M
  -rwx------+ 1 ramsay None 13M Nov 10  2013 gcc-core-4.8.2-1.tar.xz*
  -rwx------+ 1 ramsay None 13M Dec 22  2013 gcc-core-4.8.2-2.tar.xz*
  -rw-r--r--  1 ramsay None 13M Jun  3 13:06 gcc-core-4.8.3-1.tar.xz
  $ # ie this is the first build of the compiler package for v4.8.3

  $ cygcheck -f /usr/include/string.h
  cygwin-1.7.30-1
  $ cygcheck -f /usr/include/sys/cdefs.h
  cygwin-1.7.30-1

  $ ls /usr/lib/gcc/i686-pc-cygwin/4.8.3/include-fixed/
  limits.h  README  syslimits.h

While on my (new) 64-bit installation:

  $ uname -a
  CYGWIN_NT-6.3 satellite 1.7.33-2(0.280/5/3) 2014-11-13 15:47 x86_64 C=
ygwin
  $ gcc --version
  gcc (GCC) 4.8.3
  Copyright (C) 2013 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There =
is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE.

  $ ls -l /cygdrive/c/Users/ramsay/Downloads/http%3a%2f%2fmirrors.kerne=
l.org%2fsourceware%2fcygwin%2f/x86_64/release/gcc/gcc-core/
  total 66M
  -rw-r--r-- 1 ramsay None 13M May 18  2014 gcc-core-4.8.2-3.tar.xz
  -rw-r--r-- 1 ramsay None 13M Jun  7 00:06 gcc-core-4.8.3-2.tar.xz
  -rw-r--r-- 1 ramsay None 14M Aug 30 22:48 gcc-core-4.8.3-3.tar.xz
  -rw-r--r-- 1 ramsay None 14M Nov 12 20:19 gcc-core-4.8.3-4.tar.xz
  -rw-r--r-- 1 ramsay None 14M Nov 20 13:07 gcc-core-4.8.3-5.tar.xz
  $ # ie this is the fifth build of the compiler package for v4.8.3

  $ cygcheck -f /usr/include/string.h
  cygwin-devel-1.7.33-1
  $ cygcheck -f /usr/include/sys/cdefs.h
  cygwin-devel-1.7.33-1
  $ cygcheck -f /usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include-fixed/sys/c=
defs.h
  gcc-core-4.8.3-5
  $=20

Although I have not done an actual diff of the various cdef.h files, th=
ey
do appear to be more or less the same. In other words, I no longer thin=
k
that the change results from a 'change in priority of _XOPEN_SOURCE'. T=
he
issue is simply that in the old <string.h> header these functions were
declared unconditionally; in the new headers the are contained within
preprocessor conditionals using the __GNU_VISIBLE and __BSD_VISIBLE mac=
ros
which are not set when _XOPEN_SOURCE is set (despite _GNU_SOURCE and
_BSD_SOURCE being set).

ATB,
Ramsay Jones
