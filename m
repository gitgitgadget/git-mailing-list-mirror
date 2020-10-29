Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7BC55178
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7D420756
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKoLnsRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgJ2Ucg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgJ2Uce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:32:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43AC0613D4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 13so1045935wmf.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hq7qWcx5eQSBfxV+i7dmSkyOB1hQyNCrOE42hwooC0c=;
        b=hKoLnsRFYDRUab+xKjfZP//4M0oohKzct28r8a19rMgV1mLQi9SU3UINvI6Hv0Fuoa
         YNURf2BxKOu7g8pCmLhmpHstaCLVFcuQKMzgYU9QR8q08wQpR4NRYH/+xtWsi0Nc66kK
         LHaFeKu2SqGj+HW2ztFkWAXSCaHv38tUmuxDdWueC5NSA94/mxX1trsfaQvR3c1cOy2x
         bmuas2mhRm160hkw9yi9nO/GF8Ck20DJCl/OzxHFV4dRTgngf+sSYHgJ+S4Mw/jj8QM6
         zzoaoSGgRfKCJEEVBkIQITUbExmtgDG3DVBV4Ah+mofSxQNEolhmbx/rmH+1+06fJ/Wg
         Wk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hq7qWcx5eQSBfxV+i7dmSkyOB1hQyNCrOE42hwooC0c=;
        b=eIMYSY8Mf7TNmnMzZ5m34I+VzLa2UsBKdNS0f0eQj95Ybhzitn68Kc0JUepcNrAL4U
         2DLc/TZD12gJZKVxyR9gfjAeV0s8kwiLL566VbkUocWkjAM8o6+S6x/Iyku+ob8K8xis
         oiYIsKe0UqPXcipuCzfWTzZEPalEG2eYkxKHUPCz+ZCKLtbYsdyfXDZMTk0pPsw8BWlm
         QLovmkMLG9wIKT/qIk6g6JFZTQA3iSXKo5LScUMUK7F+UCzeOuGv2sgk+cQRkXiNynVD
         +mmD+W/jL16NyHqEkKMH9ZG1YZWAawFattEU0h/aZER1Ee1lsnzO87TLuhP7xbSwq+0R
         Fp2w==
X-Gm-Message-State: AOAM532j8B73v4GXw+JRO5r6f3SDpZGlszDYkvf2YxmtUb9jDeTQMSkk
        1ssUHHDF1uC0rRTAMXokp0tG5+YPm0k=
X-Google-Smtp-Source: ABdhPJy4lbEHU1aBLE8Sn/T6L0BjfXRlSz/Ma5WEFrgoDNUyidxKt31A2PX0T+JqYITX6IFUNSEIzg==
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr1088528wme.46.1604003536328;
        Thu, 29 Oct 2020 13:32:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm6874961wrm.2.2020.10.29.13.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:32:15 -0700 (PDT)
Message-Id: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
References: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 20:32:10 +0000
Subject: [PATCH v4 0/4] Beginning of new merge strategy: New API, empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series, I show the new merge API I have developed in merge-ort, and
show how it differs from that provided by merge-recursive. I do this in four
steps, each corresponding to a patch.

Changes since v3:

 * Make 'fast-rebase' be a test-tool subcommand instead of a special hidden
   builtin, as suggested by Jonathan Tan and SZEDER Gábor

Elijah Newren (4):
  merge-ort: barebones API of new merge strategy with empty
    implementation
  merge-ort-wrappers: new convience wrappers to mimic the old merge API
  fast-rebase: demonstrate merge-ort's API via new test-tool command
  merge,rebase,revert: select ort or recursive by config or environment

 Makefile                    |   3 +
 builtin/merge.c             |  26 ++++-
 builtin/rebase.c            |   9 +-
 builtin/revert.c            |   2 +
 merge-ort-wrappers.c        |  62 +++++++++++
 merge-ort-wrappers.h        |  25 +++++
 merge-ort.c                 |  52 +++++++++
 merge-ort.h                 |  58 ++++++++++
 sequencer.c                 |  71 ++++++++++--
 t/helper/test-fast-rebase.c | 211 ++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 12 files changed, 506 insertions(+), 15 deletions(-)
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h
 create mode 100644 t/helper/test-fast-rebase.c


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895%2Fnewren%2Fort-api-with-empty-implementation-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/newren/ort-api-with-empty-implementation-v4
Pull-Request: https://github.com/git/git/pull/895

