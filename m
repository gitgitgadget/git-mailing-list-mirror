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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5885FC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B11A20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsVWH1Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgAaOk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:40:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39366 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 09:40:26 -0500
Received: by mail-qt1-f195.google.com with SMTP id c5so5538475qtj.6
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v+FStrX43uaQOWqwEdqVyv9Wh/tQ/kV0jRHRmjh9rdM=;
        b=FsVWH1FjZCyDjfXTjA8b+leXF4wZSI8Hq0pfGY42zRw6YEWvpXnJALEUTVNEPKLRBk
         uQWPqRlbMGqsNU1d8WmGGZqNJAZKc64pGjt0ht8Dp3tbXJDYmnKJ7wWZMQbzgxdMNzpo
         gzBizuKKeIUoz3hMx459Mn31hqp4IT3kt+qGStAVcKiLEh83ABG6TEK6gt7h4d79GS17
         5Jwwvs7dcH9GoRdBb1sZD+nQ9ijgDjwYth9tNvxK5t7Qmi4ivYh79FZ1Xqp00Ofw81Xb
         YVnNmU2AOU5+j/fsQ+rbUYDGNwYW7/s6UobgVl2AogiJ7Cotx85cyTdWLV2IBtffJ+BL
         +XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+FStrX43uaQOWqwEdqVyv9Wh/tQ/kV0jRHRmjh9rdM=;
        b=mzij15tFRkFrgtO3zzPQ3ly9OtWPkAzJ8DbWGTy2K6KD9SqUkcBxh+mhFhCdytqzjv
         K7teMl7hjI9u+XX6qNZwHFtRcJHrdrS7w9f4vJ5fG3ot+lupGmeHrqalTwy4lwO+zjX1
         BOWIr4o6JiFxfpg2PfL4cm5dXtS0H6/mD/UTmGmk/QFNJ5PWritHdQq1cUsbSoBk4SBF
         Vf/neBna1P7YAmd9UDRAQyE701HquvXfK+U0u9LptWiYydPW/G0CgyESn/DzT9qj3YI1
         9Hd398507enfAOhLURqKO8tvkGNJMIL8JnB03iXJUcBa9pxqQwzarAiopcm17QWmrveu
         Pydw==
X-Gm-Message-State: APjAAAUrG7viotgPM1/HGutZUV4ERwvgH+XOpzf2YiwIM8el20G0oFUq
        nKA8KXh4DSqTHhAMOgoMrmw=
X-Google-Smtp-Source: APXvYqxUdZYjJ3BsPr9CQNRq2WOfwgkeyQDgprFtf0pyPGMm2gU/fTti8tCjOdhM4kVGBgF8jA1m7A==
X-Received: by 2002:ac8:6f5b:: with SMTP id n27mr10329521qtv.96.1580481623800;
        Fri, 31 Jan 2020 06:40:23 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1010:932a:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id q130sm4455463qka.114.2020.01.31.06.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:40:22 -0800 (PST)
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
References: <cover.1580430057.git.me@ttaylorr.com>
 <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <846706e9-efe2-448d-67a3-a96638e9bcbc@gmail.com>
