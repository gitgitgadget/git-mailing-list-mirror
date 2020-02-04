Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DCC35253
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A990C2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OvPa1Jgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBDEVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:21:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52200 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDEVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 23:21:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so763230pjb.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 20:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgDmAlwBs50PK2x9SQhX/wgevn8dk5P580Iq8eys9Eg=;
        b=OvPa1JgyrNneJnROscqVcQne7Buo2fFILXTy+jtPcN04A9Hco21wXKzVLemz4O/baV
         Au1Pkk0rqIrDor5fh973nBIervmTu0mhfVgEn/+fifaCBBDwoDZG5D3Mu+KYaTvU7a+D
         qL18i4WyrCDkghmvYGVxHAONqQCju5jvjISyeLw/RaK2LIxfQPXnxYL/rColNpS3hi/B
         rPZ0KhD3U6i6VNOKAfWrnJe1SuphCW4POoTHDEB1eRVeolGOrC8yP4Uyi83nLFNQ8j49
         sKaS3Liu6WpAbA1WNL9tip5ea/G9FmlXxGDPCVFknCmJ3MZryH4obgTbAqOxCrzd0vDJ
         mGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgDmAlwBs50PK2x9SQhX/wgevn8dk5P580Iq8eys9Eg=;
        b=e4y7IensXNAUrcBhd6qOc96W65mMJyt0S8554zJo1XgumeSpGRQjJMSOT+K5I0M4tq
         UUDQ/pL44peIg2XOeNWxRTrhVMW24Ge/67Bo3kSKgcgDm30aFB3wC2ziKT4sXazjxrKP
         /rMireW29SvWa4QrKfPnFxGz5I73/ONTkk8rMYB5v6tl3d0AYAC/9upejSR0KvAwyx0c
         YscnRe1qM+djG9h7Pn+x0YyxL2kME9izMpnTHB30DHu18EJvOY0ZanAIYOV9sQEe69lU
         8p5M4vIooPi5QdcnIJGiud9c7ag/DsTU7LSNF8U0RoIn5MFZIhw8SgJe44uVOPCXHDi7
         RKww==
X-Gm-Message-State: APjAAAWx4VCeqO7Y4KZloz8k5ceDP9w+xqUuxeSP/lJP8565QMNoyj15
        mZXU4mh62rvqf3FNtq/TudGHeeF1U68zuQ==
X-Google-Smtp-Source: APXvYqxyb20+eY+QEFxaLOAp2YKhyHv3vJk//kFyXF3VLeu550e19SrwAO44w/f3mva+cfslWV9s6w==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr28026136plt.64.1580790090742;
        Mon, 03 Feb 2020 20:21:30 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id g9sm22382809pfm.150.2020.02.03.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 20:21:30 -0800 (PST)
Date:   Mon, 3 Feb 2020 20:21:29 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <20200204042129.GF5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
 <846706e9-efe2-448d-67a3-a96638e9bcbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <846706e9-efe2-448d-67a3-a96638e9bcbc@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 09:40:23AM -0500, Derrick Stolee wrote:
