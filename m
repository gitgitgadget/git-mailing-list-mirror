Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA063C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiKNKJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiKNKI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:08:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29608655F
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so27037494ejc.4
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KglISibYEWGedPmmCzFDBrZVz4Dy5msX1g6Cbt+4ko=;
        b=Si59up80C0wsPF0g+zNSGmia0skhEd5Kea+YzdJu8qO+ElM8kmXhZzBaT0IeMzzzyc
         3ixAbzV6fB+/29Hnjr70kcwdEVl8PUnJQdBULsQ9WQaKwwVRs8mf0TVEQ6rf1TwTQDgC
         UNq/yWKAEDHoaIExFlHIdrJZ1odzSLxGVHzRAsvJ/RZ/0ng2ytukOmK6ff+Bt7AYzoUF
         LdTBYOxbp4Wbb1DuvwT39c7eN6xmgUXOPXfY+g7Z8ODUDPd/im5udL4ISGzIhouRjj06
         LE5n1PgPhU9oT0GZziiQxvQiHBp5ilA0m7Fl0xebm10dZiDJ4XizV6ebNcUuAYzYPPpD
         8T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KglISibYEWGedPmmCzFDBrZVz4Dy5msX1g6Cbt+4ko=;
        b=IXAyj5PzbhVdON6vw/c/C+vZivqxv8QjhZonHIVxgJosYsRUS98zcGZ9VJmkCwh6Ll
         cAKMLKRUyKm1Mv9lPTvkRQZ8KtnV+rYFQHnkW6PhAjUc28mJsAzfXNTyV2JqK6m22CCv
         krqqsmcEikHbbewHV0kCN6nY7MBDwPw21lU2rZS1W530Row5Er5ABQLsw90n7+pZ3U8p
         7Siy1AQDqiK8tbSR/zVxkV6d9gn9/PCqn4rXx9gEn1HIon6XbdYH3tlZ+q5DBdW5ZgDc
         dKPdr6cTnFjgb8t7BvlnipW7iSePq181eASjOUFak5LwOKQhkThVw9meNzSxHPpkUI3t
         jlfQ==
X-Gm-Message-State: ANoB5pm32xiGe7Ct67aIrWb88T53EdtImfcXF7iwTgIWzM64p7xBU0Mb
        XLgZUHEikYDaLiPb58NjwntYfKxk3L8=
X-Google-Smtp-Source: AA0mqf4yHK/CVjdQ7WOJAGqao5DBC86N9dehJM5VrFIJt6VxZsMuW/OQbyh6e5hDmuGbUmPL4RMcKA==
X-Received: by 2002:a17:906:6d4:b0:7ad:bd02:f491 with SMTP id v20-20020a17090606d400b007adbd02f491mr10249964ejb.703.1668420534949;
        Mon, 14 Nov 2022 02:08:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] Get rid of "git --super-prefix"
Date:   Mon, 14 Nov 2022 11:08:40 +0100
Message-Id: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Summary

What's "--super-prefix"? The "git" command takes an "internal use
only" "--super-prefix" option, which is used to inform processes
invoked in submodules what the path prefix to the invoking
superproject is.

This is so so that e.g. "git submodule absorbgitdirs" can report
"sub-1/sub-2", instead of "sub-2" when being invoked in the "sub-1"
submodule.

For this the "--super-prefix" facility has been doing a
setenv("GIT_INTERNAL_SUPER_PREFIX", "sub-1/") as soon as it got the
"--supre-prefix=sub-1/". We'd then pass that along via the environment
when invoking the sub-process.

As this series shows we don't need such a hands-off global facility to
do this, we can instead just pass the relevant context directly in
each command. E.g. "git submodule absorbgitdirs" can pass the path to
the "git submodule absorbgitdirs" sub-process it's about to invoke.

= Relation to other submissions

This is a non-RFC version of my earlier RFC to get rid of
"--super-prefix"[1], which itself was an alternate proposal to Glen's
[2]. Per [3] he's agreed to go with this approach.

This is on top of "ab/submodule-helper-prep-only" (currently in
"next"[4]) and "ab/submodule-no-abspath" (currently in "seen"[5]).

It's also proposing to replace Glen's one-patch[6], which is working
around the problem shown in the test added in 1/10 here. Per
downthread of [7] I think Glen was aiming for getting a more narrow
fix in case we split off 9/10 here into some later fix.

