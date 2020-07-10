Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E47BC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2294420708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4UaL4qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJCA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:00:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF494C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:00:25 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a14so1911806qvq.6
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AdlPBzZujSJNqE1Yoi/1m7BWdw4WNd6+AkBmmOnlkJE=;
        b=i4UaL4qRr8RTlzqQEMn1PIUSATMR6bMsh463g24882nZJ1iqe8VYhI8wLZHRyBu9Jc
         0jzqk3J2dL18XK1Rp3+AmYG+L+zDVPxmUPtXsac7HuQ2iF2GxakoIGWXPMCENVmf/rnH
         AevOY+1Jegyhs50bBxPYofb0DXZyzIRWefUbS8+yMRUYu9XZd+OcUP9U7n3dPYevaaxV
         KJcxXuTdw+inzo/Vy48wFJWx0e9Cjo7yJeBwDUueItm2cTXmwpa42mFvWKnVlDpr2b3v
         yJlaFGaPetLr4y5pWeh/DE22fY7Y0MKv3T2oSDj//bZl5NarZkAtPHGX9QivMeb3PV0G
         57rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AdlPBzZujSJNqE1Yoi/1m7BWdw4WNd6+AkBmmOnlkJE=;
        b=aGlP8YJxdy3FGJj4/6aqrKL+wyij3g1A1+0SDlKITBqEp3+45LbjGqf4z3u0sXmOtc
         UvbP4A/3TfZE1mZwg7TQTH90Y6XlTMDlrvurYu532OYCV4/cjGZpXKRlAPxrOyH3laLG
         qtDy1/80n2+us5tVADM4D+5qZ6AP0DFUNwZhfH244PVLyNG+YHy8MJstMPZfVEBEO92q
         UJ/nZNw9IB34AnSS+KdZ37LQVL1AgudctIWQlUo+7yZt1BTmYsN5ha4o5cwAuxpt9puv
         P24NGYAI+/NIXM9DzV4jDMkGVn6YVEdv+7nq14/PJ15cs/kowL0pB6loWhA7kXgekCyQ
         2BNA==
X-Gm-Message-State: AOAM532aSvbaXvFAO3Oqt8lAeApCA2nQAmKo2vFAmOhs/DPP2jVxaDk1
        9db9KNRWV4eLZdbi7CXd1eg=
X-Google-Smtp-Source: ABdhPJy1A5UfmZatdd/OipziK9JWLskjTZmgvQ7hv/Hsdg0f0qY+8p3HZpt96Ie2r7UpeymzPW2d5g==
X-Received: by 2002:a0c:aa15:: with SMTP id d21mr22838817qvb.155.1594346423793;
        Thu, 09 Jul 2020 19:00:23 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g1sm6477372qkl.86.2020.07.09.19.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 19:00:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ed6b2339-83cd-a7b9-c653-bc86d8686680@gmail.com>
Date:   Thu, 9 Jul 2020 22:00:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200710014242.1088216-2-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 9:42 PM, Emily Shaffer wrote:
> Before now, the progress API is used by conditionally calling
> start_progress() or a similar call, and then unconditionally calling
> display_progress() and stop_progress(), both of which are tolerant of
> NULL or uninitialized inputs. However, in
> 98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
> throughput), the progress library learned to log traces during expensive
> operations. In cases where progress should not be displayed to the user
> - such as when Git is called by a script - no traces will be logged,
> because the progress object is never created.
> 
> Instead, to allow us to collect traces from scripted Git commands, teach
> a progress->verbose flag, which is specified via a new argument to
> start_progress() and friends. display_progress() also learns to filter
> for that flag. With these changes, start_progress() can be called
> unconditionally but with a conditional as an argument to determine
> whether to report progress to the user.
> 
> Since this changes the API, also modify callers of start_progress() and
> friends to drop their conditional and pass a new argument in instead.

This is a worthwhile change. Thanks! I was hoping that we would
get some of these regions for free, which extends what we can get
out of trace2 events.

