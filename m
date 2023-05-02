Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D48C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjEBOFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjEBOE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 10:04:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183201BC3
        for <git@vger.kernel.org>; Tue,  2 May 2023 07:04:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so6152673a12.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683036294; x=1685628294;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWQpSuJCRaXE/xMPMsrMdHsjMFDCsvnnePKBPx00/bg=;
        b=pS8fyGICF10oCAnmZg/Ke1v6BXTPiOzBTwCDMWGCZ1qD1gghpufqWgD1MUmrLQj3Yv
         lRKdYOQSbPpkHrwC9Nasi1fbTQwHCdo2HzMW4gqluiL3CQIke0qhRROprcPOJ1J3MhuM
         2AInyR0UMf5MKFG1lnJIP6YIwks4Y6Wr9iv3o2qggaCORD70QCg6dY6/JU3aGUsXbiQe
         j6NMBYydLa2f0QymgQ6Yqt06gYZJn0sGH0Zd6RIGK/Pi4aj56mXVEOj+pd95kri7Lds7
         1lOEy7J/ogor4qkLgZoO8ndqzLw5wMTM2927fX4nTrSAKZTUKiTn4cjeQrloZOW2ktX4
         uyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683036294; x=1685628294;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWQpSuJCRaXE/xMPMsrMdHsjMFDCsvnnePKBPx00/bg=;
        b=IeApvgTN+BwOsO9UoC6LPIsnKqrN1fD9oLbJz0LrNgRvCREIo56C+VOewyTVSrLcof
         WaCnsB7QPAQSC/0dbRU9bNJ8xwlbaasok9LomXwQ1locryVgSbbqZL96Rg0f0pT/hqN/
         RGZLpqoFro6Mv6axZtqMgZ4iW9H8pZJwnvqHASxSYn6s9R+jURIKK2Qw/DO1F/6z0XEh
         cs8N7ibYXwvsO2VcC2d0SOTmEnBrPlt4mNxC+icBL4Gpq1inOHW/qbbrlvpZQP7Sp7h6
         vIQyT3baSboO1PgZwyl2auoDJNDlc4LR3iCBEGs0xHZt0IPPgd1YkoM2dBA3PSbz5p8A
         8jbA==
X-Gm-Message-State: AC+VfDw70rr71TDqdBvLZtb0lBjON/be2l4ljL6KhaHhciSW5a+jLzGu
        7BXFl1buI0p+BpI6L5y3/DqpwrL1zwI=
X-Google-Smtp-Source: ACHHUZ6dXXg6Lj2wQMvaQJbRqR+W5cQf9tDh82gJC6jbG2J9ebB1x5zqRVbb2WbHiuHb3vlz+BqX2A==
X-Received: by 2002:a17:907:25ce:b0:961:2956:2ed9 with SMTP id ae14-20020a17090725ce00b0096129562ed9mr62700ejc.25.1683036293762;
        Tue, 02 May 2023 07:04:53 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sg9-20020a170907a40900b00959aba150c3sm11491640ejc.50.2023.05.02.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:04:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptqce-000Ttv-1H;
        Tue, 02 May 2023 16:04:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
Date:   Tue, 02 May 2023 15:52:33 +0200
References: <20230427175007.902278-1-calvinwan@google.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230427175007.902278-1-calvinwan@google.com>
Message-ID: <230502.861qjyj0cb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 27 2023, Calvin Wan wrote:

> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Unit tests additionally provide stability to the
> codebase and can simplify debugging through isolation. Turning parts of
> Git into libraries[1] gives us the ability to run unit tests on the
> libraries and to write unit tests in C. Writing unit tests in pure C,
> rather than with our current shell/test-tool helper setup, simplifies
> test setup, simplifies passing data around (no shell-isms required), and
> reduces testing runtime by not spawning a separate process for every
> test invocation.
>
> Unit testing in C requires a separate testing harness that we ideally
> would like to be TAP-style and to come with a non-restrictive license.
> Fortunately, there already exists a C TAP harness library[2] with an MIT
> license (at least for the files included in this series). 
>
> This first patch introduces the C TAP harness and includes only the
> necessary files. The second patch showcases a basic example of it. As an
> RFC, I am wondering what the list thinks about using a second testing
> library for unit testing? Are there any problems with this particular
> external testing library and does it provide the necessary functionality
> we would want for unit testing Git libraries? How should the folders be
> structured and how should the new Makefile rules be written? Ultimately,
> this will help us determine the setup of our unit tests in future
> libification patches.
>
> [1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
> [2] https://github.com/rra/c-tap-harness/ 

I have some out-of-tree patches I've been meaning to submit that massage
some of our TAP output, and I'd really prefer if we don't end up with
two TAP emitters in-tree if we can help it.

We can support such a thing, but nothing about your goals or your
explanation here provides the "why".

Or rather, I'm not really buying the "passing data around" or "recuding
[...] runtime [overhead]". I think you're describing how *some* of our
*.sh to *.c interop goes, but we have test-lib.sh driving C code without
those issues.

We already have pure-C libraries that we add a really shim to unit test,
the most extreme example of this is t0032-reftable-unittest.sh, whose
body is simply (excluding comments):
	
	#!/bin/sh
	test_description='reftable unittests'
	
	TEST_PASSES_SANITIZE_LEAK=true
	. ./test-lib.sh
	
	test_expect_success 'unittests' '
		TMPDIR=$(pwd) && export TMPDIR &&
		test-tool reftable
	'
	
	test_done

Now, that goes into reftable/test_framework.h which basically implements
its own mini-test framework, so that's at least a *partial* argument for
what you're suggesting here, but note that it doesn't emit TAP, it just
returns an exit code, the EXPECT() etc. is purely internal. I.e. "what
should we return?".

Probably a more git-y example is t0071-sort.sh, whose body is similar
(skipping most of the boilerplate):
	
	test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
		test-tool mergesort test
	'

We then have similar library tests as e.g. t0063-string-list.sh,
t0061-run-command.sh, t3070-wildmatch.sh etc.

None of those are perfect, but I think the current arrangement is rather
ideal. We can write most or all of the test in C, but we just do so by
calling a function that returns an exit code.

It does mean we need to spawn a shell for test-lib.sh, and call a
test-tool at least once, but the overhead of that is trivial. It's not
trivial in some cases where we call the helper in a loop, but that's
much more easily addressed than hoisting all of TAP generation into the
C space.