As we're fixing an edge case in something that's always been broken
(and thus wouldn't backport) I think it's better to just fix the
problem directly, rather than introducing new "--super-prefix" use,
just to take it away later.

= Changes since the RFC

* Added Glen's "git fetch" test as a 1/10, with an updated commit message
* Updated 2/10's commit message for the non-RFC, and adjusted and
  incorporated a variant of Glen's fsmonitor test change.
* 9/10: Correctly re-arrange bitfield define's when removing one, make
  the test added in 1/10 pass.

* 10/10: New commit to make "git fetch" use our own "--super-prefix"
  instead of its "--submodule-prefix", which makes it consistent with
  the other command-level "--super-prefix" introduced here.

  Personally I'm rather "meh" on this. It's not actually needed by the
  main body of the series, but Glen seems to prefer it in[9], and
  doing it is easy enough.

  That change is a pure refactoring clean-up for consistency. The only
  reason it's 10/10 and not 1/10 is because it uses the
  "OPT__SUPER_PREFIX()" introduced in 2/10.

= CI & fetch URL

Passing at: https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local-2

1. https://lore.kernel.org/git/RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20221109004708.97668-1-chooglen@google.com/
3. https://lore.kernel.org/git/kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com/
4. c0c4f4d1c33 (Merge branch 'ab/submodule-helper-prep-only' into next, 2022-11-08)
5. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
6. https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgadget@gmail.com/
7. https://lore.kernel.org/git/221111.86fsepmbhe.gmgdl@evledraar.gmail.com/
8. https://lore.kernel.org/git/20221109004708.97668-3-chooglen@google.com/
9. https://lore.kernel.org/git/kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com/

Glen Choo (1):
  read-tree + fetch tests: test failing "--super-prefix" interaction

Ævar Arnfjörð Bjarmason (9):
  submodule--helper: don't use global --super-prefix in "absorbgitdirs"
  submodule--helper: "deinit" has never used "--super-prefix"
  submodule--helper: convert "foreach" to its own "--super-prefix"
  submodule--helper: convert "sync" to its own "--super-prefix"
  submodule--helper: convert "status" to its own "--super-prefix"
  submodule--helper: convert "{update,clone}" to their own
    "--super-prefix"
  submodule tests: test "git branch -t" output and stderr
  read-tree: add "--super-prefix" option, eliminate global
  fetch: rename "--submodule-prefix" to "--super-prefix"

 Documentation/fetch-options.txt |  5 --
 Documentation/git.txt           |  8 +--
 builtin.h                       |  4 --
 builtin/checkout.c              |  2 +-
 builtin/fetch.c                 |  7 +--
 builtin/read-tree.c             |  1 +
 builtin/submodule--helper.c     | 95 ++++++++++++++++++--------------
 cache.h                         |  2 -
 entry.c                         | 12 ++--
 entry.h                         |  6 +-
 environment.c                   | 13 -----
 git.c                           | 41 +++-----------
 parse-options.h                 |  4 ++
 submodule.c                     | 70 +++++++++++------------
 submodule.h                     | 12 ++--
 t/lib-submodule-update.sh       | 98 ++++++++++++++++++---------------
 t/t1001-read-tree-m-2way.sh     |  2 +-
 t/t5616-partial-clone.sh        | 43 +++++++++++++++
 t/t7527-builtin-fsmonitor.sh    | 33 +++--------
 unpack-trees.c                  | 23 ++++----
 unpack-trees.h                  |  1 +
 21 files changed, 244 insertions(+), 238 deletions(-)

Range-diff against v1:
 -:  ----------- >  1:  1114a4ff666 read-tree + fetch tests: test failing "--super-prefix" interaction
 1:  ad0356b596f !  2:  5a35f7b75b3 submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    @@ Commit message
         declare "fsmonitor--daemon" as accepting it too, even though it
         doesn't care about it.
     
    -    There's a parallel proposal to remove "--super-prefix" as an option to
    -    "git" in [3], and some of the approach might be the easiest route in
    -    some cases.
    -
         But in the case of "absorbgitdirs" it only needed "--super-prefix" to
         invoke itself recursively, and we'd never have another "in-between"
         process in the chain. So we didn't need the bigger hammer of "git
    @@ Commit message
         stone makes such an eventual change easier, as we'll need to deal with
         less global state at that point.
     
    +    The "fsmonitor--daemon" test adjusted here was added in [3]. The
    +    comment added in that commit has been out-of-date from the beginning,
    +    and the "have_t2_error_event()" was being overly specific in testing
    +    for a bug that we *don't* have. Let's instead test for the stdout and
    +    stderr that we *do have*.
    +
         1. 74866d75793 (git: make super-prefix option, 2016-10-07)
         2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
            2022-05-26)
    -    3. https://lore.kernel.org/git/20221109004708.97668-1-chooglen@google.com/
    +    3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
    +       2022-05-26)
     
    +    Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    @@ submodule.h: void submodule_unset_core_worktree(const struct submodule *sub);
      
      /*
       * Return the absolute path of the working tree of the superproject, which this
    +
    + ## t/t7527-builtin-fsmonitor.sh ##
    +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
    + # the submodule, and someone does a `git submodule absorbgitdirs`
    + # in the super, Git will recursively invoke `git submodule--helper`
    + # to do the work and this may try to read the index.  This will
    +-# try to start the daemon in the submodule *and* pass (either
    +-# directly or via inheritance) the `--super-prefix` arg to the
    +-# `git fsmonitor--daemon start` command inside the submodule.
    +-# This causes a warning because fsmonitor--daemon does take that
    +-# global arg (see the table in git.c)
    +-#
    +-# This causes a warning when trying to start the daemon that is
    +-# somewhat confusing.  It does not seem to hurt anything because
    +-# the fsmonitor code maps the query failure into a trivial response
    +-# and does the work anyway.
    +-#
    +-# It would be nice to silence the warning, however.
    +-
    +-have_t2_error_event () {
    +-	log=$1
    +-	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
    +-
    +-	tr '\047' Q <$1 | grep -e "$msg"
    +-}
    ++# try to start the daemon in the submodule.
    + 
    + test_expect_success "stray submodule super-prefix warning" '
    + 	test_when_finished "rm -rf super; \
    +-			    rm -rf sub;   \
    +-			    rm super-sub.trace" &&
    ++			    rm -rf sub" &&
    + 
    + 	create_super super &&
    + 	create_sub sub &&
    +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "stray submodule super-prefix warning" '
    + 
    + 	test_path_is_dir super/dir_1/dir_2/sub/.git &&
    + 
    +-	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
    +-		git -C super submodule absorbgitdirs &&
    +-
    +-	! have_t2_error_event super-sub.trace
    ++	cat >expect <<-\EOF &&
    ++	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/dir_2/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
    ++	EOF
    ++	git -C super submodule absorbgitdirs >out 2>actual &&
    ++	test_cmp expect actual &&
    ++	test_must_be_empty out
    + '
    + 
    + # On a case-insensitive file system, confirm that the daemon
 2:  87a780eb9bf =  3:  a7a1f9487dc submodule--helper: "deinit" has never used "--super-prefix"
 3:  4858e2ad0ed =  4:  935d8070834 submodule--helper: convert "foreach" to its own "--super-prefix"
 4:  5ffe4407e46 =  5:  933c752513d submodule--helper: convert "sync" to its own "--super-prefix"
 5:  a46540b63c2 =  6:  67273f729e0 submodule--helper: convert "status" to its own "--super-prefix"
 6:  78ebf0e2abf =  7:  eaa73f5b1e4 submodule--helper: convert "{update,clone}" to their own "--super-prefix"
 7:  00a9e789be7 =  8:  172b5865811 submodule tests: test "git branch -t" output and stderr
 8:  3ba894a6698 !  9:  9fdeab60773 read-tree: add "--super-prefix" option, eliminate global
    @@ git.c
       */
      #define NEED_WORK_TREE		(1<<3)
     -#define SUPPORT_SUPER_PREFIX	(1<<4)
    - #define DELAY_PAGER_CONFIG	(1<<5)
    - #define NO_PARSEOPT		(1<<6) /* parse-options is not used */
    +-#define DELAY_PAGER_CONFIG	(1<<5)
    +-#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
    ++#define DELAY_PAGER_CONFIG	(1<<4)
    ++#define NO_PARSEOPT		(1<<5) /* parse-options is not used */
      
    + struct cmd_struct {
    + 	const char *cmd;
     @@ git.c: const char git_usage_string[] =
      	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
      	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
    @@ t/t1001-read-tree-m-2way.sh: test_expect_success 'read-tree supports the super-p
      '
      
     
    + ## t/t5616-partial-clone.sh ##
    +@@ t/t5616-partial-clone.sh: test_expect_success 'repack does not loosen promisor objects' '
    + 	grep "loosen_unused_packed_objects/loosened:0" trace
    + '
    + 
    +-test_expect_failure 'lazy-fetch in submodule succeeds' '
    ++test_expect_success 'lazy-fetch in submodule succeeds' '
    + 	# setup
    + 	test_config_global protocol.file.allow always &&
    + 
    +
      ## unpack-trees.c ##
     @@ unpack-trees.c: static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
      	  ? ((o)->msgs[(type)])      \
 -:  ----------- > 10:  100ba36dfb7 fetch: rename "--submodule-prefix" to "--super-prefix"
-- 
2.38.0.1471.ge4d8947e7aa

