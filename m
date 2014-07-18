From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Fri, 18 Jul 2014 21:14:05 +0200
Message-ID: <53C971FD.6040500@web.de>
References: <53C944B3.5080106@web.de> <20140718184246.GS12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Dbv-0008KE-2W
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbaGRTOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 15:14:22 -0400
Received: from mout.web.de ([212.227.15.14]:52653 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbaGRTOW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 15:14:22 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MTdS4-1WzJfv3JoG-00QWfY; Fri, 18 Jul 2014 21:14:19
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140718184246.GS12427@google.com>
X-Provags-ID: V03:K0:rUcF7EDcXPmAXVXWsb4LSiocGbzYnv6TwVgt+NQx5sSmqnV5Dfy
 D7TN+njQpINCy5vPx3EnJ4ir/bQLiyspK2jTX5aB7y3KiYPQLnGnSE4MXU+qunlMK+rFGjJ
 yYJbTZs6DMB6fgrV0w6TjynVkTymc57O/33b17t2wsheSdieg+3vlEKlvWx+AQ0svf/XpIZ
 nVE6WxcjmZigyvbIpDfNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253840>

Am 18.07.2014 20:42, schrieb Jonathan Nieder:
> Ren=E9 Scharfe wrote:
>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   fast-import.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Before:
>
>    $ size git-fast-import
>       text    data     bss     dec     hex filename
>     804138    6768  754160 1565066  17e18a git-fast-import
>
> After:
>
>    $ size git-fast-import
>       text    data     bss     dec     hex filename
>     804154    6768  754160 1565082  17e19a git-fast-import
>
> So this makes the text size worse on this machine (amd64, building
> with gcc 4.8.2 -O2).  That's probably because the old code does 'call
> memcmp', while the new code inlines it.  Inlining is presumably the
> better choice.
>
> More importantly, the new code is more readable.

Yes, the latter point is the important one.

If inlining is really better is another matter; I don't understand how=20
1a812f3a (hashcmp(): inline memcmp() by hand to optimize) could have=20
made git gc 18% faster, as it claimed.  I would expect memcmp(), which=20
can compare more than a byte at a time, to be significantly faster -- o=
r=20
at least just as fast as whatever the compiler does with the inlined=20
version.

Ren=E9