Date:   Fri, 31 Jan 2020 09:40:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 7:28 PM, Taylor Blau wrote:
> The 'write' mode of the 'commit-graph' supports input from a number of
> different sources: pack indexes over stdin, commits over stdin, commits
> reachable from all references, and so on. Each of these options are
> specified with a unique option: '--stdin-packs', '--stdin-commits', etc.
> 
> Similar to our replacement of 'git config [--<type>]' with 'git config
> [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> deprecate '[--<input>]' in favor of '[--input=<source>]'.
> 
> This makes it more clear to implement new options that are combinations
> of other options (such as, for example, "none", a combination of the old
> "--append" and a new sentinel to specify to _not_ look in other packs,
> which we will implement in a future patch).
> 
> Unfortunately, the new enumerated type is a bitfield, even though it
> makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> compatible with '--append'. For this reason, use a bitfield.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt | 26 +++++-----
>  builtin/commit-graph.c             | 77 ++++++++++++++++++++++--------
>  t/t5318-commit-graph.sh            | 46 +++++++++---------
>  t/t5324-split-commit-graph.sh      | 44 ++++++++---------
>  4 files changed, 114 insertions(+), 79 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 8d61ba9f56..cbf80226e9 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -41,21 +41,21 @@ COMMANDS
>  
>  Write a commit-graph file based on the commits found in packfiles.
>  +
> -With the `--stdin-packs` option, generate the new commit graph by
> +With the `--input=stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> -with `--stdin-commits` or `--reachable`.)
> +with `--input=stdin-commits` or `--input=reachable`.)
>  +
> -With the `--stdin-commits` option, generate the new commit graph by
> -walking commits starting at the commits specified in stdin as a list
> +With the `--input=stdin-commits` option, generate the new commit graph
> +by walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
> -`--stdin-packs` or `--reachable`.)
> +`--input=stdin-packs` or `--input=reachable`.)
>  +
> -With the `--reachable` option, generate the new commit graph by walking
> -commits starting at all refs. (Cannot be combined with `--stdin-commits`
> -or `--stdin-packs`.)
> +With the `--input=reachable` option, generate the new commit graph by
> +walking commits starting at all refs. (Cannot be combined with
> +`--input=stdin-commits` or `--input=stdin-packs`.)
>  +
> -With the `--append` option, include all commits that are present in the
> -existing commit-graph file.
> +With the `--input=append` option, include all commits that are present
> +in the existing commit-graph file.
>  +
>  With the `--split[=<strategy>]` option, write the commit-graph as a
>  chain of multiple commit-graph files stored in
> @@ -107,20 +107,20 @@ $ git commit-graph write
>    using commits in `<pack-index>`.
>  +
>  ------------------------------------------------
> -$ echo <pack-index> | git commit-graph write --stdin-packs
> +$ echo <pack-index> | git commit-graph write --input=stdin-packs
>  ------------------------------------------------
>  
>  * Write a commit-graph file containing all reachable commits.
>  +
>  ------------------------------------------------
> -$ git show-ref -s | git commit-graph write --stdin-commits
> +$ git show-ref -s | git commit-graph write --input=stdin-commits
>  ------------------------------------------------
>  
>  * Write a commit-graph file containing all commits in the current
>    commit-graph file along with those reachable from `HEAD`.
>  +
>  ------------------------------------------------
> -$ git rev-parse HEAD | git commit-graph write --stdin-commits --append
> +$ git rev-parse HEAD | git commit-graph write --input=stdin-commits --input=append
>  ------------------------------------------------
>  
>  
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index f03b46d627..03d815e652 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -10,7 +10,7 @@
>  static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> +	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
>  	   "[--[no-]progress] <split options>"),
>  	NULL
>  };
> @@ -22,22 +22,48 @@ static const char * const builtin_commit_graph_verify_usage[] = {
>  
>  static const char * const builtin_commit_graph_write_usage[] = {
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> +	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
>  	   "[--[no-]progress] <split options>"),
>  	NULL
>  };
>  
> +enum commit_graph_input {
> +	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
> +	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
> +	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
> +	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
> +};
> +
>  static struct opts_commit_graph {
>  	const char *obj_dir;
> -	int reachable;
> -	int stdin_packs;
> -	int stdin_commits;
> -	int append;
> +	enum commit_graph_input input;
>  	int split;
>  	int shallow;
>  	int progress;
>  } opts;
>  
> +static int option_parse_input(const struct option *opt, const char *arg,
> +			      int unset)
> +{
> +	enum commit_graph_input *to = opt->value;
> +	if (unset || !strcmp(arg, "packs")) {
> +		*to = 0;
> +		return 0;
> +	}

Here, you _do_ clear the bitfield, allowing "--input=reachable --input"
to do the correct override. Thanks!

> +
> +	if (!strcmp(arg, "reachable"))
> +		*to |= COMMIT_GRAPH_INPUT_REACHABLE;
> +	else if (!strcmp(arg, "stdin-packs"))
> +		*to |= COMMIT_GRAPH_INPUT_STDIN_PACKS;
> +	else if (!strcmp(arg, "stdin-commits"))
> +		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
> +	else if (!strcmp(arg, "append"))
> +		*to |= COMMIT_GRAPH_INPUT_APPEND;
> +	else
> +		die(_("unrecognized --input source, %s"), arg);
> +	return 0;
> +}
> +
>  static struct object_directory *find_odb_or_die(struct repository *r,
>  						const char *obj_dir)
>  {
> @@ -137,14 +163,21 @@ static int graph_write(int argc, const char **argv)
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
>  			N_("dir"),
>  			N_("The object directory to store the graph")),
> -		OPT_BOOL(0, "reachable", &opts.reachable,
> -			N_("start walk at all refs")),
> -		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
> -			N_("scan pack-indexes listed by stdin for commits")),
> -		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
> -			N_("start walk at commits listed by stdin")),
> -		OPT_BOOL(0, "append", &opts.append,
> -			N_("include all commits already in the commit-graph file")),
> +		OPT_CALLBACK(0, "input", &opts.input, NULL,
> +			N_("include commits from this source in the graph"),
> +			option_parse_input),
> +		OPT_BIT(0, "reachable", &opts.input,
> +			N_("start walk at all refs"),
> +			COMMIT_GRAPH_INPUT_REACHABLE),
> +		OPT_BIT(0, "stdin-packs", &opts.input,
> +			N_("scan pack-indexes listed by stdin for commits"),
> +			COMMIT_GRAPH_INPUT_STDIN_PACKS),
> +		OPT_BIT(0, "stdin-commits", &opts.input,
> +			N_("start walk at commits listed by stdin"),
> +			COMMIT_GRAPH_INPUT_STDIN_COMMITS),
> +		OPT_BIT(0, "append", &opts.input,
> +			N_("include all commits already in the commit-graph file"),
> +			COMMIT_GRAPH_INPUT_APPEND),

Since you are rewriting how we interpret the deprecated options, perhaps we
should keep some tests around that call these versions? It would make the
test diff be a bit smaller. These options can be removed from the tests if/when
we actually remove the options.

> @@ -351,10 +351,10 @@ test_expect_success '--split=merge-all always merges incrementals' '
>  	git rev-list -3 HEAD~4 >a &&
>  	git rev-list -2 HEAD~2 >b &&
>  	git rev-list -2 HEAD >c &&
> -	git commit-graph write --split=no-merge --stdin-commits <a &&
> -	git commit-graph write --split=no-merge --stdin-commits <b &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <a &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <b &&
>  	test_line_count = 2 $graphdir/commit-graph-chain &&
> -	git commit-graph write --split=merge-all --stdin-commits <c &&
> +	git commit-graph write --split=merge-all --input=stdin-commits <c &&
>  	test_line_count = 1 $graphdir/commit-graph-chain
>  '
>  
> @@ -364,8 +364,8 @@ test_expect_success '--split=no-merge always writes an incremental' '
>  	git reset --hard commits/2 &&
>  	git rev-list HEAD~1 >a &&
>  	git rev-list HEAD >b &&
> -	git commit-graph write --split --stdin-commits <a &&
> -	git commit-graph write --split=no-merge --stdin-commits <b &&
> +	git commit-graph write --split --input=stdin-commits <a &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <b &&
>  	test_line_count = 2 $graphdir/commit-graph-chain
>  '

Updating these new tests with the given options is good. Perhaps convert only one
of the old tests for each of the stdin-packs, reachable, "", and "append" options?

Thanks,
-Stolee
