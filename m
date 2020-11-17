Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F72C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE6124671
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jaXhc0gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgKQA0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbgKQA0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:26:35 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE9C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 16:26:34 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so18900128qke.8
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pH0C4mwcjt9dUqMYmCNR2akMY3waOSnUYvtoawR6Vf0=;
        b=jaXhc0gJGvihMkqrhJv8NQ8sod0nV8emzLEmR/ZaSj8GrphnmTjA69cNJBIWRCpceZ
         yhGWGrZckVZTMwWFlXYAOvizvjNnYaaAka4xo73IBoE8LJJwgOdfF4iEv10y2JBREKjf
         Vc7Mrrm580/bJrdQobrUm1W9XsDBisZzcBOxJh8Cv0nFiXlk2Ywrs7w3ZRSCmjBPMCYn
         /lOXHLSfiw1bgnyupusiBzeR5bUqEjYfaSNTk8Pyl5e/gz3V8FTXKZ90VWqYSE6kAlB7
         T7XVcujoKnLuLNBUdUR3wf/2C4l2LlppeFFrPmvkuFFB2DFbwL9bADs8iviJEnTXkJPh
         Bhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pH0C4mwcjt9dUqMYmCNR2akMY3waOSnUYvtoawR6Vf0=;
        b=koeinAV+n7tgPtlO4Dlnwm4PEg5dDPeW+RiyO91vMD11JBjyvJxuFdbPU3bg7jqDjw
         3g1WR0zEEF/7945EdsOAJbYT5pFBtUBBlwkFfsOfr7asXPEn3E4gCGADanLfzEcvldCv
         7e09+4KgNrQhaLbWVdzQuYPF7TjpFaKgUrybz50SGbIT5v16sReMYHLby1LFLOY6hYVk
         FXmAowcMx/3JUI9/ShwGdfGeFg5KZ9s74jpUkUnqXXDyDVek39qvX/LNGq1FGfriO+Lu
         es7AlPM5cHxq0mKKw5L4MldpWkluCsFlkJ8YJ+tpLE8eIBqFvaWzAEMO9sIuGjyaVctd
         651g==
X-Gm-Message-State: AOAM531aNUBaKu2QXl4bSq7bSRH/KKk4G33V9hzt7bXXpO7O2mlhNKeK
        BYdMIAp8xMNx5nYzfYjpW6NfyQ==
X-Google-Smtp-Source: ABdhPJwNCCLoq00duMaf7gtOW7PYcprlY5whqyZkkJlE6mfvsn85K2POM4uLraaIAzno1qQI/P8ebQ==
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr17412029qkc.388.1605572793401;
        Mon, 16 Nov 2020 16:26:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2e3a:4a72:e851:164d])
        by smtp.gmail.com with ESMTPSA id 72sm8307896qtg.69.2020.11.16.16.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 16:26:32 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:26:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
Message-ID: <X7MYtjLQmmhfyHA5@nand.local>
References: <cover.1605552016.git.me@ttaylorr.com>
 <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
 <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
 <20201117000252.GB12322@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117000252.GB12322@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 07:02:52PM -0500, Jeff King wrote:
> I think you could make an argument either way:
>
>   - we have an existing bitmap for free, and bitmaps make things faster,
>     so why not keep it?
>
>   - the user did not ask for bitmaps, so we should make the outcome
>     consistent whether a pack of the exact name existed before or not
>
> The second one seems less surprising to me. But I think if we did the
> first, the code would be shorter (it would not need any of this "keep
> track of what pack-objects generated" stuff at all, but would just copy
> whatever files we see into place).

I think that the second one is _far_ less surprising to me, so I'd
prefer that we did that instead of keeping the .bitmap from the last run
regardless of whether or not the user asked for it.

> > >  				if (rename(fname_old, fname))
> > >  					die_errno(_("renaming '%s' failed"), fname_old);
> >
> > OK, so this is where the previous step matters.  We do the same as
> > before (i.e. stat+chmod and rename) only for paths we have created.
> >
> > We don't reuse the old one because we have already written a new
> > file so we won't save anything by doing so, and checking if the
> > target of rename exists already before deciding not to rename cannot
> > be made atomic, so just relying on rename() to do the right thing is
> > a good idea anyway.
>
> Even though the pack is byte-for-byte identical, the new .idx, etc,
> might not be. And those could be affected by options. E.g.:
>
>   git -c pack.writeBitmapHashCache=false repack -adb
>   git -c pack.writeBitmapHashCache=true  repack -adb
>
> should probably end up with a bitmap file that contains a hash cache.

Agreed completely.

> -Peff

Thanks,
Taylor
