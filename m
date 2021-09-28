Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D9C61058
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhI1CiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhI1CiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:38:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1ACC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:36:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dn26so144417edb.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=b1TfXwlYPBjuZujnkDjJH2qlDXipNQQr1FIHZVT8RRo=;
        b=aV/D+KcL5tseUiGjBopgv0Z6zXC77d+NXDpp1qfLKWTpqL49rgwMdGwCgeplCZBn2H
         xMTjZqasDkU7Ki85pcqCBHjj+2B0C0+EBenwunplk3oAoIn4zX6hYxYtZdH9newkeLFV
         OPNI+t4NpClj7Zklq64RnSk8kDCikqDC2U+h7rdTnefKhQh+yWoB+0QnJ044Lc+NpIjp
         ELODIBIM/9MHeTPenIZuLKwet4VI7A7UjzJ5PI4GzCuB1j7zJ+WfweMpUVb/hxegSyIM
         GO/bCiLBUkzkuaYgQCPlpSy+e/eP3mH3Pf/qMarSui7bEJ36Ny0Tq6i1ZmwWxsZUCkuK
         n9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=b1TfXwlYPBjuZujnkDjJH2qlDXipNQQr1FIHZVT8RRo=;
        b=I/x0st9AslUIKN8ReYHN2FTwZSX2UEWk9TYhdVmWs82m8G87b/l3LU2Wn55fTabPw5
         b8O4XYAZlWwJHNlnR92c40hOt7p+uW3x7R7VNmkZXxh1duvq8GRm7BklYb1KOFLGl977
         U68Wrlus+v+f/FQDPfaBaSGzP50zCVHV14QOjEOWFE9igbFQ6cxLzHtENuhowGUfXbev
         FZEvCCHgwlURRbX0X7yDfPHDHqeaGobOMh0+jOtHloTPxibXNdr6EiPPrXzS6qg8hDSh
         I0jttfo7AhFg6NJmDG3MvYs5K8sR7lvJlwX00VceqXzJvj55xGoJtDfHCAK4OOZhHxqT
         +5Ig==
X-Gm-Message-State: AOAM531q6D6HlWqn0CP1YFIQ2iUcqANlGP/njZ/PIrh8wUaEI8zqhQrj
        0tM4j/7zXqLIETqR+TLZXOs=
X-Google-Smtp-Source: ABdhPJyiiuJZJ2Y4APcpGITaaMYxdpp0aTBDQtI1xQblVsAmqa033fXO5bf9a1zEFb5pCC/Trq1Imw==
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr3996957ejc.77.1632796598029;
        Mon, 27 Sep 2021 19:36:38 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7sm624000edt.37.2021.09.27.19.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:36:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.org>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Date:   Tue, 28 Sep 2021 03:57:01 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzhmsi7.fsf@gitster.g>
Message-ID: <87czotzaru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

Updates on my topics, CC'd the people I mentioned.

> * ab/config-based-hooks-1 (2021-09-27) 8 commits
>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c users: use "hook_exists()" instead of "find_hook()"
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() from run-command.c to hook.c
>  - Makefile: remove an out-of-date comment
>  - Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY

Thanks for picking this up. Looks like my split-up plan is working in
that this has received a lot of careful review.

I think per Ren=C3=A9's the v2 should be good-to-go, barring any new
undiscovered issues:
https://lore.kernel.org/git/0e07cee4-079a-af12-880f-d4a99300df28@web.de/

> * ab/http-pinned-public-key-mismatch (2021-09-27) 1 commit
>  - http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors
>
>  HTTPS error handling updates.
>
>  Will merge to 'next'?

I'd like it merged. I think a fair summary of Jeff King's
https://lore.kernel.org/git/YU5CJC9XJvQITfr8@coredump.intra.peff.net/ is
"meh" though :)

I think the translation improvement + mentioning the specific git config
variable in play is a pretty minor but still worthwhile change.

> * ab/make-compdb-fix (2021-09-27) 1 commit
>  - Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=3Dyes
>
>  Build update.
>
>  Will merge to 'next'.

Thanks, FWIW I thought Carlos's cb/make-compdb-fix was better, but see
from this E-Mail & other context that you'd looked at both and preferred
the consistency with my COMPUTE_HEADER_DEPENDENCIES fix.

In any case both fix the immediate "pedantic" fallout.

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.
>
>  Expecting a reroll.

I said I'd re-roll this into the larger "git bundle --stdin" topic I had
in mind, but when doing so found one memory leak, which I really wanted
the SANITIZE=3Dleak interface to fix.

I think it's best to eject/discard this given the amount of other
outstanding stuff I've got. I don't really *need* this for anything
else, I'll loop back to it sometime after the SANITIZE=3Dleak testing has
landed.

