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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD440C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A4F610CC
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGVHVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhGVHVf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:21:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CBFC061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:02:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hd33so7077153ejc.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=peHrZcpdOzxdLjX8sDlCyWjoIj620XUPma+DVz8AcJM=;
        b=SH6sG3F4nwXVvzBivA7Mm9HvAe/AlUOL+cRFudXwxXH+R1P40XSFBr/tir7warHMrr
         ht0HQzzWFXd9lrI3udlORwN+ZVYhkRbZ707dxBCnaagndhHcWAbBHyp1oyD3ckTCQlf4
         9xQS8KSyxfTKNaiKpQC9ckVolLXAS98EEMPH2HvwSy3azkGAz8E2/2u+rcSZF6joDoFY
         Zl1oz0H1QMp0cu4rm6GkgYzF3HzOZxqD8G45kIq9we03HGYyxj9qEL+IWQSFbBF9GG2r
         XHFgrwLdZMT0lphN7zMwOTxGmmSTR3wECTJFm/V7S0SNe57z06UqNF2GUNlMOPWB0Bh3
         bhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=peHrZcpdOzxdLjX8sDlCyWjoIj620XUPma+DVz8AcJM=;
        b=JEa/PCz0gn6jDz9a4QH3mxVByereiwIGA9rTak9KfOhpjK3Uh4Ejrf0Lm3aGwBLsqc
         kWCllLLvBmPRYJGNxcpEkqTOuFmRz1rsVRZuMFeu19septNkfxaORDaBhTBeT+moudhZ
         kkCrlxDJXo6YqN1N4VlfiWYUJjS1UxhMYdK87zR0f/pl5dIikqAAfhMQN8JViAUH0bfC
         uA+eXtjOGL3Yf3bBSa5vlo+Kn6tTXUiiEW+jcD+SQsEwwKtKg9+v6dmIaydofTzJUXKW
         ghNd8tJQTtNVexFVmMiforbWZK5CVWnE8e2LfQSHDtYa1HFy+g3mFw+mxqRcRjscRc+K
         aNPQ==
X-Gm-Message-State: AOAM532iLfMO3LLQfWu19iQtLZ78T8jFOFpU/8V+wr+29HV+KYvP1PaU
        UbC3x5+ZPogJ81Es8jcu9v8=
X-Google-Smtp-Source: ABdhPJzO5/xxzjaV/9hSHQsFAmlvCfaUfL2DCHaxL723vR6sd2cI5Dtz+kMAWDJZ9Tx6ERXQVkEakQ==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr43398530ejz.235.1626940928118;
        Thu, 22 Jul 2021 01:02:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o23sm9885533edv.22.2021.07.22.01.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 01:02:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jul 2021, #05; Wed, 21)
Date:   Thu, 22 Jul 2021 09:33:39 +0200
References: <xmqqo8av9j7f.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqo8av9j7f.fsf@gitster.g>
Message-ID: <87a6mevkrx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Junio C Hamano wrote:

> It has only been two days since the previous issue, but here it is.
>
> Two topics at the tip of 'seen' breaks CI (d000d1d); it can be seen
> that an extra CI run on 'seen' without them (7d8ed3b) passes.
>
>  (d000d1d) https://github.com/git/git/actions/runs/1053603028

I'll look at that, FWIW it looks like you rewound d000d1d and the
current version of it is 286871f41aa (Yikes, 2021-07-20). I.e. it's the
hn/reftable probably interacting with my ab/refs-files-cleanup.

Updates on my topics & things I have comments on below:

> * ab/bundle-tests (2021-07-20) 2 commits
>  - bundle tests: use test_cmp instead of grep
>  - bundle tests: use ">file" not ": >file"
>
>  "git bundle" gained more test coverage.
>
>  Will merge to 'next'.

Thanks!

> * es/config-based-hooks (2021-07-20) 9 commits
>  - hook: implement hookcmd.<name>.skip
>  - hook: teach 'hookcmd' config to alias hook scripts
>  - hook: allow out-of-repo 'git hook' invocations
>  - hook: include hooks from the config
>  - hook: allow running non-native hooks
>  - hook: treat hookdir hook specially
>  - hook: introduce "git hook list"
>  - hook: allow parallel hook execution
>  - hook: run a list of hooks instead
>  (this branch uses ab/config-based-hooks-base.)
>
>  The "hooks defined via the configuration variables" topic.

Outstanding comments from me:

 * Core design / complexity concerns:
   https://lore.kernel.org/git/87fswey5wd.fsf@evledraar.gmail.com/
=20
 * Re-adding needless complexity I fixed in the base topic:
   https://lore.kernel.org/git/87r1fyy728.fsf@evledraar.gmail.com/

 * Maybe a bug in the base topic?
   https://lore.kernel.org/git/87tukuy7vc.fsf@evledraar.gmail.com/

   At least it needs a test in es/config-based-hooks.

   I don't see how it's an issue without es/config-based-hooks, i.e. the
   sendemail-validate is always in-repo, except maybe with
   core.hooksPath?

There's also some other trivial suggestions of squashes, code style
etc. in that thread from me, but that's the main gist of the outstanding
comments for now.

