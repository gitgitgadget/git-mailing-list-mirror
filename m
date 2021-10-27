Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19227C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B460E76
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhJ0IAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbhJ0IAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:00:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9EC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:58:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso5466600wmc.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yCud1P09UJ4ZXs94Pn+/5f7p8FHTv19JLCXq2PaqxSw=;
        b=Pm88VwHf35y04oieJakWPIJpHdiPI+gbITlKavQADpiCtGOZQWJhpGgU5bne4xKYBJ
         E70W4oTyRfozXgbvCOFxulgiQj7CcCuae4AjnxfWCNNOnZyv+BnCZZmB56psZWCUopjd
         8MkslRi4ya9oHADg5kwO8OZnIDe42BFzkkGCB5reLKyPlQkNwFjlstvMao9jP7y/DCgN
         cZ+5lrCevXyKBSVYfUlPfjgfbcRheVdOHoenLCrnwxcZTf507cHidaDDnzntucZcxRIj
         Og44413xVEip8PsvSqj7oIeFrdZOBALKIfYvYEFCOwBHwMbc0j2/7j62sZbTrC8Mtegy
         FQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yCud1P09UJ4ZXs94Pn+/5f7p8FHTv19JLCXq2PaqxSw=;
        b=XLTdf5qn2xnFG/J0YqhKic+kWJM/lsJAYv6pxbvUIELfj0q7es8y7Yi0fVOh1A/xLP
         FlKgIlrQwhm9vUEgurNUm3GARD2cQ7Nos29nd56fEYCVkW/9QA1sCZEhx+m/m0/yRJd0
         kb8UTsx3GBiKCrkdXYsISaHWkLwAj66s8kr3Gd86leilx6oQoHMiCCsHJAS8e/1Ahto+
         sVvAndMtN+v3b+/Eup3L38wWD3F2VrhIGgc26ZXGRBdhhKgWiZYbi5AwZ2Y/3WQGblnG
         Ab9Z4INl1uVtobiaMQ9AGi7/dGZ+5+X5SdRLtworWwy72aI3tWL4KKXqaAuobPBOXf1d
         ySRw==
X-Gm-Message-State: AOAM532Md3JCKiF6s787dtTjozU2hsb1uEjhlcfIP8JZ+17/s02g5G29
        ePlEmnD3aTFieMhwb6uPOVo=
X-Google-Smtp-Source: ABdhPJxHhBSHWHULLTnmoEOBG7OZYYvHZiurbleFd6TDDkX8z0V4+cWRGsBaUwBEMFs8WU9RSo/3Ww==
X-Received: by 2002:a05:600c:4894:: with SMTP id j20mr4201507wmp.60.1635321483430;
        Wed, 27 Oct 2021 00:58:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d8sm22131254wrv.80.2021.10.27.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:58:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfdov-001xPH-KR;
        Wed, 27 Oct 2021 09:58:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Date:   Wed, 27 Oct 2021 09:51:38 +0200
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXhjstW2XAnixEqh@nand.local>
Message-ID: <211027.86zgquyk52.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Taylor Blau wrote:

> On Fri, Oct 22, 2021 at 12:32:17PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Extend the SANITIZE=3Dleak testing mode added in 956d2e4639b (tests: add
>> a test mode for SANITIZE=3Dleak, run it in CI, 2021-09-23) to optionally
>> be able to add a "suppressions" file to the $LSAN_OPTIONS.
>>
>> This allows for marking tests as passing with
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" when they still have failure due more
>> general widespread memory leaks, such as from the "git log" family of
>> commands. We can now mark the "git -C" tests as passing.
>>
>> For getting specific tests to pass this is preferable to using
>> UNLEAK() in these codepaths, as I'll have fixes for those leaks soon,
>> and being able to atomically mark relevant tests as passing with
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" helps to explain those changes. See
>> [1] for more details.
>>
>> 1. https://lore.kernel.org/git/211022.86sfwtl6uj.gmgdl@evledraar.gmail.c=
om/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> On Fri, Oct 22 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > On Fri, Oct 22 2021, Taylor Blau wrote:
>> >
>> >> On Thu, Oct 21, 2021 at 01:50:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >>>
>> >>> On Wed, Oct 20 2021, Taylor Blau wrote:
>> [...]
>> > If you want to pick that approach up and run with it I think it would
>> > probably make sense to factor that suggested test_expect_success out
>> > into a function in test-lib-functions.sh or whatever, and call it as
>> > e.g.:
>> >
>> >     TEST_PASSES_SANITIZE_LEAK=3Dtrue
>> >      . ./test-lib.sh
>> >     declare_known_leaks <<-\EOF
>> >     add_rev_cmdline
>> >     [...]
>> >     EOF
>> >
>> > Then pipe it through sed 's/^/leak:/' and have it set LSAN_OPTIONS for
>> > you.
>> >
>> > Doing it that way would be less boilerplate for each test that wants i=
t,
>> > and is also more likely to work with other non-LSAN leak appoaches,
>> > i.e. as long as something can take a list of lines matching stack trac=
es
>> > we can feed that to that leak checker's idea of a whitelist.
>>
>> I just went ahead and hacked that up. If you're OK with that approach
>> it would really help reduce the work for leak changes I've got
>> planned, and as noted gives you the end-state of a passing 5319.
>>
>> I don't know if it makes more sense for you to base on top of this
>> if/when Junio picks it up, or to integrate it into your series
>> etc. Maybe Junio will chime in ...
>
> Hmm. This seems neat, but I haven't been able to get it to work without
> encountering a rather annoying bug along the way.
>
> Here is the preamble of my modified t5319 to include all of the leaks I
> found in the previous round (but decided not to fix):
>
> TEST_PASSES_SANITIZE_LEAK=3Dtrue
> . ./test-lib.sh
> todo_leaks <<-\EOF
> ^add_rev_cmdline$
> ^cmd_log_init_finish$
> ^prepare_revision_walk$
> ^prep_parse_options$
> EOF
>
> So running that when git is compiled with SANITIZE=3Dleak *should* work,
> but instead produces this rather annoying leak detection after t5319.7:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   =3D=3D1785298=3D=3DERROR: LeakSanitizer: detected memory leaks
>
>   Indirect leak of 41 byte(s) in 3 object(s) allocated from:
>       #0 0x7f2f2f866db0 in __interceptor_malloc ../../../../src/libsaniti=
zer/lsan/lsan_interceptors.cpp:54
>       #1 0x7f2f2f64b4aa in __GI___strdup string/strdup.c:42
>
>   -----------------------------------------------------
>   Suppressions used:
>     count      bytes template
>         1        576 ^add_rev_cmdline$
>   -----------------------------------------------------
>
>   SUMMARY: LeakSanitizer: 41 byte(s) leaked in 3 allocation(s).
>   Aborted
>
> Huh? Looking past __GI___strdup (which I assume is just a
> symbolification failure on ASan's part), who calls strdup()? That trace
> is annoyingly incomplete, and doesn't really give us anything to go off
> of.
>
> It does seem to remind me of this:
>
>   https://github.com/google/sanitizers/issues/148
>
> though that issue goes in so many different directions that I'm not sure
> whether it really is the same issue or not. In any case, that leak
> *still* shows up even when suppressing xmalloc() and xrealloc(), so I
> almost think that it's a leak within ASan itself.
>
> But most interesting is that those calls go away when I stop setting
> `suppressions` in $LSAN_OPTIONS by dropping the call to your todo_leaks.
>
> So this all feels like a bug in ASan to me. I'm curious if it works on
> your system, but in the meantime I think the best path forward is to
> drop the last patch of my original series (the one with the three
> UNLEAK() calls) and to avoid relying on this patch for the time being.

There are similar cases where LSAN doesn't provide as meaningful of a
stacktrace as valgrind, sometimes when tracing leaks I get a relatively
bad stacktrace like that ending in some __GI___*<stdlib-name>
function. I'll usually compile without SANITIZE=3Dleak and just run a
slower:

    valgrind --leak-check=3Dfull --show-leak-kinds=3Dall

In this case however it's not a bug or bad leak tracing, but an artifact
of us using these stacktrace exclusions.

If you run this manually you'll see:
=20=20=20=20
    $ ~/g/git/git -c core.multiPackIndex=3Dfalse rev-list --objects --all
    cd0747a9352b58d112f0010134351efc7bbad4a6
    [... snipped output ...]
=20=20=20=20
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    =3D=3D58023=3D=3DERROR: LeakSanitizer: detected memory leaks
=20=20=20=20
    Direct leak of 576 byte(s) in 1 object(s) allocated from:
        #0 0x7fd0bfae50c5 in __interceptor_realloc ../../../../src/libsanit=
izer/lsan/lsan_interceptors.cpp:82
        #1 0x5637b3bd9163 in xrealloc /home/avar/g/git/wrapper.c:126
        #2 0x5637b3b6a1e4 in add_rev_cmdline /home/avar/g/git/revision.c:14=
82
        #3 0x5637b3b6a412 in handle_one_ref /home/avar/g/git/revision.c:1534
        #4 0x5637b3b49c4e in do_for_each_ref_helper /home/avar/g/git/refs.c=
:1483
        #5 0x5637b3b54afc in do_for_each_repo_ref_iterator refs/iterator.c:=
418
        #6 0x5637b3b49cc8 in do_for_each_ref /home/avar/g/git/refs.c:1498
        #7 0x5637b3b49d07 in refs_for_each_ref /home/avar/g/git/refs.c:1504
        #8 0x5637b3b6a563 in handle_refs /home/avar/g/git/revision.c:1578
        #9 0x5637b3b6e0e7 in handle_revision_pseudo_opt /home/avar/g/git/re=
vision.c:2597
        #10 0x5637b3b6e9d5 in setup_revisions /home/avar/g/git/revision.c:2=
738
        #11 0x5637b39ebc58 in cmd_rev_list builtin/rev-list.c:550
        #12 0x5637b3932a89 in run_builtin /home/avar/g/git/git.c:461
        #13 0x5637b3932e98 in handle_builtin /home/avar/g/git/git.c:713
        #14 0x5637b3933105 in run_argv /home/avar/g/git/git.c:780
        #15 0x5637b39335ae in cmd_main /home/avar/g/git/git.c:911
        #16 0x5637b3a1a898 in main /home/avar/g/git/common-main.c:52
        #17 0x7fd0bf860d09 in __libc_start_main ../csu/libc-start.c:308
=20=20=20=20
    Indirect leak of 41 byte(s) in 3 object(s) allocated from:
        #0 0x7fd0bfae4db0 in __interceptor_malloc ../../../../src/libsaniti=
zer/lsan/lsan_interceptors.cpp:54
        #1 0x7fd0bf8c7e4a in __GI___strdup string/strdup.c:42
=20=20=20=20
    SUMMARY: LeakSanitizer: 617 byte(s) leaked in 4 allocation(s).

Which is why I put the "strdup" there, but forgot to tell you when I
submitted the real PATCH version that that one shouldn't have the ^$
anchoring.

FWIW this will work on top of your series:
=20=20=20=20
    diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
    index a3c72b68f7c..891de720b2c 100755
    --- a/t/t5319-multi-pack-index.sh
    +++ b/t/t5319-multi-pack-index.sh
    @@ -2,6 +2,17 @@
=20=20=20=20=20
     test_description=3D'multi-pack-indexes'
     . ./test-lib.sh
    +todo_leaks <<-\EOF
    +^add_rev_cmdline$
    +^cmd_log_init_finish$
    +^prep_parse_options$
    +^prepare_revision_walk$
    +^start_progress_delay$
    +
    +# An indirect leak reported because we excluded the leaks above
    +strdup$
    +EOF
    +
=20=20=20=20=20
     GIT_TEST_MULTI_PACK_INDEX=3D0
     objdir=3D.git/objects
