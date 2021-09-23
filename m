Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A40C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F016961090
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbhIWVD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWVDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:03:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BCC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 14:02:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ee50so27879891edb.13
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NSfQNJwLwGn90LruuCtfWJL/HSdtOvluZyfEQlPBGKg=;
        b=bo4IiSEaTEBnEAosmHfuAB6Fft6YjAGuIjA+DUvkWvX0cv4O2RN/ku7eTXW5/zrg09
         Zc6xzULMUdv7W2ZQ8up7qUbauOPIINTiOWVuu6A8V5mGjGu6D6EeKVGTpQLPH/5LvEJd
         Za6hvlqkC72gu7UVMnsdbt2xhfeVcWGQqkWzgJOYWo5U6NOqvJ9q0XBb2R4bKMNLDJtV
         fY/zMES6wVgW67IiKo6khLrWhW7CnkmPhSLsujvyUMMKeGOx2M+DFeSeOwJhg/2s+h21
         nHMUkFr/H4B0AoKWVrLGU5ulNBTuj+bTEV50B7dVFaiifoD0KvRi36CSKnJQXCaCY1KR
         ChVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NSfQNJwLwGn90LruuCtfWJL/HSdtOvluZyfEQlPBGKg=;
        b=J1OH0Ts006ddYe+q8tAd+NI8szjU+c5/ObAUdEeTaXB7Gtgqaa1oizFJOqP5AogZ61
         EGyyh0dDHiyFdioSIfQenrwacKvYkpiCoqP4vSV9J3hn6pUZi0gQQwnDqZMTTnADMQpF
         SEkHZGBhJGyef7m7YTKF7MtWkkJz42p12SQGPN2PqlQ5DKTFanBqwQrpTZXLP+jh/86g
         N7fYvYhpBnb/FE3fkUrPYSJNZ0cTgTSrgNeLbugPS2tWhoO6e31VekCSsRcmuEs4DJI+
         FjBR/JfAoYwa2Z1LoIIVOHU09iLvCN+K4djPKGv1UqMD4La4EKf1rtO5M5RCvGbXGszA
         ZxVg==
X-Gm-Message-State: AOAM531c6TgYDkI3xKPQM0sozWgtLUt7iZdn8PRGlDL9QCz8EMSkc4YI
        DRR8XVmrI49HzKnX+QCh+o4kmeiKLOwVWA==
X-Google-Smtp-Source: ABdhPJw1Lwq0G+Etxo55Nq01iTYprRaD24o5F4A43NFKZWT6rq9U0MZjpdCDioIPOCAg5tjMBsp0aQ==
X-Received: by 2002:a50:e081:: with SMTP id f1mr1073184edl.65.1632430939147;
        Thu, 23 Sep 2021 14:02:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l11sm4366793edv.67.2021.09.23.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:02:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/7] Builtin FSMonitor Part 1
Date:   Thu, 23 Sep 2021 22:47:13 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <87v92r49mt.fsf@evledraar.gmail.com>
 <0ec69aff-40a9-aac1-5fca-08033c967d88@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0ec69aff-40a9-aac1-5fca-08033c967d88@jeffhostetler.com>
Message-ID: <87ee9f3t0m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021, Jeff Hostetler wrote:

> On 9/23/21 10:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> Here is V2 of Part 1 of my Builtin FSMonitor series.
>>>
>>> Changes since V1 include:
>>>
>>>   * Drop the Trace2 memory leak.
>>>   * Added a new "child_ready" event to Trace2 as an alternative to the
>>>     "child_exit" event for background processes.
>>>   * Convert the Trace2-related NEEDSWORK items in "start_bg_command()" =
to use
>>>     the new "child_ready" event.
>>>   * Various minor code and documentation cleanups.
>> I see 7/7 still has a pattern you included only to make a compiler
>> error
>> better. I noted in
>> https://lore.kernel.org/git/87ilyycko3.fsf@evledraar.gmail.com/ that it
>> make the error worse, on at least clang. You didn't note which compiler
>> you were massaging, presumably MSVC.
>>=20
>
> I've been holding my tongue for days on this issue and hoping a third
> party would step in an render an opinion one way or another.
>
> Too me, a forward declaration seemed like no big deal and it does
> have value as I tried to explain.  And frankly, it felt a little bit
> like bike-shedding and was trying to avoid that again.

I agree with you that it's no big deal in the end,

I thought I made it clear in <87v92r49mt.fsf@evledraar.gmail.com> but
the main thing I'm commenting on is not that I or anyone else suggested
Y over X, and you said nah and went for X in the end.

