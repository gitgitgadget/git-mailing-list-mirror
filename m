From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Thu, 15 Nov 2012 19:17:00 +0000
Message-ID: <50A53FAC.8020401@ramsay1.demon.co.uk>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com> <50A2978D.6080805@ramsay1.demon.co.uk> <50A2B2DF.1080704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Douglas Mencken <dougmencken@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ51f-0006cP-JE
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768766Ab2KOTWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 14:22:39 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:39499 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768727Ab2KOTWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:22:38 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 82BBBA648C0;
	Thu, 15 Nov 2012 19:22:37 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id C105EA648C3;	Thu, 15 Nov 2012 19:22:36 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Thu, 15 Nov 2012 19:22:35 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <50A2B2DF.1080704@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209842>

Torsten B=C3=B6gershausen wrote:
> On 13.11.12 19:55, Ramsay Jones wrote:
>> Douglas Mencken wrote:
>>> *Any* git clone fails with:
>>>
>>> fatal: premature end of pack file, 106 bytes missing
>>> fatal: index-pack failed
>>>
>>> At first, I tried 1.8.0, and it failed. Then I tried to build 1.7.1=
0.5
>>> then, and it worked. Then I tried 1.7.12.2, but it fails the same w=
ay
>>> as 1.8.0.
>>> So I decided to git bisect.
>>>
>>> b8a2486f1524947f232f657e9f2ebf44e3e7a243 is the first bad commit
>>> ``index-pack: support multithreaded delta resolving''
>>
>> This looks like the same problem I had on cygwin, which lead to
>> commit c0f86547c ("index-pack: Disable threading on cygwin", 26-06-2=
012).
>>
>> I didn't notice which platform you are on, but maybe you also have a
>> thread-unsafe pread()? Could you try re-building git with the
>> NO_THREAD_SAFE_PREAD build variable set?
>>
>> HTH.
>>
>> ATB,
>> Ramsay Jones
>=20
> This is interesting.
> I had the same problem on a PowerPC=20
> (Old PowerBook G4 running Linux).
>=20
> Using NO_THREAD_SAFE_PREAD helped, thanks for the hint.
> (After recompiling without NO_THREAD_SAFE_PREAD I could clone
> from this machine again, so the problem is not really reproducable)

Yes, the failures would be intermittent (and often not easily
reproducible). The threaded index-pack code did not fail for
me on cygwin at all during development, including tests, but failed
immediately I installed v1.7.11. On real repositories, it failed
intermittently. On some repos it always failed, on some it never
failed and on some others it would sometimes fail, sometimes not.

ATB,
Ramsay Jones
