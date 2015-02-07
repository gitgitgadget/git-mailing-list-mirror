From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: read()  MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 07 Feb 2015 21:32:34 +0100
Message-ID: <54D67662.7040504@web.de>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <loom.20150207T182443-33@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 21:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKC3X-0007uQ-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 21:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750AbbBGUci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2015 15:32:38 -0500
Received: from mout.web.de ([212.227.15.3]:52999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115AbbBGUci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 15:32:38 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MQ8vL-1YFV5s2VRT-005FmE; Sat, 07 Feb 2015 21:32:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <loom.20150207T182443-33@post.gmane.org>
X-Provags-ID: V03:K0:eZrwZ3ytErOPwPDgt7L2IgHgTPqjjFdGUl5nLo8K/wGJCUFDaXy
 GMN2AWhU1VPOnuUvurFtImzs6faM9HvhayDPT6q/9otZpjXLCn2wExMvqR00cjcL4Xpau4/
 2XPQ8pp5qiQPksulpyXui2n/FAxxEjHXCyHjJOWv6wPnriqEaXE4RXSmkSz0RI9I/YLCamh
 nJRdG0Qe7Lw12G7WMBPdw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263455>

On 2015-02-07 18.29, Joachim Schmitz wrote:
> Torsten B=C3=B6gershausen <tboegi <at> web.de> writes:
>=20
>>
>> On 2015-02-07 17.45, Joachim Schmitz wrote:
> <snip>
>>
>> How about changing wrapper.c like this:
>>
>> #ifndef MAX_IO_SIZE
>>  #define MAX_IO_SIZE (8*1024*1024)
>> #endif
>> ---------------------
>> and to change config.mak.uname like this:
>>
>> ifeq ($(uname_S),NONSTOP_KERNEL)
>>
>> 	BASIC_CFLAGS +=3D -DMAX_IO_SIZE=3D(32*1024)
>> Does this work for you ?
>=20
> Of course it would, but,=20
> a) 32k is smaller than we can go (and yes, we could make it 52k)
Sorry, I missed that:  (52*1024)
> b) never ever should read() be asked to read more than SSIZE_MAX, thi=
s =20
> should be true for every platform on the planet? You may want to have=
 is=20
> smaller than SSIZE_MAX (like the current 8MB vs. the possible 2TB on=20
> Linux), but surely never larger?
>=20
Good question.
I don't know every platform of the planet well enough to be helpful her=
e,
especially the ones which don't follow all the specifications.

In other words: As long as we can not guarantee that SSIZE_MAX is defin=
ed,
(and is defined to somethong useful for xread()/xwrite() )
we should be more defensive here:

tweak only on platform where we know it is needed and we know that it w=
orks.

And leave the other ones alone, until someone finds another
platform which needs the same or another tweak and sends a tested patch=
=2E


Thanks for the report, do you want to send a patch to the list ?
