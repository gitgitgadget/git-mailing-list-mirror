From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 22 Apr 2014 21:14:04 +0200
Message-ID: <5356BF7C.1010200@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com> <5349C314.50500@gmail.com> <53511617.80506@web.de> <535596D1.6070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 21:14:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcg9E-000158-4B
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbaDVTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:14:20 -0400
Received: from mout.web.de ([212.227.15.3]:57369 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbaDVTOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:14:15 -0400
Received: from [192.168.178.41] ([79.193.67.121]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M6Df8-1WrQmR3C38-00y5Il; Tue, 22 Apr 2014 21:14:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <535596D1.6070709@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:PRUIsP9IvfKBtKY98x9H0JyUSCyHRLH1AQUI8oNuLwaSABQavin
 tc9XY5Cz6xxE5y875p50/t5z8t7AXwGqbXoGpeB+K7RX0gDR6OyoCSLry1esLsPlj0aHjqO
 nP0q/hECU1l7/6h/fZwPJFM51pWz93Cj0trzb+qnr9FXOeoaiLYM2Em2t6lPrTdcaGNCmxk
 /TZk9RX63FuU9mkAlQrGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246772>

Am 22.04.2014 00:08, schrieb Ronald Weiss:
> On 18. 4. 2014 14:09, Jens Lehmann wrote:
>> Am 13.04.2014 00:49, schrieb Ronald Weiss:
>>> Allow ignoring submodules (or not) by command line switch, like diff
>>> and status do.
>>>
>>> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
>>> but didn't allow to override it from command line.
>>>
>>> This patch depends on Jens Lehmann's patch "commit -m: commit staged
>>> submodules regardless of ignore config". Without it,
>>> "commit -m --ignore-submodules" would not work and tests introduced
>>> here would fail.
>>
>> Apart from the flags of the test (see below) I get three failures when
>> running t7513. And I'm wondering why you are using "test_might_fail"
>> there, shouldn't we know exactly if a commit should succeed or not
>> and test exactly for that?
> 
> I used "test_might_fail" instead of "test_must_fail" to denote that this
> test doesn't care whether "git commit" fails or not due to empty commit
> message. I found it more appropriate. However, if you disagree, I can
> change it to "test_must_fail", no problem for me.

I'd rather have them fail because nothing is to be committed (and not
because the commit message is empty) and document we expect that to
happen by using test_must_fail (and that for example will catch a later
change which accidentally makes commit create empty commits here).

> Unfortunately I don't know why the test fails for you, they pass for me.
> Did you apply it on top of your own patch for "commit -m", which is
> a prerequisite?

Silly me, I forgot to do that (even though you explicitly mention
this dependency in the commit message). Sorry for the noise, all
tests run fine after rebasing your changes on top of mine.

> I tried it again, on top of current master (cc29195 [tag: v2.0.0-rc0]).
> First, I have applied your patch from here:
> 
> http://article.gmane.org/gmane.comp.version-control.git/245783
> 
> On top of that, I applied my two patches, and the tests pass fine here.
> Until now I was testing on Windows, but now I tested on a Linux box,
> and that makes no difference.
> 
