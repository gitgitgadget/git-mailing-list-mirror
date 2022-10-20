Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16EC43219
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJTS5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJTS5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:57:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8320DB53
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:57:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so3207795wma.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BnmTfdXfgmFfgyMn/IjQIpcF9du/TEZOxDLYs7raQE=;
        b=P4sNgK/SakJ8eOHaqGaTDgnC4lY6NC5faOO+5x3OtHChTgMCIxuTgCBrQs6PRqH2Th
         O8dfW8/S6qK7rU4gCqZOev7jRpkVrKT+Px2murO4RdAQ4r3IWQBb1RG4pGMwcpo6gHc1
         u+8kZWhY77981NXSvTccF67q6nyh7S1JZGsmoXGNIkv3x+lByf99OGtJ15Xtcd730HkR
         lZKeN31xsOuzalqrI6nfvVHZ7jLxiqMQT4fwfDax0FogjfgrgRuufz2r38FaOq99d5lF
         5Xeq1+P8zPSyRdpgJZzsfjj42wvwg94xeDEm9i66e1yU+46yzHtdaaIwKw7SBFDJiMQj
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BnmTfdXfgmFfgyMn/IjQIpcF9du/TEZOxDLYs7raQE=;
        b=BHF/wotoBZtjgGQUpEAJge0y/CJ0YXa5/WJppk9hADYNCjz6+iC1Fr0x5v8zPxrI7J
         twPh8rXRo7D0wlJZjohQy7a2Wqxok73Ld2DCDjyxRGjQY+jNaDGEz2aDe4EBrPuOpXlK
         tHp5zWWhotfsn+QPoTaJavbDSA/AwRv5W1PhMmIoGF8wt6TmpWIsmAFSsJPYha/xs4Xk
         36dxpI2nr5QsfkZBoOfXQiEEiguo4dJ9hXffSEiwK0jkQcSzrqfbuOxve/acod729w70
         CcTw67+9p83k/1rJLtEYAfrHovB4nObpbX+9vQqktLHvaTVdufbghBIo+QtwvscyhvEO
         TB3w==
X-Gm-Message-State: ACrzQf26jvbJ5uE6y9O/jm2alOmpW528dzg0VcCsuMcUJko+wwbzwLvy
        fvWG9FFQopULlKmx5auoXEU=
X-Google-Smtp-Source: AMsMyM5bun4HrkixK5WSXCaQ22IJnOeqTqz4c0YqyheoE7Yn8ESiJKKO49Cu3f7feKZDxGCvKrZ5IA==
X-Received: by 2002:a05:600c:54e6:b0:3c6:b966:4367 with SMTP id jb6-20020a05600c54e600b003c6b9664367mr32153643wmb.30.1666292253321;
        Thu, 20 Oct 2022 11:57:33 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6a48000000b0022b11a27e39sm17041766wrw.1.2022.10.20.11.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:57:32 -0700 (PDT)
Subject: Re: [PATCH] Makefile: force -O0 when compiling with SANITIZE=leak
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <Y07yeEQu+C7AH7oN@nand.local>
 <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
 <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
 <221018.86k04whkgf.gmgdl@evledraar.gmail.com>
 <Y0+i1G5ybdhUGph2@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <939ccb0c-005c-4f98-a6ca-3f8e5cda1641@gmail.com>
Date:   Thu, 20 Oct 2022 20:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y0+i1G5ybdhUGph2@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/10/22 9:10, Jeff King wrote:
 
