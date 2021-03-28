Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448ADC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BC06194B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1Nuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1NuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:50:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30AEC061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:50:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ap14so2289392ejc.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=I5c/GbXCBRx+7FPSNnz4pUYlv93dnKtlJwAyLbvADD4=;
        b=oCoZ2LT/w2tlbaBqD/aQQ6+B4lu0PUhK80vmE237aG/9c6ZBH57/9qprtT1a8cuU3M
         vin4AyB2bL7Gfofhu/eS1Yfq0cAwqWi3klR6YVV6GMFqzoQ3iA4zyCLAMoUAuAic4+RB
         vY0m4wa8q8heQzd/RToiujvoeaHVjkq06105adahkXISuyAN3e+Aja1i/UQtl7aCyY1Y
         twv0yZujrW6aUvRcnRoLi1UnBofRHREmQhfWoN7P6+bjKXPugiKIxwissaWB7F4L8LTi
         wndPkxdTsr3YxOcVpQiFc4g2JRukQaSOX14bUuJgOW6XD0jodnYm5s7KHL9S5vGm/rKT
         hZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=I5c/GbXCBRx+7FPSNnz4pUYlv93dnKtlJwAyLbvADD4=;
        b=PLzUXKJ34utCIlOV2YR72wT5y/g9equqAhKfuydhSgWcZeuYkm65PKgTkgtTF7c9gq
         5iW/MdCmjPHJzBVrgMWPMH3XQflEsn0nGXkfPFDvhl6fR8u2V3gArkmHymw940SnLGyQ
         hanNHZRYr5Zid/zTPrPPzr4G93U+R11lkA6MHc7A+zsGldsMRaiPjkrPyzSdECJjz/DS
         EHbO0Nw516DQoTzTVDOM8LOKhYFAqwApHYhCsDbMWEnUuLr1PzX+PNvrJyopKKCMp+R7
         Yc9TPUIZYFcaeBKNf6FJOOBWRKL/C+Ike07U5OvYMpHkzN1Ys6zAfcrkmyeYj53LpD1H
         7Qng==
X-Gm-Message-State: AOAM531/xiSw5t4pgzKExIBBfuic02yJEfNnurBB/IRyTxK2BxBCUaaU
        vkN4E/ZuCtq45RpaHmPrczw=
X-Google-Smtp-Source: ABdhPJzJWfHIlvgtkaWTwYqtWL9hXp/IowP1Xzbn1Dxe612S62FrG/bNl5nI+6RmHB9v49OvRgNalg==
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr23897462ejb.268.1616939421507;
        Sun, 28 Mar 2021 06:50:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ci22sm3353999ejc.54.2021.03.28.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:50:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2021, #07; Mon, 22)
References: <xmqq35wm5y6d.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq35wm5y6d.fsf@gitster.g>
Date:   Sun, 28 Mar 2021 15:50:20 +0200
Message-ID: <878s67o09v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 23 2021, Junio C Hamano wrote:

Quick notes on my outstanding submissions listed here:

> * ab/fsck-api-cleanup (2021-03-17) 19 commits
>  - fetch-pack: use new fsck API to printing dangling submodules
>  - fetch-pack: use file-scope static struct for fsck_options
>  - fetch-pack: don't needlessly copy fsck_options
>  - fsck.c: move gitmodules_{found,done} into fsck_options
>  - fsck.c: add an fsck_set_msg_type() API that takes enums
>  - fsck.c: pass along the fsck_msg_id in the fsck_error callback
>  - fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
>  - fsck.c: give "FOREACH_MSG_ID" a more specific name
>  - fsck.c: undefine temporary STR macro after use
>  - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>  - fsck.h: re-order and re-assign "enum fsck_msg_type"
>  - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>  - fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
>  - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>  - fsck.c: move definition of msg_id into append_msg_id()
>  - fsck.c: rename variables in fsck_set_msg_type() for less confusion
>  - fsck.h: use "enum object_type" instead of "int"
>  - fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
>  - fsck.c: refactor and rename common config callback
>
>  Fsck API clean-up.
>  cf. <20210317182054.5986-1-avarab@gmail.com>

Re-rolled just now;
https://lore.kernel.org/git/cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com/

> * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
>  - tests: get rid of $_x05 from the test suite
>  - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
>  - test-lib: remove unused $_x40 and $_z40 variables
>  - git-bisect: remove unused SHA-1 $x40 shell variable
>
>  Remove variables that hold regexp and glob that match fixed number
>  of hexadecimal digits from the test suite.
>
>  Expecting a reroll.
>  At least the last one weakens a test and should be dropped; there
>  may be similar breakage due to not understanding what they are
>  trying to test.

Looking at those patches again I think it would be acceptable to merge
this having peeled off either 4/4 or that patch and 3/4?

But as noted in that discussion I submitted these thinking some other
abbrev patches of mine had landed, but I misrecalled that and they never
did.

I have a version of those locally, so I'd rather just focus on that. So
if you're not interested in peeling off the first 2 or 3 patches of this
for the trivial cleanuplet's just drop this one.

> * ab/make-cocci-dedup (2021-03-22) 4 commits
>  - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>  - Makefile/coccicheck: allow for setting xargs concurrency
>  - Makefile/coccicheck: speed up and fix bug with duplicate hunks
>  - Makefile/coccicheck: add comment heading for all SPATCH flags
>
>  Coccicheck update.
>
>  cf. <cover.1616414951.git.avarab@gmail.com>

