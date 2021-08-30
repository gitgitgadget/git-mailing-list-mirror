Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A2660F5C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhH3MGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbhH3MDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 08:03:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0EC061764
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:03:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i21so30624537ejd.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SfOhdTFSJb0oUEavO0n4Qvo2oEVvVzDWuAse9m6CiFU=;
        b=nnIrDe+DiEdICxHJIfV5/XFPQWLhKX6bl76wHfNhvN6ziiV4kK+W6BtzOAyI9QF+pi
         ep5TBCiSsfuVW78F+GZFJYdGvu0GlBMx/CI/3rVEWv3zCs8VF/sIjfYllZsx7ZDN4sMc
         5sKtpbhUg/KaYxNzw+3iQrf8KOitmTDDQkmiJcbmCVLTG9C+gkHAFeMZU+t/k3SnZl5n
         D1v/qdVBNJfXPukgqZfMCXoPOIbMWyRqzHD+FrGMiYNuiuuR9NUBDU4Yp/uzhuIRcf8a
         nPa6xf5wPnavuiSxMgSn/d4Yca6J8qTxPD/+OHf1P5xDfatPvyPHcYawaaBG/smRpFy8
         02FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SfOhdTFSJb0oUEavO0n4Qvo2oEVvVzDWuAse9m6CiFU=;
        b=Ng9JdAhS6XD0s/sGNrJubu60zUvzk1qtFvylS2tgfArl9fGSQV73DGTKRnVzzFwp+j
         5F4Dh+zWVtc6Iwb8xGCgO0sSHFEcIWPQMGrnhham6tf9C9lfVxhW+bL8HWpG9IVwEktx
         x+WEutYsDkMz989OnwMrXxyiI3yDfw5fVyOYFTmf2ADtUACO3jc3psh6OUL4ZgEs4LzI
         lkXP+lr/+npeHjT7suEWGvJ1A6tw7MpVVOAFjIrSdRE0ptnwJi9cse/feM9KLjy5GsNt
         Q8UHyR1Wo6NrhfVJ6+frQGh9HEShXVXUSpPggXNM94slPe39z4vD+riCBbu0WGPfqjsw
         0l2Q==
X-Gm-Message-State: AOAM533AM6GnqoGFKYM9KNXZGzvUmGggGdjEFEtneWMKbU7hWt7C72mC
        jy3kNXcTDwy57dvkam3G4oY=
X-Google-Smtp-Source: ABdhPJytvscuaWPeQPwKiHUWkayliiEdU0KJO8unQY/pOM9c18taD03CL9EOjF81UWVzlsk9LuxWtw==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr25357124eji.385.1630324977355;
        Mon, 30 Aug 2021 05:02:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s23sm7653597eds.12.2021.08.30.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:02:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
Date:   Mon, 30 Aug 2021 13:00:46 +0200
References: <xmqq35qr7mq5.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq35qr7mq5.fsf@gitster.g>
Message-ID: <87tuj7xhqo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 29 2021, Junio C Hamano wrote:

> I've been a bit under the weather during the last week and wanted to
> concentrate on what to push out to 'master', so while I may have
> picked up new topics and replaced existing topics with their new
> versions, I haven't added or updated my summaries on their doneness
> to this document.  Help is appreciated.

Sorry to hear that, hope you're in good health now.

Below is my usual summary of my topics + topics I've got comments on.

Please take the below comments in the spirit of helping you along
whenever you can get to them, and not as needless prodding to prioritize
them in particular over others.

Also re your <xmqqbl5ml70u.fsf@gitster.g> I'll switch to quoting
Message-ID's in that style, and not as
https://lore.kernel.org/git/<msgid> links. FWIW I was doing the latter
for the benefit of readers on the sidelines, but will switch.

> [Graduated to 'master']
> [...]
> * ab/bundle-doc (2021-08-02) 4 commits

Thanks!

> * ab/http-drop-old-curl (2021-07-30) 5 commits

Thanks. I've got those changes to introduce a git-curl-compat.h etc. on
top ready to go, but haven't submitted them considering the amount of
things I've got outstanding, but if you'd like them sooner than later...

> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits

Thanks!

> * hn/refs-test-cleanup (2021-08-02) 11 commits

Yay, more of reftable moving forward...

> [...]
> [New Topics]
>
> * ab/commit-graph-usage (2021-08-25) 7 commits
>  - commit-graph: show "unexpected subcommand" error
>  - commit-graph: show usage on "commit-graph [write|verify] garbage"
>  - commit-graph: early exit to "usage" on !argc
>  - multi-pack-index: refactor "goto usage" pattern
>  - commit-graph: use parse_options_concat()
>  - commit-graph: remove redundant handling of -h
>  - commit-graph: define common usage with a macro

Taylor, SZEDER: That's at
<cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>, you
reviwed the earlier
<cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>, what do you
think about this version?

> * ab/ls-remote-packet-trace (2021-08-24) 1 commit

Thanks!

> * ab/rebase-fatal-fatal-fix (2021-08-24) 1 commit

