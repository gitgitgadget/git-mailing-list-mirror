Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E9C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7561073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbhJ0IaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbhJ0I37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC2C061243
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso2441398wmc.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=C6AwIb3CF+H1ILn9rhkhvFQAYcs6e+SgBVMlR68Pbqw=;
        b=KUMqrTvLM3ci/IzWSuDVdcxki8PwerNrmRe9/dxl5SLG8G98ORim/2zV5o5gbpAA+I
         FNcVGkMUqnPmCV7XrbYMS9chBvujT4osupXP7bZoFKVQsfr/KGiES/YgxmqMlCn+0umt
         RQSILSOjYNe0ij5blOtgEpEUPqp5oorB/ui01iKxua7TlnSfxdfPdolzfzQ7u6mWYYVq
         FS1V011N2kan8vXzgnDZ5x5S5Tc0TMkvND6v0Auzokeoe9koEldkQXzCH5N4Y9X45eUH
         RYszVB97+DHnZSyQ5rDWskWO1FTjLyWDPiBKHAehQjZ2X+wvkaslbGJvCyYJNyNJBbUS
         Z4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=C6AwIb3CF+H1ILn9rhkhvFQAYcs6e+SgBVMlR68Pbqw=;
        b=LkstGUWtXYY55r/d2MjDAjHixlM+kVBCKhdj2Hi/e9I8+x4wu0sbEC3VMYX6n+pkT/
         kquudr6NsL5cRUmZ2jOr56qcFwgv9WzztbSUNAdkeg4OkJsX1+Dw0PNCLbd/PEXGVgnL
         C4D7heRJVcvAbnDbgqyaKfocopwd5j+RbWXMleiM5KKQyrLsge2Q5eDaddVXyp45XFHj
         mpFr8GRPnZ8TfqDlG8jku0HS54PVi0atsgzaS3vH9l2IMNDY383LuGn2isDgUlKAMScR
         fwO+LBt4kESNi0GK15ncoDzFKNLH6pOb8zrTVq/k3tAj5Uib6r0zWLySe8ahHAz83dD6
         q1gQ==
X-Gm-Message-State: AOAM530MwCTzPZwIhKD1vrdjG/ciDlN0Pgay+TX/TmR3ay4c2/JvtTLc
        5dKJTQ2sluTV+btdD0I4Q0c=
X-Google-Smtp-Source: ABdhPJyPblauJMpRg/R4Atv5riFEqb6nbckVZ5XqdUVQYwzfKFmhWLVYV5AGnmoZd26m8gBZ/EGfMA==
X-Received: by 2002:a05:600c:1c10:: with SMTP id j16mr4252955wms.28.1635323244833;
        Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y5sm12138878wrd.75.2021.10.27.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfeHL-001xwe-M9;
        Wed, 27 Oct 2021 10:27:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Date:   Wed, 27 Oct 2021 10:04:17 +0200
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local> <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
Message-ID: <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Jeff King wrote:

It seems that I've gotten what I wanted from this side-thread, yay!
Thanks both, not to pile on, but just to clarify:

> On Tue, Oct 26, 2021 at 04:23:14PM -0400, Taylor Blau wrote:
>
>> So this all feels like a bug in ASan to me. I'm curious if it works on
>> your system, but in the meantime I think the best path forward is to
>> drop the last patch of my original series (the one with the three
>> UNLEAK() calls) and to avoid relying on this patch for the time being.
>
> Bugs aside, I'd much rather see UNLEAK() annotations than external ones,
> for all the reasons we introduced UNLEAK() in the first place:
>
>   - it keeps the annotations near the code. Yes, that creates conflicts
>     when the code is changed (or the leak is actually fixed), but that's
>     a feature. It keeps them from going stale.

I fully agree with you in general for "good" uses of UNLEAK(). E.g. consider:

    struct strbuf buf = xmalloc(...);
    [...]
    UNLEAK(buf);

If I was fixing leaks in that sort of code what I pointed out downthread
in [1] wouldn't apply.

So to clarify, I'm not asking in [1] that UNLEAK() not be used at all
while we have in-flight leak fixes. I.e. I'd run into a textual
conflict, but that would be trivial to resolve, and obvious what the
semantic & textual conflict was.

Rather, it's not marking specific leaks, but UNLEAK() on a container
struct that's problematic.

Depending on how they're used those structs may or may not leak. So
e.g. Taylor's upthread 11/11[2] contained:
    
    diff --git a/builtin/rev-list.c b/builtin/rev-list.c
    index 36cb909eba..df3811e763 100644
    --- a/builtin/rev-list.c
    +++ b/builtin/rev-list.c
    @@ -549,6 +549,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
     
            argc = setup_revisions(argc, argv, &revs, &s_r_opt);
     
    +       UNLEAK(revs);
    +
            memset(&info, 0, sizeof(info));
            info.revs = &revs;
            if (revs.bisect)

Which if you on master replace that with:
    
    diff --git a/builtin/rev-list.c b/builtin/rev-list.c
    index 36cb909ebaa..3cce87e0eb7 100644
    --- a/builtin/rev-list.c
    +++ b/builtin/rev-list.c
    @@ -548,6 +548,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
                    revs.do_not_die_on_missing_tree = 1;
     
            argc = setup_revisions(argc, argv, &revs, &s_r_opt);
    +       BUG("using this?");
     
            memset(&info, 0, sizeof(info));
            info.revs = &revs;

You'll run into a failure with:

    GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0002-gitfile.sh

I.e. our existing leak tests already take that codepath and don't run
into a leak from using "revs".

So we wouldn't just be marking a known specific leak, but hiding all
leaks & non-leaks in container from the top-level, and thus hide
potential regressions, an addition to attaining the end-goal of marking
some specific test as passing.

Now, that specific example isn't very useful right now, since we don't
have a release_revisions() at all, but e.g. the first batch of fixes
I've got for the revisions.[ch] leak fix most common cases (e.g. the
pending array), but not some obscure ones.

Being able to incrementally mark those leaks as fixed on a test-by-test
basis has the advantage over UNLEAK() that we won't have regressions
while we're not at a 100% leak free (at which point we could remove the
UNLEAK()).

>   - leak-checkers only know where things are allocated, not who is
>     supposed to own them. So you're often annotating the wrong thing;
>     it's not a strdup() call which is buggy and leaking, but the
>     function five layers up the stack which was supposed to take
>     ownership and didn't.

As noted in [3] this case is because the LSAN suppressions list was in
play, so we excluded the meaningful part of the stack trace (which is
shown in that mail).

Hrm, now that I think about it I think that the cases where I had to
resort to valgrind to get around such crappy stacktraces (when that was
all I got, even without suppressions) were probably all because there
was an UNLEAK() in play...

1. https://lore.kernel.org/git/211022.86sfwtl6uj.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/f1bb8b73ffdb78995dc5653791f9a64adf216e21.1634787555.git.me@ttaylorr.com/
3. https://lore.kernel.org/git/211027.86zgquyk52.gmgdl@evledraar.gmail.com/
