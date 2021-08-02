Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E59FC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC7D61057
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhHBJdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 05:33:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74217C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 02:32:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qk33so29823040ejc.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=svaf1SdVKiHdswKexzurVQEA59/9RZ6PDP+DJozOwZo=;
        b=YLFco7ZTEyplPolGAMYkMyO+Svpuxrpfbrpi5Bk2ubrPbznZU6KGm0zm1kVVNwVLPj
         17QlyuBVbYyjQ7/yPljXYBor0gZUNtroL7Vb6M3Vm3W8oNM8OlRbK+49iTp061TKRRaf
         cJ++srVpd7f0694SVttUI7A0X3pBwMHY2w4jbTPAM5JW7ycXtaq482NzP5HDmNPca4Px
         EL44CL0qhTqi7LV7tWC+vB9GXuVN0jngAcAJP+bDgYKABtLJzEYFgxwWQUQtGWyGBJuR
         1NGYOJJrt8wX3QRGHr5ywn0jtt7TFz5lPY0SbFzNXfWP1i9yQCLNiuYgxL7fTJ32C3jP
         gH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=svaf1SdVKiHdswKexzurVQEA59/9RZ6PDP+DJozOwZo=;
        b=VNc3hTqkod+sTWk45lSzM1D0oQJ955J1n6WyhZF3vra0AKfSEhiKspIFYyJVwnkcmP
         TbFthnyfSPE5ba84yBEDnhRYV+vAg1JLEOXkTexaVsX377HgG7nNMDv24dS6qmXpcW/D
         9sQCaGbc8amMcwpnmnuDhmoFZDgykihkJ8fH3auEC4ECm3KmmDmtINxYJiI+uLFIAMGg
         zFxIOF4c1MUCNbfm/OdGpEfwDxFZAFt3r3Q58pf4I3cF9LIgec4+CPfgYY789l2S/Mh+
         aXYh8zwWIVh5gKbOLHvCwKIFhubgjb89psxdl4mc6ARQ+je6P0X0F1piPgA2MKQPS/+s
         kCAg==
X-Gm-Message-State: AOAM532cfoscmONIiHVHk26VLwuCuu70hcaxEbz0IqNHTDDKNazQk1xm
        tEIhTw9hvG1D/LhvayyL3K4=
X-Google-Smtp-Source: ABdhPJwos7fSVx63YwigIRqylVOwoq/aP1joeunvG4EJIS3FV82IPrJWkH2co4LV3LLxlP5FkaLaAQ==
X-Received: by 2002:a17:906:c013:: with SMTP id e19mr14844407ejz.389.1627896772857;
        Mon, 02 Aug 2021 02:32:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d2sm4241279ejo.13.2021.08.02.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:32:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
Date:   Mon, 02 Aug 2021 11:04:20 +0200
References: <xmqqk0l4xuvo.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqk0l4xuvo.fsf@gitster.g>
Message-ID: <87wnp4p4xo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 01 2021, Junio C Hamano wrote:

> * ab/getcwd-test (2021-07-30) 1 commit
>  - t0001: fix broken not-quite getcwd(3) test in bed67874e2
>
>  Portability test update.
>
>  Will merge to 'next'.

Thanks!

> * ab/http-drop-old-curl (2021-07-30) 5 commits
>  - http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
>  - http: drop support for curl < 7.19.3 and < 7.17.0 (again)
>  - http: drop support for curl < 7.19.4
>  - http: drop support for curl < 7.16.0
>  - http: drop support for curl < 7.11.1
>
>  Support for ancient versions of cURL library has been dropped.
>
>  Will merge to 'next'.

Thanks, and also for fixing up the commit message while picking it up.

> * ab/lib-subtest (2021-07-21) 10 commits
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test th etest framework.

SZEDER et al: Re-poke about a request for review, per:
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/

Typo: s/th e/the /.

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

SZEDER: Re-poke about a request to review, per:
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/

> * ab/progress-users-adjust-counters (2021-07-23) 3 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - midx: don't provide a total for QSORT() progress
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Will merge to 'next'.

