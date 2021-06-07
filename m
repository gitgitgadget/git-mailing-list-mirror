Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA1C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F1860FEF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFGO13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:27:29 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:34454 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhFGO13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:27:29 -0400
Received: by mail-ej1-f42.google.com with SMTP id g8so27032330ejx.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wPyCiPU0ozebq7cdkZnrBILARB3K1X+/T3Bx4HqnqOE=;
        b=TA0hEvHdbleL2jFdRj6d2dwhNIrqOlNgqeeQJ24bk9tgbj/P5WPSGdE7QqIIOGWzAP
         Ep5acZCXZKoHUEffyw0+YY9mcGwtPoyQvjBA7VItHJtRpvyss/yL36l2vIIW7Gaqmi28
         Fe0pEDuJo+iOyyrseYhjW8jQ/RaR8VxWpoCP+x4BKl0zNzQB5h9SWoLugiz/GzSXmYN/
         GnRpfp6QZYqZNuYytnbN0NZh1J3sRa91TuwbsWCWSjHys3SOajoSDbVZdj//+DZ3xGGU
         TK83kutToOk5s32ih0C42OmDNKCHT8T5lGTWBxMdEoLDRiB+ruLo9zQhAcshn6cVJe55
         ALoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wPyCiPU0ozebq7cdkZnrBILARB3K1X+/T3Bx4HqnqOE=;
        b=Al4vPKmDBayUnSE4PZqGhYqs978LfM6+NVL+ZHvNFL2jqNSWQAZzCgTP6WdWBs26p/
         BcfuLA5dG43Ij5lpaZXwxmCjMH7JGIWfa1jM6oNx4ATt0DmJK7gSUdELZwUsTszQt8oM
         Zh2r537rbqGCh3Dq2OOFHZY/702bQcWKN9KOejqIv7HCQsZuPJPp7W8BmgUUdzDVC2eK
         dVBrdvN4YssjgCaes0ckF3X7ZbBA6qRP9tVI54k3FAQR7SBi4GQFbZp/XpES9UKvZoAt
         Lp7Ht+GVHBJDMA0HHMg8F/OeuZThUlpdxD+7XARSvMwT4c5cYi4v9Zw2Gk5Vm/ZP2nzY
         7Zdw==
X-Gm-Message-State: AOAM5318TBib7V3tS9QZkzdQI1//DpyioYfewXZt95L1GK+MQD2dcLdK
        q5rUbrPOFsN0e1TVQ/Ko3FE=
X-Google-Smtp-Source: ABdhPJxttPfdHUT5vU5k8cBDvfSfIT1PDCLwn1Hx7Hslcs7bjlLNUic+bZ/GVbYfRNXrLMUMeCzkvQ==
X-Received: by 2002:a17:906:6bc7:: with SMTP id t7mr18468362ejs.267.1623075877182;
        Mon, 07 Jun 2021 07:24:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a22sm6500203ejv.67.2021.06.07.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:24:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #02; Sun, 6)
Date:   Mon, 07 Jun 2021 16:10:17 +0200
References: <xmqq4kebxj2d.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq4kebxj2d.fsf@gitster.g>
Message-ID: <87sg1t4usb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 06 2021, Junio C Hamano wrote:

> * ab/update-submitting-patches (2021-05-13) 3 commits
>  - SubmittingPatches: remove pine-specific hints from MUA hints
>  - SubmittingPatches: replace discussion of Travis with GitHub Actions
>  - SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Expecting a reroll.
>  cf. <xmqq4kf7fueq.fsf@gitster.g>, <20210512235136.GB10785@localhost>

I submitted that re-roll today as
https://lore.kernel.org/git/cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com/

> * ab/describe-tests-fix (2021-05-11) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"
>
>  Waiting for the base topic to solidify.

...

> * ab/pickaxe-pcre2 (2021-05-11) 22 commits
>  - xdiff-interface: replace discard_hunk_line() with a flag
>  - xdiff users: use designated initializers for out_line
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: allow early return from xdiff_emit_line_fn
>  - xdiff-interface: prepare for allowing early return
>  - pickaxe -S: slightly optimize contains()
>  - pickaxe: rename variables in has_changes() for brevity
>  - pickaxe -S: support content with NULs under --pickaxe-regex
>  - pickaxe: assert that we must have a needle under -G or -S
>  - pickaxe: refactor function selection in diffcore-pickaxe()
>  - perf: add performance test for pickaxe
>  - pickaxe/style: consolidate declarations and assignments
>  - diff.h: move pickaxe fields together again
>  - pickaxe: die when --find-object and --pickaxe-all are combined
>  - pickaxe: die when -G and --pickaxe-regex are combined
>  - pickaxe tests: add missing test for --no-pickaxe-regex being an error
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - grep/pcre2 tests: reword comments referring to kwset
>  (this branch uses ab/test-lib-updates.)

...

