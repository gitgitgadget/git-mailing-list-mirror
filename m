Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D10EC4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058E2610D2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbhIBOUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbhIBOUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:20:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BFC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:10:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q3so3099412edt.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0385MUNzXUTtCJs9n/0zB5Zqh0R1V3pBhAR9sXj+gHQ=;
        b=OnMNrYnF/m68NIV1IXGvBk3R+465C+bquQsc+njUzJ/+TrqUba/mzsS4N5xgPkM9ym
         HQPRaOJqComIn3gRROAoknOxk5G9y8W3k82+32ddzVq/u5z/25DJOI4o33v7KRKH1b/q
         gMFBJ3AODlEdYPFGIDDpRJEFP/8Su6/fOD4paTy8q35kse8n97N6kTeKTOxOd0KXLPBS
         aOg4XQgFu/FhkrBWzhcdSyxkx2CkNCieg3EirKCmeMbLBsLp1vgM5gS9jX8FkGHkJ7of
         XjtO825rdlpsHisf9MrbZ4Uja4Ovwt8317HfhDA2HOsc9mxhgwr7HNHqm6XJIosc9Hy0
         zTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0385MUNzXUTtCJs9n/0zB5Zqh0R1V3pBhAR9sXj+gHQ=;
        b=M5I0GpswURYlQq/fvu1oOBnCD9njhDhje6Jf34f47iu1Xz1w28gXWYMWvMlO1AKKD7
         43klQm9x4OU4qB9fDoDcNeSDPhy7rMXJ6tUAR2t4GU1GsiKpWlMTG1iplv3W/2eSH1fR
         rFjy+3ftLnryw/qkwHA5CBhGucpFSRtJaRRgNqZ1AzuPO/ZL6iM6BptVATCXMyH6qMnW
         kuthtKr4BATZkf8wXCtnOnk2LfNv6sS8odeO1VCZqRCZTzF/MUn0xoKEkhyXIEefAgl2
         Nx0SE9JAVerkCj6T6SLcsdDlKqfhk+TsnUFtjBpceqfDcDzzhWlofCTJJGPV32UqE76X
         WNoQ==
X-Gm-Message-State: AOAM531OkFSiR5wSBGlgq+o3Lc3FX3CVxXD2xOiXfXMtvuFRUb5KjBXM
        MgKV8MS2VUozUxQStyOlPJk=
X-Google-Smtp-Source: ABdhPJydzONUAY5+YxZPM79BlVKcMJCZkxE/4KjNZyLFj/pvbm5vEDAeW4HuHnAoPy73db+nuXvQBQ==
X-Received: by 2002:aa7:d648:: with SMTP id v8mr3732110edr.340.1630591832655;
        Thu, 02 Sep 2021 07:10:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i19sm1245384edx.54.2021.09.02.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:10:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #10; Tue, 31)
Date:   Thu, 02 Sep 2021 15:29:33 +0200
References: <xmqqo89drwad.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo89drwad.fsf@gitster.g>
Message-ID: <8735qnax0o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Junio C Hamano wrote:

> * ab/gc-log-rephrase (2021-08-31) 1 commit
>  - gc: remove trailing dot from "gc.log" line
>  (this branch uses uk/userdiff-php-enum.)

Is the dependency on uk/userdiff-php-enum a mistake? They combine just
fine, but they don't have an inter-dependency.

>  Will merge to 'next'?

I think so, also per my <87eea9wdit.fsf@evledraar.gmail.com>

> * ab/mailmap-leakfix (2021-08-31) 1 commit
> * ba/object-info (2021-08-31) 1 commit
> [...]
>  Will merge to 'next'.

Thanks!

> * uk/userdiff-php-enum (2021-08-31) 1 commit
> [...]
>  Update the userdiff pattern for PHP.
>
>  Will merge to 'next'.

Looks good, noted funny inter-dependency with ab/gc-log-rephrase above.

> --------------------------------------------------
> [Stalled]
>
> * gh/gitweb-branch-sort (2021-06-10) 1 commit
>  - gitweb: use HEAD as secondary sort key in git_get_heads_list()
>
>  Tie-break branches that point at the same object in the list of
>  branches on GitWeb to show the one pointed at by HEAD early.
>
>  Waiting for reviews.

I don't use gitweb anymore, but looked this
(<20210609192806.45406-1-greg@hurrell.net>) over just now. Looks good to
me.

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

