Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239EE3F00
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 18:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjILSHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbjILSHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 14:07:34 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24CE59
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694542027; x=1695146827; i=l.s.r@web.de;
 bh=dKbO/QPpxGEPt4Oxnkp0i6M6unHzNgChj26p4OqG+KQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Twn6aGCD2gz0ZpLwGx1DNAVNA+qGKcjC5WN9TZ8+TcWs3s4OMepjKzZGUxjeOdk8ceQGjad
 vmj8zTXMQTHJ+a+vxpmE4dBN9yVnRLStevMrbKytRZA5GXvojwsCJWalF9ghzpFK8mKIcuEvP
 KCMDToRtAQerTJkPu351qed4x78dmF0gcBIqw43NxZ2y0JGrdKlx4Rt/xHSI2jR70lDoGwBb2
 NY/As+L9AVgENlDKGE6ecWabvguJ3zoQeldbKs/Cc1QiyqgslL+9ryLXpHKpYp8V0tIJUsa46
 z62Y7pWjSQzd+yKjg0+n9/eGpc1lTxbEm2K8cvKk0qWlvtCkNxFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.145.34]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1qnHjF05fO-007VAC; Tue, 12
 Sep 2023 20:07:07 +0200
Message-ID: <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
Date:   Tue, 12 Sep 2023 20:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com> <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com> <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230912135124.GA11315@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O8u7yteQbz6jijhaOiQAZNoX3IdWx+2clMIPNgD3Gy41A0OKYqJ
 2me9i2sgHQMtiIdrXGMzoHk9/zVYn0wa+nsfM/E1gyeGVNJrNPGTv2cramFg+6wmdhZpQ8v
 ftUJkXTLwiofV68pnaLbYHe4JC9m7kU+49oRTdi3Xf2ED+qmCqFb5CUQyQpxzba59rmvkxy
 oeWTsrMyn9et+oI8VsJOA==
UI-OutboundReport: notjunk:1;M01:P0:M6e3RwETGTE=;CpD9dFCY/T52ZTEBeoJFRvPK0YW
 qTZrg1cnnefspvcEa55SssbTLgDvDD8zgsRIhlStSyHl1J9Fh8CHq0pL504gONWvAW8B9yJMj
 RXZfYmD9HlCqtOzK9i1cCn4LDJtBNK0kYjsWVGY2oK/H/oTkdn9/yn8r/yxm3VLYXs8YDYQOc
 WnYB93pTzaMBOGJo8QlassvlLAVBS/hI35YNCeVrN8LKIt5GdDM1m3h1xklqBL0NRYAAl41Wg
 Iy7oGbiOv2a8zYp8Rkqza0yUp1qUAm2g/9LXAxRUCHsqw5N/XcFB1iSvubwWnHYIvpHV4QxEe
 uOzFjtuH93iG7dYrgacfaJMBYeG95T0vKV6xCbiUUD3BaXMaeh+crqnLQjK0/8q0e4+OIn6O5
 AB24tH8fuzFXL6r/kMoL3hh/FbXYzUgFcyDX8gA6+FGQGmSH3Wnlz/ThSZUf5WpnyS97JGwRQ
 syzMUz3qfsMCx9eo2sAjNNEsOjcmJxfoxirUnR1lPflXfdAER739NF5mPdaZh4iNDEPnFw0yu
 2g3rs/sReaJIdP7eKAofqzOkydbjD8pEqQ9hFRKbudiBVJo0FzolwGblKeoncLFA7dV8DZFbk
 v/LXBg7untsfwx74uq7m2dZ92weyuEE2mixbaHbpm80PB6OjR3k7zlhFGR5PxWHw4xdnwZwLG
 NX/meW9ymvFrYOejAJ7BMyp+QXULlNKigy+ERF60tHj9wDf+8S99/k/+7EiPiTSpe1EUGd4AJ
 /CTDt4VBPsNbJgEyOlg5AE7MAmpsYYjX5Rmo7a5YQbNeB5e6H/9oOnRTgrpKgPAU1+nZ/gorD
 zlbjOsMliWXgXR0xqLGE74tQJ0v9xO6qPOc2IEsAzubpv9bqJTQv4gu4UpLlc9Zyrv+iKFK5I
 WtZgWHtm6xN/ijHp8jVlACS2eEviJ+xSllgQ4UBMAZ8yfYAKDFkVrXNTGZu+ISUSGf9rDpYyl
 zUDRjQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.09.23 um 15:51 schrieb Oleg Nesterov:
> On 09/12, Oleg Nesterov wrote:
>>
>> Ren=C3=A9, Junio,
>>
>> I don't like the fact we can't understand each other ;) Could you
>> please explain why do you think this patch should update the docs?

Good thinking!  And thank you for the examples and you patience!

