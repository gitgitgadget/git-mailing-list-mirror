Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F1C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190C964DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBOVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:19:54 -0500
Received: from mout.web.de ([212.227.15.3]:60401 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBOVTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613423868;
        bh=MmIYPNgEDz5wd1CaiwrgXPeuB8p8oXMj/yZkZ870/Q8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Xl5BnzLqWnNAEyZSDVifmtzHeZxpQejoFhe4ROSUMy4Vp2/vnK8vJhTzF6VkFlLwL
         Rum8cpyTZPASpnX9wz1l24W/3bYlt65R//9RypSb7XkNDabvYlZ+x7aTNLxIugc4o7
         rzQPUrRmFyk+FKlTkBMR3OblVWivO3pfUNsp7GC0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lc8aj-1ldMII44e5-00jdKc; Mon, 15 Feb 2021 22:17:48 +0100
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210215155020.2804-2-avarab@gmail.com>
 <d02c99b8-ae26-9804-480c-eae880f4a6cb@web.de>
 <87im6tb0ca.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <6ccba73c-ea51-7842-8cc3-d96fd71c0efc@web.de>
Date:   Mon, 15 Feb 2021 22:17:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87im6tb0ca.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PQDcBUaxfkGPWQqywUcrCirBmOj0GJm7S9F3gHQczZbGbDmrpY7
 LfHC3zEUM91XHG4Sx6GD4N9A1/FLrqSGok8Hw4ozD2iF/yeuRsgIMuTu6J7TzRzjfnnGrGL
 dRYYUzne27uHLdBwpHL5MdYYJTqIZAJUVvUlkQcOiNO+bowNhVDFd4i1BqiWb0EB1GXHLfI
 HP9HpYdJoxSUsfWZ3Ue7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2svZG6ABMc=:HhavitN1nLk/V5n5fRFC9x
 Gu7eA5b9FaowcLxHmmYUvPWQNQ4VT/dSzArm8W5DUwRGRy7pFGWd43uj6LTUKH+s29tdFu86w
 sGv4qfPS389FXYFGLdCucoO8A0DHK46XWn69FrhrHk4Uktx12Q7asOmvGUBRTi/EQUznOawR3
 hsJ3Jo7gTfCP5H/9sonQafNDLEpKraqnSup6vfvBBe1nAHoMiI9b3zHz/RtL7j9to1IUQ0qH3
 nJ5Ei8/4MpOmkfRgiv7srI/bYnGCHdC7L50wWHykKsHLfCGFGkOAITURJHuljV94j0dp98QmA
 pv66bCmTI/kUd+xvEETKn62ZYEl2YbMsIH7biVs30rbPHQvmrBg43dovbyc/Tul3Y1KIAIpmC
 rh3MSlLPWq5wdYRaQXJjBqBVuznZro53j/J8cBvpxmhJwgll1srkzjeOlyeGXFyIbEg7TD9rT
 ZYeqmI5XWhYIGQP2fLgLf/AGaMigzYZxuMcEQbUM0lkUBsSYqcAGOqPSc7nROVrNohn6c8IYj
 f8zVQlak0dqLqLF/89BfbBe3p1mnSfkuprtCFdyW7A0bgq9oIWnX8ZE9raL+CIF2CeFogO38o
 LS4mRitc/Fp4r7Yl4bcMzgSELOSnunXURpDqzzP+6/1PMw3BBvc7wMR38TjFYcEn6s1WCk2Ru
 aKe/v+2wYM0c3lurpLohZ/I1jDJ4VBvKMMeSGI2EvjPgglHcy4PxVtgvwp+oGTJiyAybEx/14
 JOQnPd+vG41Jaq+VPLWxdJ1WryvidVlOF3A/jUFNiKT0LJvVbNAiZFZ/JIu5iOdqDiCMLZVNY
 rYY0siZJ1X/IEXhlLbBHSUdFJ1PVeqdLnnmNRe0/97CJ74AuNBrzLz0nB2WUL2x6WStm+cmFG
 r7KKJ/rW+ck0Yl3KZM9w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 20:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Feb 15 2021, Ren=C3=A9 Scharfe. wrote:
>
>> Your reasoning applies to patches generated without -W as well.  If the
>> precontext contains a function line then the @@ line should not contain
>> a function comment.  However, e.g. with this:
>>
>> -- snip --
>> cat >a <<EOF
>> func a
>>
>> func b
>> 1
>> 2
>> 3
>> EOF
>> sed 's/3/three/' <a >b
>> diff -up a b
>> -- snap --
>>
>> ... I get this:
>>
>> --- a	2021-02-15 18:30:21.000000000 +0100
>> +++ b	2021-02-15 18:30:21.000000000 +0100
>> @@ -3,4 +3,4 @@ func a
>>  func b
>>  1
>>  2
>> -3
>> +three
>>
>> So diff(1) shows the previous function line.  git diff does the same.
>>
>> The behaviour of diff(1) and git diff does make sense to me: It's easy
>> to implement and the only downside is that it produces extra output in
>> some cases.
>>
>> I can understand that users would rather have a tidy diff without
>> distractions, though.  So I like the output change you propose.
>
> Does GNU diff have something like git's -W, both "diff -U 0 -F func a b"
> and "diff -U 0 -p a b" don't extend the context window as we do.

Exactly my point: GNU diff doesn't have something like -W, but still can
show an unchanged function at the @@ line, because it searches upwards
starting just above the first shown line, and the name of the actually
changed function might be in one of the shown lines.

> I don't think the patch I'm submitting here would make sense for GNU
> diff, since there it just shows the context without being guaranteed to
> show the full set of lines leading up to it under -W, but with Git diff
> we do that, so I think it makes sense to omit the context.

Given the goal to show the name of the changed function it *would* make
sense to start searching at the first changed line instead.

>> However, I'm not sure it would be a good idea to clear @@ lines of hunk=
s
>> generated without -W that have function lines in their precontext, even
>> though it would be a logical thing to do.
>
> Yes, I don't think that's a good idea either. I think it only makes
> sense under -W where the user explicitly asks "show me the function this
> change was in", and we're (before this patch) showing different context
> on the basis of emergent behavior.

Right, -W never needs diff(1)'s -p, while the case is less clear for
diffs generated without -W.

Ren=C3=A9