That's fine, I mean, depending on the comment/issue etc. it's something
other reviewers & Junio can draw their own conclusions about.

What I am saying that it's much better for review of iterations of
patches in general, and especially of a complex multi-part series if
reviewers don't have to read the cover letter of vX and wonder what's
omitted/unaddressed in the V(X-1) comments, and then go and re-read the
discussion themselves. It's not the "nah", but that the "nah" is
implicit and only apparent when sending an E-Mail like this.

Of course that's never perfect, you can't summarize every point
etc. Personally I try to do this, but I've sometimes noticed after the
fact that I've gotten it wrong etc.

In the end I and I think anyone else offering their time to review
things is trying to move the relevant topic forward in one way or
another. I'd much rather spend my time on a vX discussing new things &
getting the thing closer to merge-able state, than re-reading all of
v(X-1) & effectively coming up with my own cover letter summary in my
head or in my own notes as I read along.

Anyway, sorry about the bikeshedding getting out of hand, and what seems
to have been at least partially a misunderstanding in the last couple of
E-Mails between us, but the above is all I was going for.

> The error message I quoted was from Clang v11.0.3.  My forward
> declaration of the function prior to the actual definition of
> the function causes the compiler to stop at the function definition
> and complain with a short message saying that the function itself
> is incorrectly defined and doesn't match the typedef that it is
> associated with.
>
> When I use MSVC I get a similar error at the function definition.
>
> When I use GCC I get error messages at both the function definition
> and the usage in the call.
>
>
> Additionally, the forward declaration states that the function is
> associated with that typedef (something that is otherwise implicit
> and may be hard to discover (more on that in a minute)).
>
> And it doesn't require a reference to the function pointer (either
> on the right side of an assignment, a vtable initialization, or passing
> it in a function call) to flag the error.  We always get the error
> at the point of the definition.
>
>
> The error message in your example is, I feel, worse than mine.
> It splats 2 different function signatures -- only one of which has
> the typedef name -- in a large, poorly wrapped brick of text.

For what it's worth any poor wrapping is my fault, I have a relatively
wide terminal and re-wrapped this when composing the E-Mail. I think
both GCC & Clang (and most other mature compilers) would give the person
getting the error sane wrapping based on their $COLUMNS.

> Yes, your error message does print corresponding arg in the function
> prototype of "start_bg_command()" that doesn't agree with the symbol
> used at the call-site, but that is much later than where the actual
> error occurred.  And if the forward declaration were present, you'd
> already know that back up at the definition, right.
>
>
> Let's look at this from another point of view.
>
> Suppose for example we have two function prototypes with the same
> signature.  Perhaps they describe groups of functions with different
> semantics -- the fact that they have the same argument list and return
> type is just a coincidence.
>
>     typedef int(t_fn_1)(int);
>     typedef int(t_fn_2)(int);
>
> And then declare one or more instances of functions in those groups:
>
>     int foo_a(int x) { ... }
>     int foo_b(int x) { ... }
>     int foo_c(int x) { ... }
>     int foo_d(int x) { ... }
>     int foo_e(int x) { ... }
>     int foo_f(int x) { ... }
>     int foo_g(int x) { ... }
>
> Which of those functions should be associated with "t_fn_1" and which
> with "t_fn_2"?   Again, they all have the same signature, but different
> semantics.  The author knows when they wrote the code, but it may be
> hard to automatically determine later.
>
> If I then have a function like start_bg_command() that receives a
> function pointer:
>
>     int test(..., t_fn_1 *fn, ...) { ... }
>
> In C -- even with the use of forward function declarations -- the
> compiler won't complain if you pass test() a pointer of type t_fn_2
> -- as long a t_fn_1 and t_fn_2 have the same signature.
>
> But it does give the human a chance to catch the error.  Of if we
> later change the function signature in the t_fn_1 typedef, we will
> automatically get a list of which of those foo_x functions do and
> do not need to be updated.
>
>
> Anyway, I've soapboxed on this enough.  I think it is a worthy
> feature for the price.

Code in git.git generally just declares say an "int foo(int)" and leaves
it at passing the "foo", we're not concerned about that "foo" just so
happening to be passed to some other interface that takes the same
signature, certainly not something within a <1k line t/helper/* file.

We all have habits we've picked up from other codebases prior to working
on git.git. I'm not arguing that what you're describing is worse in some
abtract sense, but that there's a larger value in following conventions
within the codebase as Junio noted in his reply.