Still marked for "next", last time around (in
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/) I
asked:

    Thanks. Do you think a re-roll is needed for what you mentioned in
    https://lore.kernel.org/git/xmqqbl6slmer.fsf@gitster.g/?

I'll assume a "no" as far as me doing a re-roll, but in case you just
didn't see that...

> * ab/bundle-tests (2021-07-22) 2 commits
>   (merged to 'next' on 2021-07-22 at 053b5d0ecf)
>  + bundle tests: use test_cmp instead of grep
>  + bundle tests: use ">file" not ": >file"
>
>  "git bundle" gained more test coverage.
>
>  Will merge to 'master'.

Thanks!

> * ab/refs-files-cleanup (2021-07-26) 11 commits
>  - refs/files: remove unused "errno != ENOTDIR" condition
>  - refs/files: remove unused "errno == EISDIR" code
>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>  - reflog expire: don't lock reflogs using previously seen OID
>  - refs/files: add a comment about refs_reflog_exists() call
>  - refs: make repo_dwim_log() accept a NULL oid
>  - refs/debug: re-indent argument list for "prepare"
>  - refs/files: remove unused "skip" in lock_raw_ref() too
>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>  - refs/packet: add missing BUG() invocations to reflog callbacks
>  (this branch is used by hn/refs-errno-cleanup.)
>
>  Waiting for a reroll.
>  Patches are mostly good, but needs typofixes etc.

In the last WC this had a "Will merge to 'next'", I think the typofixes
etc. note is obsolute for 1-2 iterations now, latest one at:
https://lore.kernel.org/git/cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com

> * ab/bundle-doc (2021-07-20) 3 commits
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: elaborate on object prerequisites
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Expecting a reroll.
>  at least for the second patch.

I think
https://lore.kernel.org/git/cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com/
should address this.

This note (I think) applies to v6.

> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Ack?
>  cf. <YND3h2l10PlnSNGJ@nand.local>

As noted in
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/ let's
take Taylor's https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/
as that Ack (he was also CC'd on my reply to the last WC...)>

> * ab/make-tags-cleanup (2021-07-22) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: the "cscope" target always creates a "cscope.out"
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Expecting a reroll.
>  4/5 may want a minor tweak to the log and the patch text but otherwise looks good.

Per my note in reply to the last WC I think it's fine as-is:
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/

> * ab/config-based-hooks-base (2021-06-29) 33 commits
>  - hooks: fix a TOCTOU in "did we run a hook?" heuristic
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - receive-pack: convert 'update' hook to hook.h
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - reference-transaction: use hook.h to run hooks
>  - transport: convert pre-push hook to use config
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - am: convert 'post-rewrite' hook to hook.h
>  - hook: support passing stdin to hooks
>  - run-command: allow stdin for run_processes_parallel
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change hook to use config
>  - commit: use hook.h to execute hooks
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: use config-based hooks for post-merge hook
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch hooks to use config
>  - rebase: teach pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand
>  - hook-list.h: add a generated list of hooks, like config-list.h
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

I'll re-roll this one as promised in
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/; didn't
get to it.

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
>  Expecting a reroll.
>  cf. <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
>  cf. <87tul24iw2.fsf@evledraar.gmail.com>

As noted in my notes on the last WC these have both been addressed in a
re-roll.

> * hn/refs-errno-cleanup (2021-07-26) 7 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch uses ab/refs-files-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.
>
>  Blocked by ab/refs-files-cleanup but otherwise is ready for 'next'.

I think both are ready for next per the note above, i.e.t that blockage
in ab/refs-files-cleanup is resolved 1-2 re-rolls of mine ago.

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Will re-roll per
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/; didn't
get around to it.

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.

As noted in last week's WC I re-rolled this for a merge conflict with
"seen": https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/
& would like to see this advance to unblock some feature work I've got
unsubmitted...

> * ab/update-submitting-patches (2021-07-22) 2 commits
>   (merged to 'next' on 2021-07-30 at 9ae2de7f7a)
>  + SubmittingPatches: replace discussion of Travis with GitHub Actions
>  + SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Will merge to 'master'.

Thanks!
