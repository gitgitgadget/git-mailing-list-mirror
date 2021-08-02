Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D203CC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B418E60725
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhHBWFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHBWFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:05:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B63BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 15:05:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go31so33164721ejc.6
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aWSJDF1sw8plIW4qsPvnr0c/Srfoj+nUKUNv3JaRvlU=;
        b=aF2uOh3Hrb0VeMIWOFC4jZ7UBOA8OzjuDZQQkh48mJfsqhcbiXmw9ot+L/bYVA4t8h
         Otd5Xf4A07iGsbiC84TPFjLauH/QOj+qtNCA/f8WkvKiJtAiALjwRdcESxN75MTotg4Y
         L0eDvU01otHCYL8wdHs8S45WaI1wxbvuNwpDyf+21BhBwuj4QEP6NcA+ASp9Xlpd1u/G
         MM1UrlDgkp3xd70ETFTrtJWtIdf+HIQraFpg7lyDGr8SedkBTYM7CFYl9GRZXAV6O3jY
         V0cZxUTqCsigwIHcj0LUBWPXBAwIPzbovCawV2QpqRbOdTEGhW16b9paBFgQJf3VySfl
         r0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aWSJDF1sw8plIW4qsPvnr0c/Srfoj+nUKUNv3JaRvlU=;
        b=GMmlEVafuFG9piMrk34/X/b2ia1+TfxHQR6unm0nh/ZU6bNspNBswEkY6DiGQ2SsQr
         kl/IVp+7bSiaeNxT8Pxja8V0qEfFUtp1+TSuiD8Kj3XWN7RKdT+KO+7pmkZM0EVchc80
         8/O77zdMhWiJr/m9zn0GGr7WhYAp/ALFj8i19MuVZFt4CKUZTRrucohxjQnJbbhioWOv
         AyaU/QYksRvde8O3LJFg2AajdVGDNhjJjjKSV9TUXLO6+d1QgQ94Dh5Kua3FMAV0VTgE
         BsF2ET98TCHT21lktanCHoJAN0axT3y750DYqY93VU60UNA3ZpLyBmdCL383egMOEOfy
         mm4A==
X-Gm-Message-State: AOAM533qQS1KC3Fha4VRkGqL0qT8cI/bJzRdDnMYrDpCXyhGqDSnxmZx
        BSyL3/rLCREOU7QmQWltefs=
X-Google-Smtp-Source: ABdhPJywFkqpu7yfbARIoO79p9TWUQJmrhlnxTMYCRC2wSh2Alp7fbS2lYXKxamDo73IhjH7GU1rkQ==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr17109946ejb.511.1627941908975;
        Mon, 02 Aug 2021 15:05:08 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id l9sm1674320edt.55.2021.08.02.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:05:08 -0700 (PDT)
Date:   Tue, 3 Aug 2021 00:05:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/3] entry: show finer-grained counter in "Filtering
 content" progress line
Message-ID: <20210802220506.GF23408@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
 <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
 <xmqqbl6slmer.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbl6slmer.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 03:01:48PM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > From: SZEDER Gábor <szeder.dev@gmail.com>
> >
> > The "Filtering content" progress in entry.c:finish_delayed_checkout()
> > is unusual because of how it calculates the progress count and because
> > it shows the progress of a nested loop.  It works basically like this:
> >
> >   start_delayed_progress(p, nr_of_paths_to_filter)
> >   for_each_filter {
> >       display_progress(p, nr_of_paths_to_filter - nr_of_paths_still_left_to_filter)
> >       for_each_path_handled_by_the_current_filter {
> >           checkout_entry()
> >       }
> >   }
> >   stop_progress(p)
> >
> > There are two issues with this approach:
> >
> >   - The work done by the last filter (or the only filter if there is
> >     only one) is never counted, so if the last filter still has some
> >     paths to process, then the counter shown in the "done" progress
> >     line will not match the expected total.
> >
> >     This would cause a BUG() in an upcoming change that adds an
> >     assertion checking if the "total" at the end matches the last
> >     progress bar update..
> 
> So the other series will semantically depend on this 3-patch series?
> Just making sure that is the intended topic structure.
> 
> > diff --git a/entry.c b/entry.c
> > index 125fabdbd5..d92dd020b3 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -162,7 +162,7 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
> >  int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
> >  {
> >  	int errs = 0;
> > -	unsigned delayed_object_count;
> > +	unsigned processed_paths = 0;
> >  	off_t filtered_bytes = 0;
> >  	struct string_list_item *filter, *path;
> >  	struct progress *progress;
> > @@ -172,12 +172,10 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
> >  		return errs;
> >  
> >  	dco->state = CE_RETRY;
> > -	delayed_object_count = dco->paths.nr;
> > -	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
> > +	progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
> >  	while (dco->filters.nr > 0) {
> >  		for_each_string_list_item(filter, &dco->filters) {
> >  			struct string_list available_paths = STRING_LIST_INIT_NODUP;
> > -			display_progress(progress, delayed_object_count - dco->paths.nr);
> >  
> >  			if (!async_query_available_blobs(filter->string, &available_paths)) {
> >  				/* Filter reported an error */
> > @@ -224,6 +222,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
> >  				ce = index_file_exists(state->istate, path->string,
> >  						       strlen(path->string), 0);
> >  				if (ce) {
> > +					display_progress(progress, ++processed_paths);
> >  					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
> >  					filtered_bytes += ce->ce_stat_data.sd_size;
> >  					display_throughput(progress, filtered_bytes);
> 
> Hmph.  A missing cache entries will not increment processed; would
> that cause stop_progress() to see at the end the counter that is
> smaller than dco->paths.nr we saw at the beginning?

Yes, but this 'if (ce)' condition has an 'else errs = 1;' branch as
well, i.e. a missing cache entry is considered an error.  This patch
fixes issues with this progress bar in the case when all went well,
i.e. when there were no errors.  In my original submission it is
followed up by another patch that attempts to fix this progress line
when there are errors, arguing that it's wrong to show "done" at the
end when not all work was done because of said errors...  although
"fix" is not quite the right word for the approach taken in that
patch, it's more like "papering over" ;)

  https://public-inbox.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/

