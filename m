Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C36C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2FF206F1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeUaILzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgE0WRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WRj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 18:17:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFCCC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:17:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci23so2154475pjb.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=onxZ6EEDvZsv6xWtNJxHP0HFiHOl3eHvuhAXTEwFy0o=;
        b=oeUaILzLTX79q90vHoqokVn6w+go7KjJXyaYVLPM2tHUyj0JVPwHziNC+vNe9UnfCK
         itbu/240EbomPjFtdtS5NFL/7h15FYMfuOgYD2i87ja6kvdkx8EAhp2fFRO8CC7maF4u
         RKDBI95WiRxhWJpp3/WX+jZoO8iI6xXnl4imf2Av8iVtLbe9PwmaKgiuKPK7MU/MFfO2
         TWJTDUctne49LeLWAZy24nIy/jZC6Lqu/oa33Z6MS4DXiAbaLKTYP86mUWuBi3kb06kz
         gXKWkm9cp6USUq7U0d4a5PmVAKnz08p/eHKdvKt55f5M1mbWfveqbj9rsUlFxIsz3tha
         uTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=onxZ6EEDvZsv6xWtNJxHP0HFiHOl3eHvuhAXTEwFy0o=;
        b=XwkojZRIp48ZGDaOr52ELwAb0Mtu+o3Zc/YrkPaMv8AgaRyY7wZkq6mTUgd9/XJ8sg
         yBwGguKiFRQkSWNx42GRBOe54IqtmP972m7b7F+UAUl2PI6PhzTAMjIK3LzyCOp3vgms
         +rDV1SvaaaEHZZY/VTtJX3evyOGLNYtw5OI976S64QIQci2phnkAv9lts/NrzbW0+enX
         v5O0z+uYtWkFCQZoEy6RhUIrEbUs+uQbe6jWceivu3TgjiqP3COkf/F1xvMHs7nf0rXS
         y5pC8dqlXPYS1nIWgjCa4Kv+zmZgtBqLN3s9QwPGzYebrG5lpnurGELNtrfZYlvqRXvt
         lUzg==
X-Gm-Message-State: AOAM533faUCSw/pBt4RaoEQH0XGPsBByIReXE8W9mxL2Yc03CivOsciL
        Fgk64aNkJsCWhcbk5zEi8AqiHpJMFZU=
X-Google-Smtp-Source: ABdhPJzoASwp+FuebPHd9XLN8EZTgNoP6pU5zxUnIZP7zlhisN3ktaCNhcS0PrKy2zYDxljS+51BSw==
X-Received: by 2002:a17:902:c410:: with SMTP id k16mr552634plk.10.1590617857789;
        Wed, 27 May 2020 15:17:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id w12sm3212982pjy.15.2020.05.27.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:17:36 -0700 (PDT)
Date:   Wed, 27 May 2020 15:17:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 05/15] run-job: implement pack-files job
Message-ID: <20200527221730.GA65111@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <5277398f189dd6e1456b0afdd6d85dbac7d98d07.1585946894.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5277398f189dd6e1456b0afdd6d85dbac7d98d07.1585946894.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.04.03 20:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The previous change cleaned up loose objects using the
> 'loose-objects' that can be run safely in the background. Add a
> similar job that performs similar cleanups for pack-files.
> 
> One issue with running 'git repack' is that it is designed to
> repack all pack-files into a single pack-file. While this is the
> most space-efficient way to store object data, it is not time or
> memory efficient. This becomes extremely important if the repo is
> so large that a user struggles to store two copies of the pack on
> their disk.
> 
> Instead, perform an "incremental" repack by collecting a few small
> pack-files into a new pack-file. The multi-pack-index facilitates
> this process ever since 'git multi-pack-index expire' was added in
> 19575c7 (multi-pack-index: implement 'expire' subcommand,
> 2019-06-10) and 'git multi-pack-index repack' was added in ce1e4a1
> (midx: implement midx_repack(), 2019-06-10).
> 
> The 'pack-files' job runs the following steps:
> 
> 1. 'git multi-pack-index write' creates a multi-pack-index file if
>    one did not exist, and otherwise will update the multi-pack-index
>    with any new pack-files that appeared since the last write. This
>    is particularly relevant with the background fetch job.
> 
>    When the multi-pack-index sees two copies of the same object, it
>    stores the offset data into the newer pack-file. This means that
>    some old pack-files could become "unreferenced" which I will use
>    to mean "a pack-file that is in the pack-file list of the
>    multi-pack-index but none of the objects in the multi-pack-index
>    reference a location inside that pack-file."
> 
> 2. 'git multi-pack-index expire' deletes any unreferenced pack-files
>    and updaes the multi-pack-index to drop those pack-files from the

