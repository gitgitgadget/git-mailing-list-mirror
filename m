Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA3C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A3761009
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGTWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:22:47 -0400
Received: from mout.web.de ([212.227.15.14]:43607 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhFGTWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623093651;
        bh=AEls6oI/97unM9xmoqiqppDmaFjZaw31xFVtRp1l/8A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GCjscQOV/LPK4NFZ1uVJMUCyJ5FzlkQRrlli4omi0AZ4jW1QZfCT27wxsQeh3S6g4
         KwzPiIADtsc42sxWnHQCC9u+llSdT4FnHzwaIl8QfZTk2hHke6/kBKrR6ZPSe1OBrY
         4OCxGxAxQLEpvHhRY/p/2aX36HHKJJgSXkrd6TCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MZims-1m41wC38U2-00LVzq; Mon, 07 Jun 2021 21:20:50 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
Date:   Mon, 7 Jun 2021 21:20:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87k0n54qb6.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a3vgTyaAPjOxiNXziNRWv1sQzcICZ3nLB01X5B+9d+7mqhV8MB9
 9yP86rRsZNE4poAsidROfebUzwWKIE9WIXW8/+EUmc+4Ghg8moDq8S+OmnxnitenJz2zYOk
 QePfmexZjf6s7hG0B6bf+0AqLwi+iRAHp67DpmJ81l1LEgcIm7mrJa+BGaZZDXseYh0lJJZ
 3yT0Y+yiqkOh3CNb1Hb4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ur8oNZXPUVw=:AWlFAy4MIkaLEyK/rbn3S3
 +QTMU3Aeoax2HMtarpUbYcebmaYJT9/UFXKSGh7MnY0wDjLL42iEh/39zmQOK2hB+jcuQatby
 rm2uc/joPnVhB+DSEhPTsNkQn2AkQ6AN9v6rbiBvGdnX+j1eZ7GmFn/r3cOoDiyEuzeor1M2l
 hbe8LaKZvRSdxr7+J6qRAotDs7CPsTJmUPedv1M/WA/yNUZNh2C4pIyFJsR6pPwd5utsZ1nW5
 T/Nna+Vn1iuK2OrjM5ebnscGBlU1MIP4VMv3HahutXryh9jNkQHcCAwx9P1viKuR4BoiC9qDk
 E/nwruFGf+vU3MP7az5Z1uwD5vMsRxmRPgwMTnL1QdwkrBw7t4OYZIl/y40fVy6eIH8M42tgv
 4i1aB1naPG82Ejny3O7NZ8DZmP6XE4f4QFcY7a8zvllsbPkR5OoWH//ygqavgP2dzP7rdTeWF
 5emfYOgE3pr5MJ8nOBw5pgMhZD9KYHE2YtzSzqa5Ew0YReD4Owi/+9Pxoddm+UhdCPsl+39sk
 v0DcyJYuereoRuWYJKJF/Nqqu2sKu6cLM5+i415UOXHmckh7wjpCeIZdyXqMbrbRGwNRZP7dd
 qosgFOzAf8NhtiM0zAHuFNc4B5holtUKm2Oar4fWsblek0IhRRM96Lyz1J3QkXS7BNMk3IZN/
 YK2ZUUCDFNS0P4XcoCDy6VO3rwjvGLlcauXQAAkHNXEYFMSJhz10GAx/jh0IVE+dHtSRpOQkH
 qkXn9hvEAnSea4VAmKzlFzq9AF+gQ/D8yg8hkcxd+NPctXklA8ONpvLvLnrgDif+TWh8RoFNq
 Nr+7UM6mU7+OPxmndRH/ACwmlAwJ7to/Pnon8kUmlEy5dJdOCZ6FDgO24ICBjmuPDiVuT2pNy
 d5UX/Fuj4NppLLISi8Ddjnx9E1Me4WxdkdNiTSlfxjb7Z+nyTXsoN5y5LcnGmUrpwfxYXtdjW
 qRwP7RHvR9q7Ls9PlwTPjRiHyPGfcq1bhMeCqjKFY0u6vJ1pD/rNA/EWZFlXJvpQp0Q84uffs
 JucO9x1U36ri1cSP47yZN1sN8I5XENhFMKoWNaUg+Q2AzyIV5sYwXfNi/9qOyYboTqMePvtr/
 Mr9ECyLOsVOIbd/JhoZBlCr+X0Yr3pWu7+E
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.21 um 17:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jun 07 2021, Derrick Stolee wrote:
>
>> On 6/7/2021 10:43 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> Fix a potential incorrect display of the number of items (off by one)
>>> and stalling of the progress bar in refresh_index().
>>>
>>> The off-by-one error is minor, we should say we're processing the 1st
>>> item, not the 0th. This along with the next change also allows us to
>>> remove the last display_progress() call outside the loop, as we'll
>>> always have reached 100% now.
>>
>> This "pre-announce the progress" seems correct and is unlikely
>> to have a user sitting at "100%" while the loop is actually doing
>> work on that last cache entry.
>
> I guess pre-announce v.s. post-announce is a matter of some philosophy,
> for O(n) when can we be said to be doing work on n[0]? We entered the
> for-loop and are doing work on that istate->cache[i] item, so I'd like
> to think of it more as post-announce :)

Say you have a single item to process and it takes a minute.  The
original code shows 0% for a minute, then 100% at the end.  With your
change you'd get 100% for a minute.  Both would be annoying, but the
latter would have me raging.  "If you're done", I'd yell at the uncaring
machine, "what are you still doing!?".

Showing only the completed items makes sense.  That the next one is
being processed is self-understood.  Once all of them are done, 100% is
shown and the progress line is finished.

So I think this pattern works:

	for (i =3D 0; i < nr; i++) {
		display_progress(p, i);
		/* work work work */
	}
	display_progress(p, nr);

Alternatively, if the work part doesn't contain continue statements:

	for (i =3D 0; i < nr; i++) {
		/* work work work */
		display_progress(p, i + 1);
	}

> In any case, I'm changing this to the established pattern we use in most
> other places in the codebase, this one was an odd one out.

Consistency is a good thing, but perhaps some of these other places
should be changed.  It doesn't matter much because most items git deals
with are processed quickly, so an off-by-one error should barely be
noticeable, but still it would be nice to get it right.  It's hard to
test, though.

Ren=C3=A9
