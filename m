Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B2C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 00:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E761166
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 00:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhIVAXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhIVAXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 20:23:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42AAC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 17:22:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u27so2981753edi.9
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VFs2u7HfDTbl+p2IQeenrH3b8bK/iUsiMXkl+fqTeRw=;
        b=LVcUi8YJ/h0bq7tDcACUBZ/u7AxNHgTsxfQU1LG8nOiHKzz6UI0Tx1W6WeTyB148du
         t0Xx+JveWd783DdaJSZOg/NO7EoitZEhKJB3LBQJ4Axz0M5F0I2X8EJ1w7J6ngE46IPL
         Qay26tTLrJ01ZQChFoWgvE1Gfm8tIjsq1S4joQZOBB+DZTCGN/tsDXMOFm6Il+8b+j1/
         QH1zmLhPGHqmVVVNxyhk/QAfLxfyN77zXLn13MsVTNUFFNy6yzPPUz5RKntfCypPg3Vg
         Fdo3EiNkkm1sutI9YemDjIDnuAaLffMZy7ghS/eWgd4+c3XI2f1+XtMOP2XTwbnuUKMe
         zXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VFs2u7HfDTbl+p2IQeenrH3b8bK/iUsiMXkl+fqTeRw=;
        b=6v5pUsIkB+ar/GC1acLt+n1TBA2kfDL6QQAoYhoRFwPiHH9smp4OnqtCjiFn3Pa3Ja
         Z26e+Lp469JrJNKQMEOASnJUc/+lqvsE8LH3SfstyvqPPYaSWxSNo5bpTF+gpSOMCzY6
         z9djXuEl6h62TuP1Im2yOdzM2FtPukZPGh0vzIFZAAaJFw25nBDVuMcfYFHSAurhh1dw
         e81cOTfx/Yn5eq7eKKDyPFrY0gu5QBCnwL6PIgdl3p+rmwKCDDaO2/8BhKytJKM/1r4J
         XtcEFJFbDsPIluubyd5stcAc7Vc+EW2UOikPjRZdKL25Jf3U/YpTAW3KCOsf3Wud1ISS
         t19w==
X-Gm-Message-State: AOAM533RomSODzps5oHQhtmx+nHNHgiNUV4KcWuudkKUjiC2sUydg51L
        6vdr3NKXgjvkljUP5y0UfaU=
X-Google-Smtp-Source: ABdhPJytFtw4HKu6pf18kZmBw5Fp/gkPtLhk4AouT1bEKrH/70Zxx3P83Krw0oKJntvP1F2wT0dF/Q==
X-Received: by 2002:a17:906:5f88:: with SMTP id a8mr39778482eju.564.1632270136826;
        Tue, 21 Sep 2021 17:22:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q11sm215894edv.80.2021.09.21.17.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 17:22:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
Date:   Wed, 22 Sep 2021 01:07:00 +0200
References: <xmqq1r5iaj9j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq1r5iaj9j.fsf@gitster.g>
Message-ID: <875yut8nns.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Junio C Hamano wrote:

As usual, updates on my topics:

> * ab/make-tags-cleanup (2021-08-05) 5 commits
> * ab/progress-users-adjust-counters (2021-09-09) 2 commits
> * ab/serve-cleanup (2021-08-05) 10 commits
> * ab/tr2-leaks-and-fixes (2021-09-07) 6 commits
> * ab/unbundle-progress (2021-09-07) 4 commits

Thanks!

> * ab/repo-settings-cleanup (2021-09-20) 5 commits
>  - repository.h: don't use a mix of int and bitfields
>  - repo-settings.c: simplify the setup
>  - read-cache & fetch-negotiator: check "enum" values in switch()
>  - environment.c: remove test-specific "ignore_untracked..." variable
>  - wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
>
>  Code cleanup.
>
>  Will merge to 'next'?
>  cf. <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
>  Looks like we got an implicit Ack from Derrick?

Sounds like the consensus is that it's ready for 'next'. I submitted a
v4 which both Taylor Blau & Derrick Stolee gave their
Reviewed-By/"LGTM", respectively:
https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com/;
Thanks both!

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.
>
>  Waiting for reviews.

I said a while ago I'd re-roll this with the actually interesting parts
included, will do that soonish.

