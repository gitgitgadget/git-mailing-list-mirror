From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 21:41:22 +0000
Message-ID: <5473A602.30505@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <20141124175947.GN6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6?= =?windows-1252?Q?gershausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1O3-0007rf-2v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbaKXVlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 16:41:31 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:34629 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750734AbaKXVla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:41:30 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 6566DAC40E4;
	Mon, 24 Nov 2014 21:41:29 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 1ED9AAC40BF;
	Mon, 24 Nov 2014 21:41:29 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Nov 2014 21:41:28 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141124175947.GN6527@google.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260152>

On 24/11/14 17:59, Jonathan Nieder wrote:
> Torsten B=F6gershausen wrote:
>=20
>> gcc under cygwin reports several warnings like this:
>>
>>  warning: implicit declaration of function 'memmem'
>>   [-Wimplicit-function-declaration]
>>
>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>>
>> Do not #define _XOPEN_SOURCE 600 for CYGWIN.
>>
>> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
>> ---
>> This may be a start for a patch, tested under CYGWIN-32,
>> both Windows7 and XP
>=20
> The "tested under" part would also be a good addition to the commit
> message.
>=20
>>  git-compat-util.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Patch looks good to me.  Do you know if this has been reported to the
> Cygwin maintainers?

As I said in an earlier email, I have searched the cygwin mailing list
(a few days ago now), but this issue had not been mentioned (modulo my
poor list searching fu!).

However, since I don't want to subscribe to (yet another) busy mailing
list, I won't be reporting this issue there. (If someone on this list
is already subscribed to that list, then ... ;-) ).

>                       The behavior seems counterintuitive --- I would
> expect _GNU_SOURCE to override everything else (since I thought that
> was the point of _GNU_SOURCE).

I had that impression too, but I need to read some more first.

Also, my theory about the cause of the problem has changed slightly
this evening, after booting up my old laptop and looking at an old
32-bit cygwin installation.

Rather than a change to '..../sys/cdefs.h' which changed the priority
of _XOPEN_SOURCE, it seems that it was the <string.h> header that
changed; those functions used to be declared unconditionally, whereas
the new headers have them within preprocessor conditionals.

ATB,
Ramsay Jones
