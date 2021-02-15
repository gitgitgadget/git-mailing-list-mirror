Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291AC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FBB64E31
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBOSwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhBOSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:52:31 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311FC06178A
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:51:38 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id o21so5515569qtr.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IvQ4ivuj/dmThUh89Vej0oNLpqI79sBCJhBDMBZe4J0=;
        b=ZogljCBEjbOh1fq1VKQRFDUh5QK2eIHyuy42knwa/QHsp1jQMOLVdESoIAw3H6aISP
         diuwP63Q+4ngGqHe2mMuHqcmg3XwC2/WdPwtdp30DcSRmPJgJXaA/VxYHCZImHljFkHp
         Z0MTp+QRczXsryaYfR6d3a1FP585XJ5gdA6FXHgGoh/dl2CcT4pUXkAynEh41rZpcy/s
         AZSvzwo6bCPo1tFakbVmtAM9XW23Sz9pgDTw1kNZ6V30rHBlAmgezBo8tcHEOEY5Los3
         cz4R39Nf62J90wOJZdpKa7+T4VVowVZE0GXKz3f9vvw5GCohCPLKc3TM5vrdcHbJcME6
         wEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IvQ4ivuj/dmThUh89Vej0oNLpqI79sBCJhBDMBZe4J0=;
        b=tJiXxY0lRTTjYTTyHKL0/dwj2d4fW8sxUGxYEezdczuaM/utSB0Edogsx7CvLE2Y/e
         6weUuLAfjMH0PinMdmkxNvGTRalFBds7nhN7CQF4ZnPf1uj5zjosLGtsnbm8birum+pp
         8o4dGufGJyuKW8zxmmn/mJEKpGnJNxz82OKMHkxeLIRdjmCZZis8QVZO96fjmLhlt1AH
         hRRfX3OYf6NNvBv8CbvFhk/EXCSLjz3EATmihoAXs6XQmSIFDdSMsBTDnEUBsgRRBTbM
         UxZlExi+TeNkbb/2lU5DYMWXlsTmIqD/mvn9/3LpHmFByULXgS0r/tDtd+KuLI0+lNSd
         HBHg==
X-Gm-Message-State: AOAM532JC9CIqp/Kl6SzdQSTiU4iA8csV6GocwNbTO1JV7W/c0a/L1vh
        2rqFb24olTqXk3Wg94Zu+1UQBQ==
X-Google-Smtp-Source: ABdhPJxExoZ4yp6Af681fIS8FUYTZlbcAxwoYxPLxK0zMrA/9vpkUfauqKkitGOPuVDPEeL5HUprFw==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr15476653qti.60.1613415097865;
        Mon, 15 Feb 2021 10:51:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id u4sm12774125qkc.42.2021.02.15.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:51:37 -0800 (PST)
Date:   Mon, 15 Feb 2021 13:51:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YCrCt8sEFJSPE+28@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215184118.11306-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 07:41:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Make use of the parse_options_concat() so we don't need to copy/paste
> common options like --object-dir. This is inspired by a similar change
> to "checkout" in 2087182272
> (checkout: split options[] array in three pieces, 2019-03-29).
>
> A minor behavior change here is that now we're going to list both
> --object-dir and --progress first, before we'd list --progress along
> with other options.

"Behavior change" referring only to the output of `git commit-graph -h`,
no?

Looking at the code (and understanding this whole situation a little bit
better), I'd think that this wouldn't cause us to parse anything
differently before or after this change, right?

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 43 ++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index baead04a03..a7718b2025 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -44,6 +44,21 @@ static struct opts_commit_graph {
>  	int enable_changed_paths;
>  } opts;
>
> +static struct option *add_common_options(struct option *prevopts)
> +{
> +	struct option options[] = {
> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
> +			   N_("dir"),
> +			   N_("the object directory to store the graph")),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
> +		OPT_END()
> +	};

I'm nitpicking, but I wouldn't be sad to see this called "common"
instead".

Can't this also be declared statically?

> +	struct option *newopts = parse_options_concat(options, prevopts);
> +	free(prevopts);
> +	return newopts;
> +}
> +
>  static struct object_directory *find_odb(struct repository *r,
>  					 const char *obj_dir)
>  {
> @@ -75,22 +90,20 @@ static int graph_verify(int argc, const char **argv)
>  	int fd;
>  	struct stat st;
>  	int flags = 0;
> -
> +	struct option *options = NULL;
>  	static struct option builtin_commit_graph_verify_options[] = {
> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
> -			   N_("dir"),
> -			   N_("the object directory to store the graph")),
>  		OPT_BOOL(0, "shallow", &opts.shallow,
>  			 N_("if the commit-graph is split, only verify the tip file")),
> -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_END(),
>  	};
> +	options = parse_options_dup(builtin_commit_graph_verify_options);

Another nitpick, but I'd rather see the initialization of "options" and
its declaration be on the same line, after declaring
builtin_commit_graph_verify_options.

> +	options = add_common_options(options);
>
>  	trace2_cmd_mode("verify");
>
>  	opts.progress = isatty(2);
>  	argc = parse_options(argc, argv, NULL,
> -			     builtin_commit_graph_verify_options,
> +			     options,
>  			     builtin_commit_graph_verify_usage, 0);
>
>  	if (!opts.obj_dir)
> @@ -205,11 +218,8 @@ static int graph_write(int argc, const char **argv)
>  	int result = 0;
>  	enum commit_graph_write_flags flags = 0;
>  	struct progress *progress = NULL;
> -
> +	struct option *options = NULL;
>  	static struct option builtin_commit_graph_write_options[] = {
> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
> -			N_("dir"),
> -			N_("the object directory to store the graph")),
>  		OPT_BOOL(0, "reachable", &opts.reachable,
>  			N_("start walk at all refs")),
>  		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
> @@ -220,7 +230,6 @@ static int graph_write(int argc, const char **argv)
>  			N_("include all commits already in the commit-graph file")),
>  		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
>  			N_("enable computation for changed paths")),
> -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
>  			N_("allow writing an incremental commit-graph file"),
>  			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> @@ -236,6 +245,8 @@ static int graph_write(int argc, const char **argv)
>  			0, write_option_max_new_filters),
>  		OPT_END(),
>  	};
> +	options = parse_options_dup(builtin_commit_graph_write_options);
> +	options = add_common_options(options);
>
>  	opts.progress = isatty(2);
>  	opts.enable_changed_paths = -1;
> @@ -249,7 +260,7 @@ static int graph_write(int argc, const char **argv)
>  	git_config(git_commit_graph_write_config, &opts);
>
>  	argc = parse_options(argc, argv, NULL,
> -			     builtin_commit_graph_write_options,
> +			     options,
>  			     builtin_commit_graph_write_usage, 0);
>
>  	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
> @@ -312,12 +323,8 @@ static int graph_write(int argc, const char **argv)
>
>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  {
> -	static struct option builtin_commit_graph_options[] = {
> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
> -			N_("dir"),
> -			N_("the object directory to store the graph")),
> -		OPT_END(),
> -	};
> +	struct option *no_options = parse_options_dup(NULL);

Hmm. Why bother calling add_common_options at all here?

Thanks,
Taylor
