Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1771CA0EC6
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbjIKVbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbjIKUMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:12:10 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5041A7
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694463110; x=1695067910; i=l.s.r@web.de;
 bh=BHPO0k22BVPGIoUkho29pNXAHMuKBf7tyL/cUp/MpNw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rHp0olK5bYEp1e7B6b/Q/Yxjz3aTgW5A+VknBx6uRyULLXAwhzHqqgvj9Aqh+6iRzu4ctlr
 PA0UsYGklzavc8Z5tLd2JYZKBOlibQKTIgr0LK4M6j8W62RW7u60FwckAS4eav5vHoaAyvcx5
 amSEfzniHuiGgK4E6gg7i3HUzoW3ewyl3dPlK7Bu1W/W0RK1n8hLlYofXH9JQGjnJh7lMxV6D
 29PbTfFrfheZKXff1ohrovdw3cvMvzcF0bEOVcmtToqKdN7aDkJpcG/6VxqF5wAS9yj9SfY5i
 ItIVRPw9oUnT9anANoB/1BNPEXEcEWmwcSoHFit0phJrGGj7UdSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.145.34]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1peJ1704Fr-011Gjt; Mon, 11
 Sep 2023 22:11:50 +0200
Message-ID: <e214eb9c-7576-f8f5-ef1d-3828affd47d8@web.de>
Date:   Mon, 11 Sep 2023 22:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
To:     Oleg Nesterov <oleg@redhat.com>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230911121211.GA17401@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gmsh7Mvh17ZeKQIkUNObMQrSRV4rQ8xfcQx4PNvvjyfVsxcYBpO
 yuA0wY5Grd3FiftawxyCP8U8urFyRFlPoBZQFB+jOXIYBPEAuPLGyFq/DhuCVTJ4YtuGOqM
 1gtqU9zPBIylG8/cdXXO4HuY7zzzHNfzehXLNZ7EIJwfon5sUns9mH8/SF/KBl2+ZedYIAu
 gamihAWsnsq0bLlqgzFzg==
UI-OutboundReport: notjunk:1;M01:P0:QS7N7fzr2z8=;PzrjZ0xBi+P6+BNeHi8ku5hYwTq
 vF4TBn0WK7Y3VuZv2dspx+Sbi5haRNpIH3fDyjR9Oms6kUiv5ATHa/6datb1iXvKbDVPMyrmn
 RK7WvzeUG+uN3PtmtUEvDvCpsyF7RgINsXGr9GVX+vQrAUd9lq9IrrtZ+oZ/FsaLk11YpJXRb
 BXqyR6NKJQLOLtaINMQXoWRvgrHktgHh/HE8VmxULLP21knQv1FUzKWMoFy7TKagtS22v/bNZ
 LoyDyv6xzsvAS6VzyztRc5es6bC4/bXNzAoRszOVBKakg3avVJujt90SxVp9C5kHab58gIpt+
 vAb3FkLGT7q8JzE6fLlqgFZU50FSDPWGJZjrPed6twrBoREX2xwjnDVf8ChjdApEminrr1Y86
 2IxdrZmMT6+z/OGwAlJVO6N1piINHlBH0rwCuOF55nOQs2r6ap6nUU223u15EhtkebpZjqcaB
 2arkpRcRh1Y5IYOWFmzrU7eL5zAhitSqozxmW5icYzuFlKrcsah/aiwCiFzJ737UQZ+NEmHFu
 F+cMAq4WxZ2PTB+xGGmarKcV1pJscXQeKJY9Bc8FNW08tTsnmFEkWvCSXPBT/RmCi8VKB+2W0
 ma5APPwE+CdMR9R82OgO/r9U1X0aEwqsF+olQQxqA2/KUhRyUFt6SkwsdwMCg1qh7VKw6ji/o
 iBbO0JDUoaYXL8YgB8KUIcRQ37o7eVxmezwg2lxm2ytzMG50PKMIAHtNxK+5P8OzwL5qrLNCG
 8ET3DJ9KpQj8HuB8VAVrLgEQcKzsZXk47wgAafLzWMQUPzWACG14Fr3bGZlrDTiZBMtqoZ0ux
 yIeJENd4Eqj3DALNnjBPv3Vw8IL/Hg+AwDbHCYQUklMaKiaLVPHybeP/K1DxVUc7WCY/cwh1e
 aRk8RbONep5iqaDs+gMwzRfB9Yd/eWWu5vxjnpg54TkgUm3raQSzmf90d/YGuDx7BV8APMzVi
 795Z8Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.23 um 14:12 schrieb Oleg Nesterov:
> show_funcname_line() returns when "lno <=3D opt->last_shown" and this
> is not right in that the ->last_shown line (which matched the pattern)
> can also have the actual function name we need to report.
>
> Change this code to check "lno < opt->last_shown". While at it, move
> this check up to avoid the unnecessary "find the previous bol" loop.
>
> Note that --lno can't underflow, lno=3D=3D0 is not possible in this loop=
.
>
> Simple test-case:
>
> 	$ cat TEST.c
> 	void func(void);
>
> 	void func1(xxx)
> 	{
> 		use1(xxx);
> 	}
>
> 	void func2(xxx)
> 	{
> 		use2(xxx);
> 	}
>
> 	$ git grep --untracked -pn xxx TEST.c
>
> before the patch:
>
> 	TEST.c=3D1=3Dvoid func(void);
> 	TEST.c:3:void func1(xxx)
> 	TEST.c:5:       use1(xxx);
> 	TEST.c:8:void func2(xxx)
> 	TEST.c:10:      use2(xxx);
>
> after the patch:
>
> 	TEST.c=3D1=3Dvoid func(void);
> 	TEST.c:3:void func1(xxx)
> 	TEST.c=3D3=3Dvoid func1(xxx)
> 	TEST.c:5:       use1(xxx);
> 	TEST.c:8:void func2(xxx)
> 	TEST.c=3D8=3Dvoid func2(xxx)
> 	TEST.c:10:      use2(xxx);
>
> which looks much better to me.

Interesting idea to treat function lines as annotations of matches
instead of as special context.  Showing lines twice feels wasteful, but
at least for -p it might be justifiable from that angle.  Wouldn't you
have to repeat function line 3 before the match in line 8, though?

The reason for not repeating a matched function line was that it
doesn't add much information under the assumption that it's easy to
identify function lines visually.  I assume this still holds, but
perhaps it doesn't for more complicated languages?

I have to admit that I almost never use --show-function, but instead
use the related --function-context a lot.  So my practical experience
with the former option is very limited.

>  grep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

The patch would need to update Documentation/git-grep.txt as well to
reflect the changed output.

Ren=C3=A9