> * es/config-based-hooks (2021-09-09) 6 commits
>  - hook: allow out-of-repo 'git hook' invocations
>  - hook: include hooks from the config
>  - hook: introduce "git hook list"
>  - hook: allow parallel hook execution
>  - fixup! hook: run a list of hooks instead
>  - hook: run a list of hooks instead
>  (this branch uses ab/config-based-hooks-base.)
>
>  Revamp the hooks subsystem to allow multiple of them to trigger
>  upon the same event and control via the configuration variables.
>
>  On hold.
>  This is an interim one that goes with the updated ab/config-based-hooks-base.

More on this below....

> * ab/fsck-unexpected-type (2021-09-07) 22 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object types
>  - object-file.c: use "enum" return type for unpack_loose_header()
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

Taylor gave the v6 a really thorough review, and I re-rolled with a v7:
https://lore.kernel.org/git/cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com/

I think the current state is probably that he's going to get to looking
the v7 over a bit better, let's wait a few days...

> * ab/align-parse-options-help (2021-09-12) 4 commits
>  - parse-options: properly align continued usage output
>  - git rev-parse --parseopt tests: add more usagestr tests
>  - send-pack: properly use parse_options() API for usage string
>  - parse-options API users: align usage output in C-strings
>
>  When "git cmd -h" shows more than one line of usage text (e.g.
>  the cmd subcommand may take sub-sub-command), parse-options API
>  learned to align these lines, even across i18n/l10n.
>
>  Will merge to 'next'?

I think it's ready, I've got a minor v5 re-roll now :
https://lore.kernel.org/git/cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com/

> * ab/help-config-vars (2021-09-10) 6 commits
>  - fixup! help / completion: make "git help" do the hard work
>  - help / completion: make "git help" do the hard work
>  - help: correct logic error in combining --all and --config
>  - help tests: add test for --config output
>  - help: correct usage & behavior of "git help --guides"
>  - help: correct the usage string in -h and documentation
>
>  Teach "git help -c" into helping the command line completion of
>  configuration variables.
>
>  Will merge to 'next'?

I re-rolled it just now:
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com/T/#u

I think it should be ready, but as shown there the range-diff against
the v2 is non-trivial.

> * ab/gc-remove-unused-call (2021-09-12) 1 commit
> [...]
>  Will merge to 'master'.
> [...]
>  Will merge to 'master'.

Thanks!

> * ab/unused-script-helpers (2021-09-12) 4 commits
> [...]
>  Will merge to 'master'.

Thanks. Between this and this and the upcoming
git-rebase-preserve-merges.sh removal I had some plans for code
deletions in this area, but would appreciate your feedback at
https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/

I.e. I still have no idea what sort of sweet spot you're trying to aim
for with backwards compatibility for the *.sh libraries....

> * ab/retire-option-argument (2021-09-12) 4 commits
> [...]
>  Will merge to 'master'.
> * ab/http-drop-old-curl-plus (2021-09-13) 9 commits
>  Will merge to 'master'.

Thanks!

> * ab/sanitize-leak-ci (2021-09-20) 2 commits
>  - tests: add a test mode for SANITIZE=leak, run it in CI
>  - Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
>
>  CI learns to run the leak sanitizer builds.
>
>  Will merge to 'next'?

Yes please, as noted in
https://lore.kernel.org/git/87r1dh8r62.fsf@evledraar.gmail.com/ more
leak fixes are waiting on this.

I think the mode itself is thoroughly reviewed, we just had some hiccups
with t0000-basic.sh between "master" and "seen", but the v7 picked other
less troublesome tests as canaries:
https://lore.kernel.org/git/cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com/

> * ab/lib-subtest (2021-08-05) 11 commits
> [...]
>
>  Updates to the tests in t0000 to test the test framework.

Stalled for quite some time, I wonder seeing as it's purely a test-only
code movement (and largely a code deletion) whether we could just
declare it good enough to proceed...

> * ab/only-single-progress-at-once (2021-07-23) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - pack-bitmap-write.c: add a missing stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c: stop eagerly fflush(stderr) when not a terminal
>  - progress.c: call progress_interval() from progress_test_force_update()
>  - progress.c: move signal handler functions lower
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop verbs on stdin
>
>  Further tweaks on progress API.
>
>  On hold.
>  cf. <20210901050406.GB76263@szeder.dev>

