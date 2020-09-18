Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA169C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9910620848
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 10:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0vXz4PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIRKsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgIRKsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 06:48:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C4C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 03:48:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg9so2799445plb.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DS5/xPSsEn6QjhSlvtuvKYO9L7BnttBSpmkNMMRUW38=;
        b=t0vXz4POdZDdeJjCv88izDT9eT5wovE4KRGY4dpdm9wWQQDglu6Il1U0HhtVYD8PJb
         /zutJdGdeHlSibHO21hlne+cy4JapMhK4XjA52WXkrLcSfWfLiMl4QZdRXrnfKS16vfw
         TqGAKvaj/jZIT8EsdsC66b6D6qXEd9DX5FU4QV/d/gj75Jlof37AZa6BkUQJ8tOTLzUx
         qvINcUxYs2YUuOcNr8AGW5FMMJVRmJ65co+2lAyTzytauYERex6wopT8mzkPxzKxGcvM
         /rWsKeBX6VobxAIebLqFGQE/ZScBe1rS0zvUB9MaXyFGiHnjNoo6sHZFsFW7IMk7iMb/
         jvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DS5/xPSsEn6QjhSlvtuvKYO9L7BnttBSpmkNMMRUW38=;
        b=ggm5qz4iUqMf/kNhI0MpBZW4OzWGH1FFJ3A+FhuBs/U+0aaDZH8dP6OSGmYzn2+W0g
         sJ+jUtB0Q8TFf3O8/AEvClUE6R6Syu90a5gH62OjsEZKtszQK00ed+XScQHKYtq3mn1v
         AeikehRIIYRXWKjtH3IkAIZAhiNSqViHNIv77Jpa2JCysoeb2s38ha1q6BbvvO9e7kW3
         uFT7RFFMLoDzJbX8SP6J+ISwlpiOObgkSmiWpvxM3++Yk930Jlc2wOjcS5tHw5FD6GWu
         p5Ue3kfr5tWN/r/QCTi0RiwxHptNuTc5YrRhrkcFbwhc8aFCqsIrHFibwWhlk2fvi54r
         jgUg==
X-Gm-Message-State: AOAM532rxPK6H07S9fEC038OevWc2m3qpxxp09p1NLE5B9e5dF2fxQ/v
        PmIo6bXLe4dxV9Y+56nNif/q5XXFVRA=
X-Google-Smtp-Source: ABdhPJwqCJ9UAwtILlIZ0uERl+LFjxQSPztDL9I6kF4weG9uK3tZvgAat9YjxxkCr25PbCzsLv1o3g==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr12047488pjt.76.1600426116286;
        Fri, 18 Sep 2020 03:48:36 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id o5sm2492673pjs.13.2020.09.18.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:48:35 -0700 (PDT)
Date:   Fri, 18 Sep 2020 03:48:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200918104833.GB1874074@generichostname>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
 <xmqq363gs1mt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq363gs1mt.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 11:23:54AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +	if (read_stdin && merge_base)
> > +		die(_("--stdin and --merge-base are mutually exclusive"));
> > +
> > +	if (merge_base) {
> > +		struct object_id oid;
> > +
> > +		if (opt->pending.nr != 2)
> > +			die(_("--merge-base only works with two commits"));
> > +
> > +		diff_get_merge_base(opt, &oid);
> > +		opt->pending.objects[0].item = lookup_object(the_repository, &oid);
> > +	}
> > +
> 
> This looks quite straight-forward.
> 
> > -	/*
> > -	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
> > -	 * swap them.
> > -	 */
> > -	if (ent1->item->flags & UNINTERESTING)
> > -		swap = 1;
> > -	oid[swap] = &ent0->item->oid;
> > -	oid[1 - swap] = &ent1->item->oid;
> > +	if (merge_base) {
> > +		diff_get_merge_base(revs, &mb_oid);
> > +		oid[0] = &mb_oid;
> > +		oid[1] = &revs->pending.objects[1].item->oid;
> > +	} else {
> > +		int swap = 0;
> > +
> > +		/*
> > +		 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
> > +		 * swap them.
> > +		 */
> > +		if (ent1->item->flags & UNINTERESTING)
> > +			swap = 1;
> > +		oid[swap] = &ent0->item->oid;
> > +		oid[1 - swap] = &ent1->item->oid;
> > +	}
> 
> It is not entirely clear why the original has to become an [else]
> clause here, unlike the change we saw earlier in cmd_diff_tree().
> It feels quite inconsistent.

Since we're only interested in the oids, I thought that it would be
possible to save a lookup_object() and just use the oids directly. If
it's clearer, this can be written as something like this but the lookup
feels unnecessary:

	/*
	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
	 * swap them.
	 */
	if (ent1->item->flags & UNINTERESTING)
		swap = 1;

	if (merge_base) {
		struct object_id mb_oid;
		if (swap)
			BUG("swap is unexpectedly set");
		if (diff_get_merge_base(revs, &mb_oid))
			exit(128);
		ent0->item = lookup_object(the_repository, &mb_oid);
	}


	oid[swap] = &ent0->item->oid;
	oid[1 - swap] = &ent1->item->oid;

Thanks,
Denton
