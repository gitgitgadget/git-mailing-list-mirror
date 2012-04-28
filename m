From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Sat, 28 Apr 2012 13:09:13 +0200
Message-ID: <4F9BCFD9.8020005@in.waw.pl>
References: <20120426223422.GC22261@camk.edu.pl>	<1335518725-19728-1-git-send-email-zbyszek@in.waw.pl> <xmqqaa1x9mdi.fsf@junio.mtv.corp.google.com> <4F9B1F38.8040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Lucian Poston <lucian.poston@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 19:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOXl9-0004L1-9E
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 19:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab2D2RSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Apr 2012 13:18:00 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35702 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2D2RR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 13:17:59 -0400
Received: from ip-37-209-130-26.free.aero2.net.pl ([37.209.130.26])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SOXky-0000Mf-Gm; Sun, 29 Apr 2012 19:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <4F9B1F38.8040406@gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196511>

On 04/28/2012 12:35 AM, Stefano Lattarini wrote:
> Hi Junio, Zbigniew.
>=20
> On 04/27/2012 06:21 PM, Junio C Hamano wrote:
>> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>>
>>> mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
>>> $COLUMNS is "always set, defaults to 80, unless the value as report=
ed
>>> by stty(1) is non-zero and sane enough". This applies also to setti=
ng
>>> it directly for one command:
>>>
>>> $ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
>>> 30
>>> $ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
>>> 20
>>> $ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
>>> 98
>>
>> I wonder if this is an easier workaround, though.
>>
>> 	env COLUMNS=3D10 $cmd
>>
> It works for me:
>=20
>   $ mksh -c 'COLUMNS=3D10 env | grep COLUMNS'
>   COLUMNS=3D113
>=20
>   $ mksh -c 'env COLUMNS=3D10 env | grep COLUMNS'
>   COLUMNS=3D10
>=20
>   $ dpkg -l mksh
>   ...
>   ii  mksh  40.2-2  MirBSD Korn Shell
>=20
> HTH,
>   Stefano
>=20
This approach with 'env COLUMNS=3D1 git ...' looks nicer, and works whe=
n
invoked directly, but doesn't work when run under the test harness,
because bin-wrappers/git uses !/bin/sh, which resets COLUMNS. So this
simpler approach doesn't look feasible.

Zbyszek
