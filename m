Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067CC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiC2L1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiC2L1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:27:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2421A7734
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so1038314wmq.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BUm9A0tH3YQ2vpxQbczzS0ud3+Io87MEpRmkiFit2/w=;
        b=VAypjcPr09/umak3K7LOcYyYvSv3sSRfh+VjT50PD5NlCsYA+7xxgwktJ+vGlEts4p
         iLvkqBRivFnGIMmHHLyWGmxJYRkzz/fzUm/djDTTsRG7hs15DxLPAnmstltEhlPjgy+s
         2fiC0r0Jsw9GXxfRm100u49sEOFRSbhw7jSAcW1cbnOi29wBTyoShlu8a77ye03JU++Z
         VtghC/oxj5DroI89iZ8QncwWU8QdCoD8KI6TevkoZ2eEnFBfJk3OsYqYHgPleDvqfqEd
         82VLey4gKfRJ4HMq3OQnjwRgFMw5VNCqNkINhkikdviCC0k91QvEpyo250G5U7vobypQ
         SCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BUm9A0tH3YQ2vpxQbczzS0ud3+Io87MEpRmkiFit2/w=;
        b=0gvsa3dd+ZKHIB2wYwLZLnccqMjz2vOa+LYaJEKiJNDV0ytNV4nKJG42zNxO09LFfE
         pj2WjmtvVKqJomG2yYIw3RiQbeVPmEmKMZKfaZzFjaE1otRkTsPEl9mXw3zCoaYIr2Ho
         MS9A0YoUDJ3gnA/lSXkslTFtoFDB+G2C7LfVTyfVcNw1F7QPMJRqEC0w14DmcEV+/z0W
         s6/xYCQqV9asI78PPKbsMA09CTz8M+gt0rkv/F2ZdA4QpQOCV4oEuJDBKWxOYbqeCuDM
         1z8UEnZdQEWPGq6qsyKaYUMAlCTit3E/FMqDghrfSmTIEihmC2RlrWeBSPs8/d7CyhV1
         kdFg==
X-Gm-Message-State: AOAM530Bdxbbh1h0biLLE6DAEFhv5+54cdhKguoc7iU5Qxqos7bGTWNz
        mIoJasorDPKjcCemBFSEB1/HFyxClvE=
X-Google-Smtp-Source: ABdhPJxpdmi5wr55hldzlwq/GQAFCkONR/G35Riw5r5bbKqfagNV/rJT/VKB50rOlxJANWMWcMvImQ==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr6306477wma.108.1648553135872;
        Tue, 29 Mar 2022 04:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm2050936wmc.22.2022.03.29.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:25:35 -0700 (PDT)
Message-Id: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 11:25:32 +0000
Subject: [PATCH v5 0/2] Support untracked cache with '--untracked-files=all' if configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it possible for users of the -uall flag to git status, either by
preference or by need (eg UI tooling), to benefit from the untracked cache
when they set their 'status.showuntrackedfiles' config setting to 'all'.
This is especially useful for large repos in Windows, where without
untracked cache "git status" times can easily be 5x higher, and GUI tooling
typically does use -uall.

In this fifth version, split the change into two patches - one to introduce
tests of the current untracked-cache-skipping behavior when -uall is
specified, and then new tests checking the new behavior with
'status.showuntrackedfiles=all'.

My two remaining questions with respect to this patchset are:

 1. Does it make sense to do this as a simple enhancement as proposed here,
    or would people be more comfortable with a new configuration option,
    given the potential for worse performance under specific (and. I
    believe, vanishingly rare) circumstances?
 2. If it makes sense to envision a future where a single untracked cache
    structure can support both -uall and -unormal, where should this
    possible future be alluded to, if anywhere?

Tao Klerks (2):
  untracked-cache: test untracked-cache-bypassing behavior with -uall
  untracked-cache: support '--untracked-files=all' if configured

 dir.c                             |  85 +++++++++++++++++------
 t/t7063-status-untracked-cache.sh | 108 ++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 19 deletions(-)


