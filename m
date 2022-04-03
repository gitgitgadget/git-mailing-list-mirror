Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291DC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358366AbiDCNJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiDCNJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:09:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E426AF9
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:07:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so10594068wrg.12
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9UOzdWLx6aUMA+Z/lfyrT1QU1cNpSco/OzFEv0bxXms=;
        b=evN8TaumEnbVqF4cHQnQeVYzUl42LU/lTMYr8T/c9+AyR1J9PycM/OxPKjeh7jVH4I
         hDMvSfLv3/uIYuoW5CNIdzWylSf09N08VCBWkRltvhlvx70gA5UUuCdIZonknOU95jMB
         B09GWfSh+nWZpuiigKqATYmhVnEA4IueUhEZ5qJFPGbBWagMwugwJ2avC0cDohk7nBfk
         pHCf6p6X423vPS+X+J3U+fD60S+Pr4SnUgll/ODATjzNxzKTiz4fMSkzstDXLLa93bY7
         ffi3LUcHi76lglSiYEVreg5LiGzz2o6J8UDTkgoKERSc+EN8jWl+N0j3Bnj1l1ZIbNvz
         jiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9UOzdWLx6aUMA+Z/lfyrT1QU1cNpSco/OzFEv0bxXms=;
        b=StGYqHRaWJIZFkhTpAsYuzwdCsKGwEhK1uxd7OmkvfwK3HvmRzsyrHlh0RqDJ16ugy
         LW/KcfXN4bRu3Evan9Tu2v96TTlbGOM/NMleCgwwSGJ+fwvmHfuSTUvNZURyyphKEt8F
         +a22yMMingKKHpC6BBirksdL88rKxcVl2VFCMcp5I9AQqkaap16Unkxf0O7tb7hBwokm
         YxayefVIPqafRH5OY69bRuEM3I26jkhXwhqYHrlyWRG5VFUOpWKVWTeNXQvhBBsRlq99
         3xrpv+ej1hkEzdNDUZWm4dX1ZpSHa4kTN/buwyIKx6arPOjgcAGXA5V/ItG1dnF8K9qd
         U0gw==
X-Gm-Message-State: AOAM53105IRB0m8t4/IE4DSPtw1vSirHmDKF/lM3pZeVKVk3hi36sFun
        m6TgBINkcwTfWA8QB2xAnPM=
X-Google-Smtp-Source: ABdhPJzvkrw/PM/23jnuqtzyLn5d59iYYedL97lnkiCkJsy3zgl6wnwjtQamiYANZOt5YbnP9luu1g==
X-Received: by 2002:a05:6000:2a8:b0:205:a7be:c330 with SMTP id l8-20020a05600002a800b00205a7bec330mr13906869wry.290.1648991247168;
        Sun, 03 Apr 2022 06:07:27 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0038c7d1086a7sm14561891wmq.1.2022.04.03.06.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 06:07:26 -0700 (PDT)
Message-ID: <5d3345d9-3c7c-a761-9c7a-03468a653e48@gmail.com>
Date:   Sun, 3 Apr 2022 14:07:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/27] revision.[ch]: add and use release_revisions()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

