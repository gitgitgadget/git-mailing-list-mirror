From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Thu, 17 May 2012 09:11:53 +0200
Message-ID: <4FB4A4B9.3080009@lsrfire.ath.cx>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Thu May 17 09:12:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUusU-00007Q-LW
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 09:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761056Ab2EQHL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 03:11:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:60791 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760967Ab2EQHL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 03:11:56 -0400
Received: from [192.168.2.105] (p4FFD93A6.dip.t-dialin.net [79.253.147.166])
	by india601.server4you.de (Postfix) with ESMTPSA id 0CDD22F806F;
	Thu, 17 May 2012 09:11:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197912>

Am 17.05.2012 01:31, schrieb =C3=98yvind A. Holm:
> On Debian GNU/Linux 6.0.5 (squeeze), the two commits on the
> tr/xdiff-fast-hash branch introduces compiler warnings and breaks
> t/t0020-crlf.sh and maybe later tests:

What does the following short C program report when run (e.g. put it in=
=20
a file named s.c, then run "gcc -o s s.c" and "./s")?

   #include <stdio.h>
   int main(int argc, const char **argv) {
     printf("%u %u %u\n", sizeof(int), sizeof(long), sizeof(void *));
     return 0;
   }

I suspect you run a 32-bit userland on a 64-bit kernel.

On Ubuntu 12.04 x86, t0020 fails for me as well when I compile with=20
XDL_FAST_HASH explicitly set (it's off by default).  It succeeds after=20
reverting 6f1af02, though, strangely enough.  No compiler warnings are=20
printed in either case.

   $ gcc --version
   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

   $ uname -a
   Linux ubuntu 3.2.0-24-generic #37-Ubuntu SMP Wed Apr 25 08:43:52 UTC=
=20
2012 i686 i686 i386 GNU/Linux

Also, here are the measurements for master (v1.7.10.2-520-g6a4a482)=20
without XDL_FAST_HASH, and with master minus 6f1af02 plus explicitly se=
t=20
XDL_FAST_HASH:

   Test                                 master           reverted+FAST
   --------------------------------------------------------------------=
-
   4000.1: log -3000 (baseline)         0.08(0.05+0.02)  0.08(0.05+0.02=
)
   4000.2: log --raw -3000 (tree-only)  0.39(0.34+0.04)  0.39(0.32+0.06=
)
   4000.3: log -p -3000 (Myers)         1.55(1.43+0.11)  1.43(1.29+0.12=
)
   4000.4: log -p -3000 --histogram     1.63(1.51+0.10)  1.50(1.35+0.14=
)
   4000.5: log -p -3000 --patience      1.85(1.71+0.13)  1.73(1.62+0.10=
)

Ren=C3=A9
