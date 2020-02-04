Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF73C3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417E2080D
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bFGswGRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgBDDrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:47:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46626 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgBDDrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 22:47:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so8938770pgb.13
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 19:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZjRllp3RY7Y2/qMJZ9sYpDfyxd5NPOGJ69H86pze4U=;
        b=bFGswGRdAOJgnPBzu7pQASOWakZBeZpLk7nOe5J8y5klBs+2J96dnaGx1203LX8hQ9
         SbLsM/+pP8ZAQlQT3mrqbdFGtRKRqFFbZ+Ieytuw6WTnb6ef+JxVmYOj3BifNi3UWkv/
         l/bidxN+PLt3CGrcEw384yYvRA9H34UzyPmf919WQ3XFB3eVet5oKkwjMP43ch1e0g33
         vGsX4gP4G2j9foJjyyno+FNKqom00u5mb3Brr6MM1Og9kzyfGW5FIJoqv7R7R+UlrOhz
         toliEVxcNrMTy3EAEUKgNz7Ty7kjk2g/ic+zyBOXmq5dgvqNt3PZWmJUhqKxP75mPeHP
         ZN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZjRllp3RY7Y2/qMJZ9sYpDfyxd5NPOGJ69H86pze4U=;
        b=qMRD8P7nvWwBy+j9XoHaD1WGQl0hqq9Na2ifdpbkvh/xtzpTkoENqhKJh5L+RQvGVN
         oEQjKkBNBstqx6fZMokdSHyVXUlEVefexXRtEYHZR0P1CdVwtClDah+kpkyEXc+rnY0M
         un/NyofDuGc7Hjw8Dhf73IIoOfLwyTwkE1WjNWsH7fmPce8ijF4vsBiciZYfJXsVpsT+
         qnITuNPX5sxOu51nPv967f7ULz717/VQVOI+TmWdE3kRDBFuK6RM5zL/oZsqsFjlDy/K
         hTEMTbAKwIuAcwWDkhn2aYmpESG74IDaIniTmA3Ije3FJ6sMtBK0SFo3gJqoBz1MV3cx
         bgLQ==
X-Gm-Message-State: APjAAAVsD4y3q7jqcgZGMLHhIpujJJudsPemsZs+nEO5U97HCk+wJMk1
        gQmTrr3BLMjqGdOTtKK1EAMCr3FFHXjLLQ==
X-Google-Smtp-Source: APXvYqzlz5EY2Vqbylv0MOFQRi6NDZlFWB9iFqeQAl2JC0DXhJRfUO2jTmqkcXn9eYWALjNuPCEQkg==
X-Received: by 2002:a63:1b0a:: with SMTP id b10mr28317929pgb.56.1580788035823;
        Mon, 03 Feb 2020 19:47:15 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id u7sm21584583pfh.128.2020.02.03.19.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 19:47:14 -0800 (PST)
