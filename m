Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57979C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3946E613DF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFEPWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:22:53 -0400
Received: from mout.web.de ([217.72.192.78]:38003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhFEPWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622906459;
        bh=Ecj9C7fH7Sgg5XnFAWgfWluzTA5X+DKzSJJcOQWnoks=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SuCj18jjh5CiF45snpmNhMjHOJU85UJABwqsNnzra/YwqG1ZHPqeivE79+hnze+rv
         tZ3+boJR6RLuzb5N9HQzIfZRj95ZWx0wJkD8AjhfFbKEYi6/vyFbVuvHeAlWxy1J1Y
         iEZHFPtA3y+g0ysoI1EhWO/WJNJpJYBDzfDDSyrs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MrwwJ-1l3r1a1xif-00o2Y7; Sat, 05 Jun 2021 17:20:59 +0200
Subject: Re: [PATCH] parallel-checkout: use grep -c to count workers in tests
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <CAHd-oW7f0rfRaTyvJJMt7uNiLS4F9c=D3oKYc5v+unzxPPxjCw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a946daaa-6aa8-8527-5b55-ccf86de2a9d7@web.de>
Date:   Sat, 5 Jun 2021 17:20:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7f0rfRaTyvJJMt7uNiLS4F9c=D3oKYc5v+unzxPPxjCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AIAg/LSJOWDwX/BQw/THKwOxU1zRAz6aVW6NwzNOKlmellBKuQK
 fmE1Xml93/D7FN+UdmK53DnnlkTw7D8fHFRosp1F7JNmhCaQUjqQNHFFV3D2K2oluB6jogg
 4Pjba5hvOS3hfX7FrmNLdOVyrzYopPHteTZrotiVJTvRprIjrN3XH7lgCbvxaUPX6QCijuz
 qqO9Nf1IZcO64cl4v/Qfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rre9oo/QtB4=:ige9iqyY4HkmcZ+i9LLVIO
 XzqLjQYe76sSxFR0bxG9uao7TTNwgCiEtwY5L7WTvh07wNT1PoY6nWgkolIq9dj2qf4j33YxC
 gtqbib4gf5J+/whdevcLebk/OuDLA17rGB9bLk5eYIscyeMVNXRR8fUAIMd321HYkinTYQ72G
 d9sUhqAQTjLVQscQKV7Mw1IPSIhzlS8HXFxVCOiZepvVAHHf5AMhaWYKzLflJvmSVlurYBW97
 KSmupboJG33UJc7atTrkNSb/uRGHXVJ9BgZj6AomIVcvEFg/4LXmza/wQ2GHqDFkNUadGsgk+
 7G2+0r37TON2F0bjNKaK1OOw5J5ayRHlPzQdbyomG3dqMTcFAuHPWzWnku/5vE5YeUatlQOma
 eC0EbNtZljd8VDMl2XpTwq4b2QYsmEOa1M1OcDFXK08Zkf2JtBiqESonr1rNTJ2K+KixmPpRn
 5wSI5zUB+kd5aYrLd+7+pLrQwNThDtteOxhxmDGbch/KjJzihY9NUO6laxq9B6CSWLjKmXSS6
 WYq+LcO682yZJ6/qL98HEyS6u2UQESkv54N0cggZC3jee7+y62yaEF6bZOq1JwPw0AEZ4q1ci
 hikUaPFf7qAwVDanNTTIUrhkmiyiqqnYr36MAZdspzbLFuCWy+iZ1UMdEigf7INdEr+shtKYO
 xObukC/AUeo1ftTOx8ssUbgdp9kQWdXoEdO0CphO/xYbKmzUPlA4M5QG58I40fzKCBCDqEd/e
 s/VPXhh8ODxIjl2/UOemdxof9wpAq997rdaLGsw98hrwEbYo6YQqC7DvQ4/bfSFX72RSKGjYy
 IBcRp3pnXi2A6xnqfv70G51lIuWEPsvx8D/tv0rxFFOV+frhm3toKd3kftTGkH60tjDEb0fgI
 9HzRnlX4nwYl5zZpU1KFmLmPyedUYG7bfdNFHcEaeRLVRmVUtddf2XvshzB+COiPooCbd30sB
 uS6HJpyUfTfNpNeP5QYajQTyCopFSMUtSwWgpuW9nhNWRk+r/gLaKLiTRw2vODytfRna9Bs8X
 yanP7Adkp0SDR30oupxBw8Q9YxQWa/fvd9RjVYpcusx3GQ1/AXMbA5BhFPcXmhV00/jbiIiRj
 pDP7TOtNEGVS96MB/hQ8XXtL1utfFHZaSQJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.21 um 16:31 schrieb Matheus Tavares Bernardino:
> On Sat, Jun 5, 2021 at 9:27 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
>> reporting the following error:
>>
>>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
>
> That's interesting. It seems that dash is trying to use wc's output
> (in this case "0") as a local variable name which, of course, is not
> valid.
>
> This reply [1] to this bug report [2] mentions that dash expands a
> local assignment like the following:
>
>     x=3D"1 2 3"
>     local y=3D$x ---expands-to---> local y=3D1 2 3
>
> So, in this case, dash thinks we are trying to declare three local
> variables, y, 2, and 3, which is an error. In bash, the above commands
> would result in $y getting the value "1 2 3", even though we didn't
> quote $x in the assignment. (BTW, the reply mentions that quoting the
> right side of the assignment should make this work in dash as well.)
>
> I wonder if that's what's happening here. Maybe "wc -l" is outputting
> a space before the number, and that makes dash parse this line as
> something like `local workers=3D"" 0=3D"" `? If that's really the case (=
I
> can't confirm because the bug seems to have been fixed in the dash
> version I have), maybe we could mention that in the commit message.
>
> [1]: https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097/comments=
/6
> [2]: https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097

Ah, indeed:

   $ dash -c 'foo () { local bar=3D$(echo "1"); }; foo'

   $ dash -c 'foo () { local bar=3D$(echo " 1"); }; foo'
   dash: 1: local: 1: bad variable name

   $ wc -l </dev/null | tr ' ' s
   sssssss0

>>  t/lib-parallel-checkout.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
>> index 21f5759732..145276eb4c 100644
>> --- a/t/lib-parallel-checkout.sh
>> +++ b/t/lib-parallel-checkout.sh
>> @@ -27,7 +27,7 @@ test_checkout_workers () {
>>         rm -f "$trace_file" &&
>>         GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>>
>> -       local workers=3D$(grep "child_start\[..*\] git checkout--worker=
" "$trace_file" | wc -l) &&
>> +       local workers=3D$(grep -c "child_start\[..*\] git checkout--wor=
ker" <"$trace_file") &&
>
> Nice, and the result is both cleaner and more efficient :) Just one
> minor nit: I think we could drop the redirection as grep can take the
> file name as an argument.

I'm not sure if there's a grep out there that prints the filename before
the count even if it deals with a single file.  git grep does that, at
least.  POSIX[3] implies the lack of filename prefix for the single file
case, but I don't know if we can rely on that everywhere.

[3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

>
>>         test $workers -eq $expected_workers &&
>>         rm "$trace_file"
>>  } 8>&2 2>&4
>> --
>> 2.31.1
