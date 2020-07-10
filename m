Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D52C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD412073A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="f+djmv45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJCRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGJCRn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:17:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAACCC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:17:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so3900948qke.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmvUhltEf1s9SxMs8tqCBfnwQHeHN9bvu1U9BP9Lglw=;
        b=f+djmv45TmVTqW7EFqkqzcncPfU4WjCnxbRwE56aBOzE1r4HFSOpJ3RZ9QoK6tZciI
         1JxKtbUF5LP4f3f6fud66LvnZ3BDQyqu+MM/+RbGUgBu5S/VNRntCHeWbPJ5nJ4Ff2Qt
         0FEyGWUKviRwLuFlI0FJlWLdf46jyaTT5LhmL/HSdc1rc+mRQdNUSQsHGNj5jGbzHTN/
         IGYCmBCC5Tw55pnmFwynU/YIDhRuxOFRlY3roKRsCDByrDtgnNanrJmpULJkvOFkXBxj
         R0Sfz5LH2v7e0tTaxxnAgkRv8pZNd8p95/t/wlevE+cZCJoVphfNUGSSF4X9JAzqjwA6
         p+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pmvUhltEf1s9SxMs8tqCBfnwQHeHN9bvu1U9BP9Lglw=;
        b=DefvxR9BPJ4lVZYJr8haZUfIhLTOw3IA9MToVf/6JRlk/YL5hgUTAfWzP1WmGbfYyV
         7lRF2yKMKoz8NISXCmi1o6NmpPQQso7YWDxvq+Jd/5d3Q4MRLCmmBN9LGaynGACbSaya
         DRZsedbng5nyGL2oJj1tlb1GoyPcS7HMAYVhbXOM0owR7/k5rngmxWUaAYVKT0QEjjkj
         GvWoemopbaBdhCQMv1L8PeXbnUn2nYGi/0ECpb6ITQfOO7+VELQnQX065ZKuCmsWrsLs
         EVHtn2ZXdJ3zjZ6ogKlC5ogdUnPg1BCdO4t32xikYxUvNBds7OSAh6KKsZeUVjMshA6G
         YlSA==
X-Gm-Message-State: AOAM532DzatQ+yhcXU2fIYlJqLm5VxSZhhHMsTrlPrdYeHGzvhhEVlR6
        O/2VEwyfIKA7dnKC1N7w0zA4cg==
X-Google-Smtp-Source: ABdhPJya9vThgRRKiOQQVuQ8ozvCWtXjp26U/p98hi6w6cSkiAY03dPgegpGBk9E7dcBBhbE8JCGyg==
X-Received: by 2002:a05:620a:1519:: with SMTP id i25mr58500533qkk.91.1594347461740;
        Thu, 09 Jul 2020 19:17:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4c16:d6c9:a96a:4df9])
        by smtp.gmail.com with ESMTPSA id s8sm5979111qtc.17.2020.07.09.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 19:17:41 -0700 (PDT)
Date:   Thu, 9 Jul 2020 22:17:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200710021740.GA39052@syl.lan>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
 <ed6b2339-83cd-a7b9-c653-bc86d8686680@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed6b2339-83cd-a7b9-c653-bc86d8686680@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi both,

On Thu, Jul 09, 2020 at 10:00:23PM -0400, Derrick Stolee wrote:
> On 7/9/2020 9:42 PM, Emily Shaffer wrote:
> > Before now, the progress API is used by conditionally calling
> > start_progress() or a similar call, and then unconditionally calling
> > display_progress() and stop_progress(), both of which are tolerant of
> > NULL or uninitialized inputs. However, in
> > 98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
> > throughput), the progress library learned to log traces during expensive
> > operations. In cases where progress should not be displayed to the user
> > - such as when Git is called by a script - no traces will be logged,
> > because the progress object is never created.