> On 1/30/2020 7:28 PM, Taylor Blau wrote:
> > The 'write' mode of the 'commit-graph' supports input from a number of
> > different sources: pack indexes over stdin, commits over stdin, commits
> > reachable from all references, and so on. Each of these options are
> > specified with a unique option: '--stdin-packs', '--stdin-commits', etc.
> >
> > Similar to our replacement of 'git config [--<type>]' with 'git config
> > [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> > `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> > deprecate '[--<input>]' in favor of '[--input=<source>]'.
> >
> > This makes it more clear to implement new options that are combinations
> > of other options (such as, for example, "none", a combination of the old
> > "--append" and a new sentinel to specify to _not_ look in other packs,
> > which we will implement in a future patch).
> >
> > Unfortunately, the new enumerated type is a bitfield, even though it
> > makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> > options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> > compatible with '--append'. For this reason, use a bitfield.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-commit-graph.txt | 26 +++++-----
> >  builtin/commit-graph.c             | 77 ++++++++++++++++++++++--------
> >  t/t5318-commit-graph.sh            | 46 +++++++++---------
> >  t/t5324-split-commit-graph.sh      | 44 ++++++++---------
> >  4 files changed, 114 insertions(+), 79 deletions(-)
> >
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 8d61ba9f56..cbf80226e9 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -41,21 +41,21 @@ COMMANDS
> >
> >  Write a commit-graph file based on the commits found in packfiles.
> >  +
> > -With the `--stdin-packs` option, generate the new commit graph by
> > +With the `--input=stdin-packs` option, generate the new commit graph by
> >  walking objects only in the specified pack-indexes. (Cannot be combined
> > -with `--stdin-commits` or `--reachable`.)
> > +with `--input=stdin-commits` or `--input=reachable`.)
> >  +
> > -With the `--stdin-commits` option, generate the new commit graph by
> > -walking commits starting at the commits specified in stdin as a list
> > +With the `--input=stdin-commits` option, generate the new commit graph
> > +by walking commits starting at the commits specified in stdin as a list
> >  of OIDs in hex, one OID per line. (Cannot be combined with
> > -`--stdin-packs` or `--reachable`.)
> > +`--input=stdin-packs` or `--input=reachable`.)
> >  +
> > -With the `--reachable` option, generate the new commit graph by walking
> > -commits starting at all refs. (Cannot be combined with `--stdin-commits`
> > -or `--stdin-packs`.)
> > +With the `--input=reachable` option, generate the new commit graph by
> > +walking commits starting at all refs. (Cannot be combined with
> > +`--input=stdin-commits` or `--input=stdin-packs`.)
> >  +
> > -With the `--append` option, include all commits that are present in the
> > -existing commit-graph file.
> > +With the `--input=append` option, include all commits that are present
> > +in the existing commit-graph file.
> >  +
> >  With the `--split[=<strategy>]` option, write the commit-graph as a
> >  chain of multiple commit-graph files stored in
> > @@ -107,20 +107,20 @@ $ git commit-graph write
> >    using commits in `<pack-index>`.
> >  +
> >  ------------------------------------------------
> > -$ echo <pack-index> | git commit-graph write --stdin-packs
> > +$ echo <pack-index> | git commit-graph write --input=stdin-packs
> >  ------------------------------------------------
> >
> >  * Write a commit-graph file containing all reachable commits.
> >  +
> >  ------------------------------------------------
> > -$ git show-ref -s | git commit-graph write --stdin-commits
> > +$ git show-ref -s | git commit-graph write --input=stdin-commits
> >  ------------------------------------------------
> >
> >  * Write a commit-graph file containing all commits in the current
> >    commit-graph file along with those reachable from `HEAD`.
> >  +
> >  ------------------------------------------------
> > -$ git rev-parse HEAD | git commit-graph write --stdin-commits --append
> > +$ git rev-parse HEAD | git commit-graph write --input=stdin-commits --input=append
> >  ------------------------------------------------
> >
> >
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index f03b46d627..03d815e652 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -10,7 +10,7 @@
> >  static char const * const builtin_commit_graph_usage[] = {
> >  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> >  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> > -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> > +	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
> >  	   "[--[no-]progress] <split options>"),
> >  	NULL
> >  };
> > @@ -22,22 +22,48 @@ static const char * const builtin_commit_graph_verify_usage[] = {
> >
> >  static const char * const builtin_commit_graph_write_usage[] = {
> >  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> > -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> > +	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
> >  	   "[--[no-]progress] <split options>"),
> >  	NULL
> >  };
> >
> > +enum commit_graph_input {
> > +	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
> > +	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
> > +	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
> > +	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
> > +};
> > +
> >  static struct opts_commit_graph {
> >  	const char *obj_dir;
> > -	int reachable;
> > -	int stdin_packs;
> > -	int stdin_commits;
> > -	int append;
> > +	enum commit_graph_input input;
> >  	int split;
> >  	int shallow;
> >  	int progress;
> >  } opts;
> >
> > +static int option_parse_input(const struct option *opt, const char *arg,
> > +			      int unset)
> > +{
> > +	enum commit_graph_input *to = opt->value;
> > +	if (unset || !strcmp(arg, "packs")) {
> > +		*to = 0;
> > +		return 0;
> > +	}
>
> Here, you _do_ clear the bitfield, allowing "--input=reachable --input"
> to do the correct override. Thanks!
>
> > +
> > +	if (!strcmp(arg, "reachable"))
> > +		*to |= COMMIT_GRAPH_INPUT_REACHABLE;
> > +	else if (!strcmp(arg, "stdin-packs"))
> > +		*to |= COMMIT_GRAPH_INPUT_STDIN_PACKS;
> > +	else if (!strcmp(arg, "stdin-commits"))
> > +		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
> > +	else if (!strcmp(arg, "append"))
> > +		*to |= COMMIT_GRAPH_INPUT_APPEND;
> > +	else
> > +		die(_("unrecognized --input source, %s"), arg);
> > +	return 0;
> > +}
> > +
> >  static struct object_directory *find_odb_or_die(struct repository *r,
> >  						const char *obj_dir)
> >  {
> > @@ -137,14 +163,21 @@ static int graph_write(int argc, const char **argv)
> >  		OPT_STRING(0, "object-dir", &opts.obj_dir,
> >  			N_("dir"),
> >  			N_("The object directory to store the graph")),
> > -		OPT_BOOL(0, "reachable", &opts.reachable,
> > -			N_("start walk at all refs")),
> > -		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
> > -			N_("scan pack-indexes listed by stdin for commits")),
> > -		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
> > -			N_("start walk at commits listed by stdin")),
> > -		OPT_BOOL(0, "append", &opts.append,
> > -			N_("include all commits already in the commit-graph file")),
> > +		OPT_CALLBACK(0, "input", &opts.input, NULL,
> > +			N_("include commits from this source in the graph"),
> > +			option_parse_input),
> > +		OPT_BIT(0, "reachable", &opts.input,
> > +			N_("start walk at all refs"),
> > +			COMMIT_GRAPH_INPUT_REACHABLE),
> > +		OPT_BIT(0, "stdin-packs", &opts.input,
> > +			N_("scan pack-indexes listed by stdin for commits"),
> > +			COMMIT_GRAPH_INPUT_STDIN_PACKS),
> > +		OPT_BIT(0, "stdin-commits", &opts.input,
> > +			N_("start walk at commits listed by stdin"),
> > +			COMMIT_GRAPH_INPUT_STDIN_COMMITS),
> > +		OPT_BIT(0, "append", &opts.input,
> > +			N_("include all commits already in the commit-graph file"),
> > +			COMMIT_GRAPH_INPUT_APPEND),
>
> Since you are rewriting how we interpret the deprecated options, perhaps we
> should keep some tests around that call these versions? It would make the
> test diff be a bit smaller. These options can be removed from the tests if/when
> we actually remove the options.

That sounds good. I thought about doing this in the original round, but
I talked myself out of it because it wasn't clear to me which tests were
the ones worth converting and which should be left alone.

But, since you think it's good, so do I. I picked the ones to convert
mostly at random, and left the new ones as-is using the '--input=' form.

> > @@ -351,10 +351,10 @@ test_expect_success '--split=merge-all always merges incrementals' '
> >  	git rev-list -3 HEAD~4 >a &&
> >  	git rev-list -2 HEAD~2 >b &&
> >  	git rev-list -2 HEAD >c &&
> > -	git commit-graph write --split=no-merge --stdin-commits <a &&
> > -	git commit-graph write --split=no-merge --stdin-commits <b &&
> > +	git commit-graph write --split=no-merge --input=stdin-commits <a &&
> > +	git commit-graph write --split=no-merge --input=stdin-commits <b &&
> >  	test_line_count = 2 $graphdir/commit-graph-chain &&
> > -	git commit-graph write --split=merge-all --stdin-commits <c &&
> > +	git commit-graph write --split=merge-all --input=stdin-commits <c &&
> >  	test_line_count = 1 $graphdir/commit-graph-chain
> >  '
> >
> > @@ -364,8 +364,8 @@ test_expect_success '--split=no-merge always writes an incremental' '
> >  	git reset --hard commits/2 &&
> >  	git rev-list HEAD~1 >a &&
> >  	git rev-list HEAD >b &&
> > -	git commit-graph write --split --stdin-commits <a &&
> > -	git commit-graph write --split=no-merge --stdin-commits <b &&
> > +	git commit-graph write --split --input=stdin-commits <a &&
> > +	git commit-graph write --split=no-merge --input=stdin-commits <b &&
> >  	test_line_count = 2 $graphdir/commit-graph-chain
> >  '
>
> Updating these new tests with the given options is good. Perhaps convert only one
> of the old tests for each of the stdin-packs, reachable, "", and "append" options?

Yup, thanks.

> Thanks,
> -Stolee

Thanks,
Taylor
