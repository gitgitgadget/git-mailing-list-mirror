Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3917BC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69522173E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TsPOhDjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgHETXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHERaG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:30:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CCC0D942C
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:19:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so19891702qth.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7NdhIXezKi6ye5ZA6UfQy5G/PpsH5znK+DxQumm48FA=;
        b=TsPOhDjEF026LJPDHo/Y4hxzBhExsgKUREnolg5yFG58yK8xZBVFxLXUcFttTnyw44
         +lweAdDHv5RulwfWzWzVovMROOwDlhGxbgPPReGhUc0O/OvuFQ0iUN1cB0TC0HUoWIaI
         +XVIE3ctW5Sc4ST1S8EbmxeiIdgIPWBw+7D0427JpHUKpv/ejUh2LsEcIIJCr796DSfA
         J+a1H0J9bVuXvRsO5MEbROw+Vb93yHGtNZZWOgeh9dfO2VHDcpLjC1yiVvPmJJ/tL1GG
         FJPl9kHyXouEphRXzUdk534kuWnjwyi6APPSAjpxb+vXX0SvZO1hG0SNb1zhGzFdMgdF
         f1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7NdhIXezKi6ye5ZA6UfQy5G/PpsH5znK+DxQumm48FA=;
        b=avL4uPF7SUtFqFcr5LgNQgYYJtrsB69B0YysrqtjxRqeDL/bIWS+9VyV2Pxi+9iZ7O
         yU/2iigLAwPk1FodS5AGPThjOnFY6eunKIFrEvvrjMc1eBkbRvNR0xsGmHz6IZCGBMca
         MiC96mT39lwqal3d1fBBLWu/g+YHnu+FAKKsKVtBz2tTEppWJpgEmnvYJCz9nPRtYs9i
         wEqx5m+ZYP3rwq0RfmX3JFQv/tbTDWBaCffUPojgqd63IwLhA+C/PE2cYHmPDWB4vr4Q
         BuTviXKmnAto13/ZOtvIVMdeHuugidccqdzcKYqfkNyOhupRNLg5pzT1i89jL4M/oBpF
         5MvA==
X-Gm-Message-State: AOAM533V5CWCBKTcg3mwYubrdg+9gXKTwPbZO2qQ4hpzxxUEOkRwzvvE
        cpo0FiEKZol5l9rfd9eego+NKA==
X-Google-Smtp-Source: ABdhPJw9qt7L7SlJzgfqeNc5Jj7ep9AhU4/RBSDTf7BZz/oNH/xhRO16kANjlXIv088o6xdM+/gT4A==
X-Received: by 2002:ac8:6f55:: with SMTP id n21mr3816935qtv.10.1596640796558;
        Wed, 05 Aug 2020 08:19:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id 94sm2253834qtc.88.2020.08.05.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:19:54 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:19:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] revision: avoid leak when preparing bloom filter for
 "/"
Message-ID: <20200805151953.GE9546@syl.lan>
References: <20200804074146.GA190027@coredump.intra.peff.net>
 <20200804075017.GC284046@coredump.intra.peff.net>
 <5159cfbb-55a4-8010-66a3-f6b4e4b05d7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5159cfbb-55a4-8010-66a3-f6b4e4b05d7e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 09:09:21AM -0400, Derrick Stolee wrote:
> On 8/4/2020 3:50 AM, Jeff King wrote:
> > If we're given an empty pathspec, we refuse to set up bloom filters, as
> > described in f3c2a36810 (revision: empty pathspecs should not use Bloom
> > filters, 2020-07-01).
> >
> > But before the empty string check, we drop any trailing slash by
> > allocating a new string without it. So a pathspec consisting only of "/"
> > will allocate that string, but then still cause us to bail, leaking the
> > new string. Let's make sure to free it.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Just noticed while reading the function to fix the previous patch.
> >
> > I'm not even sure if it's possible to get here with a pathspec of "/",
> > since we'd probably give a "/ is outside repository" error before then.
> >
> > So maybe this case doesn't even matter. If it doesn't, then it might
> > simplify the function a bit to do the empty-pathspec check before

For what it's worth, I am almost certain that this isn't possible after
your last patch, but I also agree that it's not hurting anything in the
meantime, either. So...

> > handling trailing slashes. But handling it does help make it more clear
> > this function is doing the right thing no matter what input it is given,
> > so that's what I went with here.
>
> Works for me. Thanks for your careful attention here.

Works for me, too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> -Stolee
>
> >  revision.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/revision.c b/revision.c
> > index 5ed86e4524..b80868556b 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -702,6 +702,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
> >  	len = strlen(path);
> >  	if (!len) {
> >  		revs->bloom_filter_settings = NULL;
> > +		free(path_alloc);
> >  		return;
> >  	}
> >
> >

Thanks,
Taylor
