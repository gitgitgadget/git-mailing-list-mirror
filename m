Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA81C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbiDYSa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiDYSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 14:30:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD13D2494F
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q23so9219948wra.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8W5phXmVcgoh93Csf1bUv7BSGu0H+byzN3C4Iyf1WI8=;
        b=j/q9kN+giUSEe7hAk4LftDSy91e+TEvu68KgabVm4fQvGGWhARcTgLEgjMympF/EgH
         qkB9A7ZydTUBRIAJWpXOQ+J/J1elwyX4TQZLnCWyquYmNCmf8OXVcuFKmtUI6oAZpds+
         D+GdhEKPp5yhaqENvXSGOVZouaY0G8uaqUiJGQIpSz1lx08WBxjCwWURw5C0y7oi5XrU
         VHNr++4cHGLbmeoNogI0cnaNU9+ASg6MUEqYm8Oe3fnHWK6WyZVhYOMqzfBs16fdqwd6
         IZJyGYXPSJvmG+z1tg9kBm3AEHaQVVNibKBTtQAiunFNoAxkcDySpfNTXf+0m2NSQusZ
         fZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8W5phXmVcgoh93Csf1bUv7BSGu0H+byzN3C4Iyf1WI8=;
        b=3NNCiNbi9UklAMxZbfA5UTE0O6gwWGJHpmOdU+VrIWlYKFVJDEhnDUWWZhpqBbef2J
         0SErMyPJZHioUpfoZp1EytR2W44VeZ2JRt8uxRIXyMgQn4gqInv3EC93RiLBuuUFbH2T
         wdfW7THZVs0tFuIC43fxT9xDwi7xplDdRjN8x6fqDWOnAHxsYCm7+tTfmmvdDfVFzJmk
         4QY05Tashl0ERhZHoCEP1+A1x2MaYPJfD6MYYXQWwU+8qX8oYpyxvQqK0y2RcMTxsc6x
         l+tAUKEPWH576CMoVxJ6k0umtcG4vtcqxRzDtjni8FxTWU5q6xkG4iGNHigKIqEo5CKr
         Fswg==
X-Gm-Message-State: AOAM533m1Nlp3Nk9XCb972Y/B4mv1pKf1zEHkzHbB/f5VyXprTxdQr64
        G5sgEkxO+VXXSA8jyPW3OznTW4TpHdA=
X-Google-Smtp-Source: ABdhPJyqCTSXnPsWkI1K5LMIQvPRSfn+4I6aEaNhJeXc5+JRDsV69ZBC6TANTOe3TYfurMdOWyNoiQ==
X-Received: by 2002:a05:6000:502:b0:20a:d9d2:ccea with SMTP id a2-20020a056000050200b0020ad9d2cceamr5627438wrf.128.1650911235811;
        Mon, 25 Apr 2022 11:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020adfa196000000b0020ad517ce4bsm6392018wru.52.2022.04.25.11.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:27:15 -0700 (PDT)
Message-Id: <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 18:27:11 +0000
Subject: [PATCH v2 0/3] multi-pack-index: use real paths for --object-dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A VFS for Git user reported [1] that the background maintenance did not seem
to be doing anything. At least, the 'git multi-pack-index expire' and 'git
multi-pack-index repack' steps did nothing. The 'write' subcommand worked to
collect all pack-files into a single multi-pack-index file, but the packs
were only growing in number instead of being maintained carefully.

[1] https://github.com/microsoft/git/issues/497

The root issue is about path comparisons between Windows and Unix path
styles.

The fix is two-fold:

 * Patch 1 performs real-path normalization at a low-level where it is
   required.
 * Patch 2 performs real-path normalization at a high-level to be extra
   safe.
 * Patch 3 adds an extra API hardening that I noticed while making Patch 2
   for v2.

I'm not exactly sure how to test this properly in the Git codebase, but I'm
looking to add some tests into VFS for Git to ensure this doesn't regress in
the future.


Updates in v2
=============

 * Patch 2 is rewritten to use an option callback, as recommended by
   Victoria. This is more robust to future changes to the CLI.
 * Patch 3 is new, and something I found while working on patch 2.

Thanks, -Stolee

Derrick Stolee (3):
  midx: use real paths in lookup_multi_pack_index()
  multi-pack-index: use --object-dir real path
  cache: use const char * for get_object_directory()

 builtin/multi-pack-index.c | 45 ++++++++++++++++++++++++++++----------
 cache.h                    |  2 +-
 environment.c              |  2 +-
 midx.c                     | 17 ++++++++++----
 4 files changed, 49 insertions(+), 17 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1221%2Fderrickstolee%2Fmidx-normalize-object-dir-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1221/derrickstolee/midx-normalize-object-dir-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1221