I re-rolled this, and think per
https://lore.kernel.org/git/cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com/
that this should be put off hold.

Hopefully SZEDER will chime in, but it appears to me that
<20210901050406.GB76263@szeder.dev> may have been based on a
misunderstanding about which series was queued up, or perhaps just
general justified paranoia about a BUG() in that code, but I think I've
shown that we probably won't run into one in the updated commit message
in v2.

> * ab/config-based-hooks-base (2021-09-09) 36 commits
>  - hooks: fix a TOCTOU in "did we run a hook?" heuristic
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - receive-pack: convert 'update' hook to hook.h
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output

<mark2> (referenced below)

>  - reference-transaction: use hook.h to run hooks
>  - hook tests: use a modern style for "pre-push" tests
>  - hook tests: test for exact "pre-push" hook input
>  - transport: convert pre-push hook to hook.h
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - am: convert 'post-rewrite' hook to hook.h
>  - hook: support passing stdin to hooks
>  - run-command: allow stdin for run_processes_parallel

<mark1> (referenced below)

>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: convert post-merge to use hook.h
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand

<mark0> (referenced below)

>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c users: use "hook_exists()" instead of "find_hook()"
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() from run-command.c to hook.c
>  - Makefile: remove an out-of-date comment
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY
>  (this branch is used by es/config-based-hooks.)
>
>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

It seems due to the size of this series we might be better off splitting
up this already split-up series.

I was trying to convince you to merge down the much more trivial changes
up to the <mark0> above, which are purely build system prep work. Any
chance you'd reconsider?

I think a plan that might be better would be:

 1. Eject both ab/config-based-hooks-base & es/config-based-hooks
 2. I'd submit a series up to the <mark0>, hopefully that can land fairly
    soon thereafter.
 3. Once that's in, another one for <mark0>..<mark1>, i.e. the "git hook
    run" command, but only the more basic bits, and migrating fairly
    simple hooks.
 4. Then <mark1>..<mark2>, followed by <mark2>..ab/config-based-hooks-base
 5. Then Emily's es/config-based-hooks.

That's converting a 2-step process (ab/config-based-hooks-base +
es/config-based-hooks) into 5 steps, but I suspect it would go faster,
right now it seems there's no takers for a review of this rather large
series. What do you & Emily think?

> * hn/reftable (2021-09-10) 20 commits
>  - fixup! reftable: implement stack, a mutable database of reftable files.
>  - Add "test-tool dump-reftable" command.
>  - reftable: add dump utility
>  - reftable: implement stack, a mutable database of reftable files.
>  - reftable: implement refname validation
>  - reftable: add merged table view
>  - reftable: add a heap-based priority queue for reftable records
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: generic interface to tables
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - Provide zlib's uncompress2 from compat/zlib-compat.c
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: RFC: add LICENSE
>  - hash.h: provide constants for the hash IDs
>
>  The "reftable" backend for the refs API, without integrating into
>  the refs subsystem.
>
>  Will merge to 'next'?
>
>
> * ab/refs-files-cleanup (2021-08-25) 13 commits
>  - refs/files: remove unused "errno != ENOTDIR" condition
>  - refs/files: remove unused "errno == EISDIR" code
>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>  - refs API: remove OID argument to reflog_expire()
>  - reflog expire: don't lock reflogs using previously seen OID
>  - refs/files: add a comment about refs_reflog_exists() call
>  - refs: make repo_dwim_log() accept a NULL oid
>  - refs/debug: re-indent argument list for "prepare"
>  - refs/files: remove unused "skip" in lock_raw_ref() too
>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>  - refs: drop unused "flags" parameter to lock_ref_oid_basic()
>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>  - refs/packet: add missing BUG() invocations to reflog callbacks
>  (this branch is used by ab/refs-errno-cleanup and hn/refs-errno-cleanup.)
>
>  Continued work on top of the hn/refs-errno-cleanup topic.
>
>  Will merge to 'next'?
>
>
> * hn/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.
>
>  Will merge to 'next'?

I think "yes" to all of these, but I'm obviously biased :)

We had the cleanup topics merged to "next" already in an earlier
iteration, ran into an issue that's well understood & now fixed. I don't
think hanging around in "seen" for longer is going to give us any more
meaningful testing or data.

The combination of those topics & hn/reftable then allows us to proceed
with "real" reftable work.
