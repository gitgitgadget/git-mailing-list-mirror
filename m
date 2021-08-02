Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53296C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222960F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhHBVsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHBVsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:48:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C5C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:48:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so839268wmb.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0vGkKC9qN57TrhF8r6CFWI+yL1U5erxVJG2kdc5odPk=;
        b=gSZ2iwBPGhEwg/urgEcRoeX5ufKCLobL6RshpeUqi7dvzVCalSbenL1BGNwau9V8Mj
         CjIRf8QQUjrwkQafUj9+QWphSuyo/xg7Tb2Z3qHq3xFdgCJGGLBzzchkIvNn1Eei3r4m
         z2b2na4T8c/Fxu9dK0CPTE8bRxmLLsiGkWrKVL6/qL5oYXyohU9GFa/iL3tecqwM8e14
         dkT0Wp4nJ0R+V7FB8drx89sHn+7M2e4wBv9fcAZVJ4ojGb+J1oxU3xgR38uCW0VTsdnD
         Vn6n3mlEvXVG+vQfgA/06hBn+SlA78vUytg3GnK3cko9ax6BlTg3e0WuzgM7IKHFe4mM
         cJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0vGkKC9qN57TrhF8r6CFWI+yL1U5erxVJG2kdc5odPk=;
        b=m5tdB8pchrmPvrP5JSpqlfyIUZ574I07vYQDzEjxsK1HwWh5dMMyMD+tesDkhqNyJQ
         j8xHiZud1cs7xemhLVNiPmDCAR4UyGWiL0nKHF3yIa4UVKfBPEKEIUupXsBeQbLoAAmA
         sA+ze50/Yq7zXxcNrbuIq7wMVBfDsHwOlA1/csQJ9aUzmc3ExnBYV3z0LyYfmvIAxeFX
         2xekn0BY4x+m//oQeyY8xzB4gv/OcyX8A0c+J/x94MtT3VIEVVYye4vPki42jWbSkgWt
         n9FW6EBdajV1LN51dxbILRqOl/6fblA/MfWnaPL6ngalZPP9+IMZeeOzqFBQz832xxcx
         GUaA==
X-Gm-Message-State: AOAM532ssf8sxt5bxt+NdsAozmw5WQUnx31bcaMdp+M3pQGqFkTkFLdM
        aeTA5awCXy86D6SqiGleV50=
X-Google-Smtp-Source: ABdhPJyBD9h13Hc2scTky8IE6wzm4neCOhRsv5isTDuzWy0ELUN5wA73MApYRAcNF0IELk2nsx5pdw==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr924582wme.61.1627940909652;
        Mon, 02 Aug 2021 14:48:29 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id j14sm12475996wrr.16.2021.08.02.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:48:29 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:48:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/3] entry: show finer-grained counter in "Filtering
 content" progress line
Message-ID: <20210802214827.GE23408@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
 <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 02:20:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> From: SZEDER Gábor <szeder.dev@gmail.com>
> 
> The "Filtering content" progress in entry.c:finish_delayed_checkout()
> is unusual because of how it calculates the progress count and because
> it shows the progress of a nested loop.  It works basically like this:
> 
>   start_delayed_progress(p, nr_of_paths_to_filter)
>   for_each_filter {
>       display_progress(p, nr_of_paths_to_filter - nr_of_paths_still_left_to_filter)
>       for_each_path_handled_by_the_current_filter {
>           checkout_entry()
>       }
>   }
>   stop_progress(p)
> 
> There are two issues with this approach:
> 
>   - The work done by the last filter (or the only filter if there is
>     only one) is never counted, so if the last filter still has some
>     paths to process, then the counter shown in the "done" progress
>     line will not match the expected total.
> 
>     This would cause a BUG() in an upcoming change that adds an
>     assertion checking if the "total" at the end matches the last
>     progress bar update..
> 
>     This is because both

"Both" what?

>     use only one filter.  (The test 'delayed
>     checkout in process filter' uses two filters but the first one
>     does all the work, so that test already happens to succeed even
>     with such an assertion.)
> 
>   - The progress counter is updated only once per filter, not once per
>     processed path, so if a filter has a lot of paths to process, then
>     the counter might stay unchanged for a long while and then make a
>     big jump (though the user still gets a sense of progress, because
>     we call display_throughput() after each processed path to show the
>     amount of processed data).
> 
> Move the display_progress() call to the inner loop, right next to that
> checkout_entry() call that does the hard work for each path, and use a
> dedicated counter variable that is incremented upon processing each
> path.
> 
> After this change the 'invalid file in delayed checkout' in
> 't0021-conversion.sh' would succeed with the future BUG() assertion
> discussed above but the 'missing file in delayed checkout' test would
> still fail, because its purposefully buggy filter doesn't process any
> paths, so we won't execute that inner loop at all (this will be fixed
> in a subsequent commit).

I don't like how the updates to the commit message keeps referring to
some future BUG().

A benefit of my original submission is that all those checks are added
at the beginning of the patch series, so when looking at these later
bugfix patches reviewers can easily run the problematic tests with
GIT_TEST_CHECK_PROGRESS=1 to see the failure themselves and to confirm
that the fix indeed works.  Without those checks the next best thing
is applying the patch below and then looking at the verbose log of
those tests:


diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index b5749f327d..93a67f2f1f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -955,7 +955,8 @@ test_expect_success PERL 'missing file in delayed checkout' '
 	) &&
 
 	rm -rf repo-cloned &&
-	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
+	test_must_fail env GIT_PROGRESS_DELAY=0 git clone repo repo-cloned 2>git-stderr.log &&
+	cat git-stderr.log &&
 	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
 '
 
@@ -976,7 +977,8 @@ test_expect_success PERL 'invalid file in delayed checkout' '
 	) &&
 
 	rm -rf repo-cloned &&
-	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
+	test_must_fail env GIT_PROGRESS_DELAY=0 git clone repo repo-cloned 2>git-stderr.log &&
+	cat git-stderr.log &&
 	grep "error: external filter .* signaled that .unfiltered. is now available although it has not been delayed earlier" git-stderr.log
 '
 

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  entry.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 125fabdbd5..d92dd020b3 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -162,7 +162,7 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
>  int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
>  {
>  	int errs = 0;
> -	unsigned delayed_object_count;
> +	unsigned processed_paths = 0;
>  	off_t filtered_bytes = 0;
>  	struct string_list_item *filter, *path;
>  	struct progress *progress;
> @@ -172,12 +172,10 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
>  		return errs;
>  
>  	dco->state = CE_RETRY;
> -	delayed_object_count = dco->paths.nr;
> -	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
> +	progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
>  	while (dco->filters.nr > 0) {
>  		for_each_string_list_item(filter, &dco->filters) {
>  			struct string_list available_paths = STRING_LIST_INIT_NODUP;
> -			display_progress(progress, delayed_object_count - dco->paths.nr);
>  
>  			if (!async_query_available_blobs(filter->string, &available_paths)) {
>  				/* Filter reported an error */
> @@ -224,6 +222,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
>  				ce = index_file_exists(state->istate, path->string,
>  						       strlen(path->string), 0);
>  				if (ce) {
> +					display_progress(progress, ++processed_paths);
>  					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
>  					filtered_bytes += ce->ce_stat_data.sd_size;
>  					display_throughput(progress, filtered_bytes);
> -- 
> 2.32.0.957.gd9e39d72fe6
> 