Date:   Mon, 3 Feb 2020 19:47:14 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200204034714.GA5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <8a648a69-60bd-2b19-facb-1d7821661883@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a648a69-60bd-2b19-facb-1d7821661883@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 09:19:19AM -0500, Derrick Stolee wrote:
> On 1/30/2020 7:28 PM, Taylor Blau wrote:
> > With '--split', the commit-graph machinery writes new commits in another
> > incremental commit-graph which is part of the existing chain, and
> > optionally decides to condense the chain into a single commit-graph.
> > This is done to ensure that the aysmptotic behavior of looking up a
> > commit in an incremental chain is dominated by the number of
> > incrementals in that chain. It can be controlled by the '--max-commits'
> > and '--size-multiple' options.
> >
> > On occasion, callers may want to ensure that 'git commit-graph write
> > --split' always writes an incremental, and never spends effort
> > condensing the incremental chain [1]. Previously, this was possible by
> > passing '--size-multiple=0', but this no longer the case following
> > 63020f175f (commit-graph: prefer default size_mult when given zero,
> > 2020-01-02).
> >
> > Reintroduce a less-magical variant of the above with a new pair of
> > arguments to '--split': '--split=no-merge' and '--split=merge-all'. When
> > '--split=no-merge' is given, the commit-graph machinery will never
> > condense an existing chain and will always write a new incremental.
> > Conversely, if '--split=merge-all' is given, any invocation including it
> > will always condense a chain if one exists.  If '--split' is given with
> > no arguments, it behaves as before and defers to '--size-multiple', and
> > so on.
> >
> > [1]: This might occur when, for example, a server administrator running
> > some program after each push may want to ensure that each job runs
> > proportional in time to the size of the push, and does not "jump" when
> > the commit-graph machinery decides to trigger a merge.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-commit-graph.txt | 18 +++++++++++-----
> >  builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++----
> >  commit-graph.c                     | 19 +++++++++--------
> >  commit-graph.h                     |  7 +++++++
> >  t/t5324-split-commit-graph.sh      | 25 ++++++++++++++++++++++
> >  5 files changed, 85 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 28d1fee505..8d61ba9f56 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -57,11 +57,19 @@ or `--stdin-packs`.)
> >  With the `--append` option, include all commits that are present in the
> >  existing commit-graph file.
> >  +
> > -With the `--split` option, write the commit-graph as a chain of multiple
> > -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> > -not already in the commit-graph are added in a new "tip" file. This file
> > -is merged with the existing file if the following merge conditions are
> > -met:
> > +With the `--split[=<strategy>]` option, write the commit-graph as a
> > +chain of multiple commit-graph files stored in
> > +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> > +strategy and other splitting options. The new commits not already in the
> > +commit-graph are added in a new "tip" file. This file is merged with the
> > +existing file if the following merge conditions are met:
> > +* If `--split=merge-always` is specified, then a merge is always
> > +conducted, and the remaining options are ignored. Conversely, if
> > +`--split=no-merge` is specified, a merge is never performed, and the
> > +remaining options are ignored. A bare `--split` defers to the remaining
> > +options. (Note that merging a chain of commit graphs replaces the
> > +existing chain with a length-1 chain where the first and only
> > +incremental holds the entire graph).
> >  +
> >  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
> >  tip file would have `N` commits and the previous tip has `M` commits and
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index de321c71ad..f03b46d627 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -9,7 +9,9 @@
> >
> >  static char const * const builtin_commit_graph_usage[] = {
> >  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> > -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> > +	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> > +	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> > +	   "[--[no-]progress] <split options>"),
> >  	NULL
> >  };
> >
> > @@ -19,7 +21,9 @@ static const char * const builtin_commit_graph_verify_usage[] = {
> >  };
> >
> >  static const char * const builtin_commit_graph_write_usage[] = {
> > -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> > +	N_("git commit-graph write [--object-dir <objdir>] [--append] "
> > +	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> > +	   "[--[no-]progress] <split options>"),
> >  	NULL
> >  };
> >
> > @@ -101,6 +105,25 @@ static int graph_verify(int argc, const char **argv)
> >  extern int read_replace_refs;
> >  static struct split_commit_graph_opts split_opts;
> >
> > +static int write_option_parse_split(const struct option *opt, const char *arg,
> > +				    int unset)
> > +{
> > +	enum commit_graph_split_flags *flags = opt->value;
> > +
> > +	opts.split = 1;
> > +	if (!arg)
> > +		return 0;
>
> This allows `--split` to continue working as-is. But should we also
> set "*flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED" here? This allows one
> to run "git commit-graph write --split=no-merge --split" (which could
> happen if "--split=no-merge" is inside an alias).

Yeah, this is an oversight on my part. I think that we should set the
split option to 'COMMIT_GRAPH_SPLIT_UNSPECIFIED' when '--split' is
given, for exactly the reason you outlined above. Thanks for the
suggestion!

> > +test_expect_success '--split=merge-all always merges incrementals' '
> > +	test_when_finished rm -rf a b c &&
> > +	rm -rf $graphdir $infodir/commit-graph &&
> > +	git reset --hard commits/10 &&
> > +	git rev-list -3 HEAD~4 >a &&
> > +	git rev-list -2 HEAD~2 >b &&
> > +	git rev-list -2 HEAD >c &&
> > +	git commit-graph write --split=no-merge --stdin-commits <a &&
> > +	git commit-graph write --split=no-merge --stdin-commits <b &&
> > +	test_line_count = 2 $graphdir/commit-graph-chain &&
> > +	git commit-graph write --split=merge-all --stdin-commits <c &&
> > +	test_line_count = 1 $graphdir/commit-graph-chain
> > +'
> > +
> > +test_expect_success '--split=no-merge always writes an incremental' '
> > +	test_when_finished rm -rf a b &&
> > +	rm -rf $graphdir &&
> > +	git reset --hard commits/2 &&
> > +	git rev-list HEAD~1 >a &&
> > +	git rev-list HEAD >b &&
> > +	git commit-graph write --split --stdin-commits <a &&
> > +	git commit-graph write --split=no-merge --stdin-commits <b &&
> > +	test_line_count = 2 $graphdir/commit-graph-chain
> > +'
> > +
> >  test_done
>
> Good tests!

Thanks :-).

> Thanks,
> -Stolee

Thanks,
Taylor
