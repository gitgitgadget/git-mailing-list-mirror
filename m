Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C16C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5229561163
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhJVSWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhJVSWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B4C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so3566162wrc.10
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4uM3TAfHmp1dqgITIJQ9NmY6utUBFQHi7YZi8VSbPU=;
        b=UKXltkeYPp0Js+Aphy3aHdLDlDwOQaioJSve4zmPtUat0jCv/pnXRAWFrQhyourjEE
         jajYIiPG/Fka8amS24gmHbPFCXI61fKh+QKflkOEltFo1e1fPfrhFlwY8t5Mx1em9Kxl
         h7BEiRJcGQdEGY9bkayYzBrAEYFOvYyd7ict1ZiwOY5pw+EzogNeml9qbt7BLirmCkU/
         +aQ3El3/x2gC74mzF//r8DYbNULGcGHMei//F14ZryOWn8uuz63qJebZEifRtd/CCJKo
         SMRjWLsZ6hw1+cJb79G/Oswz8HkfOPxDfn5o4fskVZtgJrbplilV7Ijb0UVJ6vZ8VJdx
         mmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4uM3TAfHmp1dqgITIJQ9NmY6utUBFQHi7YZi8VSbPU=;
        b=XX/BPEaBO1RKdfbyqADmBqCpnyabwybsQMFH4hqjp1F1viJPbWv/KHM4jWIauB8B/f
         yuMlzH6uAqb8KXMuYaQ+Rp3W3pMsjdzTOzd6kd+epxZo2zoprGoCikJRRbE9URdD2Akb
         XmhVEdKO8Fuqkz46mJkMh30eMrIk7QnFFniXh8Rb6Rquu6vVXywLpro1ua+L6Ts0Pkqk
         INj+eYlinrpdw4Udwfvy+s7eS+XQzYrMeQNKO/oEQeuNHwD8hJJlVgcNmIdsGAGAZS4K
         SuJFITTalLPL6YP7qDcOf2eE9YjcRh4PowcHlP6JnBZlYEsQvcCROjqlD1T5XJVS0PTO
         QwHA==
X-Gm-Message-State: AOAM533D2ynM3HyE76fBVgAq2tAwxke5yxzk8bJslL/WdYraUddT1pL2
        OnRM5OTlD1JGe1FRlFSsP+/wgPdvngDRmQ==
X-Google-Smtp-Source: ABdhPJxM1+UBvGFdbI1tfCNHfaczkY93v0n8KNzp5BYsSugFHJf3Zcm8CcHsASmNBbnhRwXp+EQHHA==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr1834946wrw.102.1634926780775;
        Fri, 22 Oct 2021 11:19:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] usage.c: add die_message() & plug memory leaks in refs.c & config.c
Date:   Fri, 22 Oct 2021 20:19:33 +0200
Message-Id: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What started as a set of small memory leak fixes is now adding and
usinge a die_message() function. This non-fatal-die() is useful to
various callers that want to print "fatal: " before exiting, but don't
want to call die() for whatever reason.

I wasn't planning to submit that now, but these were incomplete
patches I had lying around, and make the 5th and 6th patch much nicer,
in response to comments on v1 and v2 to the effect that managing
free()-ing around die() functions was rather nasty.

This doesn't conflict with anything in-flight, and the changes
themselves are rather simple.

Ævar Arnfjörð Bjarmason (6):
  usage.c: add a die_message() routine
  usage.c API users: use die_message() where appropriate
  usage.c + gc: add and use a die_message_errno()
  config.c: don't leak memory in handle_path_include()
  config.c: free(expanded) before die(), work around GCC oddity
  refs: plug memory leak in repo_default_branch_name()

 builtin/fast-import.c     | 13 +++++----
 builtin/gc.c              | 21 ++++++++------
 builtin/notes.c           |  9 +++---
 config.c                  | 22 ++++++++++-----
 git-compat-util.h         |  4 +++
 http-backend.c            |  3 +-
 parse-options.c           |  2 +-
 refs.c                    |  8 +++++-
 run-command.c             | 16 ++++-------
 t/t1305-config-include.sh |  1 +
 usage.c                   | 58 +++++++++++++++++++++++++++++++--------
 11 files changed, 106 insertions(+), 51 deletions(-)

