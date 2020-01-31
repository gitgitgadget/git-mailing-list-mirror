Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D0C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B8020707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAWayAhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgAaOTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:19:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44285 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgAaOTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 09:19:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so6591771qkb.11
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9dj2lKYauWIrCAasGsIQ5hPcQuYl6nIvsyGFMAYnDjY=;
        b=rAWayAhQntdhhdNkDdL6+mPNKOnPa0L8WENM7DRuJnuxeKIeNEpeWD+7GIXI6WeqPr
         4Ba06LHnsyZGbg3OuJ3AzC40tzvMllkc1BCvtaVzfS+gf2aidHBnJhVIcVByQVVPpssE
         eJQSCPLOJpXc12AMASR/zCNlwIHLrgpRVSVNXfsaM8YvsCm2VYqQWQH+ssfPXCmBxvqQ
         MzuMYMf40BA7LT4/uzXUctI3HjUDQU5hallx5aT/gk7ufS+g56mB1byhNv7iF8f/X/BT
         E1zSw+hxWtUwgxURsMZN8+9RmTXN0gGWBg61feEefvZGhGUQWDNqvDA3c2AicA/ZO/si
         uNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dj2lKYauWIrCAasGsIQ5hPcQuYl6nIvsyGFMAYnDjY=;
        b=IiM7swltmnsyfQlSfG8dxLfmkTZuuWI82Q3Bk9oW+TvFOzqcE24TuRVd71dZsd3El3
         GHJPzQKIdOK/svDeln1n5h/Kta9PDayG/YFd3IM8yWiO0qF1l9MhZaPywwIEdq2roOAH
         Oiu39bPpcH+7pdyKzW2mzKyAaSTnbZ2QHscG757yUkDeXmVb9hiCtzw4ENIaQgKZF4Lg
         +evpTECRPuMJDAmemeyH9hixs0jXaVK/5iK7a3z86KQ1VRdkZr5ueKZFUxxxL/nk7Djy
         8C6iavYdyO+/5pr1qCjJRMdQYHffaqvl8Zd3AOYWpxm7KYGAfUFWSFL6Don7sO4JuyEN
         dwsw==
X-Gm-Message-State: APjAAAVy3VllmCCS+GtGW1EDo3IM1efCjOjt6v3irMnxqiE9lTGKOC8i
        oRY0n9NAlBfCx0UsTV0RTkE=