Range-diff vs v3:

 1:  3357ea415e = 1:  3357ea415e merge-ort: barebones API of new merge strategy with empty implementation
 2:  d7f6a834ab = 2:  d7f6a834ab merge-ort-wrappers: new convience wrappers to mimic the old merge API
 3:  27ad756600 ! 3:  fce0db8778 fast-rebase: demonstrate merge-ort's API via temporary/hidden command
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    fast-rebase: demonstrate merge-ort's API via temporary/hidden command
     +    fast-rebase: demonstrate merge-ort's API via new test-tool command
      
     -    Add a special built-in that is only of use to git-developers and only
     -    during the development of merge-ort, and which is designed to
     -    immediately fail and print:
     -       git: 'fast-rebase' is not a git command
     -    unless a special GIT_TEST_MERGE_ALGORITHM environment variable is set.
     -
     -    This special builtin serves two purposes:
     +    Add a new test-tool command named 'fast-rebase', which is a
     +    super-slimmed down and nowhere near as capable version of 'git rebase'.
     +    'test-tool fast-rebase' is not currently planned for usage in the
     +    testsuite, but is here for two purposes:
      
            1) Demonstrate the desired API of merge-ort.  In particular,
               fast-rebase takes advantage of the separation of the merging
               operation from the updating of the index and working tree, to
               allow it to pick N commits, but only update the index and working
               tree once at the end.  Look for the calls to
     -         merge_inmemory_nonrecursive() and merge_switch_to_result().
     +         merge_incore_nonrecursive() and merge_switch_to_result().
      
            2) Provide a convenient benchmark that isn't polluted by the heavy
               disk writing and forking of unnecessary processes that comes from
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Makefile ##
     -@@ Makefile: BUILTIN_OBJS += builtin/difftool.o
     - BUILTIN_OBJS += builtin/env--helper.o
     - BUILTIN_OBJS += builtin/fast-export.o
     - BUILTIN_OBJS += builtin/fast-import.o
     -+BUILTIN_OBJS += builtin/fast-rebase.o
     - BUILTIN_OBJS += builtin/fetch-pack.o
     - BUILTIN_OBJS += builtin/fetch.o
     - BUILTIN_OBJS += builtin/fmt-merge-msg.o
     -
     - ## builtin.h ##
     -@@ builtin.h: int cmd_difftool(int argc, const char **argv, const char *prefix);
     - int cmd_env__helper(int argc, const char **argv, const char *prefix);
     - int cmd_fast_export(int argc, const char **argv, const char *prefix);
     - int cmd_fast_import(int argc, const char **argv, const char *prefix);
     -+int cmd_fast_rebase(int argc, const char **argv, const char *prefix);
     - int cmd_fetch(int argc, const char **argv, const char *prefix);
     - int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
     - int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
     +@@ Makefile: TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
     + TEST_BUILTINS_OBJS += test-dump-split-index.o
     + TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
     + TEST_BUILTINS_OBJS += test-example-decorate.o
     ++TEST_BUILTINS_OBJS += test-fast-rebase.o
     + TEST_BUILTINS_OBJS += test-genrandom.o
     + TEST_BUILTINS_OBJS += test-genzeros.o
     + TEST_BUILTINS_OBJS += test-hash-speed.o
      
     - ## builtin/fast-rebase.c (new) ##
     + ## t/helper/test-fast-rebase.c (new) ##
      @@
      +/*
      + * "git fast-rebase" builtin command
     @@ builtin/fast-rebase.c (new)
      + */
      +
      +#define USE_THE_INDEX_COMPATIBILITY_MACROS
     -+#include "builtin.h"
     ++#include "test-tool.h"
      +
      +#include "cache-tree.h"
      +#include "commit.h"
     @@ builtin/fast-rebase.c (new)
      +	return (struct commit *)obj;
      +}
      +
     -+int cmd_fast_rebase(int argc, const char **argv, const char *prefix)
     ++int cmd__fast_rebase(int argc, const char **argv)
      +{
      +	struct commit *onto;
      +	struct commit *last_commit = NULL, *last_picked_commit = NULL;
     @@ builtin/fast-rebase.c (new)
      +	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct strbuf branch_name = STRBUF_INIT;
      +
     ++	/*
     ++	 * test-tool stuff doesn't set up the git directory by default; need to
     ++	 * do that manually.
     ++	 */
     ++	setup_git_directory();
     ++
      +	if (argc == 2 && !strcmp(argv[1], "-h")) {
      +		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
      +		exit(129);
      +	}
      +
     -+	if (!getenv("GIT_TEST_MERGE_ALGORITHM")) {
     -+		fprintf_ln(stderr, _("git: 'fast-rebase' is not a git command. See 'git --help'."));
     -+		exit(1);
     -+	}
     -+
      +	if (argc != 5 || strcmp(argv[1], "--onto"))
      +		die("usage: read the code, figure out how to use it, then do so");
      +
     @@ builtin/fast-rebase.c (new)
      +	return (clean == 0);
      +}
      
     - ## git.c ##
     -@@ git.c: static struct cmd_struct commands[] = {
     - 	{ "env--helper", cmd_env__helper },
     - 	{ "fast-export", cmd_fast_export, RUN_SETUP },
     - 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
     -+	{ "fast-rebase", cmd_fast_rebase, RUN_SETUP /* | NEED_WORK_TREE */ },
     - 	{ "fetch", cmd_fetch, RUN_SETUP },
     - 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
     - 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
     + ## t/helper/test-tool.c ##
     +@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     + 	{ "dump-split-index", cmd__dump_split_index },
     + 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
     + 	{ "example-decorate", cmd__example_decorate },
     ++	{ "fast-rebase", cmd__fast_rebase },
     + 	{ "genrandom", cmd__genrandom },
     + 	{ "genzeros", cmd__genzeros },
     + 	{ "hashmap", cmd__hashmap },
     +
     + ## t/helper/test-tool.h ##
     +@@ t/helper/test-tool.h: int cmd__dump_fsmonitor(int argc, const char **argv);
     + int cmd__dump_split_index(int argc, const char **argv);
     + int cmd__dump_untracked_cache(int argc, const char **argv);
     + int cmd__example_decorate(int argc, const char **argv);
     ++int cmd__fast_rebase(int argc, const char **argv);
     + int cmd__genrandom(int argc, const char **argv);
     + int cmd__genzeros(int argc, const char **argv);
     + int cmd__hashmap(int argc, const char **argv);
 4:  0479d59c33 = 4:  75d19804bd merge,rebase,revert: select ort or recursive by config or environment

-- 
gitgitgadget