Reviews most welcome!

> * ab/commit-graph-usage (2021-08-30) 7 commits
> [...]
>  Will merge to 'next'.

Thanks, and also far adding Taylor Blau's Reviewed-by.

> * ab/ls-remote-packet-trace (2021-08-24) 1 commit
> * ab/rebase-fatal-fatal-fix (2021-08-24) 1 commit
> [...]
>  Will merge to 'master'.

Thanks!

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  (this branch is used by hn/reftable; uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "remainder" of hn/refs-errno-cleanup topic.

Noted below.

> * ab/retire-advice-config (2021-08-25) 4 commits
>  - advice: move advice.graftFileDeprecated squashing to commit.[ch]
>  - advice: remove use of global advice_add_embedded_repo
>  - advice: remove read uses of most global `advice_` variables
>  - advice: add enum variants for missing advice variables
>
>  Code clean up to migrate callers from older advice_config[] based
>  API to newer advice_if_enabled() and advice_enabled() API.
>
>  Will merge to 'next'.

Thanks!

> * ab/unbundle-progress (2021-08-27) 5 commits
>  - bundle: show progress on "unbundle"
>  - index-pack: add --progress-title option
>  - bundle API: change "flags" to be "extra_index_pack_args"
>  - strvec: add a strvec_pushvec()
>  - bundle API: start writing API documentation
>
>  Add progress display to "git bundle unbundle".
>
>  Expecting a reroll.
>  cf. <87tuj7xhqo.fsf@evledraar.gmail.com>

Will get to it. This has outstanding feedback at
<cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> that I need
to respond to.

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
>  Expecting a reroll
>  but ab/config-based-hooks-base needs to be in a better shape first.
>  cf. <87v93wflm0.fsf@evledraar.gmail.com>
>  cf. <87tuj7xhqo.fsf@evledraar.gmail.com>

Discussed below.

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

In <xmqqeeaaz3i5.fsf@gitster.g> you noted:

    [...]it is still a bit disturbing to see these three versions were
    sent without much reaction to the list.

Perhaps someone looked it over but had nothing to add? It's hard to tell
if it's a lack of review or lack of any suggestions. Any takers?

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

SZEDER asked you to hold this off in
<20210901050406.GB76263@szeder.dev>: "I've found some issues with it,
but not the time to raise them.". Scary, but no idea what those issues
are yet...

> * ab/progress-users-adjust-counters (2021-08-25) 2 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Will merge to 'next'?

[Copied from my reply to What's Cooking @
<87tuj7xhqo.fsf@evledraar.gmail.com>]:

Yes, should be good to go with my re-roll at
<cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>, which
you've picked up here.

> * ab/make-tags-cleanup (2021-08-05) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Will merge to 'next'?

I think it's ready for that. Thanks.

> * ab/config-based-hooks-base (2021-08-03) 36 commits
>  - hooks: fix a TOCTOU in "did we run a hook?" heuristic
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - receive-pack: convert 'update' hook to hook.h
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
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
>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c users: use "hook_exists()" insted of "find_hook()"
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() to this new library
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

I've re-rolled this just now at
<cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>. Emily
will need to re-roll her es/config-based-hooks on top of it.

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
>  Will merge to 'next'?

I think it's ready for it. Derrick Stolee looked at least some of it
over at <17efcff7-9a62-046b-ecf9-2cbed84280e9@gmail.com>, and the
current v4 had deeper review in earlier rounds (which I addressed).

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

[Copied from my reply to What's Cooking @
<87tuj7xhqo.fsf@evledraar.gmail.com>]:

I had a series waiting to be submitted that depends on this and
ab/bundle-doc, since ab/bundle-doc has landed I think I'll re-roll this
with that feature series appended, to see if there's more interest once
the end-state I was going for is known...

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
>  (this branch is used by ab/refs-errno-cleanup, hn/refs-errno-cleanup and hn/reftable.)
>
>  Continued work on top of the hn/refs-errno-cleanup topic.
>
>
> * hn/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch is used by ab/refs-errno-cleanup and hn/reftable; uses ab/refs-files-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.

I think these three (hn/refs-errno-cleanup + ab/refs-errno-cleanup +
ab/refs-files-cleanup) should be stable by now. They were ejected out of
"next" previously due to some previously obscure edge cases (now fixed)
that were spotted only when they got down to "next".

So I wonder if the only thing for them is more wider testing...