X-Google-Smtp-Source: APXvYqxtip3bBwRQwecMsIuT2kgB3niAcoPswdyIYZyOOjz1rucmybXAfC9hjvBOSkeeoaO6s+adqQ==
X-Received: by 2002:a37:9ace:: with SMTP id c197mr10960852qke.482.1580480359875;
        Fri, 31 Jan 2020 06:19:19 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1010:932a:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id k50sm5042718qtc.90.2020.01.31.06.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:19:19 -0800 (PST)
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a648a69-60bd-2b19-facb-1d7821661883@gmail.com>
Date:   Fri, 31 Jan 2020 09:19:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 7:28 PM, Taylor Blau wrote:
> With '--split', the commit-graph machinery writes new commits in another
> incremental commit-graph which is part of the existing chain, and
> optionally decides to condense the chain into a single commit-graph.
> This is done to ensure that the aysmptotic behavior of looking up a
> commit in an incremental chain is dominated by the number of
> incrementals in that chain. It can be controlled by the '--max-commits'
> and '--size-multiple' options.
> 
> On occasion, callers may want to ensure that 'git commit-graph write
> --split' always writes an incremental, and never spends effort
> condensing the incremental chain [1]. Previously, this was possible by
> passing '--size-multiple=0', but this no longer the case following
> 63020f175f (commit-graph: prefer default size_mult when given zero,
> 2020-01-02).
> 
> Reintroduce a less-magical variant of the above with a new pair of
> arguments to '--split': '--split=no-merge' and '--split=merge-all'. When
> '--split=no-merge' is given, the commit-graph machinery will never
> condense an existing chain and will always write a new incremental.
> Conversely, if '--split=merge-all' is given, any invocation including it
> will always condense a chain if one exists.  If '--split' is given with
> no arguments, it behaves as before and defers to '--size-multiple', and
> so on.
> 
> [1]: This might occur when, for example, a server administrator running
> some program after each push may want to ensure that each job runs
> proportional in time to the size of the push, and does not "jump" when
> the commit-graph machinery decides to trigger a merge.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt | 18 +++++++++++-----
>  builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++----
>  commit-graph.c                     | 19 +++++++++--------
>  commit-graph.h                     |  7 +++++++
>  t/t5324-split-commit-graph.sh      | 25 ++++++++++++++++++++++
>  5 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 28d1fee505..8d61ba9f56 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -57,11 +57,19 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> -With the `--split` option, write the commit-graph as a chain of multiple
> -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> -not already in the commit-graph are added in a new "tip" file. This file
> -is merged with the existing file if the following merge conditions are
> -met:
> +With the `--split[=<strategy>]` option, write the commit-graph as a
> +chain of multiple commit-graph files stored in
> +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> +strategy and other splitting options. The new commits not already in the
> +commit-graph are added in a new "tip" file. This file is merged with the
> +existing file if the following merge conditions are met:
> +* If `--split=merge-always` is specified, then a merge is always
> +conducted, and the remaining options are ignored. Conversely, if
> +`--split=no-merge` is specified, a merge is never performed, and the
> +remaining options are ignored. A bare `--split` defers to the remaining
> +options. (Note that merging a chain of commit graphs replaces the
> +existing chain with a length-1 chain where the first and only
> +incremental holds the entire graph).
>  +
>  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
>  tip file would have `N` commits and the previous tip has `M` commits and
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index de321c71ad..f03b46d627 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -9,7 +9,9 @@
>  
>  static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> +	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> +	   "[--[no-]progress] <split options>"),
>  	NULL
>  };
>  
> @@ -19,7 +21,9 @@ static const char * const builtin_commit_graph_verify_usage[] = {
>  };
>  
>  static const char * const builtin_commit_graph_write_usage[] = {
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> +	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> +	   "[--[no-]progress] <split options>"),
>  	NULL
>  };
>  
> @@ -101,6 +105,25 @@ static int graph_verify(int argc, const char **argv)
>  extern int read_replace_refs;
>  static struct split_commit_graph_opts split_opts;
>  
> +static int write_option_parse_split(const struct option *opt, const char *arg,
> +				    int unset)
> +{
> +	enum commit_graph_split_flags *flags = opt->value;
> +
> +	opts.split = 1;
> +	if (!arg)
> +		return 0;

This allows `--split` to continue working as-is. But should we also
set "*flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED" here? This allows one
to run "git commit-graph write --split=no-merge --split" (which could
happen if "--split=no-merge" is inside an alias).

> +test_expect_success '--split=merge-all always merges incrementals' '
> +	test_when_finished rm -rf a b c &&
> +	rm -rf $graphdir $infodir/commit-graph &&
> +	git reset --hard commits/10 &&
> +	git rev-list -3 HEAD~4 >a &&
> +	git rev-list -2 HEAD~2 >b &&
> +	git rev-list -2 HEAD >c &&
> +	git commit-graph write --split=no-merge --stdin-commits <a &&
> +	git commit-graph write --split=no-merge --stdin-commits <b &&
> +	test_line_count = 2 $graphdir/commit-graph-chain &&
> +	git commit-graph write --split=merge-all --stdin-commits <c &&
> +	test_line_count = 1 $graphdir/commit-graph-chain
> +'
> +
> +test_expect_success '--split=no-merge always writes an incremental' '
> +	test_when_finished rm -rf a b &&
> +	rm -rf $graphdir &&
> +	git reset --hard commits/2 &&
> +	git rev-list HEAD~1 >a &&
> +	git rev-list HEAD >b &&
> +	git commit-graph write --split --stdin-commits <a &&
> +	git commit-graph write --split=no-merge --stdin-commits <b &&
> +	test_line_count = 2 $graphdir/commit-graph-chain
> +'
> +
>  test_done

Good tests!

Thanks,
-Stolee