base-commit: abf474a5dd901f28013c52155411a48fd4c09922
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-985%2FTaoK%2Ftaok-untracked-cache-with-uall-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-985/TaoK/taok-untracked-cache-with-uall-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/985

Range-diff vs v4:

 -:  ----------- > 1:  98a4d8f35c5 untracked-cache: test untracked-cache-bypassing behavior with -uall
 1:  5da418e5c60 ! 2:  f60d2c6e36c untracked-cache: support '--untracked-files=all' if configured
     @@ Commit message
          untracked-cache: support '--untracked-files=all' if configured
      
          Untracked cache was originally designed to only work with
     -    '-untracked-files=normal', but this causes performance issues for UI
     +    '--untracked-files=normal', but this causes performance issues for UI
          tooling that wants to see "all" on a frequent basis. On the other hand,
          the conditions that prevented applicability to the "all" mode no
          longer seem to apply.
     @@ dir.c: static void set_untracked_ident(struct untracked_cache *uc)
       }
       
      -static void new_untracked_cache(struct index_state *istate)
     -+static unsigned configured_default_dir_flags(struct repository *repo)
     ++static unsigned new_untracked_cache_flags(struct index_state *istate)
      +{
     ++	struct repository *repo = istate->repo;
     ++	char *val;
     ++
      +	/*
      +	 * This logic is coordinated with the setting of these flags in
      +	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
      +	 * of the config setting in commit.c#git_status_config()
      +	 */
     -+	char *status_untracked_files_config_value;
     -+	int config_outcome = repo_config_get_string(repo,
     -+						    "status.showuntrackedfiles",
     -+						    &status_untracked_files_config_value);
     -+	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
     ++	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
     ++	    !strcmp(val, "all"))
      +		return 0;
     -+	} else {
     -+		/*
     -+		 * The default, if "all" is not set, is "normal" - leading us here.
     -+		 * If the value is "none" then it really doesn't matter.
     -+		 */
     -+		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
     -+	}
     ++
     ++	/*
     ++	 * The default, if "all" is not set, is "normal" - leading us here.
     ++	 * If the value is "none" then it really doesn't matter.
     ++	 */
     ++	return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
      +}
      +
     -+static void new_untracked_cache(struct index_state *istate, unsigned flags)
     ++static void new_untracked_cache(struct index_state *istate, int flags)
       {
       	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
       	strbuf_init(&uc->ident, 100);
       	uc->exclude_per_dir = ".gitignore";
      -	/* should be the same flags used by git-status */
      -	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
     -+	uc->dir_flags = flags;
     ++	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
       	set_untracked_ident(uc);
       	istate->untracked = uc;
       	istate->cache_changed |= UNTRACKED_CHANGED;
     @@ dir.c: static void new_untracked_cache(struct index_state *istate)
       {
       	if (!istate->untracked) {
      -		new_untracked_cache(istate);
     -+		new_untracked_cache(istate,
     -+				    configured_default_dir_flags(istate->repo));
     ++		new_untracked_cache(istate, -1);
       	} else {
       		if (!ident_in_untracked(istate->untracked)) {
       			free_untracked_cache(istate->untracked);
      -			new_untracked_cache(istate);
     -+			new_untracked_cache(istate,
     -+					    configured_default_dir_flags(istate->repo));
     ++			new_untracked_cache(istate, -1);
       		}
       	}
       }
     @@ dir.c: void remove_untracked_cache(struct index_state *istate)
       
       static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
      -						      int base_len,
     --						      const struct pathspec *pathspec)
     +-						      const struct pathspec *pathspec,
     +-						      struct index_state *istate)
      +							    int base_len,
      +							    const struct pathspec *pathspec,
      +							    struct index_state *istate)
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
      +	 * the current effective flags don't match the configured
      +	 * flags.
      +	 */
     -+	if (dir->flags != configured_default_dir_flags(istate->repo))
     ++	if (dir->flags != new_untracked_cache_flags(istate))
      +		return NULL;
      +
      +	/*
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
      +		dir->untracked = istate->untracked;
      +	}
      +
     - 	if (!dir->untracked->root)
     + 	if (!dir->untracked->root) {
     + 		/* Untracked cache existed but is not initialized; fix that */
       		FLEX_ALLOC_STR(dir->untracked->root, name, "");
     +
     + ## t/t7063-status-untracked-cache.sh ##
     +@@ t/t7063-status-untracked-cache.sh: test_expect_success 'untracked cache remains after bypass' '
     + 	test_cmp ../dump.expect ../actual
     + '
       
     -@@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
     - 		return dir->nr;
     - 	}
     - 
     --	untracked = validate_untracked_cache(dir, len, pathspec);
     -+	untracked = validate_untracked_cache(dir, len, pathspec, istate);
     - 	if (!untracked)
     - 		/*
     - 		 * make sure untracked cache code path is disabled,
     ++test_expect_success 'if -uall is configured, untracked cache gets populated by default' '
     ++	test_config status.showuntrackedfiles all &&
     ++	: >../trace.output &&
     ++	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
     ++	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     ++	test_cmp ../status_uall.expect ../status.iuc &&
     ++	test_cmp ../status_uall.expect ../actual &&
     ++	get_relevant_traces ../trace.output ../trace.relevant &&
     ++	cat >../trace.expect <<EOF &&
     ++ ....path:
     ++ ....node-creation:3
     ++ ....gitignore-invalidation:1
     ++ ....directory-invalidation:0
     ++ ....opendir:4
     ++EOF
     ++	test_cmp ../trace.expect ../trace.relevant
     ++'
     ++
     ++cat >../dump_uall.expect <<EOF &&
     ++info/exclude $EMPTY_BLOB
     ++core.excludesfile $ZERO_OID
     ++exclude_per_dir .gitignore
     ++flags 00000000
     ++/ $ZERO_OID recurse valid
     ++three
     ++/done/ $ZERO_OID recurse valid
     ++/dthree/ $ZERO_OID recurse valid
     ++three
     ++/dtwo/ $ZERO_OID recurse valid
     ++two
     ++EOF
     ++
     ++test_expect_success 'if -uall was configured, untracked cache is populated' '
     ++	test-tool dump-untracked-cache >../actual &&
     ++	test_cmp ../dump_uall.expect ../actual
     ++'
     ++
     ++test_expect_success 'if -uall is configured, untracked cache is used by default' '
     ++	test_config status.showuntrackedfiles all &&
     ++	: >../trace.output &&
     ++	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
     ++	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     ++	test_cmp ../status_uall.expect ../status.iuc &&
     ++	test_cmp ../status_uall.expect ../actual &&
     ++	get_relevant_traces ../trace.output ../trace.relevant &&
     ++	cat >../trace.expect <<EOF &&
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:0
     ++EOF
     ++	test_cmp ../trace.expect ../trace.relevant
     ++'
     ++
     ++# Bypassing the untracked cache here is not desirable, but it expected
     ++# in the current implementation
     ++test_expect_success 'if -uall is configured, untracked cache is bypassed with -unormal' '
     ++	test_config status.showuntrackedfiles all &&
     ++	: >../trace.output &&
     ++	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
     ++	git status -unormal --porcelain >../actual &&
     ++	iuc status -unormal --porcelain >../status.iuc &&
     ++	test_cmp ../status.expect ../status.iuc &&
     ++	test_cmp ../status.expect ../actual &&
     ++	get_relevant_traces ../trace.output ../trace.relevant &&
     ++	cat >../trace.expect <<EOF &&
     ++ ....path:
     ++EOF
     ++	test_cmp ../trace.expect ../trace.relevant
     ++'
     ++
     ++test_expect_success 'repopulate untracked cache for -unormal' '
     ++	git status --porcelain
     ++'
     ++
     + test_expect_success 'modify in root directory, one dir invalidation' '
     + 	: >four &&
     + 	test-tool chmtime =-240 four &&

-- 
gitgitgadget