Range-diff against v2:
-:  ----------- > 1:  fe8763337ed usage.c: add a die_message() routine
-:  ----------- > 2:  dfc3a8fbccb usage.c API users: use die_message() where appropriate
-:  ----------- > 3:  6b33e394b2f usage.c + gc: add and use a die_message_errno()
2:  d6d04da1d9d = 4:  3607b905627 config.c: don't leak memory in handle_path_include()
3:  d812358e331 ! 5:  9a44204c4c9 config.c: free(expanded) before die(), work around GCC oddity
    @@ Commit message
         We really do have a memory leak here in either case, as e.g. running
         the pre-image under valgrind(1) will reveal. It's documented
         SANITIZE=leak (and "address", which exhibits the same behavior) might
    -    interact with compiler optimization in this way in some cases, and
    -    since this function is called recursively it's going to be especially
    +    interact with compiler optimization in this way in some cases. Since
    +    this function is called recursively it's going to be especially
         interesting as an optimization target.
     
         Let's work around this issue by freeing the "expanded" memory before
    -    we call die(), using the "goto cleanup" pattern introduced in the
    -    preceding commit.
    +    we call die(), using a combination of the "goto cleanup" pattern
    +    introduced in a preceding commit, and the newly introduced
    +    die_message() function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ config.c: static int handle_path_include(const char *path, struct config_include
      	int ret = 0;
      	struct strbuf buf = STRBUF_INIT;
      	char *expanded;
    -+	int die_depth = 0;
    ++	int exit_with = 0;
      
      	if (!path)
      		return config_error_nonbool("include.path");
    @@ config.c: static int handle_path_include(const char *path, struct config_include
     -			    cf->name ? cf->name :
     -			    "the command line");
     +		if (++inc->depth > MAX_INCLUDE_DEPTH) {
    -+			die_depth = 1;
    ++			exit_with = die_message(_(include_depth_advice),
    ++						MAX_INCLUDE_DEPTH, path,
    ++						!cf ? "<unknown>" : cf->name ?
    ++						cf->name : "the command line");
     +			goto cleanup;
     +		}
      		ret = git_config_from_file(git_config_include, path, inc);
    @@ config.c: static int handle_path_include(const char *path, struct config_include
      cleanup:
      	strbuf_release(&buf);
      	free(expanded);
    --	return ret;
    -+	if (!die_depth)
    -+		return ret;
    -+	die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
    -+	    !cf ? "<unknown>" : cf->name ? cf->name : "the command line");
    ++	if (exit_with)
    ++		exit(exit_with);
    + 	return ret;
      }
      
    - static void add_trailing_starstar_for_dir(struct strbuf *pat)
1:  4f8554bb02e ! 6:  d2f639b53cd refs.c: make "repo_default_branch_name" static, remove xstrfmt()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs.c: make "repo_default_branch_name" static, remove xstrfmt()
    +    refs: plug memory leak in repo_default_branch_name()
     
    -    The repo_default_branch_name() function introduced in
    -    8747ebb7cde (init: allow setting the default for the initial branch
    -    name via the config, 2020-06-24) has never been used outside of this
    -    file, so let's make it static, its sibling function
    -    git_default_branch_name() is what external callers use.
    +    Fix a memory leak in repo_default_branch_name(), we'll leak memory
    +    before exit(128) here.
     
    -    In addition the xstrfmt() to get the "full_ref" in the same commit
    -    isn't needed, we can use the "REFNAME_ALLOW_ONELEVEL" flag to
    -    check_refname_format() instead.
    +    Normally we would not care much about such leaks, we do leak the
    +    memory, as e.g. valgrind(1) will report. But the more commonly used
    +    SANITIZE=leak mode will use GCC and Clang's LSAN mode will not
    +    normally report such leaks.
     
    -    This also happens to fix an issue with c150064dbe2 (leak tests: run
    -    various built-in tests in t00*.sh SANITIZE=leak, 2021-10-12) in "next"
    -    when combined with SANITIZE=leak and higher optimization flags on at
    -    least some GCC versions. See [1].
    +    At least one GCC version does that in this case, and having the tests
    +    fail under -O3 would be annoying, so let's free() the allocated memory
    +    here.
     
    -    1. https://lore.kernel.org/git/patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com/
    +    This uses a new die_message() function introduced in a preceding
    +    commit. That new function makes the flow around such code easier to
    +    manage. In this case we can't free(ret) before the die().
    +
    +    In this case only the "free(full_ref)" appears to be needed, but since
    +    we're freeing one let's free both, some other compiler or version
    +    might arrange this code in such a way as to complain about "ret" too
    +    with SANITIZE=leak, and valgrind(1) will do so in any case.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
    -@@ refs.c: static const char default_branch_name_advice[] = N_(
    - "\tgit branch -m <name>\n"
    - );
    - 
    --char *repo_default_branch_name(struct repository *r, int quiet)
    -+static char *repo_default_branch_name(struct repository *r, int quiet)
    - {
    - 	const char *config_key = "init.defaultbranch";
    +@@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
      	const char *config_display_key = "init.defaultBranch";
    --	char *ret = NULL, *full_ref;
    -+	char *ret = NULL;
    + 	char *ret = NULL, *full_ref;
      	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
    ++	int exit_with = 0;
      
      	if (env && *env)
    + 		ret = xstrdup(env);
     @@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
    - 			advise(_(default_branch_name_advice), ret);
    - 	}
      
    --	full_ref = xstrfmt("refs/heads/%s", ret);
    --	if (check_refname_format(full_ref, 0))
    -+	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
    - 		die(_("invalid branch name: %s = %s"), config_display_key, ret);
    --	free(full_ref);
    + 	full_ref = xstrfmt("refs/heads/%s", ret);
    + 	if (check_refname_format(full_ref, 0))
    +-		die(_("invalid branch name: %s = %s"), config_display_key, ret);
    ++		exit_with = die_message(_("invalid branch name: %s = %s"),
    ++					config_display_key, ret);
    + 	free(full_ref);
    ++	if (exit_with) {
    ++		free(ret);
    ++		exit(exit_with);
    ++	}
      
      	return ret;
      }
    -
    - ## refs.h ##
    -@@ refs.h: int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
    -  * return value of `git_default_branch_name()` is a singleton.
    -  */
    - const char *git_default_branch_name(int quiet);
    --char *repo_default_branch_name(struct repository *r, int quiet);
    - 
    - /*
    -  * A ref_transaction represents a collection of reference updates that
-- 
2.33.1.1494.g88b39a443e1