> * ab/fsck-unexpected-type (2021-09-22) 17 commits
> [...]
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Needs review.

The "needs review" note here pre-dates v6, which got a thorough review,
and Taylor seemed happy with the v7, aside from a minor issue I just
re-rolled v8 with a fix for:

https://lore.kernel.org/git/cover-v8-00.17-00000000000-20210928T021616Z-ava=
rab@gmail.com/

> * ab/make-clean-depend-dirs (2021-09-22) 1 commit
> [...]
>  Will merge to 'next'.

Thanks!

> * ab/auto-depend-with-pedantic (2021-09-22) 1 commit
>  - Makefile: make COMPUTE_HEADER_DEPENDENCIES=3Dauto work with DEVOPTS=3D=
pedantic
>
>  Improve build procedure for developers.
>
>  Will merge to 'next'.

Thanks!

> * ab/make-sparse-for-real (2021-09-22) 1 commit
>  - Makefile: make the "sparse" target non-.PHONY
>
>  Prevent "make sparse" from running for the source files that
>  haven't been modified.
>
>  Will merge to 'next'?

I just submitted a hopefully final v4, please ignore the v3 :)
https://lore.kernel.org/git/patch-v4-1.1-f31fa3e8282-20210928T014023Z-avara=
b@gmail.com/T/#u

That leaves "sparse" as the bug-for-bug compatible old target, with a
new "sparse-incr" for those (like me) who want the incremental
version. The feedback on v2 was mainly about the change in behavior
breaking existing workflows, so v4 should get around that nicely.

> * ab/repo-settings-cleanup (2021-09-22) 5 commits
> [...]
>  Will merge to 'next'.

Thanks!

> * ab/align-parse-options-help (2021-09-22) 4 commits
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

I think it's ready for that.

> * ab/help-config-vars (2021-09-23) 9 commits
>  - help: move column config discovery to help.c library
>  - help / completion: make "git help" do the hard work
>  - help tests: test --config-for-completion option & output
>  - help: simplify by moving to OPT_CMDMODE()
>  - help: correct logic error in combining --all and --guides
>  - help: correct logic error in combining --all and --config
>  - help tests: add test for --config output
>  - help: correct usage & behavior of "git help --guides"
>  - help: correct the usage string in -h and documentation
>
>  Teach "git help -c" into helping the command line completion of
>  configuration variables.
>
>  Will merge to 'next'?

I think so too, you had some feedback on the v3, I think partially
addressed by the "simplify by moving to OPT_CMDMODE()" step.

For further improving the usage info in the rare case of combining
e.g. --all and --config I'd prefer to just leave it for a future
improvement.

> * ab/sanitize-leak-ci (2021-09-23) 2 commits
>  - tests: add a test mode for SANITIZE=3Dleak, run it in CI
>  - Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS
>
>  CI learns to run the leak sanitizer builds.
>
>  Will merge to 'next'?

Yes please! As noted in some other threads I've got more memory leak
fixes waiting on this, and since the v8 to avoid testing the split index
it doesn't seem to be causing any trouble:
https://lore.kernel.org/git/cover-v8-0.2-00000000000-20210923T091819Z-avara=
b@gmail.com/

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "remainder" of hn/refs-errno-cleanup topic.

I think this should be ready too, but if you'd prefer to wait a bit
after ab/refs-files-cleanup and ab/refs-files-cleanup land I understand,
it's a lot of ref code changes...

> * ab/lib-subtest (2021-09-22) 9 commits
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test the test framework.
>
>  Will merge to 'next'?

Yes please, it was waiting on review for a long time. Carlo had some
feedback on it that I re-rolled v4 addressing, resolving what I think
was the main sticking point all along. I.e. conflating a test assertion
mode with this t0000 cleanup/split-up:

https://lore.kernel.org/git/cover-v4-0.7-00000000000-20210922T111734Z-avara=
b@gmail.com/

> * ab/only-single-progress-at-once (2021-09-22) 8 commits
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

I think per
https://lore.kernel.org/git/cover-v2-0.8-00000000000-20210920T225701Z-avara=
b@gmail.com/
this should be ready to progress.

I.e. it was held off due to comment from SZEDER that once clarified I
understand to be a general concern that we should test the 8/8 step. As
noted in the re-rolled 8/8 I've tested this thoroughly in a way that
would break if that BUG() was going to bite us.

> * ab/refs-files-cleanup (2021-08-25) 13 commits
> [...]
>
>  Continued work on top of the hn/refs-errno-cleanup topic.
>
>  Will merge to 'master'.

[...]

> * hn/refs-errno-cleanup (2021-08-25) 4 commits
> [...]
>
>  Will merge to 'master'.

Yay, thanks!