Should be dropped per
https://lore.kernel.org/git/87k0psnzv5.fsf@evledraar.gmail.com/

> * ab/unexpected-object-type (2021-03-08) 7 commits
>  - tag: don't misreport type of tagged objects in errors
>  - object tests: add test for unexpected objects in tags
>  - object.c: add a utility function for "expected type X, got Y"
>  - tree.c: fix misindentation in parse_tree_gently()
>  - oid_object_info(): return "enum object_type"
>  - object.c: make type_from_string() return "enum object_type"
>  - object.c: refactor type_from_string_gently()
>
>  Error reporting upon object type mismatch has been improved
>
>  Expecting a reroll.
>  Looked good except for some rewrites.

I have a re-roll of this at
https://lore.kernel.org/git/cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com/

It fixes the rewrites, but now there's some other outstanding feedback
on code in v1 (but not commented on at the time)...

> * ab/describe-tests-fix (2021-03-01) 10 commits
>  - test-lib: return 1 from test_expect_{success,failure}
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated-tag option to "test_commit"
>  - describe tests: always assert empty stderr from "describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>
>  Various updates to tests around "git describe"
>
>  Expecting a reroll.
>  cf. <xmqq1rcj6hzr.fsf@gitster.g>

Hoping to re-roll this soon...

> * ab/make-cleanup (2021-02-23) 5 commits
>   (merged to 'next' on 2021-03-22 at e9e16c9fc4)
>  + Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
>  + Makefile: split OBJECTS into OBJECTS and GIT_OBJS
>  + Makefile: sort OBJECTS assignment for subsequent change
>  + Makefile: split up long OBJECTS line
>  + Makefile: guard against TEST_OBJS in the environment
>
>  Originally merged to 'next' on 2021-03-19
>
>  Reorganize Makefile to allow building git.o and other essential
>  objects without extra stuff needed only for testing.
>
>  Will merge to 'master'.

Thanks, I'd seen before that that merge peeled off (Makefile: build
"$(FUZZ_OBJS)" in CI, not under "all", 2021-01-28) per list discussion
about wanting to have a canary for the fuzz objects.

Is there any interest in an "all" target that's narrowly tailored to
just build the git you asked for via other options? Maybe "make all
NO_CANARY=Y" ?

> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: support early exit in xdiff_outf()
>  - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
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
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - test-lib functions: add --printf option to test_commit
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib-functions: document and test test_commit --no-tag
>  - grep/pcre2 tests: reword comments referring to kwset
>  - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
>  - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>  Ready???

I think it's been ready for while, but unfortunately it hasn't gotten
much/any review.

The changes to the C code are all rather trivial (just the "change
return; to return 0" is rather verbose). 

> * ab/tree-walk-with-object-type (2021-03-17) 32 commits
>  . tree-walk.h API: add a tree_entry_extract_type() function
>  . blame: emit a better error on 'git blame directory'
>  . tree-walk.h API: add a get_tree_entry_path() function
>  . tree-walk.h API: add get_tree_entry_all()
>  . tree-walk.h API: add a tree_entry_extract_all() function
>  . tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
>  . tree-walk.h API: document and format tree_entry_extract()
>  . tree-walk.h API: add get_tree_entry_type()
>  . match-trees: use "tmp" for mode in shift_tree_by()
>  . tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
>  . tree-walk.h API: formatting changes for subsequent commit
>  . tree-walk.h users: use temporary variable(s) for "mode"
>  . fsck.c: switch on "object_type" in fsck_walk_tree()
>  . merge-ort: correct reference to test in 62fdec17a11
>  . merge-tree tests: test for the mode comparison in same_entry()
>  . tree-walk.h users: migrate miscellaneous "mode" to "object_type"
>  . tree-walk.h users: refactor chained "mode" if/else into switch
>  . tree-walk.h users: migrate "p->mode &&" pattern
>  . tree.h API: make read_tree_fn_t take an "enum object_type"
>  . archive: get rid of 'stage' parameter
>  . tree.h users: format argument lists in archive.c
>  . tree.h: format argument lists of read_tree_recursive() users
>  . tree-walk.h users: switch object_type(...) to new .object_type
>  . cache.h: have base_name_compare() take "is tree?", not "mode"
>  . diff tests: test that "mode" is passed when sorting
>  . mktree tests: test that "mode" is passed when sorting
>  . fast-import tests: test for sorting dir/file foo v.s. foo.txt
>  . tree-walk.c: migrate to using new "object_type" field when possible
>  . tree-walk.h: add object_type member to name_entry
>  . cache.h: add a comment to object_type()
>  . notes & match-trees: use name_entry's "pathlen" member
>  . diff.c: remove redundant canon_mode() call
>  (this branch uses ab/read-tree.)
>
>  Code clean-up.
>
>  I am not exactly sure where this series wants to go, other than
>  unnecessarily churning the code.  Seems to break "diff --no-index"
>  rather badly, too (e.g. t4050, t4002, among others).

I see this got ejected from "seen" around the time of the release.

As noted in
https://lore.kernel.org/git/87o8fcqrg8.fsf@evledraar.gmail.com/ I do
think it's a useful eventual step to simplify the various API use around
tree-walk to the desires of its callers (who really care about object
types, not what mode bits *say* about object types). As noted this
doesn't do that yet, but is necessary for that.

More importantly, I do need the improved tree-walk API this is leading
up to for fixing a long standing bug in us not validating tree mode bits
in fsck.