> Yes, that's a mouthful. If you really really want it, we can make the
> "-O0" behavior conditional. But I remain entirely unconvinced that what
> you're trying to do is useful.
> 
>> I'd prefer not to need to do that, because while non-O0 is noisy
>> sometimes, I've also found that it points (at least indirectly) to some
>> useful edge-cases.
> 
> I haven't seen any evidence that leak-checking with -O2 produces
> anything of value. And I have seen several examples where it produces
> garbage. I guess you're referring here to the elaboration you give below
> in your message. But I think you're just wrong about it being useful.
> 
>> The tl;dr is that I think you use "leak" in the sense that valgrind
>> talks about "still reachable" leaks, which is conceptually where
>> -fsanitize=leak draws the line. I.e. it's not a malloc()/free() tracker,
>> but tries to see what's "in scope".
> 
> No, these "still reachable" cases are not at all interesting. If we end
> the program by returning up the stack, then perhaps they could be (but
> IMHO they are not generally, because it's perfectly reasonable to leave
> globals pointing to allocated memory at program exit). But if we exit in
> the middle of a function, and variables are left on the stack, what in
> the world is the use of a leak-checker complaining about that?
> 
> It is not hurting anything, because by definition we have exited the
> program and released the memory. And it is near-impossible to remove
> these entirely. In the example we're discussing, there's a local
> variable in git_config_push_env() that _could_ be freed before calling
> die(). But not in the general case:
> 
>   - what about heap allocations in callers? Imagine a program like this:
> 
>       void foo(const char *str)
>       {
>         if (some_func(str))
>           die("bad str");
>       }
>       void bar(void)
>       {
>         char *str = strdup("some string");
> 	foo(str);
> 	free(str);
>       }
> 
>     If foo() calls die(), then bar()'s str is a "still reachable" leak.
>     But we can't fix it in any reasonable way. foo() doesn't know about
>     freeing the string. And bar() doesn't know about calling die().
> 
>   - likewise, we may actually need the heap-allocated string to call
>     die! Consider this:
> 
>       void foo(void)
>       {
>         char *str = strdup("some string");
> 	if (some_func(str))
> 	  die("bad str: %s", str);
> 	free(str);
>       }
> 
>     You can't avoid a "still reachable" leak here, because die() would
>     need to use the string, then free it, then exit.
> 
> So if these "still reachable" leaks are not hurting anything, and if
> they are impossible to get rid of, why do we want to care about them?
> Doing so just causes pain with no benefit.
> 
>> This is getting a bit academic, but I don't see how you can both say
>> that the "compilers are allowed to modify the program as long as the
>> observable behavior of that abstract machine is unchanged" *and* claim
>> that e.g. the git_config_push_env() case isn't a real leak.
> 
> The words "observable behavior" are doing a lot of heavy lifting there.
> That is the behavior which a conforming C program can observe. And in
> this case, nothing is violated. We did not reach the free() call, so
> there was no need to make sure we had the parameters available. The C
> standard's abstract machine doesn't know about things like "the stack is
> memory that you can look at". Doing that is undefined behavior, and a
> program which cares about that is not conforming.
> 
> I agree this is mostly academic. My point in bringing it up was just to
> say that no, this isn't a bug in the optimizer. Clobbering values for
> NORETURN is perfectly reasonable and valid according to the standard.
> And leak-checking, while basically undefined behavior from the
> perspective of the standard, is a useful tool. It's the interaction
> between the two that is ugly, and the most useful thing for us to do is
> avoid using both at the same time.
> 
>> Because surely the thing that makes it a "leak" by your definition (and
>> what LSAN strives for) is that it's attributed to a variable that's "in
>> scope", but the compiler is free to re-arrange all of that.
> 
> If you mean "not a leak", then yes: there's still an in-scope variable
> that points to it, which is what makes it not a leak.
> 
>> Anyway, one reason I wanted to punt on that "git --config-env" issue is
>> because we can entirely avoid the malloc()/free() there. See the "-- >8
>> --" below, but if we just malloc() after we do our assertions we can
>> un-confuse clang.
>>
>> And that seems like a good idea in general, and re whether the "leak" is
>> gone, at that point valgrind will stop reporting it, so we're really not
>> leaking at all, not just in the "still reachable" sense.
> 
> I'm not convinced it's a good idea. The resulting code requires an extra
> variable and is (IMHO) slightly harder to understand. And what have we
> accomplished? We silenced one false positive, but we know there are
> others. And the linux-leaks CI job is failing on master _right now_, and
> the patch below doesn't fix that.
> 
> That makes the job somewhat worthless. And worse, it makes all of CI
> less useful, because if it says "failed" on every build, people will
> start to ignore it.
> 
>> The reason I mention all of that is to try to define the problem here. I
>> haven't seen cases where the compilers get it wrong about there being a
>> leak, it's just that they're mis-categorizing them as "still reachable"
>> or not, re your "abstract machine" summary.
> 
> This paragraph makes it sound like we are mixing up a real leak and a
> "still reachable" leak. But it is mixing up "there is no leak and
> nothing to fix" with "there is a still reachable leak".
> 
>> Now, the other cases in t1300 are from git.c using exit() instead of
>> retur-ing to our main().
>>
>> Among numerous other leak fixes I have queued up I have a fix for that,
>> which fixes the other t1300 cases that have been reported now:
>> https://github.com/avar/git/tree/avar/git-c-do-not-exit
> 
> I said it in the last round of discussion, and I'll say it again: this
> is the wrong direction. These are not real leaks, and we should not be
> twisting our code to try to avoid them. We should be fixing our
> leak-checking so that they don't come up.
> 
>> The actual meaningful fix here is that we don't need to do this
>> allocation at all. The only reason it's needed is because there's no
>> variant of "sq_quote_buf()" in quote.c that takes a "len"
>> parameter (but I have one locally).
>>
>> If we had that we could just pass a "key" and "key_len" to
>> git_config_push_split_parameter() instead and avoid the allocation
>> altogether. But in lieu of that better fix (which other API users of
>> quote.c would benefit from) let's defer the allocation, which happens
>> to fix the leak reporting on
> 
> So as you probably guessed, I absolutely hate this patch and think we
> should not take it.
> 
> If we had a version of sq_quote_buf() that took a "len" parameter, then
> sure, it would be reasonable to use. But it absolutely is not worth
> caring about to silence a leak that is a false positive. There is
> _nothing_ wrong with the code as written.
> 
> -Peff
> 

"-O2" is what goes public, testing it, directly or indirectly, is useful.
Another thing is the pay-off..

We're losing a few eyeballs on "-O2" and some test performance in the way, in
exchange of avoiding some false positives.  And even with "-O0" the compiler is
free to keep playing the whack-a-mole with us.

I can easily find motivations for people to switch to "-O0" and do its local
tests for example, and so we add eyeballs... but not so easily the other way
around, to switch to "-O2".

"False positives" makes me think the leak checker does its best.  And the
compiler.  This "-O0 leak" is ignored by both, with "-O2":

	void func()
	{
		malloc(1024);
		exit(1);
	}

UNLEAK(), "-O0" as a /second opinion/ /confirmation/, some attention to the
false positives,... are things that doesn't sound so bad.  Maybe there is a
better way.  Dunno.

Un saludo.