Thanks!

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  (this branch is used by hn/reftable; uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "remainder" of hn/refs-errno-cleanup topic.

Thanks, and thanks for bearing with me on the whole
ab/refs-errno-cleanup & hn/refs-errno-cleanup v.s. hn/reftable ordering
question.

> * ab/retire-advice-config (2021-08-25) 4 commits
>  - advice: move advice.graftFileDeprecated squashing to commit.[ch]
>  - advice: remove use of global advice_add_embedded_repo
>  - advice: remove read uses of most global `advice_` variables
>  - advice: add enum variants for missing advice variables
>
>  Code clean up to migrate callers from older advice_config[] based
>  API to newer advice_if_enabled() and advice_enabled() API.
>
>  Want to merge to 'next' but a tree-wide change like this can
>  interfere other topics in flight, so I'll need to block some time
>  to see how safe it is to proceed before we can do so.

As you've doubtless found out, since this series doesn't change the
advice.h API a patch like the outstanding
<7749a69a38faeceadc7a8735fb3d0edd359c954c.1629842085.git.gitgitgadget@gmail.com>
by Derrick Stolee doesn't conflict with it, but the scaffolding part in
<496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
by Josh Steadmon does.

I think in this case the least painful thing overall is to get this
topic merged down to "master" sooner than later, i.e. before we get more
patches needing advice.c changes based on top of the current master.

But alternatively I could re-roll and split up
<patch-v4-4.4-7f79fb282e5-20210823T103719Z-avarab@gmail.com> and leave
the "static struct" in place with some dummy variable, purely to make
resolving any merge conflicts easier for you. We'd then eventually drop
that scaffolding later.

Or I could do nothing and you could merge this down at whatever pace
you're OK with. Just let me know if I can help make it easier in any
way.

> * ab/unbundle-progress (2021-08-27) 5 commits

This has outstanding feedback at
<cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> that I need
to respond to.

> * ab/fsck-unexpected-type (2021-07-12) 21 commits
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

:( @ the no takers in reviewing it. E.g. at
<87v93wflm0.fsf@evledraar.gmail.com>.

> * zh/cherry-pick-advice (2021-08-23) 1 commit
>  - cherry-pick: use better advice message
>
>  The advice message that "git cherry-pick" gives when it asks
>  conflicted replay of a commit to be resolved by the end user has
>  been updated.
>
>  Will merge to 'next'?

I think so, I looked it over as part of browsing advice()-related
changes, looks good to me.

> * es/config-based-hooks (2021-08-19) 7 commits
>  - hook: allow out-of-repo 'git hook' invocations
>  - hook: include hooks from the config
>  - hook: allow running non-native hooks
>  - hook: introduce "git hook list"
>  - hook: allow parallel hook execution
>  - hook: run a list of hooks instead
>  - Merge branch 'ab/config-based-hooks-base' into es/config-based-hooks
>  (this branch uses ab/config-based-hooks-base.)
>
>  Revamp the hooks subsystem to allow multiple of them to trigger
>  upon the same event and control via the configuration variables.
>
>  Will merge to 'next'?
>  cf. <87v93wflm0.fsf@evledraar.gmail.com>

This needs a re-roll based on my comments in reply to
<20210819033450.3382652-1-emilyshaffer@google.com>. It's mostly ready as
far as the end-state is concerneb, but e.g. will break "rebase" (a
commit in the middle doesn't compile), leaks memory etc.

It needs a re-roll of ab/config-based-hooks-base, which I was waiting on
some of Emily's feedback to do. Looks like there's no outstanding things
there, so iwll work on that SOON.

> * js/advise-when-skipping-cherry-picked (2021-08-10) 2 commits
>  - SQUASH???
>  - sequencer: advise if skipping cherry-picked commit
>
>  "git rebase" by default skips changes that are equivalent to
>  commits that are already in the history the branch is rebased onto;
>  give messages when this happens to let the users be aware of
>  skipped commits, and also teach them how to tell "rebase" to keep
>  duplicated changes.

This LGTM with your proposed obviously-correct squash.

Re comment about ab/retire-advice-config above: I could also just fold
this into that series if you'd prefer, i.e. it would be one way to deal
with the only outstanding merge conflict in advice.c between
master..seen.

> * cb/makefile-apple-clang (2021-08-06) 3 commits
>  - build: catch clang that identifies itself as "$VENDOR clang"
>  - build: clang version may not be followed by extra words
>  - build: update detect-compiler for newer Xcode version
>
>  Build update.
>
>  Will merge to 'next'.

Makes sense. Any reason other than lack of time that you opted not to go
for the IMO simpler approach I suggested in
<87bl6aypke.fsf@evledraar.gmail.com>?

> * ab/lib-subtest (2021-08-05) 11 commits
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: assert no copy/pasted mock test code
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test the test framework.

I think with my re-roll at
<cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> it should be
OK to declare this good to go sooner than later. I.e. the only trouble I
can imagine this causing in
<patch-v3-6.9-bc79b29f3c-20210805T103237Z-avarab@gmail.com> is now easy
to revert in isolation.

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

(Summary copied from <87v93wflm0.fsf@evledraar.gmail.com>)

The changes are rather straightforward, see
<cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>; so if anyone's
interested in reviewing them.

There's been no reports of anyone running into the new BUG() assertion
in 8/8 of it: <patch-8.8-1a14176bee-20210722T125012Z-avarab@gmail.com>

> * ab/progress-users-adjust-counters (2021-08-25) 2 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Will merge to 'next'?

Yes, should be good to go with my re-roll at
<cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>, which
you've picked up here.

> * fs/ssh-signing (2021-08-29) 9 commits
>  - ssh signing: test that gpg fails for unknown keys
>  - ssh signing: tests for logs, tags & push certs
>  - ssh signing: duplicate t7510 tests for commits
>  - ssh signing: verify signatures using ssh-keygen
>  - ssh signing: provide a textual signing_key_id
>  - ssh signing: retrieve a default key from ssh-agent
>  - ssh signing: add ssh key format and signing code
>  - ssh signing: add test prereqs
>  - ssh signing: preliminary refactoring and clean-up
>
>  Use ssh public crypto for object and push-cert signing.
>
>  Comments?

I'm also interested in this one. My reading of
<9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> is that the author
plans to re-roll it sometimes around mid-September. I personally punted
on reviewing the current version while waiting for that.

> * cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
>  - fetch: fix segfault on --set-upstream while on a detached HEAD
>
>  "git fetch --set-upstream" while on detached HEAD segfaulted
>  instead of noticing that such an operation did not make sense.
>
>  Expecting a reroll.
>  cf. <xmqqsg0ri5mq.fsf@gitster.g>

I think the author's comment in reply to my
<patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com> can be read
as them being happy to go with my alternate version, but CC'd them.

I'll re-roll with what I noted in <87bl5nfcof.fsf@evledraar.gmail.com>,
which amounts to a cosmetic change, but is probably easier to read.

> * ab/make-tags-cleanup (2021-08-05) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Expecting a reroll.
>  4/5 may want a minor tweak to the log and the patch text but otherwise looks good.

(Summary copied from <87v93wflm0.fsf@evledraar.gmail.com>)

This entire comment has been in What's Cooking since v3 of the series,
but v4 has been out since August 4th:
<cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>

> * ab/config-based-hooks-base (2021-08-03) 36 commits
> [...]
>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

See above comment for ab/config-based-hooks-base.

> * ab/serve-cleanup (2021-08-05) 10 commits
>  - upload-pack: document and rename --advertise-refs
>  - serve.[ch]: remove "serve_options", split up --advertise-refs code
>  - {upload,receive}-pack tests: add --advertise-refs tests
>  - serve.c: move version line to advertise_capabilities()
>  - serve: move transfer.advertiseSID check into session_id_advertise()
>  - serve.[ch]: don't pass "struct strvec *keys" to commands
>  - serve: use designated initializers
>  - transport: use designated initializers
>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>  - serve: mark has_capability() as static
>
>  Code clean-up around "git serve".
>
>  Expecting a reroll.

(Summary copied from <87v93wflm0.fsf@evledraar.gmail.com>)

The "Expecting a reroll" here was added in response to (I think) my
commentary in <87wnp1mqv2.fsf@evledraar.gmail.com> that I'd re-roll it,
but the already picked up v4 is that re-roll:
<cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>

> * ab/test-tool-cache-cleanup (2021-08-24) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.

I had a "take it or leave it" comment at
<878s0nz5q2.fsf@evledraar.gmail.com>.

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

I had a series waiting to be submitted that depends on this and
ab/bundle-doc, since ab/bundle-doc has landed I think I'll re-roll this
with that feature series appended, to see if there's more interest once
the end-state I was going for is known...

> * hn/reftable (2021-08-26) 29 commits
>  - SQUASH??? https://github.com/git/git/runs/3439941236?check_suite_focus=true#step:5:700
>  - reftable: fixup for new base topic 3/3
>  - reftable: fixup for new base topic 2/3
>  - reftable: fixup for new base topic 1/3
>  - t1404: annotate test cases with REFFILES
>  - t1401,t2011: parameterize HEAD.lock for REFFILES
>  - t1301: document what needs to be done for reftable
>  - Add "test-tool dump-reftable" command.
>  - git-prompt: prepare for reftable refs backend
>  - refs: RFC: Reftable support for git-core
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
>  - init-db: set the_repository->hash_algo early on
>  - hash.h: provide constants for the hash IDs
>  (this branch uses ab/refs-errno-cleanup, ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "reftable" backend for the refs API.

Han-Wen: It would be really nice to have this re-rolled sooner than
later, my and Junio's "fixup" commits at the end are a band-aid, but I
already ran into wanting to bisect something between master..seen that
was unnecessarily painful due to the series now not compiling without
the "fixup" commits at the end.

> * ab/refs-files-cleanup (2021-08-25) 13 commits
> [...]
> * hn/refs-errno-cleanup (2021-08-25) 4 commits
> [...]
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.

As noted in the comment for ab/refs-errno-cleanup above, thanks!
