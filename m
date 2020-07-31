Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4050C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B5822B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YIRTS7fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGaV3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgGaV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:29:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F3C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:29:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so24053929qtm.10
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9WbbsyyWCh/D55JW8kFQ++gQl2fZ/6twmqGPd/nSkQ=;
        b=YIRTS7fb84fb1soT5dG/WUEACyOUfUL9Eb5qU/gqCDno1vaf88lP6uj60yT6ieY9vh
         WWcFtwe8Vxci7eQHYZ2NuoKvqEBu1WNH7WXKJm2eQTG1sc/tU4zZTfdxq/TwWiC2bgui
         GWuRVbSCrqYxabfZuwrIfWjbfd8YBiGKMfGbYkeL9UTu8BSRSz4kGMAbi2Tav0YoJiQK
         2KcxEWJmCJVUNnCpbqa/XE9oX47UQU6gq+xYtSEvY7sY8HP3rczd6JJD70/qPjZyRr/e
         Qf5AHsotoZ6P1T9orXgpWr5m15fO+eAM3/nBW+pIwPrXNbtYjarsjWKqgU/FAcVl34wo
         xp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9WbbsyyWCh/D55JW8kFQ++gQl2fZ/6twmqGPd/nSkQ=;
        b=sCgZncxCX2wewxJ0j3f8Y0Uom7VpaXPWWqXPmMewURYqfmIb1gXSXfumjmFJn8mCPb
         dsuKkpY/Bs3N+BhJmnmCZNFHOqtLKMKiQ5L7DhwY5YE0bT70mABP7sSihSot8ApFMP9T
         npbubn4DGiiLZtK6vxE6VRSaW8klz/Yt/fwlaPC7x6uEriX0i4wOwDdxZsE/O0RtJgeF
         4l5KmNImgSg1pclgcQD19c8E4+w+2G2lQSxYk9I5JME6wKbha7aEtT0Z7i+Gzd1jw3aq
         kQVo4SVYZt28iWokmb1wfUsTM5+cvvpMEWAeSHtZhBPhrdfriQ6AacPZYBj1ZGSLb6t0
         n4JA==
X-Gm-Message-State: AOAM533HairNkYxajzWtpJ/cx1aMU0i++4bdSpLFFkXl+RG/TmVurQnX
        4ETJ9dX4j7NSU8Gr39mMNkuhTOmBYXmRCQ==
X-Google-Smtp-Source: ABdhPJz0y6vF44DHlrxnnbuq0zPFjCMpBxu8vrEt7MCm1D8CO1UX0mzLVhViPqBE9clVN2FoW78TsA==
X-Received: by 2002:aed:3fa9:: with SMTP id s38mr5876739qth.237.1596230947463;
        Fri, 31 Jul 2020 14:29:07 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id u42sm12874438qtu.48.2020.07.31.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:29:06 -0700 (PDT)
Date:   Fri, 31 Jul 2020 17:29:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731212905.GE3409@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
 <20200731210114.GC1440890@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731210114.GC1440890@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 05:01:14PM -0400, Jeff King wrote:
> On Fri, Jul 31, 2020 at 04:26:39PM -0400, Taylor Blau wrote:
>
> > +test_expect_success 'upload-pack limits tree depth filters' '
> > +	test_config -C srv.bare uploadpackfilter.allow false &&
> > +	test_config -C srv.bare uploadpackfilter.tree.allow true &&
> > +	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
> > +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
> > +		"file://$(pwd)/srv.bare" pc3 2>err &&
> > +	test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err
> > +'
>
> Same i18ngrep comment as in the earlier patch (i.e., we can use grep
> here).
>
> > @@ -1029,6 +1040,11 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
> >
> >  	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
> >  		    list_object_filter_config_name(banned->choice));
> > +	if (banned->choice == LOFC_TREE_DEPTH &&
> > +	    data->tree_filter_max_depth != ULONG_MAX)
> > +		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
> > +			    data->tree_filter_max_depth,
> > +			    banned->tree_exclude_depth);
>
> Hmm. So I see now why you wanted to go with the strbuf in the earlier
> patch. This does still feel awkward, though. You check "is it allowed"
> in an earlier function, we get "nope, it's not allowed", and now we have
> to reimplement the check here. That seems like a maintenance burden.

I'm not sure that I follow. Is the earlier function that you're
referring to 'banned_filter'? If so, the only use of that function is
within 'die_if_using_banned_filter'. 'banned_filter' exists only insofar
as to answer the question "return me the first banned filter, if one
exists, or NULL otherwise".

Then, dying here is as simple as (1) lookup the banned filter, and (2)
check if it's NULL or not.

If you're referring to 'allows_filter_choice', I guess I see what you're
getting it, but to be honest I'm not sure if I'm buying it. If we were
to combine 'allows_filter_choice', 'banned_filter', and
'die_if_using_banned_filter' into one function that traversed the filter
tree and 'die()'d as soon as it got to a banned one, that function would
have to know how to:

  1. Recurse through the tree when it hits a LOFC_COMBINE node.

  2. At each node, translate the filter->choice into the appropriate key
  name, look it up, and then figure out how to interpret its allowed
  status (including falling back to the default if unspecified).

  3. And, it would have to figure out how to format the message at each
  step.

(3) I think is made easier, since we know what message to format based
on whether or not we're in the 'opts->choice == LOFC_TREE_DEPTH' arm or
not. But, there are two more things that we now have to cram into that
same function.

Maybe I'm being too strict an adherent to having simpler functions, but
I'm failing to see how to combine these in a way that's cleaner than
what's written here.

> I think a more natural flow would be either:
>
>   - the "is it allowed" functions calls immediately into the function
>     that sends the error and dies (this might need a conditional if
>     there's a caller who doesn't want to die; I didn't check)
>
> or
>
>   - on failure it populates an error buffer itself, which the caller can
>     then pass along as it sees fit

I guess; I'm not a huge fan of the side-effecting nature, but maybe it's
cleaner.

I dunno. I appreciate your review, but I feel like we're in a bikeshed.

> -Peff

Thanks,
Taylor