This is such a fantastic idea. Just the other day, I was thinking of
getting your (for clarification, Emily, since I'm responding to
Stolee's mail) progress-emits-trace2-events work hooked into GitHub's
trace2 pipeline.

There were two unfortunate things that prevented this from working:

  1. GitHub filters which trace2 categories are of interest to us (these
     interesting ones get logged, and the uninteresting ones get
     discarded) using an environment variable of comma-separated
     categories. Since all of the trace2 metrics generated by the
     progress API don't have categories, taking in one interesting
     metric meant taking them all in, which is a non-starter for us.

  2. On top of that, we don't even _generate_ these progress events most
     of the time, since we're often running without a tty, and so we
     never end up hitting those 'if (progress) start_progress()'
     conditionals in the first place.

If we had something like this, it would reduce the problem to only (1),
which would make a lot of my headaches go away. (It would also give me a
good excuse to convert many of our custom trace2 regions into patches on
the list, and get rid of a non-trivial amount of code that generates
merge conflicts often).

> > Instead, to allow us to collect traces from scripted Git commands, teach
> > a progress->verbose flag, which is specified via a new argument to
> > start_progress() and friends. display_progress() also learns to filter
> > for that flag. With these changes, start_progress() can be called
> > unconditionally but with a conditional as an argument to determine
> > whether to report progress to the user.
> >
> > Since this changes the API, also modify callers of start_progress() and
> > friends to drop their conditional and pass a new argument in instead.

I don't think that this is why I was CC'd, but could you perhaps talk a
little bit about why this is all in the same patch? I don't think this
change needs to be broken out by the area affected per-se, but the
current form is a little unruly to review all at once.

> This is a worthwhile change. Thanks! I was hoping that we would
> get some of these regions for free, which extends what we can get
> out of trace2 events.
>
> CC'ing Taylor because he had some thoughts on adding a possible
> trace2 category to make it easier to reason about the regions,
> when appropriate. Not sure if he's ready to apply that change
> on top of this series.

This is what I was talking about above. It would be nice if we could
somehow teach the 'start_*_progress()' API about a trace2 category.

Unfortunately, this would need to be a new parameter, since we need to
know the category when we enter the region. So, the API changes might be
far-reaching. It would be nice if there was a way to limit the blast
radius (i.e., 'start_progress_trace2(..., category)'), but I haven't
thought deeply about it.

I don't want to delay this patch series with that. I'd be happy to build
it in myself on top after this graduates.

> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index f520111eda..f64cad8390 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -620,8 +620,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> >  	if (bisect_list)
> >  		revs.limited = 1;
> >
> > -	if (show_progress)
> > -		progress = start_delayed_progress(show_progress, 0);
> > +	/*
> > +	 * When progress is not printed to the user, we still want to be able to
> > +	 * classify the progress during tracing. So, use a placeholder name.
> > +	 */
> > +	progress = start_delayed_progress(
> > +			show_progress ? show_progress : _("Quiet rev-list operation"),
> > +			0, show_progress != NULL)
>
> This is so strange, how we let the command-lines specify a progress
> indicator. I guess it is necessary when we use rev-list as a
> subcommand instead of in-process. One such case is check_connected()
> in connected.c.
>
> It's stranger still that "show_progress" is actually a string here,
> as opposed to being an int in most other places.
>
> Your transformation is correct, here, though. Thanks for calling it
> out in the commit message.
>
> >
> >  	if (use_bitmap_index) {
> >  		if (!try_bitmap_count(&revs, &filter_options))
> > diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> > index dd4a75e030..719d446916 100644
> > --- a/builtin/unpack-objects.c
> > +++ b/builtin/unpack-objects.c
> > @@ -498,8 +498,7 @@ static void unpack_all(void)
> >  			ntohl(hdr->hdr_version));
> >  	use(sizeof(struct pack_header));
> >
> > -	if (!quiet)
> > -		progress = start_progress(_("Unpacking objects"), nr_objects);
> > +	progress = start_progress(_("Unpacking objects"), nr_objects, !quiet);
> >  	obj_list = xcalloc(nr_objects, sizeof(*obj_list));
> >  	for (i = 0; i < nr_objects; i++) {
> >  		unpack_one(i);
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 328ab06fd4..b9a784fece 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1152,10 +1152,10 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
> >  	struct progress *progress = NULL;
> >  	int i = 0;
> >
> > -	if (ctx->report_progress)
> > -		progress = start_delayed_progress(
> > -			_("Writing changed paths Bloom filters index"),
> > -			ctx->commits.nr);
> > +	progress = start_delayed_progress(
> > +		_("Writing changed paths Bloom filters index"),
> > +		ctx->commits.nr,
> > +		ctx->report_progress);
>
> There are a lot of blocks like this, where the progress string is long enough to
> require the first param to be after the method name. Since we are changing the
> API and every caller, would the resulting code be cleaner if the string value
> was the last parameter? That would allow this code pattern in most cases:
>
> 	progress = start_delayed_progress(count, show_progress,
> 					  _("My special string!"));
>
> Just a thought. Not super-important.
>
> The rest of the changes look to be correct.
>
> > diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> > index 5d05cbe789..19b874f9cd 100644
> > --- a/t/helper/test-progress.c
> > +++ b/t/helper/test-progress.c
> > @@ -23,16 +23,18 @@
> >  int cmd__progress(int argc, const char **argv)
> >  {
> >  	int total = 0;
> > +	int quiet = 0;
> >  	const char *title;
> >  	struct strbuf line = STRBUF_INIT;
> >  	struct progress *progress;
> >
> >  	const char *usage[] = {
> > -		"test-tool progress [--total=<n>] <progress-title>",
> > +		"test-tool progress [--total=<n>] [--quiet] <progress-title>",
> >  		NULL
> >  	};
> >  	struct option options[] = {
> >  		OPT_INTEGER(0, "total", &total, "total number of items"),
> > +		OPT_BOOL(0, "quiet", &quiet, "suppress stderr"),
> >  		OPT_END(),
> >  	};
> >
> > @@ -42,7 +44,7 @@ int cmd__progress(int argc, const char **argv)
> >  	title = argv[0];
> >
> >  	progress_testing = 1;
> > -	progress = start_progress(title, total);
> > +	progress = start_progress(title, total, !quiet);
> >  	while (strbuf_getline(&line, stdin) != EOF) {
> >  		char *end;
> >
> > diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> > index 1ed1df351c..9d6e6274ad 100755
> > --- a/t/t0500-progress-display.sh
> > +++ b/t/t0500-progress-display.sh
> > @@ -309,4 +309,31 @@ test_expect_success 'progress generates traces' '
> >  	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
> >  '
> >
> > +test_expect_success 'progress generates traces even quietly' '
> > +	cat >in <<-\EOF &&
> > +	throughput 102400 1000
> > +	update
> > +	progress 10
> > +	throughput 204800 2000
> > +	update
> > +	progress 20
> > +	throughput 307200 3000
> > +	update
> > +	progress 30
> > +	throughput 409600 4000
> > +	update
> > +	progress 40
> > +	EOF
> > +
> > +	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
> > +		--quiet "Working hard" <in 2>stderr &&
> > +
> > +	# t0212/parse_events.perl intentionally omits regions and data.
> > +	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> > +	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> > +	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
> > +	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
> > +'
>
> Thanks for adding a test, including the resulting trace events!
>
> The patch of Taylor's that I mentioned earlier changes the "category"
> to something a bit more specific than "progress", when appropriate.
>
> > +
> > +
> >  test_done
>
> nit: extra empty line
>
> Thanks!
> -Stolee

Thanks,
Taylor
