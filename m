Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DAC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951E560F9D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347668AbhIUCVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhIUBsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:48:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C206C065F2C
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:39:29 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x2so5902530ilm.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7FeeQulfmweYQxehk4SjQyY14gBNqgJ+f6LrwZTLKEs=;
        b=pcKGEtsJEU95zzc3YQqrP/V063MWFKmXYSoEH0IE4xNo4mu0bFFSa2IPRv+UxeyaUL
         wPdi6uABhwmgzRVGK0yqcJFZDjl4JJdI/Wy/FY8A9y9MCoC2si81nKSJam9HnDUdM4TT
         2NJ0QWi8CXLSOisfPzFzlNEmrLoa2OF+aDM6pSwe15VfkkrMS6kLExia/fhBQpUsh+Y8
         ZgSFkUR4bSrgCBBpkBW1Z/HdezDORCNLoSqgp3GmHSiYba7Ew4X9zZ58cSOk7ND01Bg2
         WQKB3bnBoWH5STKGHrpMmg6IvAMSwiSB75YMho2WwKKYsTGGwPuIQyeE12f35tz87+f7
         D1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7FeeQulfmweYQxehk4SjQyY14gBNqgJ+f6LrwZTLKEs=;
        b=jpHzYN7Ig4Xk7wJGiOMGyLs05IN9PA7p5PHls9DWvztXEmDgbIERguBmIukl0AcbSk
         aRR6rbjHAl/ZjxhZuybmR7Xk+tMLqlIpW/Ps+PKbWzbKnsQi2j9iHyjzgiWu9562TxEA
         CzADYlOA7YbCRxIvydgWLgsN8P3ZK28CP2VwswgC4QInwESzT9GcT23DOIEccxn8W6lB
         J8k0LxZn8qTgJmP0sOE+h/fr/w3MwvoEa51OZta7u5Ms5ZeaEQ97jgb5THbGv298UtcO
         dNU8zGBzBthN7QFX3PM61EDqXV8T+wPHHfQKezFn76Zil0B5R8CCOs0EbqD4baOcqXIG
         esYw==
X-Gm-Message-State: AOAM533H0U15G/zszc0SQ4ccfuymw8e3dytQe9L/EC3pM3OsaFI2T5BN
        V1Cwug1UfG322hEg+Nqiae4VCg==
X-Google-Smtp-Source: ABdhPJz7X6K/z+u+F+56T0w9bBQG+JC9oUCvEq7aDJMj+9LL8BYUc1C13L8DoPxhAQLBFIbsM8k2cA==
X-Received: by 2002:a05:6e02:156a:: with SMTP id k10mr19164665ilu.317.1632173968703;
        Mon, 20 Sep 2021 14:39:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12sm10463736ill.33.2021.09.20.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:39:28 -0700 (PDT)
Date:   Mon, 20 Sep 2021 17:39:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        szeder.dev@gmail.com, avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
Message-ID: <YUj/h3xucy4JR7B1@nand.local>
References: <cover.1631980949.git.me@ttaylorr.com>
 <xmqqr1dj9c0b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1dj9c0b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 02:24:04PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > An open question is whether the same should be done for the multi-pack-index
> > command, whose top-level support for `--[no-]progress` was released in v2.32.0
> > with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).
>
> We do not mind too much about "breaking backward compatibility" by
> removing the mistaken "git multi-pack-index --progress cmd", I would
> say.  It's not like people would type it once every day and removing
> the "support" will break their finger-memory.

OK; if we don't mind then we could do something like the following on
top. But if we're OK to remove the top-level `--progress` option from
the commit-graph and multi-pack-index builtins at any time, then both
patches become far less urgent.

Thanks,
Taylor

--- >8 ---

Subject: [PATCH] builtin/multi-pack-index.c: disable top-level --[no-]progress

In a similar spirit as the previous patch, let sub-commands which
support showing or hiding a progress meter handle parsing the
`--progress` or `--no-progress` option, but do not expose it as an
option to the top-level `multi-pack-index` builtin.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  6 ++---
 builtin/multi-pack-index.c             | 31 +++++++++++++++++++++-----
 t/t5319-multi-pack-index.sh            | 12 +++++-----
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ffd601bc17..5ba4bd5166 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,8 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
-	[--preferred-pack=<pack>] <subcommand>
+'git multi-pack-index' [--object-dir=<dir>] <sub-command>

 DESCRIPTION
 -----------