Range-diff vs v1:

 1:  34785a0c7cc = 1:  34785a0c7cc midx: use real paths in lookup_multi_pack_index()
 2:  0435406e2db ! 2:  fd580e79477 multi-pack-index: use --object-dir real path
     @@ Commit message
          using the object_dir value, so it can be helpful to convert the path to
          the real-path before sending it to those locations.
      
     -    Adding the normalization in builtin/multi-pack-index.c is a little
     -    complicated because of how the sub-commands were split in 60ca94769
     -    (builtin/multi-pack-index.c: split sub-commands, 2021-03-30). The
     -    --object-dir argument could be parsed before the sub-command name _or_
     -    after it. Thus, create a normalize_object_dir() helper to call after all
     -    arguments are parsed, but before any logic is run on that object dir.
     +    Add a callback to convert the real path immediately upon parsing the
     +    argument. We need to be careful that we don't store the exact value out
     +    of get_object_directory() and free it, or we could corrupt a later use
     +    of the_repository->objects->odb->path.
     +
     +    We don't use get_object_directory() for the initial instantiation in
     +    cmd_multi_pack_index() because we need 'git multi-pack-index -h' to work
     +    without a Git repository.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## builtin/multi-pack-index.c ##
     -@@ builtin/multi-pack-index.c: static void read_packs_from_stdin(struct string_list *to)
     - 	strbuf_release(&buf);
     - }
     +@@ builtin/multi-pack-index.c: static char const * const builtin_multi_pack_index_usage[] = {
     + };
     + 
     + static struct opts_multi_pack_index {
     +-	const char *object_dir;
     ++	char *object_dir;
     + 	const char *preferred_pack;
     + 	const char *refs_snapshot;
     + 	unsigned long batch_size;
     +@@ builtin/multi-pack-index.c: static struct opts_multi_pack_index {
     + 	int stdin_packs;
     + } opts;
       
     -+static void normalize_object_dir(void)
     ++
     ++static int parse_object_dir(const struct option *opt, const char *arg,
     ++			    int unset)
      +{
     -+	if (!opts.object_dir)
     -+		opts.object_dir = get_object_directory();
     ++	free(opts.object_dir);
     ++	if (unset)
     ++		opts.object_dir = xstrdup(get_object_directory());
      +	else
     -+		opts.object_dir = real_pathdup(opts.object_dir, 1);
     ++		opts.object_dir = real_pathdup(arg, 1);
     ++	return 0;
      +}
      +
     - static int cmd_multi_pack_index_write(int argc, const char **argv)
     - {
     - 	struct option *options;
     -@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv)
     - 
     - 	FREE_AND_NULL(options);
     - 
     -+	normalize_object_dir();
     -+
     - 	if (opts.stdin_packs) {
     - 		struct string_list packs = STRING_LIST_INIT_DUP;
     - 		int ret;
     -@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_verify(int argc, const char **argv)
     - 
     - 	FREE_AND_NULL(options);
     - 
     -+	normalize_object_dir();
     -+
     - 	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
     - }
     - 
     -@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_expire(int argc, const char **argv)
     - 
     - 	FREE_AND_NULL(options);
     - 
     -+	normalize_object_dir();
     -+
     - 	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
     - }
     + static struct option common_opts[] = {
     +-	OPT_FILENAME(0, "object-dir", &opts.object_dir,
     +-	  N_("object directory containing set of packfile and pack-index pairs")),
     ++	OPT_CALLBACK(0, "object-dir", &opts.object_dir,
     ++	  N_("directory"),
     ++	  N_("object directory containing set of packfile and pack-index pairs"),
     ++	  parse_object_dir),
     + 	OPT_END(),
     + };
       
      @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_repack(int argc, const char **argv)
     + int cmd_multi_pack_index(int argc, const char **argv,
     + 			 const char *prefix)
     + {
     ++	int res;
     + 	struct option *builtin_multi_pack_index_options = common_opts;
       
     - 	FREE_AND_NULL(options);
     + 	git_config(git_default_config, NULL);
       
     -+	normalize_object_dir();
     ++	if (the_repository &&
     ++	    the_repository->objects &&
     ++	    the_repository->objects->odb)
     ++		opts.object_dir = xstrdup(the_repository->objects->odb->path);
      +
     - 	return midx_repack(the_repository, opts.object_dir,
     - 			   (size_t)opts.batch_size, opts.flags);
     - }
     -@@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv,
     + 	argc = parse_options(argc, argv, prefix,
     + 			     builtin_multi_pack_index_options,
       			     builtin_multi_pack_index_usage,
       			     PARSE_OPT_STOP_AT_NON_OPTION);
       
     @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv
       	if (!argc)
       		goto usage;
       
     + 	if (!strcmp(argv[0], "repack"))
     +-		return cmd_multi_pack_index_repack(argc, argv);
     ++		res = cmd_multi_pack_index_repack(argc, argv);
     + 	else if (!strcmp(argv[0], "write"))
     +-		return cmd_multi_pack_index_write(argc, argv);
     ++		res =  cmd_multi_pack_index_write(argc, argv);
     + 	else if (!strcmp(argv[0], "verify"))
     +-		return cmd_multi_pack_index_verify(argc, argv);
     ++		res =  cmd_multi_pack_index_verify(argc, argv);
     + 	else if (!strcmp(argv[0], "expire"))
     +-		return cmd_multi_pack_index_expire(argc, argv);
     ++		res =  cmd_multi_pack_index_expire(argc, argv);
     ++	else {
     ++		error(_("unrecognized subcommand: %s"), argv[0]);
     ++		goto usage;
     ++	}
     ++
     ++	free(opts.object_dir);
     ++	return res;
     + 
     +-	error(_("unrecognized subcommand: %s"), argv[0]);
     + usage:
     + 	usage_with_options(builtin_multi_pack_index_usage,
     + 			   builtin_multi_pack_index_options);
 -:  ----------- > 3:  c9b13f0e146 cache: use const char * for get_object_directory()

-- 
gitgitgadget
