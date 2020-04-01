Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC8C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3128620719
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qffMH88m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDAT1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:27:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44520 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbgDAT1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:27:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id 142so588904pgf.11
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/JaXN+tpdrlHP1oSpY1nPYsMhZhkL2d7UpjQN+0TQY=;
        b=qffMH88mCviYoZgeakFkxUQQg75EZwyYlCLfTd8RV6yrrS6+Di13pNkGg6oKV0mZkp
         DRPgE3HFffQ8mrSqr8BUKstak3BptSCl4scDpelJRZwBBBJq668ioZRrFdoDn1Q/aat+
         Ce5xd7V3QFl9PhFJ5VYw6WlsTeOu1aZD0+iSIwpq8mNONOHjyn5GlciNP9LllBsr6HG5
         U4QFo93ol06juPtjZJK9hYk7/bc1ZjJnCYhEUbIATMZPoeZTp6mJl/M2Gvo5d7Y+ncKv
         KHljo8yMvaMhK/Zn6P9E9BAOj1f4i6WRRniddNSUjux+xuAZvp2DTRREKdBvPwpuakRm
         3jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/JaXN+tpdrlHP1oSpY1nPYsMhZhkL2d7UpjQN+0TQY=;
        b=jnkOPutFiA7g79a3bhmPN9ZU/k0I0m2p7Gkwjc42rhVrfJF2+z6wDgBUoN2jAvMPfu
         EuglU9ZBeZlqn+8PJB+v22md1Zu/UkDHcQhyhM6emFLfNFu9pg7RJ0F6Q+fZ/gcjQc59
         uCSGoxxwDQNjbiYk520x///R7c1j3PygI5xu46FghyS1Ibs2obhzZVmJwtFsLXHbOA0o
         GzelJeIcPTzB6DrmxOwOY7C6Dbfp08UxQvi3ZA7WeUA6/zLS6+HSSjOn64L43857bmSs
         A4FaD9Nk/OmMSZagwmqG024r1mrhuJZHIaD1rqnn9Yjka2L+EtTqIm8MdHuLAIv4Kj6/
         HASw==
X-Gm-Message-State: ANhLgQ2iEzElUxGvNNTHD8xPpraZB4M6QrZabxBMvav0Sxn58WWAwKaq
        mVi50wzai5McUaF4pA4bVOx0spvDmqqeqg==
X-Google-Smtp-Source: ADFU+vvYds2kStVaHdHWeH39HoX5qwc12tfo8r/q+eXqCyHeRDNpijcc6sCxJpva10Qf5k2zM+EieQ==
X-Received: by 2002:a62:8684:: with SMTP id x126mr24584028pfd.160.1585769237748;
        Wed, 01 Apr 2020 12:27:17 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c11sm2123157pfc.216.2020.04.01.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:27:17 -0700 (PDT)
Date:   Wed, 1 Apr 2020 13:27:15 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
Message-ID: <20200401192715.GB13599@syl.local>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 06:11:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph builtin has an --expire-time option that takes a
> datetime using OPT_EXPIRY_DATE(). However, the implementation inside
> expire_commit_graphs() was treating a non-zero value as a number of
> seconds to subtract from "now".

Ah, nice catch. The fix below seems straightforward. Since we're using
'OPT_EXPIRY_DATE', parse-options accepts either, but gives us back a
date-time, so there's no need to subtract it from the current instant or
anything like that.

This patch below looks fine (I left a minor note here, and in the
documentation fixup that you sent shortly after this message, but
otherwise I think that this is good to go, at least from my point of
view).

> Update t5323-split-commit-graph.sh to demonstrate the correct value
> of the --expire-time option by actually creating a crud .graph file
> with mtime earlier than the expire time. Instead of using a super-
> early time (1980) we need to use a recent time or else the old
> logic actually passes by accident. This test will start passing
> again on the old logic in 40 years or so.
>
> I noticed this when inspecting some Scalar repos that had an excess
> number of commit-graph files. In Scalar, we were using this second
> interpretation by using "--expire-time=3600" to mean "delete graphs
> older than one hour ago" to avoid deleting a commit-graph that a
> foreground process may be trying to load.
>
> Also I noticed that the help text was copied from the --max-commits
> option. Fix that help text.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     commit-graph: fix buggy --expire-time option
>
>     This is embarassing. I should have noticed this when writing it the
>     first time, or when integrating the feature into Scalar and VFS for Git.
>     Sorry!
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-596%2Fderrickstolee%2Fcommit-graph-expire-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-596/derrickstolee/commit-graph-expire-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/596
>
>  builtin/commit-graph.c        | 2 +-
>  commit-graph.c                | 2 +-
>  t/t5324-split-commit-graph.sh | 4 +++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4a70b33fb5f..8000ff0d2ee 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
>  		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
>  			N_("maximum ratio between two levels of a split commit-graph")),
>  		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
> -			N_("maximum number of commits in a non-base split commit-graph")),
> +			N_("do not expire files newer than a number of seconds before now")),
>  		OPT_END(),
>  	};
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f013a84e294..0d0d37787a0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1707,7 +1707,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
>  	timestamp_t expire_time = time(NULL);
>
>  	if (ctx->split_opts && ctx->split_opts->expire_time)
> -		expire_time -= ctx->split_opts->expire_time;
> +		expire_time = ctx->split_opts->expire_time;
>  	if (!ctx->split) {
>  		char *chain_file_name = get_chain_filename(ctx->odb);
>  		unlink(chain_file_name);
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 53b2e6b4555..4e4efcaff22 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>  		git config core.commitGraph true &&
>  		test_line_count = 2 $graphdir/commit-graph-chain &&
>  		test_commit 15 &&
> -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
> +		touch -m -t 201801010000.00 $graphdir/extra.graph &&
> +		git commit-graph write --reachable --split --size-multiple=10 --expire-time=2019-01-01 &&

Could this be written instead as:

  touch -m -t $(date -r $test_tick +"%Y%m%d%H%M.%S") $graphdir/extra.graph &&
  test_tick &&
  git commit-graph write --reachable --split --size-multiple=10 --expire-time=now &&

to avoid breaking in 40 years?

>  		test_line_count = 1 $graphdir/commit-graph-chain &&
> +		test_path_is_missing $graphdir/extra.graph &&
>  		ls $graphdir/graph-*.graph >graph-files &&
>  		test_line_count = 3 graph-files
>  	) &&
>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> --
> gitgitgadget

Thanks,
Taylor
