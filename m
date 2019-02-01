Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31461F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfBAQYi (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:24:38 -0500
Received: from mx-out1.startmail.com ([145.131.90.139]:42665 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBAQYi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:24:38 -0500
Subject: Re: Broken interactive rebase text after some UTF-8 characters
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1549038275;
        bh=xiMcrzhkq8W9rpH/xhOtQ/4TibD9KZHVN6+aB6PAxto=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KsP9ynJZibCweet/tNYxzGuvdjRQ6gY28rAZlfwumv5V3CXJJdr7HCO3h0gp2gM+C
         UJKvqeWNO5NvnS/sKbQZHqEox1nsX3AtrKXXxS4Lp4fHwZw5XFIbFI18grmwBci9Mt
         yEWFnT4cjbT2OWTufB4yIVZsNmRKZO3133Q0pEABbDy6IKKNeZSelq+QFDvGgktNsp
         Llw+gP45HCTK7n++G930g+95g8ALtM2ChUo43Q5gOuQSnEYRd8qVuCjAJBnVZ3krlB
         bw20dbthcLuD90mdavTgFkrBeXrBc7Z6/1JoVAbbGA3QF69Y6pgjGQOGFcrIVz+PKY
         sP+RqNlVnU8tQ==
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
 <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
 <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
 <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
 <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
 <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
 <nycvar.QRO.7.76.6.1902011530440.41@tvgsbejvaqbjf.bet>
From:   Michal Nowak <mnowak@startmail.com>
Message-ID: <eda7b1c4-5fd6-5440-8998-75eab9f73e47@startmail.com>
Date:   Fri, 1 Feb 2019 17:24:26 +0100
Mime-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902011530440.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01/19 03:33 PM, Johannes Schindelin wrote:
> Hi Michal,
> 
> On Fri, 1 Feb 2019, Michal Nowak wrote:
> 
>> On Friday, February 1, 2019 at 8:38 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> On Thu, 31 Jan 2019, Junio C Hamano wrote:
>>>
>>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>>
>>>>>> Are we misusing C formats?
>>>>>
>>>>> The C standard and POSIX both say that the * refers to the maximum
>>>>> number of bytes to print but it looks like it is being treated as the
>>>>> maximum number of characters on OpenIndiana.
>>>>>
>>>>> Johannes - Perhaps we should change it to use fwrite() unless
>>>> printf()
>>>>> gets fixed and we're sure no other operating systems are affected?
>>>>
>>>> Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
>>>> many other places in our codebase, if you can.
>>>
>>> Yes, this would be painful in particular in cases like
>>>
>>> 	master:advice.c:101:           fprintf(stderr, _("%shint: %.*s%s\n"),
>>>
>>> where we want to write more than just a variable-length buffer.
>>>
>>> I am curious: is libintl (gettext) used on OpenIndiana? I ask because
>>> AFAIR fprintf() is overridden in that case, and the bug might be a lot
>>> easier to fix if it is in libintl rather than in libc.
>>
>> here you can see the full output of the OpenIndiana git build: https://hipster.openindiana.org/logs/oi-userland/latest/git.publish.log.
>>
>>  From what I see there, libintl was found.
>>
>> If you believe this is illumos libc bug, it would be cool if someone created an simple testcase, which I can forward to the illumos developers.
> 
> You already have that example. Just take the UTF-8 text in your original
> bug report, put it into something like
> 
> 	int main(int argc, char **argv)
> 	{
> 		char utf8[] = "... your text here...";
> 
> 		printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
> 
> 		return 0;
> 	}
> 
> You should first verify, though, that this replicate the problem, and if
> it does not, use libintl (I think you have to `#include <gettext.h>` and
> `-lintl` or some such) and see whether that reproduces your problem.

Thank you, Johannes for the test case.

However, I don't see any problem with the output on OpenIndiana:

{global} newman@lenovo:~ $ cat printf.c
#include <stdio.h>
//#include <gettext.h>
int main(int argc, char **argv) {
   char utf8[] = "Gergő Mihály Doma\n";
   printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
   return 0;
}

{global} newman@lenovo:~ $ gcc printf.c -o printf && ./printf
Gergő Mihály Doma

Enabled the gettext header in the source file.

{global} newman@lenovo:~ $ gcc printf.c -o printf_intl -lintl 
-I/usr/share/gettext/ && ./printf_intl
Gergő Mihály Doma

{global} newman@lenovo:~ $ ldd printf printf_intl
printf:
         libc.so.1 =>     /lib/libc.so.1
         libm.so.2 =>     /lib/libm.so.2
printf_intl:
         libintl.so.1 =>  /lib/libintl.so.1
         libc.so.1 =>     /lib/libc.so.1
         libm.so.2 =>     /lib/libm.so.2

{global} newman@lenovo:~ $ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_ALL=


I even tried more arcane characters from 
https://www.w3.org/2001/06/utf-8-test/UTF-8-demo.html but they are 
displayed correctly as well.

Michal

> 
> Ciao,
> Johannes
> 
>>
>> Thanks,
>> Michal
>>
>>>
>>> Of course, it might *still* be a bug in libc by virtue of handing '%.*s'
>>> through to libc's implementation.
>>>
>>> Alban, can you test this with NO_GETTEXT?
>>>
>>> Thanks,
>>> Johannes
>>