@@ -26,7 +25,8 @@ OPTIONS

 --[no-]progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
-	shown if standard error is connected to a terminal.
+	shown if standard error is connected to a terminal. Supported by
+	sub-commands `write`, `verify`, `expire`, and `repack.

 The following subcommands are available:

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 649aa5f9ab..5f11a3067d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -52,7 +52,6 @@ static struct opts_multi_pack_index {
 static struct option common_opts[] = {
 	OPT_FILENAME(0, "object-dir", &opts.object_dir,
 	  N_("object directory containing set of packfile and pack-index pairs")),
-	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
 	OPT_END(),
 };

@@ -68,6 +67,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
 			   N_("preferred-pack"),
 			   N_("pack for reuse when computing a multi-pack bitmap")),
+		OPT_BIT(0, "progress", &opts.flags,
+			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};

@@ -75,6 +76,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)

 	trace2_cmd_mode(argv[0]);

+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -90,10 +93,18 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)

 static int cmd_multi_pack_index_verify(int argc, const char **argv)
 {
-	struct option *options = common_opts;
+	struct option *options;
+	static struct option builtin_multi_pack_index_verify_options[] = {
+		OPT_BIT(0, "progress", &opts.flags,
+			N_("force progress reporting"), MIDX_PROGRESS),
+		OPT_END(),
+	};
+	options = add_common_options(builtin_multi_pack_index_verify_options);

 	trace2_cmd_mode(argv[0]);

+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -106,10 +117,18 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)

 static int cmd_multi_pack_index_expire(int argc, const char **argv)
 {
-	struct option *options = common_opts;
+	struct option *options;
+	static struct option builtin_multi_pack_index_expire_options[] = {
+		OPT_BIT(0, "progress", &opts.flags,
+			N_("force progress reporting"), MIDX_PROGRESS),
+		OPT_END(),
+	};
+	options = add_common_options(builtin_multi_pack_index_expire_options);

 	trace2_cmd_mode(argv[0]);

+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -126,6 +145,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 	static struct option builtin_multi_pack_index_repack_options[] = {
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
+		OPT_BIT(0, "progress", &opts.flags,
+		  N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};

@@ -133,6 +154,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)

 	trace2_cmd_mode(argv[0]);

+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
@@ -154,8 +177,6 @@ int cmd_multi_pack_index(int argc, const char **argv,

 	git_config(git_default_config, NULL);

-	if (isatty(2))
-		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage,
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c3..86b7de2281 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -174,12 +174,12 @@ test_expect_success 'write progress off for redirected stderr' '
 '

 test_expect_success 'write force progress on for stderr' '
-	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir write --progress 2>err &&
 	test_file_not_empty err
 '

 test_expect_success 'write with the --no-progress option' '
-	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir write --no-progress 2>err &&
 	test_line_count = 0 err
 '

@@ -429,12 +429,12 @@ test_expect_success 'repack progress off for redirected stderr' '
 '

 test_expect_success 'repack force progress on for stderr' '
-	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack --progress 2>err &&
 	test_file_not_empty err
 '

 test_expect_success 'repack with the --no-progress option' '
-	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack --no-progress 2>err &&
 	test_line_count = 0 err
 '

@@ -618,7 +618,7 @@ test_expect_success 'expire progress off for redirected stderr' '
 test_expect_success 'expire force progress on for stderr' '
 	(
 		cd dup &&
-		GIT_PROGRESS_DELAY=0 git multi-pack-index --progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index expire --progress 2>err &&
 		test_file_not_empty err
 	)
 '
@@ -626,7 +626,7 @@ test_expect_success 'expire force progress on for stderr' '
 test_expect_success 'expire with the --no-progress option' '
 	(
 		cd dup &&
-		GIT_PROGRESS_DELAY=0 git multi-pack-index --no-progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index expire --no-progress 2>err &&
 		test_line_count = 0 err
 	)
 '
--
2.33.0.96.g73915697e6