> * ab/refs-files-cleanup (2021-07-20) 12 commits
>  - refs/files: remove unused "errno !=3D ENOTDIR" condition
>  - refs/files: remove unused "errno =3D=3D EISDIR" code
>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>  - reflog expire: don't lock reflogs using previously seen OID
>  - refs/files: add a comment about refs_reflog_exists() call
>  - refs: make repo_dwim_log() accept a NULL oid
>  - refs API: pass the "lock OID" to reflog "prepare"
>  - refs/debug: re-indent argument list for "prepare"
>  - refs/files: remove unused "skip" in lock_raw_ref() too
>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>  - refs/packet: add missing BUG() invocations to reflog callbacks
>  (this branch is used by hn/refs-errno-cleanup.)
>
>  Patches are mostly good, but needs typofixes etc.
>
>  Will merge to 'next'.

Yay, thanks!

> * ab/attribute-format (2021-07-13) 5 commits
> [...]
> * ab/imap-send-read-everything-simplify (2021-07-07) 1 commit
> [...]
> * ab/pkt-line-tests (2021-07-19) 1 commit

Thanks!

> * ab/bundle-doc (2021-07-20) 3 commits
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: elaborate on object prerequisites
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Expecting a reroll.
>  at least for the second patch.

My reading-between-the-lines of
https://lore.kernel.org/git/xmqqsg08hhs0.fsf@gitster.g/ and
https://lore.kernel.org/git/xmqqo8awhh5z.fsf@gitster.g/ is that you'd be
happy toh have this be merged down in its current form, no?

> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Ack?
>  cf. <YND3h2l10PlnSNGJ@nand.local>

Have re-rolled & addressed that, I think
https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/ can be read as
"sure, let's take =C3=86var's v2 as-is", but let's have Taylor Ack that :)

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

Re-rolled since & addressed those, hopefully ready for "next" now:
https://lore.kernel.org/git/cover-0.5-00000000000-20210721T231900Z-avarab@g=
mail.com/

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

This one really needs a review, especially from the original author,
Emily, but ...

>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() to this new library
>  - Makefile: remove an out-of-date comment
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY

...in case further prodding helps I'd like to poke you again about
having this base-topic-for-the-base-topic proceed ahead already, per the
discussion we had ending at
https://lore.kernel.org/git/xmqqim1spupt.fsf@gitster.g/

I.e. I submitted these as:

    https://lore.kernel.org/git/cover-0.3-0000000000-20210629T190137Z-avara=
b@gmail.com/
    https://lore.kernel.org/git/cover-0.3-0000000000-20210629T183325Z-avara=
b@gmail.com/

I think they're rock-solid & ready to move ahead. I'm not so sure about
the rest of ab/config-based-hooks-base, with 33 commits there + another
9 in es/config-based-hooks I think anything to reduce the size will help
reviewers.

>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

The one thing I have for it locally is that the commit messages still
say "use config", but we don't use config yet (just an artifact of the
patch origin before rebasing/rewriting).

I was hoping to convince you to do the above suggested split-up before
re-rolls, and of course any comments from Emily etc.

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

Re-rolled at
https://lore.kernel.org/git/cover-00.12-00000000000-20210721T233307Z-avarab=
@gmail.com/

A bit of an undirected "let's fix various stuff" at this point, but
fixing up the semantics of a widely-used API is probably inevitably
going to be like that.

I do have meaningful patches on top that I'm waiting to submit, which
hopefully will make the whole picture make more sense, but I think this
cleanup is worth it.

It's really a reduction in "real" code size, but the added tests &
conversion to designated initializers is deceptive.

> * hn/refs-errno-cleanup (2021-07-20) 7 commits
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
>  Will merge to 'next'.

Sweet. After this & the going-to-next ab/refs-files-cleanup I had (as
noted) some more (but rather trivial) loose ends cleanups to submit on
top.

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Emily: Poke @
https://lore.kernel.org/git/87pmw3dlkl.fsf@evledraar.gmail.com/

I'd think in the absence of an update from Emily (in general I've got a
few things bottlenecked in that area...), this rather trivial cleanup is
hopefully easily understood enough to move ahead.

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.

Would love to have a status update on this one / have it merged down, as
noted in
https://lore.kernel.org/git/cover-0.5-00000000000-20210709T105850Z-avarab@g=
mail.com/
I've got more interesting work waiting on it.

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

I'll get to this one today, for real this time...

> * ab/send-email-optim (2021-05-28) 13 commits
>   (merged to 'next' on 2021-07-08 at 35ac315894)
>  + perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
>  + send-email: move trivial config handling to Perl
>  + perl: lazily load some common Git.pm setup code
>  + send-email: lazily load modules for a big speedup
>  + send-email: get rid of indirect object syntax
>  + send-email: use function syntax instead of barewords
>  + send-email: lazily shell out to "git var"
>  + send-email: lazily load config for a big speedup
>  + send-email: copy "config_regxp" into git-send-email.perl
>  + send-email: refactor sendemail.smtpencryption config parsing
>  + send-email: remove non-working support for "sendemail.smtpssl"
>  + send-email tests: test for boolean variables without a value
>  + send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue
>
>  "git send-email" optimization.
>
>  Will merge to 'master'.

Thanks!

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

Yeah, this has been hanging for a while, so here's a request for
reviewers I guess. It's at
https://lore.kernel.org/git/cover-00.21-00000000000-20210710T133203Z-avarab=
@gmail.com/

I have a bunch of disconnected updates to the object APIs in various
areas that I need to re-roll. In isolation they're fixing rather obscure
issues, but I think the end result yields much better APIs
(i.e. structured error return, don't just die()).

At the end of that we can do some real simplification of upstream
consumers, e.g. the whole --allow-unknown-type handling, --literally
etc.

So if that end-goal sounds good to anyone please take a look at this
topic, thanks!
