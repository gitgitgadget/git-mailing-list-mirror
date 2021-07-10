Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F6C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFCD613BE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGJJbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhGJJbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 05:31:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C5C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:29:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg14so21221427ejb.9
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fvJ4KNPO8bUdiVHg8+Nh0u9tdGK8NuON6B/2KT5F7Gw=;
        b=HRwO6wMqSurRgLVq8bACwTqU/1dWV6pIZRe1BAeJ4wRry8wRdzBK4QLTUhk0G2u0yP
         1PcEMzJO4jtAEEtHvp0gjPOKyC4lGTHynB6NZIeXsW++n4BnsytQ1goZiF2YtvsOcY5L
         46LMIohpnZoVZRPxOL2j/FbTa5Ibso2vpvOWqSBLYNUKspikhE8SyNxUADvsph5efGfL
         xv6D9VPsOIkrgZrwZMNMPHYhGxDDZOrjbS/D1PJwbhE0qESjPU8N46M08t38ZWc280+T
         rbhMzRWccqumXBGD+e3Xm6crzNHbenvT2I9y7vJJ8UydAlYsiMw0cSsXyiAlluiodQXf
         msDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fvJ4KNPO8bUdiVHg8+Nh0u9tdGK8NuON6B/2KT5F7Gw=;
        b=BCe8W3PHS8nu+DKHNxzkFt9uiQLM4jdod51Ht6Qlw5jf7c/iaOSKNfpL3qtHdkhYs5
         YA8Qv5LqOe9CFb/EQbK+0XtTiJfdqHGuGn0baw3ZgTFXqAASR888WrqqMGQLCKMM6TwI
         OL4Hp/RxOzx5wOxV/+v1dtmGvySX9BcoPNdgigmm/Q4R7zVW6WVySKv1DU6OCQZbybji
         hNRfyQV56LBklLAIrCsWYX5nWPDa1myAdjIiL8Glosz4ZbM3DowDUIDPBDtDG/p1UZa3
         XkPlwJlvk8XcGoJu0+93tPqwzgTl0owhnm09hjsViW533qwfv6mKj9bTuZUg5zOzrfF2
         +Ilg==
X-Gm-Message-State: AOAM533nHxdzPW6D5PlRxuI9GoiKt91DstOLKUbsyF5bn0bvxRVDIPng
        uSrYT/T+STSpW0ThAoQ8R0E=
X-Google-Smtp-Source: ABdhPJwUqCKAJcbvCAYCWAEqzrh6GMaHYTVVtN8aNeOn5OdZqL0jnbb4eCqjjzZAM02+WAYSaxTaig==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr10889692ejc.114.1625909342722;
        Sat, 10 Jul 2021 02:29:02 -0700 (PDT)
Received: from evledraar ([109.36.149.59])
        by smtp.gmail.com with ESMTPSA id g23sm4391260edp.90.2021.07.10.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 02:29:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #02; Thu, 8)
Date:   Sat, 10 Jul 2021 10:56:19 +0200
References: <xmqq8s2ga19f.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq8s2ga19f.fsf@gitster.g>
Message-ID: <87tul24iw2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 08 2021, Junio C Hamano wrote:

Update on my topics:

> [...]
> * ab/cmd-foo-should-return (2021-06-09) 1 commit
> * ab/config-hooks-path-testfix (2021-06-16) 1 commit
> * ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> * ab/progress-cleanup (2021-06-08) 1 commit
> * ab/xdiff-bug-cleanup (2021-06-08) 1 commit

Thanks!

> * ab/gitignore-discovery-doc (2021-07-06) 1 commit

Tracking my topics would be marginally easier if I got an =C3=A6b/ prefix :)

> * ab/imap-send-read-everything-simplify (2021-07-07) 1 commit
> * ab/pkt-line-tests (2021-07-07) 5 commits

Thanks!=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

> * ab/lib-subtest (2021-07-01) 8 commits
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>
>  Refactor tests on test framework.
>
>  What's the review status of this thing?

Would be nice to have reviews on this, the diffstat looks good:

 2 files changed, 219 insertions(+), 305 deletions(-)

It's mostly a straight-forward cleanup of test code, with the only
tricky/clever bits being in "test-lib tests: get rid of copy/pasted mock
test code".

I.e. to avoid future copy/pasted test code creeping back in I (ab)use
the object store to create content-addressable tags, we then use
update-ref to complain if we get the same tag (i.e. copy/pasted test)
again.

> * ab/struct-init (2021-07-01) 5 commits
>  - string-list.h users: change to use *_{nodup,dup}()
>  - string-list.[ch]: add a string_list_init_{nodup,dup}()
>  - dir.[ch]: replace dir_init() with DIR_INIT
>  - *.c *_init(): define in terms of corresponding *_INIT macro
>  - *.h: move some *_INIT to designated initializers
>
>  Code cleanup around struct_type_init() functions.
>
>  Will merge to 'next'.

Thanks. I see it made it there already after your initial push-out.

> * ab/bundle-doc (2021-07-02) 3 commits
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: elaborate on object prerequisites
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Expecting a reroll.
>  at least for the second patch.

Will get to it.

> * ab/pack-stdin-packs-fix (2021-06-28) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Expecting a reroll.
>  cf. <YND3h2l10PlnSNGJ@nand.local>

Already re-rolled.

> * ab/bundle-updates (2021-07-06) 3 commits
> [...]
>  Will merge to 'master'.
> * ab/fetch-negotiate-segv-fix (2021-07-08) 3 commits
> [...]
>  Will merge to 'master'.
> * ab/make-delete-on-error (2021-06-29) 1 commit
> [..]
>  Will merge to 'master'.