Typo: updaes -> updates


>    list. This is safe to do as concurrent Git processes will see the
>    multi-pack-index and not open those packs when looking for object
>    contents. (Similar to the 'loose-objects' job, there are some Git

Is it still safe for concurrent processes if the repo did not have a
multi-pack-index when the first process started?


>    commands that open pack-files regardless of the multi-pack-index,
>    but they are rarely used. Further, a user that self-selects to
>    use background operations would likely refrain from using those
>    commands.)
> 
> 3. 'git multi-pack-index repack --bacth-size=<size>' collects a set

Typo: bacth-size -> batch-size


>    of pack-files that are listed in the multi-pack-index and creates
>    a new pack-file containing the objects whose offsets are listed
>    by the multi-pack-index to be in those objects. The set of pack-
>    files is selected greedily by sorting the pack-files by modified
>    time and adding a pack-file to the set if its "expected size" is
>    smaller than the batch size until the total expected size of the
>    selected pack-files is at least the batch size. The "expected
>    size" is calculated by taking the size of the pack-file divided
>    by the number of objects in the pack-file and multiplied by the
>    number of objects from the multi-pack-index with offset in that
>    pack-file. The expected size approximats how much data from that

Typo: approximats -> approximates


>    pack-file will contribute to the resulting pack-file size. The
>    intention is that the resulting pack-file will be close in size
>    to the provided batch size.
> 
>    The next run of the pack-files job will delete these repacked
>    pack-files during the 'expire' step.
> 
>    In this version, the batch size is set to "0" which ignores the
>    size restrictions when selecting the pack-files. It instead
>    selects all pack-files and repacks all packed objects into a
>    single pack-file. This will be updated in the next change, but
>    it requires doing some calculations that are better isolated to
>    a separate change.
> 
> Each of the above steps update the multi-pack-index file. After
> each step, we verify the new multi-pack-index. If the new
> multi-pack-index is corrupt, then delete the multi-pack-index,
> rewrite it from scratch, and stop doing the later steps of the
> job. This is intended to be an extra-safe check without leaving
> a repo with many pack-files without a multi-pack-index.
> 
> These steps are based on a similar background maintenance step in
> Scalar (and VFS for Git) [1]. This was incredibly effective for
> users of the Windows OS repository. After using the same VFS for Git
> repository for over a year, some users had _thousands_ of pack-files
> that combined to up to 250 GB of data. We noticed a few users were
> running into the open file descriptor limits (due in part to a bug
> in the multi-pack-index fixed by af96fe3392 (midx: add packs to
> packed_git linked list, 2019-04-29).
> 
> These pack-files were mostly small since they contained the commits
> and trees that were pushed to the origin in a given hour. The GVFS
> protocol includes a "prefetch" step that asks for pre-computed pack-
> files containing commits and trees by timestamp. These pack-files
> were grouped into "daily" pack-files once a day for up to 30 days.
> If a user did not request prefetch packs for over 30 days, then they
> would get the entire history of commits and trees in a new, large
> pack-file. This led to a large number of pack-files that had poor
> delta compression.
> 
> By running this pack-file maintenance step once per day, these repos
> with thousands of packs spanning 200+ GB dropped to dozens of pack-
> files spanning 30-50 GB. This was done all without removing objects
> from the system and using a constant batch size of two gigabytes.
> Once the work was done to reduce the pack-files to small sizes, the
> batch size of two gigabytes means that not every run triggers a
> repack operation, so the following run will not expire a pack-file.
> This has kept these repos in a "clean" state.
> 
> [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/PackfileMaintenanceStep.cs
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-run-job.txt | 18 ++++++-
>  builtin/run-job.c             | 90 ++++++++++++++++++++++++++++++++++-
>  midx.c                        |  2 +-
>  midx.h                        |  1 +
>  t/t7900-run-job.sh            | 39 +++++++++++++++
>  5 files changed, 147 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> index 43ca1160b5a..108ed25b8bd 100644
> --- a/Documentation/git-run-job.txt
> +++ b/Documentation/git-run-job.txt
> @@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
>  SYNOPSIS
>  --------
>  [verse]
> -'git run-job (commit-graph|fetch|loose-objects)'
> +'git run-job (commit-graph|fetch|loose-objects|pack-files)'
>  
>  
>  DESCRIPTION
> @@ -71,6 +71,22 @@ a batch of loose objects. The batch size is limited to 50 thousand
>  objects to prevent the job from taking too long on a repository with
>  many loose objects.
>  
> +'pack-files'::
> +
> +The `pack-files` job incrementally repacks the object directory using
> +the `multi-pack-index` feature. In order to prevent race conditions with
> +concurrent Git commands, it follows a two-step process. First, it
> +deletes any pack-files included in the `multi-pack-index` where none of
> +the objects in the `multi-pack-index` reference those pack-files; this
> +only happens if all objects in the pack-file are also stored in a newer
> +pack-file. Second, it selects a group of pack-files whose "expected
> +size" is below the batch size until the group has total expected size at
> +least the batch size; see the `--batch-size` option for the `repack`
> +subcommand in linkgit:git-multi-pack-index[1]. The default batch-size is
> +zero, which is a special case that attempts to repack all pack-files
> +into a single pack-file.
> +
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> index cecf9058c51..d3543f7ccb9 100644
> --- a/builtin/run-job.c
> +++ b/builtin/run-job.c
> @@ -1,13 +1,14 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "commit-graph.h"
> +#include "midx.h"
>  #include "object-store.h"
>  #include "parse-options.h"
>  #include "repository.h"
>  #include "run-command.h"
>  
>  static char const * const builtin_run_job_usage[] = {
> -	N_("git run-job (commit-graph|fetch|loose-objects)"),
> +	N_("git run-job (commit-graph|fetch|loose-objects|pack-files)"),
>  	NULL
>  };
>  
> @@ -238,6 +239,91 @@ static int run_loose_objects_job(void)
>  	return prune_packed() || pack_loose();
>  }
>  
> +static int multi_pack_index_write(void)
> +{
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	argv_array_pushl(&cmd, "multi-pack-index", "write",
> +			 "--no-progress", NULL);
> +	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +}
> +
> +static int rewrite_multi_pack_index(void)
> +{
> +	char *midx_name = get_midx_filename(the_repository->objects->odb->path);
> +
> +	unlink(midx_name);
> +	free(midx_name);
> +
> +	if (multi_pack_index_write()) {
> +		error(_("failed to rewrite multi-pack-index"));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int multi_pack_index_verify(void)
> +{
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	argv_array_pushl(&cmd, "multi-pack-index", "verify",
> +			 "--no-progress", NULL);
> +	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +}
> +
> +static int multi_pack_index_expire(void)
> +{
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	argv_array_pushl(&cmd, "multi-pack-index", "expire",
> +			 "--no-progress", NULL);
> +	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +}
> +
> +static int multi_pack_index_repack(void)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	argv_array_pushl(&cmd, "multi-pack-index", "repack",
> +			 "--no-progress", "--batch-size=0", NULL);
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> +	if (result && multi_pack_index_verify()) {
> +		warning(_("multi-pack-index verify failed after repack"));
> +		result = rewrite_multi_pack_index();
> +	}
> +
> +	return result;
> +}
> +
> +static int run_pack_files_job(void)
> +{
> +	if (multi_pack_index_write()) {
> +		error(_("failed to write multi-pack-index"));
> +		return 1;
> +	}
> +
> +	if (multi_pack_index_verify()) {
> +		warning(_("multi-pack-index verify failed after initial write"));
> +		return rewrite_multi_pack_index();
> +	}
> +
> +	if (multi_pack_index_expire()) {
> +		error(_("multi-pack-index expire failed"));
> +		return 1;
> +	}
> +
> +	if (multi_pack_index_verify()) {
> +		warning(_("multi-pack-index verify failed after expire"));
> +		return rewrite_multi_pack_index();
> +	}
> +
> +	if (multi_pack_index_repack()) {
> +		error(_("multi-pack-index repack failed"));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  int cmd_run_job(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_run_job_options[] = {
> @@ -261,6 +347,8 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
>  			return run_fetch_job();
>  		if (!strcmp(argv[0], "loose-objects"))
>  			return run_loose_objects_job();
> +		if (!strcmp(argv[0], "pack-files"))
> +			return run_pack_files_job();
>  	}
>  
>  	usage_with_options(builtin_run_job_usage,
> diff --git a/midx.c b/midx.c
> index 1527e464a7b..0f0d0a38812 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -36,7 +36,7 @@
>  
>  #define PACK_EXPIRED UINT_MAX
>  
> -static char *get_midx_filename(const char *object_dir)
> +char *get_midx_filename(const char *object_dir)
>  {
>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>  }
> diff --git a/midx.h b/midx.h
> index e6fa356b5ca..cf2c09dffc2 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -39,6 +39,7 @@ struct multi_pack_index {
>  
>  #define MIDX_PROGRESS     (1 << 0)
>  
> +char *get_midx_filename(const char *object_dir);
>  struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
>  int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
>  int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
> diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
> index 41da083257b..416ba04989d 100755
> --- a/t/t7900-run-job.sh
> +++ b/t/t7900-run-job.sh
> @@ -6,6 +6,7 @@ Testing the background jobs, in the foreground
>  '
>  
>  GIT_TEST_COMMIT_GRAPH=0
> +GIT_TEST_MULTI_PACK_INDEX=0
>  
>  . ./test-lib.sh
>  
> @@ -93,4 +94,42 @@ test_expect_success 'loose-objects job' '
>  	test_cmp packs-between packs-after
>  '
>  
> +test_expect_success 'pack-files job' '
> +	packDir=.git/objects/pack &&
> +
> +	# Create three disjoint pack-files with size BIG, small, small.
> +
> +	echo HEAD~2 | git -C client pack-objects --revs $packDir/test-1 &&
> +
> +	test_tick &&
> +	git -C client pack-objects --revs $packDir/test-2 <<-\EOF &&
> +	HEAD~1
> +	^HEAD~2
> +	EOF
> +
> +	test_tick &&
> +	git -C client pack-objects --revs $packDir/test-3 <<-\EOF &&
> +	HEAD
> +	^HEAD~1
> +	EOF
> +
> +	rm -f client/$packDir/pack-* &&
> +	rm -f client/$packDir/loose-* &&
> +
> +	ls client/$packDir/*.pack >packs-before &&
> +	test_line_count = 3 packs-before &&
> +
> +	# the job repacks the two into a new pack, but does not
> +	# delete the old ones.
> +	git -C client run-job pack-files &&
> +	ls client/$packDir/*.pack >packs-between &&
> +	test_line_count = 4 packs-between &&
> +
> +	# the job deletes the two old packs, and does not write
> +	# a new one because only one pack remains.
> +	git -C client run-job pack-files &&
> +	ls client/.git/objects/pack/*.pack >packs-after &&
> +	test_line_count = 1 packs-after
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