> * es/config-based-hooks (2021-05-27) 37 commits
>  - docs: link githooks and git-hook manpages
>  - doc: clarify fsmonitor-watchman specification
>  - run-command: stop thinking about hooks
>  - git-send-email: use 'git hook run' for 'sendemail-validate'
>  - bugreport: use hook_exists instead of find_hook
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - proc-receive: acquire hook list from hook.h
>  - receive-pack: convert 'update' hook to hook.h
>  - reference-transaction: look for hooks in config
>  - transport: convert pre-push hook to use config
>  - hook: convert 'post-rewrite' hook to config
>  - hooks: convert 'post-checkout' hook to hook library
>  - git-p4: use 'git hook' to run hooks
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change hook to use config
>  - rebase: teach pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - merge: use config-based hooks for post-merge hook
>  - am: convert applypatch hooks to use config
>  - commit: use config-based hooks
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - hook: allow specifying working directory for hooks
>  - hook: allow parallel hook execution
>  - run-command: allow stdin for run_processes_parallel
>  - hook: support passing stdin to hooks
>  - hook: introduce hook_exists()
>  - hook: add 'run' subcommand
>  - parse-options: parse into strvec
>  - hook: implement hookcmd.<name>.skip
>  - hook: teach hook.runHookDir
>  - hook: include hookdir hook in list
>  - hook: introduce git-hook subcommand
>  - doc: propose hooks managed by the config

I'd like to get some feedback on whether you think my proposed
re-staring of the topic is something you're interested in accepting in
lieu of this approach.

I'm still waiting on Emily to reply to
https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/ I'd
think it's best to wait for whath she has to say about it before.

I had the impression per
http://lore.kernel.org/git/xmqqeedi4m6o.fsf@gitster.g that you were in
favor of it. There's some outstanding comments on my v1[1]. I'd like to
get some more sense of whether there's interest in it before working on
and sending a v2 to the list.

> * ab/send-email-optim (2021-05-28) 13 commits
>  - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
>  - send-email: move trivial config handling to Perl
>  - perl: lazily load some common Git.pm setup code
>  - send-email: lazily load modules for a big speedup
>  - send-email: get rid of indirect object syntax
>  - send-email: use function syntax instead of barewords
>  - send-email: lazily shell out to "git var"
>  - send-email: lazily load config for a big speedup
>  - send-email: copy "config_regxp" into git-send-email.perl
>  - send-email: refactor sendemail.smtpencryption config parsing
>  - send-email: remove non-working support for "sendemail.smtpssl"
>  - send-email tests: test for boolean variables without a value
>  - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
>
>  "git send-email" optimization.

I think this is ready for "next" at this point.

> * ab/trace2-squelch-gcc-warning (2021-05-21) 1 commit
>   (merged to 'next' on 2021-05-28 at 6c7a015f99)
>  + trace2: refactor to avoid gcc warning under -O3
>
>  Workaround compiler warnings.
>
>  Will cook in 'next'.

Thanks.

> * ab/test-lib-updates (2021-05-11) 11 commits
>   (merged to 'next' on 2021-05-31 at 73bf1ecb31)
>  + test-lib: split up and deprecate test_create_repo()
>  + test-lib: do not show advice about init.defaultBranch under --verbose
>  + test-lib: reformat argument list in test_create_repo()
>  + submodule tests: use symbolic-ref --short to discover branch name
>  + test-lib functions: add --printf option to test_commit
>  + describe tests: convert setup to use test_commit
>  + test-lib functions: add an --annotated option to "test_commit"
>  + test-lib-functions: document test_commit --no-tag
>  + test-lib-functions: reword "test_commit --append" docs
>  + test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>  + test-lib: bring $remove_trash out of retirement
>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>
>  Test clean-up.

Per the note on the last What's Cooking I think this is ready[2], and
it's been in next for a ~week already.

So just a note to update the status of this, and since
ab/describe-tests-fix & ab/pickaxe-pcre2 would then be un-blocked by
this we can hopefully get them in early in this cycle too.

> * ab/fsck-unexpected-type (2021-05-21) 17 commits
>  . fsck: report invalid object type-path combinations
>  . fsck: report invalid types recorded in objects
>  . object-store.h: move read_loose_object() below 'struct object_info'
>  . fsck: don't hard die on invalid object types
>  . object-file.c: return -1, not "status" from unpack_loose_header()
>  . object-file.c: return -2 on "header too long" in unpack_loose_header()
>  . object-file.c: stop dying in parse_loose_header()
>  . object-file.c: add missing braces to loose_object_info()
>  . object-file.c: make parse_loose_header_extended() public
>  . cache.h: move object functions to object-store.h
>  . cat-file tests: test for current --allow-unknown-type behavior
>  . cat-file tests: add corrupt loose object test
>  . rev-list tests: test for behavior with invalid object types
>  . cat-file tests: test that --allow-unknown-type isn't on by default
>  . cat-file tests: test for missing object with -t and -s
>  . fsck tests: add test for fsck-ing an unknown type
>  . fsck tests: refactor one test to use a sub-repo
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Seems to break tests when merged to 'seen'.

I have not gotten to debugging this yet, which'll require me to find
some 32 bit machine to reproduce the issue, except I can't on the 32 bit
machines I've tried so far.

1. https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com/
2. https://lore.kernel.org/git/87cztlr688.fsf@evledraar.gmail.com/