I've left a few comments on this series for the patches that I had not 
looked at in v4. There's nothing major, the changes mostly make sense to 
me (though I'm not familiar with the revisions api)

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> This series reduces the memory leaks spotted by our tests by at least
> half, see v3[1] for a more general overview.
> 
> Thanks a lot to Phillip Wood and Junio for the v4 review! I think this
> v5 should address all of the things brought up in v4 in one way or
> another, changes:
> 
>   * The "extra_headers" or "ref_message_ids" freeing is the same, but
>     the commit message is altered to explain that commit.

I'm still not that convinced that these are owned by the code in 
builtin/log.c but lets leave that for now. The rest of the changes look 
good. Thanks for working on this, when I use LSAN on my patches before 
submitting them I often see a lot of existing leaks coming from struct 
rev_info.

Best Wishes

Phillip

>   * The "revision.[ch]: split freeing of revs->commit into a function"
>     is gone, instead I applied a coccinelle rule to free_commit_list()
>     as suggested by Phillip Wood (well, the change in pattern, not the
>     rule was the suggestion).
> 
>   * The release_revisions() is now simply using free_commit_list()
>     without a NULL assignment to the member, and I changed some
>     FREE_AND_NULL() that I'd added (for e.g. cmdline) to just free().
> 
>     The "and NULL" was just cargo-culted from elswhere, but for
>     release_revisions() we not only aren't using the struct again (it's
>     not a "reset"), but it it wouldn't have worked as a reset before
>     anyway (some things free'd without NULL-ing).
> 
>     We could trivially have a "reset" variant of release_revisions(),
>     but since no current API user wanted it let's leave it, leving the
>     memory uninitialized will help to catch any invalid API usage.
> 
>   * I missed a object_array_clear() in builtin/stash.c that
>     could/should be free'd by release_revisions().
> 
>   * An obscure memory leak in stash.c (on "master") around
>     assert_stash_ref() has been fixed.
> 
>   * Add a "goto usage" pattern for a memory leak new in stash.c that
>     this series introduced, i.e. because strvec_clear() was moved to a
>     "cleanup" block if we invoked usage_with_options() between the two
>     we'd exit without the cleanup. Now we'll cleanup on "usage" too.
> 
>   * Updated commit message & docs around REV_INFO_INIT, hopefully
>     addressing the thread left off at
>     https://lore.kernel.org/git/220401.86h77dnkpw.gmgdl@evledraar.gmail.com/
> 
> 1. https://lore.kernel.org/git/cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com/
> 
> Ævar Arnfjörð Bjarmason (27):
>    t/helper/test-fast-rebase.c: don't leak "struct strbuf"
>    blame: use "goto cleanup" for cleanup_scoreboard()
>    string_list API users: use string_list_init_{no,}dup
>    format-patch: don't leak "extra_headers" or "ref_message_ids"
>    cocci: add and apply free_commit_list() rules
>    revision.[ch]: provide and start using a release_revisions()
>    revisions API users: add straightforward release_revisions()
>    revision.[ch]: document and move code declared around "init"
>    revisions API users: use release_revisions() needing REV_INFO_INIT
>    stash: always have the owner of "stash_info" free it
>    revisions API users: add "goto cleanup" for release_revisions()
>    revisions API users: use release_revisions() in http-push.c
>    revisions API users: use release_revisions() in builtin/log.c
>    revisions API users: use release_revisions() with UNLEAK()
>    revisions API users: use release_revisions() for "prune_data" users
>    revisions API: have release_revisions() release "commits"
>    revisions API: have release_revisions() release "mailmap"
>    revisions API: have release_revisions() release "cmdline"
>    revisions API: have release_revisions() release "filter"
>    revisions API: have release_revisions() release "grep_filter"
>    revisions API: have release_revisions() release "prune_data"
>    revisions API: clear "boundary_commits" in release_revisions()
>    revisions API: release "reflog_info" in release revisions()
>    revisions API: call diff_free(&revs->pruning) in revisions_release()
>    revisions API: have release_revisions() release "date_mode"
>    revisions API: have release_revisions() release "topo_walk_info"
>    revisions API: add a TODO for diff_free(&revs->diffopt)
> 
>   add-interactive.c                          |   3 +-
>   bisect.c                                   |  20 ++--
>   builtin/add.c                              |   3 +-
>   builtin/am.c                               |   3 +
>   builtin/bisect--helper.c                   |   2 +
>   builtin/blame.c                            |   4 +-
>   builtin/checkout.c                         |   3 +-
>   builtin/commit.c                           |   6 +-
>   builtin/describe.c                         |   2 +
>   builtin/diff-files.c                       |   8 +-
>   builtin/diff-index.c                       |   5 +-
>   builtin/diff.c                             |   2 +-
>   builtin/fast-export.c                      |   1 +
>   builtin/log.c                              |  36 ++++---
>   builtin/merge.c                            |   2 +
>   builtin/pack-objects.c                     |   2 +
>   builtin/prune.c                            |   1 +
>   builtin/reflog.c                           |   1 +
>   builtin/rev-list.c                         |  25 +++--
>   builtin/shortlog.c                         |   8 +-
>   builtin/stash.c                            | 115 +++++++++++----------
>   builtin/submodule--helper.c                |  14 ++-
>   bundle.c                                   |  12 ++-
>   commit.c                                   |  19 ++--
>   contrib/coccinelle/free.cocci              |  27 +++++
>   diff-lib.c                                 |   8 +-
>   fmt-merge-msg.c                            |   1 +
>   http-push.c                                |   3 +-
>   merge-ort.c                                |   1 +
>   merge-recursive.c                          |   5 +-
>   midx.c                                     |   1 +
>   pack-bitmap-write.c                        |   1 +
>   range-diff.c                               |   2 +-
>   ref-filter.c                               |   1 +
>   reflog-walk.c                              |  24 ++++-
>   reflog-walk.h                              |   1 +
>   remote.c                                   |   1 +
>   revision.c                                 |  72 ++++++++++---
>   revision.h                                 |  73 ++++++++-----
>   sequencer.c                                |  26 +++--
>   shallow.c                                  |   1 +
>   submodule.c                                |  11 +-
>   t/helper/test-fast-rebase.c                |  23 +++--
>   t/helper/test-revision-walking.c           |   1 +
>   t/lib-git-svn.sh                           |   4 +
>   t/t0056-git-C.sh                           |   1 +
>   t/t0062-revision-walking.sh                |   1 +
>   t/t0100-previous.sh                        |   1 +
>   t/t0101-at-syntax.sh                       |   2 +
>   t/t1001-read-tree-m-2way.sh                |   1 +
>   t/t1002-read-tree-m-u-2way.sh              |   1 +
>   t/t1060-object-corruption.sh               |   2 +
>   t/t1401-symbolic-ref.sh                    |   2 +
>   t/t1411-reflog-show.sh                     |   1 +
>   t/t1412-reflog-loop.sh                     |   2 +
>   t/t1415-worktree-refs.sh                   |   1 +
>   t/t2015-checkout-unborn.sh                 |   1 +
>   t/t2200-add-update.sh                      |   1 +
>   t/t3302-notes-index-expensive.sh           |   1 +
>   t/t3303-notes-subtrees.sh                  |   1 +
>   t/t3305-notes-fanout.sh                    |   1 +
>   t/t3408-rebase-multi-line.sh               |   1 +
>   t/t4021-format-patch-numbered.sh           |   1 +
>   t/t4027-diff-submodule.sh                  |   1 +
>   t/t4028-format-patch-mime-headers.sh       |   2 +
>   t/t4036-format-patch-signer-mime.sh        |   1 +
>   t/t4039-diff-assume-unchanged.sh           |   1 +
>   t/t4055-diff-context.sh                    |   1 +
>   t/t4066-diff-emit-delay.sh                 |   1 +
>   t/t4122-apply-symlink-inside.sh            |   1 +
>   t/t4126-apply-empty.sh                     |   1 -
>   t/t4128-apply-root.sh                      |   1 +
>   t/t4206-log-follow-harder-copies.sh        |   2 +
>   t/t4207-log-decoration-colors.sh           |   1 +
>   t/t4212-log-corrupt.sh                     |   1 +
>   t/t5301-sliding-window.sh                  |   2 +
>   t/t5313-pack-bounds-checks.sh              |   2 +
>   t/t5316-pack-delta-depth.sh                |   2 +
>   t/t5320-delta-islands.sh                   |   2 +
>   t/t5322-pack-objects-sparse.sh             |   1 +
>   t/t5506-remote-groups.sh                   |   1 +
>   t/t5513-fetch-track.sh                     |   1 +
>   t/t5515-fetch-merge-logic.sh               |   1 +
>   t/t5518-fetch-exit-status.sh               |   1 +
>   t/t5532-fetch-proxy.sh                     |   2 +
>   t/t5600-clone-fail-cleanup.sh              |   1 +
>   t/t5900-repo-selection.sh                  |   2 +
>   t/t6002-rev-list-bisect.sh                 |   1 +
>   t/t6003-rev-list-topo-order.sh             |   1 +
>   t/t6005-rev-list-count.sh                  |   1 +
>   t/t6018-rev-list-glob.sh                   |   1 +
>   t/t6100-rev-list-in-order.sh               |   1 +
>   t/t6101-rev-parse-parents.sh               |   1 +
>   t/t6110-rev-list-sparse.sh                 |   1 +
>   t/t6114-keep-packs.sh                      |   2 +
>   t/t6131-pathspec-icase.sh                  |   2 +
>   t/t7008-filter-branch-null-sha1.sh         |   1 +
>   t/t7702-repack-cyclic-alternate.sh         |   2 +
>   t/t9001-send-email.sh                      |   1 +
>   t/t9100-git-svn-basic.sh                   |   1 +
>   t/t9101-git-svn-props.sh                   |   2 +
>   t/t9104-git-svn-follow-parent.sh           |   2 +
>   t/t9106-git-svn-commit-diff-clobber.sh     |   2 +
>   t/t9115-git-svn-dcommit-funky-renames.sh   |   1 +
>   t/t9116-git-svn-log.sh                     |   1 +
>   t/t9122-git-svn-author.sh                  |   2 +
>   t/t9127-git-svn-partial-rebuild.sh         |   1 +
>   t/t9129-git-svn-i18n-commitencoding.sh     |   1 +
>   t/t9132-git-svn-broken-symlink.sh          |   1 +
>   t/t9139-git-svn-non-utf8-commitencoding.sh |   1 +
>   t/t9146-git-svn-empty-dirs.sh              |   2 +
>   t/t9148-git-svn-propset.sh                 |   1 +
>   t/t9160-git-svn-preserve-empty-dirs.sh     |   1 +
>   t/t9162-git-svn-dcommit-interactive.sh     |   2 +
>   t/t9164-git-svn-dcommit-concurrent.sh      |   2 +
>   t/t9501-gitweb-standalone-http-status.sh   |   1 +
>   wt-status.c                                |  15 +--
>   117 files changed, 502 insertions(+), 190 deletions(-)
> 
> Range-diff against v4:
>   1:  b99a07f98ee =  1:  e20f951a64c t/helper/test-fast-rebase.c: don't leak "struct strbuf"
>   2:  da5be507c0f =  2:  de2e08a14e6 blame: use "goto cleanup" for cleanup_scoreboard()
>   3:  243f7c8df96 =  3:  364aa7d8990 string_list API users: use string_list_init_{no,}dup
>   4:  69f0aabe38f !  4:  5d4ad92d47b format-patch: don't leak "extra_headers" or "ref_message_ids"
>      @@ Commit message
>           cmd_format_patch(). These two are unusual special-cases in being in
>           the "struct rev_info", but not being "owned" by the code in
>           revision.c. I.e. they're members of the struct so that this code in
>      -    "builtin/log.c" can pass information code in log-tree.c.
>      +    "builtin/log.c" can conveniently pass information code in
>      +    "log-tree.c".
>      +
>      +    See e.g. the make_cover_letter() caller of log_write_email_headers()
>      +    here in "builtin/log.c", and [1] for a demonstration of where the
>      +    "extra_headers" and "ref_message_ids" struct members are used.
>       
>           See 20ff06805c6 (format-patch: resurrect extra headers from config,
>           2006-06-02) and d1566f7883f (git-format-patch: Make the second and
>      @@ Commit message
>           variable to hold it, to avoid the eventual cast from "const char *"
>           when we free() it.
>       
>      +    1. https://lore.kernel.org/git/220401.868rsoogxf.gmgdl@evledraar.gmail.com/
>      +
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## builtin/log.c ##
>   5:  2d0ed57ec2e <  -:  ----------- revision.[ch]: split freeing of revs->commit into a function
>   -:  ----------- >  5:  c38db28f920 cocci: add and apply free_commit_list() rules
>   6:  b9beaba16bf !  6:  b99f96599bb revision.[ch]: provide and start using a release_revisions()
>      @@ Commit message
>           turn adds a lot of noise when trying to mark up tests with
>           "TEST_PASSES_SANITIZE_LEAK=true".
>       
>      -    The users of that API are largely one-shot, e.g. "git log", so
>      -    arguably freeing the memory is a waste of time, but in many cases
>      -    they've actually been trying to free the memory, and just doing that
>      -    in a buggy manner.
>      +    The users of that API are largely one-shot, e.g. "git rev-list" or
>      +    "git log", or the "git checkout" and "git stash" being modified here
>      +
>      +    For these callers freeing the memory is arguably a waste of time, but
>      +    in many cases they've actually been trying to free the memory, and
>      +    just doing that in a buggy manner.
>       
>           Let's provide a release_revisions() function for these users, and
>           start migrating them over per the plan outlined in [1]. Right now this
>      @@ builtin/checkout.c: static void show_local_changes(struct object *head,
>        static void describe_detached_head(const char *msg, struct commit *commit)
>       
>        ## builtin/stash.c ##
>      +@@ builtin/stash.c: static int check_changes_tracked_files(const struct pathspec *ps)
>      + 		goto done;
>      + 	}
>      +
>      +-	object_array_clear(&rev.pending);
>      + 	result = run_diff_files(&rev, 0);
>      + 	if (diff_result_code(&rev.diffopt, result)) {
>      + 		ret = 1;
>      +@@ builtin/stash.c: static int check_changes_tracked_files(const struct pathspec *ps)
>      +
>      + done:
>      + 	clear_pathspec(&rev.prune_data);
>      ++	release_revisions(&rev);
>      + 	return ret;
>      + }
>      +
>       @@ builtin/stash.c: static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>        
>        done:
>      @@ range-diff.c: int is_range_diff_range(const char *arg)
>        }
>       
>        ## revision.c ##
>      -@@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>      - 	}
>      +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>      + 	return left;
>        }
>        
>       +void release_revisions(struct rev_info *revs)
>   7:  80ec9a131c0 =  7:  521f6967b64 revisions API users: add straightforward release_revisions()
>   8:  086cec742b4 !  8:  003b507e0b7 revision.[ch]: document and move code declared around "init"
>      @@ revision.h: void mark_trees_uninteresting_sparse(struct repository *r, struct oi
>        void show_object_with_name(FILE *, struct object *, const char *);
>        
>       +/**
>      -+ * Helpers to check if a "struct string_list" item matches wild
>      ++ * Helpers to check if a "struct string_list" item matches with
>       + * wildmatch().
>       + */
>       +int ref_excluded(struct string_list *, const char *path);
>   9:  2f4e65fb534 !  9:  240307bc3c6 revisions API users: use release_revisions() needing REV_INFO_INIT
>      @@ Commit message
>           need to have their "struct rev_info" zero-initialized before we can
>           start using it.
>       
>      -    To do this add a stub "REV_INFO_INIT" macro, ideally macro would be
>      -    able to fully initialize a "struct rev_info", but all it does is the
>      -    equivalent of assigning "{ 0 }" to the struct, the API user will still
>      -    need to use repo_init_revisions(). In some future follow-up work we'll
>      -    hopefully make REV_INFO_INIT be a "stand-alone" init likke STRBUF_INIT
>      -    and other similar macros.
>      -
>           For the bundle.c code see the early exit case added in
>           3bbbe467f29 (bundle verify: error out if called without an object
>           database, 2019-05-27).
>      @@ revision.h: struct rev_info {
>       +/**
>       + * Initialize the "struct rev_info" structure with a macro.
>       + *
>      -+ * This is not sufficient (yet!) to initialize a "struct rev_info",
>      -+ * but it's OK (but redundant) to use it before a call to
>      -+ * repo_init_revisions(), which does the real initialization. By using
>      -+ * this it's safe to call release_revisions() on the "struct rev_info"
>      -+ * without having called repo_init_revisions().
>      ++ * This will not fully initialize a "struct rev_info", the
>      ++ * repo_init_revisions() function needs to be called before
>      ++ * setup_revisions() and any revision walking takes place.
>      ++ *
>      ++ * Use REV_INFO_INIT to make the "struct rev_info" safe for passing to
>      ++ * release_revisions() when it's inconvenient (e.g. due to a "goto
>      ++ * cleanup" pattern) to arrange for repo_init_revisions() to be called
>      ++ * before release_revisions() is called.
>      ++ *
>      ++ * Initializing with this REV_INFO_INIT is redundant to invoking
>      ++ * repo_init_revisions(). If repo_init_revisions() is guaranteed to be
>      ++ * called before release_revisions() the "struct rev_info" can be left
>      ++ * uninitialized.
>       + */
>       +#define REV_INFO_INIT { 0 }
>       +
>      @@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char
>        	struct commit_list *merge_bases = NULL;
>        	struct repository *sub;
>       @@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char *path,
>      - 	print_submodule_diff_summary(sub, &rev, o);
>        
>        out:
>      + 	free_commit_list(merge_bases);
>       +	release_revisions(&rev);
>      - 	if (merge_bases)
>      - 		free_commit_list(merge_bases);
>        	clear_commit_marks(left, ~0);
>      + 	clear_commit_marks(right, ~0);
>      + 	if (sub) {
> 10:  145a0f74b6a ! 10:  4c5404912e9 stash: always have the owner of "stash_info" free it
>      @@ Commit message
>           pattern we'd otherwise free() uninitialized memory in some cases, as
>           we only strbuf_init() the string in get_stash_info().
>       
>      -    So while it's the smallest possible change, let's convert all users of
>      -    this pattern in the file while we're at it.
>      +    So while it's not the smallest possible change, let's convert all
>      +    users of this pattern in the file while we're at it.
>       
>           A good follow-up to this change would be to change all the "ret = -1;
>           goto done;" in this file to instead use a "goto cleanup", and
>      @@ Commit message
>           would allow us to drop a lot of needless brace verbosity on two-line
>           "if" statements, but let's leave that alone for now.
>       
>      +    To ensure that there's a 1=1 mapping between owners of the "struct
>      +    stash_info" and free_stash_info() change the assert_stash_ref()
>      +    function to be a trivial get_stash_info_assert() wrapper. The caller
>      +    will call free_stash_info(), and by returning -1 we'll eventually (via
>      +    !!ret) exit with status 1 anyway.
>      +
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## builtin/stash.c ##
>      @@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char
>        	free_stash_info(&info);
>        	return ret;
>        }
>      -@@ builtin/stash.c: static void assert_stash_ref(struct stash_info *info)
>      +@@ builtin/stash.c: static int do_drop_stash(struct stash_info *info, int quiet)
>      + 	return 0;
>      + }
>      +
>      +-static void assert_stash_ref(struct stash_info *info)
>      ++static int get_stash_info_assert(struct stash_info *info, int argc,
>      ++				 const char **argv)
>      + {
>      +-	if (!info->is_stash_ref) {
>      +-		error(_("'%s' is not a stash reference"), info->revision.buf);
>      +-		free_stash_info(info);
>      +-		exit(1);
>      +-	}
>      ++	int ret = get_stash_info(info, argc, argv);
>      ++
>      ++	if (ret < 0)
>      ++		return ret;
>      ++
>      ++	if (!info->is_stash_ref)
>      ++		return error(_("'%s' is not a stash reference"), info->revision.buf);
>      ++
>      ++	return 0;
>      + }
>        
>        static int drop_stash(int argc, const char **argv, const char *prefix)
>        {
>      @@ builtin/stash.c: static void assert_stash_ref(struct stash_info *info)
>        		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>        		OPT_END()
>       @@ builtin/stash.c: static int drop_stash(int argc, const char **argv, const char *prefix)
>      + 	argc = parse_options(argc, argv, prefix, options,
>        			     git_stash_drop_usage, 0);
>        
>      - 	if (get_stash_info(&info, argc, argv))
>      +-	if (get_stash_info(&info, argc, argv))
>       -		return -1;
>      +-
>      +-	assert_stash_ref(&info);
>      ++	if (get_stash_info_assert(&info, argc, argv))
>       +		goto cleanup;
>        
>      - 	assert_stash_ref(&info);
>      -
>        	ret = do_drop_stash(&info, quiet);
>       +cleanup:
>        	free_stash_info(&info);
>      @@ builtin/stash.c: static int drop_stash(int argc, const char **argv, const char *
>        		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>        		OPT_BOOL(0, "index", &index,
>       @@ builtin/stash.c: static int pop_stash(int argc, const char **argv, const char *prefix)
>      + 	argc = parse_options(argc, argv, prefix, options,
>        			     git_stash_pop_usage, 0);
>        
>      - 	if (get_stash_info(&info, argc, argv))
>      +-	if (get_stash_info(&info, argc, argv))
>       -		return -1;
>      ++	if (get_stash_info_assert(&info, argc, argv))
>       +		goto cleanup;
>        
>      - 	assert_stash_ref(&info);
>      +-	assert_stash_ref(&info);
>        	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
>      -@@ builtin/stash.c: static int pop_stash(int argc, const char **argv, const char *prefix)
>      + 		printf_ln(_("The stash entry is kept in case "
>      + 			    "you need it again."));
>        	else
>        		ret = do_drop_stash(&info, quiet);
>        
>      @@ builtin/stash.c: static void diff_include_untracked(const struct stash_info *inf
>        	struct rev_info rev;
>        	struct strvec stash_args = STRVEC_INIT;
>        	struct strvec revision_args = STRVEC_INIT;
>      +@@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
>      + 			      UNTRACKED_ONLY, PARSE_OPT_NONEG),
>      + 		OPT_END()
>      + 	};
>      ++	int do_usage = 0;
>      +
>      + 	init_diff_ui_defaults();
>      + 	git_config(git_diff_ui_config, NULL);
>       @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
>        			strvec_push(&revision_args, argv[i]);
>        	}
>      @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *
>        		}
>        	}
>        
>      + 	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
>      +-	if (argc > 1) {
>      +-		free_stash_info(&info);
>      +-		usage_with_options(git_stash_show_usage, options);
>      +-	}
>      ++	if (argc > 1)
>      ++		goto usage;
>      + 	if (!rev.diffopt.output_format) {
>      + 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
>      + 		diff_setup_done(&rev.diffopt);
>       @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
>        	}
>        	log_tree_diff_flush(&rev);
>        
>      -+	ret = diff_result_code(&rev.diffopt, 0);;
>      ++	ret = diff_result_code(&rev.diffopt, 0);
>       +cleanup:
>       +	strvec_clear(&stash_args);
>        	free_stash_info(&info);
>       -	return diff_result_code(&rev.diffopt, 0);
>      ++	if (do_usage)
>      ++		usage_with_options(git_stash_show_usage, options);
>       +	return ret;
>      ++usage:
>      ++	do_usage = 1;
>      ++	goto cleanup;
>        }
>        
>        static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
>      @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
>        	struct strbuf patch = STRBUF_INIT;
>        	struct strbuf stash_msg_buf = STRBUF_INIT;
>        	struct strbuf untracked_files = STRBUF_INIT;
>      +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>      + 	}
>      +
>      + done:
>      ++	free_stash_info(&info);
>      + 	strbuf_release(&stash_msg_buf);
>      + 	return ret;
>      + }
> 11:  c9898a5a96b ! 11:  4210232e3a1 revisions API users: add "goto cleanup" for release_revisions()
>      @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *
>        	strvec_clear(&stash_args);
>        	free_stash_info(&info);
>       +	release_revisions(&rev);
>      + 	if (do_usage)
>      + 		usage_with_options(git_stash_show_usage, options);
>        	return ret;
>      - }
>      -
>       
>        ## builtin/submodule--helper.c ##
>       @@ builtin/submodule--helper.c: static int compute_summary_module_list(struct object_id *head_oid,
> 12:  6e41d666223 = 12:  1918ca0a85d revisions API users: use release_revisions() in http-push.c
> 13:  02ca92660af = 13:  6a02b7aae4e revisions API users: use release_revisions() in builtin/log.c
> 14:  1aeb1127f34 = 14:  ddc7402b054 revisions API users: use release_revisions() with UNLEAK()
> 15:  c12b3d5a035 ! 15:  03e9bd73d4b revisions API users: use release_revisions() for "prune_data" users
>      @@ builtin/add.c: int add_files_to_cache(const char *prefix,
>        }
>        
>       
>      - ## builtin/stash.c ##
>      -@@ builtin/stash.c: static int check_changes_tracked_files(const struct pathspec *ps)
>      -
>      - done:
>      - 	clear_pathspec(&rev.prune_data);
>      -+	release_revisions(&rev);
>      - 	return ret;
>      - }
>      -
>      -
>        ## diff-lib.c ##
>       @@ diff-lib.c: int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
>        	if (diff_cache(&revs, tree_oid, NULL, 1))
> 16:  2e351702677 <  -:  ----------- revisions API: have release_revisions() release "commits"
>   -:  ----------- > 16:  285673e40bf revisions API: have release_revisions() release "commits"
> 17:  f67f1f5a575 ! 17:  ca659940ee5 revisions API: have release_revisions() release "mailmap"
>      @@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
>        	}
>       
>        ## revision.c ##
>      -@@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>      - 	}
>      +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>      + 	return left;
>        }
>        
>       +static void release_revisions_mailmap(struct string_list *mailmap)
>      @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>       +
>        void release_revisions(struct rev_info *revs)
>        {
>      - 	release_revisions_commit_list(revs);
>      + 	free_commit_list(revs->commits);
>        	object_array_clear(&revs->pending);
>       +	release_revisions_mailmap(revs->mailmap);
>        }
> 18:  1df61550e5a ! 18:  7987c748ba4 revisions API: have release_revisions() release "cmdline"
>      @@ Commit message
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## revision.c ##
>      -@@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>      - 	}
>      +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>      + 	return left;
>        }
>        
>       +static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
>      @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>       +		return;
>       +	for (i = 0; i < cmdline->nr; i++)
>       +		free((char *)cmdline->rev[i].name);
>      -+	FREE_AND_NULL(cmdline->rev);
>      ++	free(cmdline->rev);
>       +}
>       +
>        static void release_revisions_mailmap(struct string_list *mailmap)
>      @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
>        	if (!mailmap)
>       @@ revision.c: void release_revisions(struct rev_info *revs)
>        {
>      - 	release_revisions_commit_list(revs);
>      + 	free_commit_list(revs->commits);
>        	object_array_clear(&revs->pending);
>       +	release_revisions_cmdline(&revs->cmdline);
>        	release_revisions_mailmap(revs->mailmap);
> 19:  065c3cc91b2 ! 19:  e6e87ce3608 revisions API: have release_revisions() release "filter"
>      @@ Commit message
>       
>        ## revision.c ##
>       @@ revision.c: void release_revisions(struct rev_info *revs)
>      - 	release_revisions_commit_list(revs);
>      + 	free_commit_list(revs->commits);
>        	object_array_clear(&revs->pending);
>        	release_revisions_cmdline(&revs->cmdline);
>       +	list_objects_filter_release(&revs->filter);
> 20:  806fef06b87 = 20:  ebdcdc88d79 revisions API: have release_revisions() release "grep_filter"
> 21:  fabbe452a14 = 21:  84c8714571a revisions API: have release_revisions() release "prune_data"
> 22:  cb201fa1914 ! 22:  d96642d3502 revisions API: clear "boundary_commits" in release_revisions()
>      @@ Commit message
>        ## revision.c ##
>       @@ revision.c: void release_revisions(struct rev_info *revs)
>        {
>      - 	release_revisions_commit_list(revs);
>      + 	free_commit_list(revs->commits);
>        	object_array_clear(&revs->pending);
>       +	object_array_clear(&revs->boundary_commits);
>        	release_revisions_cmdline(&revs->cmdline);
> 23:  0363a69073c = 23:  0e9745d9ee1 revisions API: release "reflog_info" in release revisions()
> 24:  bad359b2983 = 24:  c7f3e92a8d1 revisions API: call diff_free(&revs->pruning) in revisions_release()
> 25:  9a51c1ae1d1 = 25:  d428d752462 revisions API: have release_revisions() release "date_mode"
> 26:  b56db37940d ! 26:  fbf233ec768 revisions API: have release_revisions() release "topo_walk_info"
>      @@ revision.c: static void release_revisions_mailmap(struct string_list *mailmap)
>       +
>        void release_revisions(struct rev_info *revs)
>        {
>      - 	release_revisions_commit_list(revs);
>      + 	free_commit_list(revs->commits);
>       @@ revision.c: void release_revisions(struct rev_info *revs)
>        	free_grep_patterns(&revs->grep_filter);
>        	diff_free(&revs->pruning);
> 27:  b02cb8fcded = 27:  ec2c77ce869 revisions API: add a TODO for diff_free(&revs->diffopt)