CC'ing Taylor because he had some thoughts on adding a possible
trace2 category to make it easier to reason about the regions,
when appropriate. Not sure if he's ready to apply that change
on top of this series.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index f520111eda..f64cad8390 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -620,8 +620,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (bisect_list)
>  		revs.limited = 1;
>  
> -	if (show_progress)
> -		progress = start_delayed_progress(show_progress, 0);
> +	/*
> +	 * When progress is not printed to the user, we still want to be able to
> +	 * classify the progress during tracing. So, use a placeholder name.
> +	 */
> +	progress = start_delayed_progress(
> +			show_progress ? show_progress : _("Quiet rev-list operation"),
> +			0, show_progress != NULL)

This is so strange, how we let the command-lines specify a progress
indicator. I guess it is necessary when we use rev-list as a
subcommand instead of in-process. One such case is check_connected()
in connected.c.

It's stranger still that "show_progress" is actually a string here,
as opposed to being an int in most other places.

Your transformation is correct, here, though. Thanks for calling it
out in the commit message.

>  
>  	if (use_bitmap_index) {
>  		if (!try_bitmap_count(&revs, &filter_options))
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index dd4a75e030..719d446916 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -498,8 +498,7 @@ static void unpack_all(void)
>  			ntohl(hdr->hdr_version));
>  	use(sizeof(struct pack_header));
>  
> -	if (!quiet)
> -		progress = start_progress(_("Unpacking objects"), nr_objects);
> +	progress = start_progress(_("Unpacking objects"), nr_objects, !quiet);
>  	obj_list = xcalloc(nr_objects, sizeof(*obj_list));
>  	for (i = 0; i < nr_objects; i++) {
>  		unpack_one(i);
> diff --git a/commit-graph.c b/commit-graph.c
> index 328ab06fd4..b9a784fece 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1152,10 +1152,10 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
>  	struct progress *progress = NULL;
>  	int i = 0;
>  
> -	if (ctx->report_progress)
> -		progress = start_delayed_progress(
> -			_("Writing changed paths Bloom filters index"),
> -			ctx->commits.nr);
> +	progress = start_delayed_progress(
> +		_("Writing changed paths Bloom filters index"),
> +		ctx->commits.nr,
> +		ctx->report_progress);

There are a lot of blocks like this, where the progress string is long enough to
require the first param to be after the method name. Since we are changing the
API and every caller, would the resulting code be cleaner if the string value
was the last parameter? That would allow this code pattern in most cases:

	progress = start_delayed_progress(count, show_progress,
					  _("My special string!"));

Just a thought. Not super-important.

The rest of the changes look to be correct.

> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 5d05cbe789..19b874f9cd 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -23,16 +23,18 @@
>  int cmd__progress(int argc, const char **argv)
>  {
>  	int total = 0;
> +	int quiet = 0;
>  	const char *title;
>  	struct strbuf line = STRBUF_INIT;
>  	struct progress *progress;
>  
>  	const char *usage[] = {
> -		"test-tool progress [--total=<n>] <progress-title>",
> +		"test-tool progress [--total=<n>] [--quiet] <progress-title>",
>  		NULL
>  	};
>  	struct option options[] = {
>  		OPT_INTEGER(0, "total", &total, "total number of items"),
> +		OPT_BOOL(0, "quiet", &quiet, "suppress stderr"),
>  		OPT_END(),
>  	};
>  
> @@ -42,7 +44,7 @@ int cmd__progress(int argc, const char **argv)
>  	title = argv[0];
>  
>  	progress_testing = 1;
> -	progress = start_progress(title, total);
> +	progress = start_progress(title, total, !quiet);
>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		char *end;
>  
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index 1ed1df351c..9d6e6274ad 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -309,4 +309,31 @@ test_expect_success 'progress generates traces' '
>  	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
>  '
>  
> +test_expect_success 'progress generates traces even quietly' '
> +	cat >in <<-\EOF &&
> +	throughput 102400 1000
> +	update
> +	progress 10
> +	throughput 204800 2000
> +	update
> +	progress 20
> +	throughput 307200 3000
> +	update
> +	progress 30
> +	throughput 409600 4000
> +	update
> +	progress 40
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
> +		--quiet "Working hard" <in 2>stderr &&
> +
> +	# t0212/parse_events.perl intentionally omits regions and data.
> +	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> +	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> +	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
> +	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
> +'

Thanks for adding a test, including the resulting trace events!

The patch of Taylor's that I mentioned earlier changes the "category"
to something a bit more specific than "progress", when appropriate.

> +
> +
>  test_done

nit: extra empty line

Thanks!
-Stolee