>> Please forget about my patch for the moment. Lets start from the very
>> beginning:
>>
>> 	-p::
>> 	--show-function::
>> 		Show the preceding line that contains the function name of
>> 		the match, unless the matching line is a function name itself.
>>
>> and in my opinion, it is the current behaviour that doesn't match the
>> documentation.>>
>> -----------------------------------------------------------------------=
--
>>
>> 	$ cat TEST1.c
>> 	void func1()
>> 	{
>> 	}
>> 	void func2()
>> 	{
>> 	}
>>
>> 	$ git grep --untracked -pn func2 TEST1.c
>> 	TEST1.c=3D1=3Dvoid func1()
>> 	TEST1.c:4:void func2()
>>
>> in this case the matching line is "void func2()" and it is also a funct=
ion
>> name itself, in this case git-grep should not show "=3Dvoid func1()" wh=
ich is
>> "the preceding line that contains the function name of the match.

Makes sense.

>> But it does.

Drat! ;)

The option -p came from diff(1).  I thought diff change lines equivalent
to grep match lines and hunk headers to the new =3D lines.  What does diff
do with the example file?

   $ diff -U0 -p TEST1.c <(sed s/2/3/ TEST1.c)
   --- TEST1.c	2023-09-12 17:59:04
   +++ /dev/fd/11	2023-09-12 18:54:03
   @@ -4 +4 @@ void func1()
   -void func2()
   +void func3()

It shows func1 in the hunk header, i.e. the next function line before
the changed line.  So that is at least consistent between git grep and
the original -p.

The analogy breaks when it comes to how often a function line is shown:
hunk headers for multiple changes in the same function show the same
function line, but git grep doesn't repeat function lines.  I did that
on purpose, possibly because doesn't have an equivalent of hunk headers
and only allows selecting and showing a subset of the lines of a file.

Except it actually does have the -- lines for separating match contexts,
which are kind of similar.  That looks a bit weird currently:

   $ git grep --untracked -C1 -np func2 TEST1.c
   TEST1.c=3D1=3Dvoid func1()
   --
   TEST1.c-3-}
   TEST1.c:4:void func2()
   TEST1.c-5-{

The function line is separated from the match plus context, but you
could argue that they belong together.

>> So perhaps git-grep needs another change, something like
>>
>> 	if (match_funcname(opt, gs, bol, end_of_line(...)))
>> 		return;
>>
>> at the start of show_funcname_line(), but my patch does not change this
>> behaviour.

Yes, to make it match the documentation it would need something like
that.  (Though I'd add a match_funcname() call before the
show_funcname_line() call in grep_source_1() instead, as it already has
the eol value.)

>>
>> -----------------------------------------------------------------------=
---
>>
>> 	$ cat TEST2.c
>> 	void func(xxx)
>> 	{
>> 		use(xxx);
>> 	}
>>
>> 	$ git grep --untracked -pn xxx TEST2.c
>> 	TEST2.c:1:void func(xxx)
>> 	TEST2.c:3:      use(xxx)
>>
>> the 2nd match is use(xxx) and it is not a function name itself, in this
>> case git-grep should "Show the preceding line that contains the functio=
n
>> name of the match.
>>
>> But it doesn't.

The corresponding function line (line 1) is shown, as a match (with a
colon).  No function line is shown for the first match because it
doesn't have any, being the first line of the file.  So this matches the
documentation at least.

>> To me, this behaviour looks as
>>
>> 		Show the preceding line that contains the function name of
>> 		the match, unless the _PREVIOUS_ matching line is a function
>> 		name itself.

To me it looks like:

		Show the preceding line that contains the function name of
		the match.

("Show" meaning "show once", not "show for each match again and again".)

Or:

		Show the preceding line that contains the function name of
		the match, unless it is already shown for a different
		reason, e.g. as a match or as the function line of a
		previous match.

>> Now, with my patch we have
>>
>> 	$ ./git grep --untracked -pn xxx TEST2.c
>> 	TEST2.c:1:void func(xxx)
>> 	TEST2.c=3D1=3Dvoid func(xxx)
>> 	TEST2.c:3:      use(xxx);
>>
>> and unless I am totatlly confused this does match the documentation.
>
> So, just in case, please see V2 below. In my opinion it _fixes_ the
> current behaviour. With this patch
>
> 	$ ./git grep --untracked -pn func2 TEST1.c
> 	TEST1.c:4:void func2()

Indeed that matches the letter of the documentation.

> 	$ ./git grep --untracked -pn xxx TEST2.c
> 	TEST2.c:1:void func(xxx)
> 	TEST2.c=3D1=3Dvoid func(xxx)
> 	TEST2.c:3:      use(xxx);

That one as well.

> Or I am totally confused?

No, I think the documentation is wrong.  I'd simply remove the part
after the comma, but there are probably better options.

Ren=C3=A9
