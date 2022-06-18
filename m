Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A3C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiFRLMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFRLMj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:12:39 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69222521
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655550736;
        bh=f/FUrnJkaKRDe3UjxEsI8lkBvs7weNXKJWIwy6IfQkI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fqi2tubAArFU1w6H/WvBhvyKU8AmDWa+N7TTFGbSOTBBBCRzcMUSw6gyXJdrcQ4eO
         Rk1gYqGfdhEra4yxaM1PURHFVxeUoMXOuYVg0n1B4JTtjaZ3KTa1qLUGp0VEQF0HLN
         u8hR/lKtYzyp62Ju4qEmbqcS/+VlXqwG+6nRsoBo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MadzU-1nRXjO1qJe-00cL0i; Sat, 18
 Jun 2022 13:12:16 +0200
Message-ID: <90d4611c-a8b1-dc15-a02a-8f5ba378d572@web.de>
Date:   Sat, 18 Jun 2022 13:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] diff: fix a segfault in >2 tree -I<regex> and
 --output=<file>
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
 <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 <xmqqleusqaff.fsf@gitster.g> <220524.86leurw3my.gmgdl@evledraar.gmail.com>
 <xmqqmtf6hgae.fsf@gitster.g> <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aHBRBAcVGLegC25SO6CJW9cbNhOjKETem2z6sAoHX66dQ48rRrm
 0+lUPejBZWahMZ+JEYWqBvnGz0BSEDaEZr8TypaMZ07O6yfpQ+W4glEaaPu5cNvAhQC+TOr
 t+jzxoGK4cy/zk2kgpw9CsJu72Rj/hKvDIctRVoWO29ZFIztB9W0m76qVdKEw/bUlhaNOQA
 ORa5ey7Ge3qcDnXR0RXeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gwev/mZwJJs=:R0Rg4xD3eFMn+0AucTZhA2
 B7ERSuu8p6yz5nb5G5s38+FKMuDRlznrbXgTrUnsS06LmPBgK0aXuxk+aoztVrhk76VNsupYQ
 iPpiIJ/LYOJkvs396Hb7NX5W8N47jsOZKR7VuHEqQRyPXjU16Shk5KPOZWJbcU2Mjq3iBJM4h
 U7A6gOwMaXE4pKGQGLIlC1sLyVg2dPjHyuucFkEzANBf7W9v5PhH+iWEbdr9NxfXm07bBj9AJ
 4y1fed1QtPfEs6H+yuIvNdXS7U/xKRPkYZn/XwcTdBRuYYyoXKzVNOQJWcSfGturK4A0SjFL0
 PR37s6BWOblti8PA9o6/bNPuRVDCIIyN9l8EBorI7RVSu/6yWFqq+ahCSLLMwtOUdRz2fgxMA
 stDaUShvR9DGTw9dlsDZfXYGi76QyHBBCW+uralv1p34pqbqAagY/60nsEqGWnU30c5fFJjhr
 VOUgd+WDA5r0gJkOsW2sB/wZ6qJMaB3qvJUmNhOx+GM952nnWu6Cxqs+QPRjkxBbcixWMvIKh
 ofM2Yn2DLIY2E697a//Qx4YIEuZGhq93U4VZdk6TeVAEx87QLo7f1lO+C6+R03r+HREkxpj+X
 mFmUaVja0JSabL3QWH1ZwsI50YzOux078wMULdXHDOHvQ2Jlq9Kl0ki/rXesbguTrcR/aJiTM
 GoyY41HbM2yPDeEe5rdsvZ8LjMjwVYrByYd5cBb/tR5W1cr91W4YeRw1IySV7AhaWvP7/jnX8
 K7JFEjcxNWFo363LZCJZmTR8gbA9VQPGyYmtgVh8u345v1WnBbWruRrXoO2xaoR/k3EY6M6ij
 gLs2gHGwbjOJulePObHOo7hOtQ1NrhXhr1lZzbnqpQ1DANbKSCrXZ1tH8b5yO3tQuwGOTnAQQ
 d5GM7Vb7taqrkRscEJ3JbXVorDccSv5A65etSkmtTn46GUKG/k6Rp/AH98/iCHLMdFNlqPHCh
 Ybu/Ox+Hd+2BITfEIu6aNnb6CZTJPsagrG1nxn7pWN/cRdi5lb1xTSgEFCEQBsJNQ/mayrRKv
 QPRFeAwgvDJgQ71TuZY4jPJIU4vvzk/uoLOaLo/CGbPuV/aKwZ0NHs+xpgUqMr4A8kUkmdnM3
 I1c6BAA+M75ldDjht0G3lb/3vQd0jFzEzkS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.22 um 22:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, May 24 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I.e. the "right" thing to do in this case would require a much more
>>> involved fix. We've somehow ended up not supporting --output=3D<file>,=
 -I
>>> and probably many other options in the combined-diff mode, which both =
in
>>> testing and in this part of the implementation seems to have become an
>>> afterthought.
>>
>> OK, a hopefully final question.
>>
>> How much less involved is it to add a new code (without doing
>> anything in this patch)
>
> ...yeah, I think for this one it makes sense to narrowly focus on the
> segfault...
>
>> to detect and die on the combination of
>> combined-diff with these two options, so that we can document the
>> fact that we do not support them?  It would give us much better way
>> forward than leaving the command silently ignore and give result
>> that is not in line with what was asked, wouldn't it?  That way, the
>> much more involved "fix" will turn into a change to add a missing
>> feature.
>
> I think not much, it's rather trivial for the case where we invoke "git
> diff", I.e. just adding something to the "builtin_diff_combined()"
> branch in builtin/diff.c to detect these two cases specifically.
>
> I haven't looked in any depth into how we might reach code in
> combine-diff.c through other means, and if any of it can set these two
> indirectly somewhere else (i.e. other things that take diff options).

So let's add those checks there.

> I also wonder if I'm just wrong in my assessment that it's a Bad Thing
> that we take some of these without ever doing anything with them in some
> modes, e.g.:
>
> 	git log --oneline -I foo
>
> This will never do anything with that "-I foo" by definition, but would
> as soon as you add -p, should we error without -p (or other diff-showing
> options).

Which definition?  The documentation says:

       -I<regex>, --ignore-matching-lines=3D<regex>
           Ignore changes whose all lines match <regex>. This option may b=
e specified more than once.

That sounds to me like it would affect history simplification, and thus
git log --oneline.  (Which seems expensive, but that's a different
concern.)  So based on that I'd expect at least a warning if -I is
ignored.

> The same goes for range-diff, format-patch, --remerge-diff and any
> number of other things where we take the full set of options, but only
> do something with a limited subset of them.
>
> It is helpful in some cases if we were more anal about it, e.g. when I
> was wondering why -I didn't do anything with the combined diff, but also
> handy for scripting and one-liners if you can tweak the command-line
> back & forth without it being so strict.
>
> So I don't know. Maybe I'm just trying to talk myself out of pulling on
> that (bound to be long) thread, but I'm coming more around to this just
> being a non-issue beyond the narrow and needed fix for diff_free() in
> particular.
>
> I.e. the more general approach of chasing down options that don't do
> anything for a given "diff mode". We might still want to error on some
> particular ones, such as -I with the combined diff (but not with
> --oneline, or whatever).

Supporting all combinations would be ideal.  Reporting unsupported
combinations would be the next best thing.  I wonder if we passed the
point of having so many options for e.g. git log that assessing all
of their pairings has become impractical, though. :-/

Ren=C3=A9
