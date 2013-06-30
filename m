From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Sun, 30 Jun 2013 21:47:36 +0200
Message-ID: <51D08B58.8000103@web.de>
References: <201306271831.13865.tboegi@web.de> <7vvc4zsbbs.fsf@alter.siamese.dyndns.org> <51CCF91F.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:48:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtNbP-0002Wv-Um
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab3F3Trr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 15:47:47 -0400
Received: from mout.web.de ([212.227.17.11]:52328 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab3F3Trr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:47:47 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MhUfW-1UY0xH1950-00Me4A; Sun, 30 Jun 2013 21:47:38
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51CCF91F.7080501@gmail.com>
X-Provags-ID: V03:K0:qWPPVfmOfnQgv8R0wt3ci0uXG7XumJzjgqZVKebLn3/WqgKGwCp
 H04kpOgj5DG/LiLhO+3GSGYWQSAvaNRBBiS2a+zornDuBdNeF6HFWnfYeYwO1WHvJroWUMs
 ovycH6dl8fNOD58F2QL4H940eWJNKqUxvO62elabZ2KAHJHpCZd068sLNL8roWW48rREPQh
 jsP2OivJIMStwLpciwm3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229287>

On 2013-06-28 04.46, Mark Levedahl wrote:
> On 06/27/2013 01:38 PM, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> Work around issues that git hangs when doing fetch or pull under
>>> various protocols under CYGWIN.
>>>
>>> Replace pipe() with a socket connection using a TCP/IP.
>>> Introduce a new function socket_pipe() in compat/socket_pipe.c
>> Sounds like sweeping the real problem, whatever it is, under rug.
>> Is it that we are assuming a pipe buffer that is sufficiently large
>> and expecting a write that we deem to be small enough not to block,
>> causing a deadlock on a platform with very small pipe buffer, or
>> something?
>>
>
> There were issues in early v1.7 Cygwin release for overlapping I/O su=
ch that the pipe was sometimes terminated early resulting in data loss.=
 If the pipe implementation in Cygwin is still a problem a good test ca=
se sent to the Cygwin developers would be the right approach rather tha=
n a one-off patch in git to try to work around a current platform bug.
>
> Note - I do not see random hangs with the stat/lstat hack removed, ra=
ther the sole test suite hang I see is repeatable in t0008.sh. So, if t=
he patch remains, we may be able to run this remaining hang to ground.
>
> Mark
Thanks,
I testet "rj/cygwin-remove-cheating-lstat" with the "socket pipe" on to=
p:
no hanging.

Then I run "rj/cygwin-remove-cheating-lstat" without "socket pipe",
(or in other words git.git/pu):
No hanging.

Then I run a "stress test" with many (but not all) "git fetch" tests:
 t1507, t1514, t2015, t2024, t3200, t3409, t3600, t4041, t6050, t6200
repeat those tests in a forever loop.

All these test run 24 hours in a row on a single core machine, no hangi=
ng.
(I need to re-do the test on a dual-core machine)

So at the moment I don't have any problems to report for cygwin, which =
is good.

And it looks as if "rj/cygwin-remove-cheating-lstat" prevents the "hang=
ing",
so there is another +1 to keep it and move it into next.
/Torsten