Thanks, will make things I'm rebasing locally easier.

> * ab/make-tags-cleanup (2021-06-29) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: fix "cscope" target to refer to cscope.out
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Expecting a reroll.
>  Hopefully with a final reroll it would become good enough shape for 'nex=
t'?
>  cf. <YN5AwdVC3QAcy2tA@coredump.intra.peff.net>
>  cf. <67c45b13-df8f-8065-377a-fbd2f80992ee@ramsayjones.plus.com>

Will re-roll, sorry for the delay.

> * ab/describe-tests-fix (2021-05-11) 5 commits
> [..]
>  Will merge to 'master'.
> [...]
> * ab/pickaxe-pcre2 (2021-05-11) 22 commits
> [...]
>  Will merge to 'master'.

Yay!

> * ab/config-based-hooks-base (2021-06-29) 33 commits
> [...]
>  Waiting for reviews.

Ping: Emily.

> * ab/doc-retire-alice-bob (2021-06-16) 6 commits
>  - pack-protocol doc: use "www-data" in place of "alice"
>  - doc: replace "alice" and "bob" with "jdoe" and "msmith"
>  - fast-import doc: change "bob" in an example to "file.txt"
>  - daemon doc + code comments: reword "alice" example
>  - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-da=
ta"
>  - gittutorial doc: replace "alice" and "bob" with "you" and "www-data"
>
>  Documentation update to avoid Alice and Bob in contexts where Eve
>  does not appear in.
>
>  Will discard.
>  Let's shelve this one for now, as it does not seem to solve any
>  real problems (other than ceasing to use Alice and Bob in contexts
>  that do not call for Eve).

Allright, although I think the mid-series "fast-import doc: change "bob"
in an example to "file.txt"" probably makes sense in any case, ditto the
doc improvements in " daemon doc + code comments: reword "alice"
example".

I might re-submit those separately, or not...

> * ab/pre-auto-gc-hook-test (2021-06-16) 1 commit
> [...]
> * ab/serve-cleanup (2021-06-28) 8 commits
>  - upload-pack.c: convert to new serve.c "startup" config cb
>  - serve: add support for a "startup" git_config() callback
>  - serve.c: add trace2 regions for advertise & command
>  - serve.c: add call_{advertise,command}() indirection
>  - serve: use designated initializers
>  - transport: use designated initializers
>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>  - serve: mark has_capability() as static
>
>  Code clean-up around "git serve".
>
>  Comments?

I have a re-roll of this queued locally. It seemed people were on the
fence about the whole "startup config" thing so I initially planned to
just drop it, but then I started fixing some other related serve.c code
and found a good/better use for it, so maybe I'll keep it. Will post it
soon.

FWIW Han-Wen's "let's rename the serve() function" suggestion sent me on
an Odyssey of discovering various unused/overly-complex-for-no-reason
code around protcol v1/v2 that I think we should just clean up...

> * ab/mktag-tests (2021-06-28) 6 commits
> * ab/show-branch-tests (2021-06-28) 4 commits
> [...]
>  Will merge to 'master'.

Yay tests!

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Haven't heard back from Emily/Jonathan Tan on in reply to my "would this
address your comments" on the last, will probably just amend commit
messages & re-roll.

> * ab/pack-objects-stdin (2021-06-28) 4 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Code clean-up.

I see you picked up my latest @
https://lore.kernel.org/git/cover-0.5-00000000000-20210709T105850Z-avarab@g=
mail.com/#t

Thanks for the hotfix on the s/int/unsigned/ brainfart of mine.

> * ab/update-submitting-patches (2021-06-08) 3 commits
>  - SubmittingPatches: remove pine-specific hints from MUA hints
>  - SubmittingPatches: replace discussion of Travis with GitHub Actions
>  - SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Expecting a reroll.
>  cf. <20210607172542.GA6312@szeder.dev>
>  cf. <nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet>

Didn't I say I was re-rolling this last time, or maybe the time before
that too? Sorry...

> * ab/send-email-optim (2021-05-28) 13 commits
> [...]
>  "git send-email" optimization.
>
>  Will merge to 'master'.

Yay!

> * ab/fsck-unexpected-type (2021-06-28) 21 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object types
>  - object-file.c: return -2 on "header too long" in unpack_loose_header()
>  - object-file.c: return -1, not "status" from unpack_loose_header()
>  - object-file.c: guard against future bugs in loose_object_info()
>  - object-file.c: stop dying in parse_loose_header()
>  - object-file.c: split up ternary in parse_loose_header()
>  - object-file.c: simplify unpack_loose_short_header()
>  - object-file.c: add missing braces to loose_object_info()
>  - object-file.c: make parse_loose_header_extended() public
>  - object-file.c: don't set "typep" when returning non-zero
>  - cache.h: move object functions to object-store.h
>  - cat-file tests: test for current --allow-unknown-type behavior
>  - cat-file tests: add corrupt loose object test
>  - rev-list tests: test for behavior with invalid object types
>  - cat-file tests: test that --allow-unknown-type isn't on by default
>  - cat-file tests: test for missing object with -t and -s
>  - fsck tests: add test for fsck-ing an unknown type
>  - fsck tests: refactor one test to use a sub-repo
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Needs review.

Will re-roll on the minor comment from Andrei:
https://lore.kernel.org/git/d77583dc-5dd6-7992-bf48-456f14e36207@gmail.com/

Maybe that'll spark some interest...
