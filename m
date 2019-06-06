Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABC41F462
	for <e@80x24.org>; Thu,  6 Jun 2019 18:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFFSmC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 14:42:02 -0400
Received: from avasout01.plus.net ([84.93.230.227]:48824 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfFFSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 14:42:01 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id YxKdhSl03NYeNYxKehTcaf; Thu, 06 Jun 2019 19:42:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1559846520; bh=WA7vWrZIGQfYUNd/TSOONFkQ2d417EXaivVS+GjtX8I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TiVPNt8KK/93oSqBTUboa/KKTPvX8mOkIPtEg7bxaJX2aEStMmeAR+Ck32aZ6VwQq
         Wl75lsPLAdVsjVTmh+lNk+UDCPrmDbAV0Cu2ZeXQ1hoSo8PnwtfaDmrQN9SfA7K4rf
         Ly2eMWupn6/CjqfchC3RFGDR8xkDJI+cT6XEQCnF1tsOv4a93xNqaBB2nOoeid6m8r
         nuV2XEOozzMYK5g06h0gcz0KNx4jevcY9qrUvRaPyiAT+gmubZHuCIkLKDVIBd6PJd
         QB9WiFOFvaRmg/14Z/258y6dmfEl8RNQYFQiRGikvi9sIBfIoCY4YtfdwtBWV0bdPl
         0o8w8AsDSSCbQ==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=f4M2+96M c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8
 a=N7ZHssyA6PlrQIm94KAA:9 a=gebevrgy-ddnjHvr:21 a=02AyVYvvXlgxOx6L:21
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 12/14] commit-graph: create options for split files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <ac5586a20f7ed600f8912b1aed07dea5098ea046.1559830527.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <02c9a0e2-4505-14a4-fa68-958a7f0c7935@ramsayjones.plus.com>
Date:   Thu, 6 Jun 2019 19:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ac5586a20f7ed600f8912b1aed07dea5098ea046.1559830527.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGKz201ssh7kkJd2mdK0LMJpHG5RlWDrmUTkN5FfHCdokmNPsxSF/GEqNrFHzBXQO5N3OsiFbiT+c4a+hVYTnHBA6FW5RUugzx5OUDS9G0IjjR2+Vsk6
 EiGTVyj5HQU+VXRzFZTDRr/czMtJNICpBJRMLLs+iztPWh0PsO7MSf/MtvNsgv2q3Ilq0h1U4fn3PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/06/2019 15:15, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The split commit-graph feature is now fully implemented, but needs
> some more run-time configurability. Allow direct callers to 'git
> commit-graph write --split' to specify the values used in the
> merge strategy and the expire time.
> 
> Update the documentation to specify these values.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt       | 21 +++++++++++++-
>  Documentation/technical/commit-graph.txt |  7 +++--
>  builtin/commit-graph.c                   | 20 +++++++++++---
>  builtin/commit.c                         |  2 +-
>  builtin/gc.c                             |  3 +-
>  commit-graph.c                           | 35 ++++++++++++++++--------
>  commit-graph.h                           | 12 ++++++--
>  t/t5323-split-commit-graph.sh            | 35 ++++++++++++++++++++++++
>  8 files changed, 112 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 624470e198..365e145e82 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -26,7 +26,7 @@ OPTIONS
>  	Use given directory for the location of packfiles and commit-graph
>  	file. This parameter exists to specify the location of an alternate
>  	that only has the objects directory, not a full `.git` directory. The
> -	commit-graph file is expected to be at `<dir>/info/commit-graph` and
> +	commit-graph file is expected to be in the `<dir>/info` directory and
>  	the packfiles are expected to be in `<dir>/pack`.
>  
>  
> @@ -51,6 +51,25 @@ or `--stdin-packs`.)
>  +
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
> ++
> +With the `--split` option, write the commit-graph as a chain of multiple
> +commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> +not already in the commit-graph are added in a new "tip" file. This file
> +is merged with the existing file if the following merge conditions are
> +met:
> ++
> +* If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
> +tip file would have `N` commits and the previous tip has `M` commits and
> +`X` times `N` is greater than  `M`, instead merge the two files into a
> +single file.
> ++
> +* If `--max-commits=<M>` is specified with `M` a positive integer, and the
> +new tip file would have more than `M` commits, then instead merge the new
> +tip with the previous tip.
> ++
> +Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
> +be the current time. After writing the split commit-graph, delete all
> +unused commit-graph whose modified times are older than `datetime`.
>  
>  'read'::
>  
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index aed4350a59..729fbcb32f 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -248,10 +248,11 @@ When writing a set of commits that do not exist in the commit-graph stack of
>  height N, we default to creating a new file at level N + 1. We then decide to
>  merge with the Nth level if one of two conditions hold:
>  
> -  1. The expected file size for level N + 1 is at least half the file size for
> -     level N.
> +  1. `--size-multiple=<X>` is specified or X = 2, and the number of commits in
> +     level N is less than X times the number of commits in level N + 1.
>  
> -  2. Level N + 1 contains more than 64,0000 commits.
> +  2. `--max-commits=<C>` is specified with non-zero C and the number of commits
> +     in level N + 1 is more than C commits.
>  
>  This decision cascades down the levels: when we merge a level we create a new
>  set of commits that then compares to the next level.
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index c2c07d3917..18e3b61fb6 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph [--object-dir <objdir>]"),
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	N_("git commit-graph verify [--object-dir <objdir>]"),
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
>  	NULL
>  };
>  
> @@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
>  };
>  
>  static const char * const builtin_commit_graph_write_usage[] = {
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
>  	NULL
>  };
>  
> @@ -135,6 +135,7 @@ static int graph_read(int argc, const char **argv)
>  }
>  
>  extern int read_replace_refs;
> +struct split_commit_graph_opts split_opts;

This 'split_opts' variable needs to be marked 'static'.

Thanks.

ATB,
Ramsay Jones

