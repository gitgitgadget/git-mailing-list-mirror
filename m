Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9ECE7A89
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 23:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjIYXDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjIYXD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 19:03:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C4101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 16:03:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f4db9e11eso60858227b3.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 16:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695683000; x=1696287800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsqAmBUCupMREb3OK59xGxLQo1Z/I7x6XbCR34nsKDg=;
        b=wfIYrC98zK97mRp1kUw/pLoxzR1kfXl1FQzcgasQTn+c9ertdhYOr+0TKDm8mGGJC+
         nW7MPBD7TH6oFy1gcRyB/Dzw6iI28PlRsmbAkGc9XH+iSJBLWlFtm0Wn2ctBhYW73efL
         iH4I2NK8mBfEaNrlnJXuuuv28ZToaYi3RW68eE2gctBu3xKgKcsyIczEtLPtrrvxMA7Y
         TLug/UYnEwfVYu6rEqJ7hHD7JjJPKjSCuQ43IcPeoweVMEH83Coy2l6E86cV6c+qhA4f
         6SMDIlVockYyg9dqdZeL7K4XHWzfiuO43wR+hZz9sVAO/hlTuUkYL8PKwH2nYoy3FKzs
         jOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683000; x=1696287800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsqAmBUCupMREb3OK59xGxLQo1Z/I7x6XbCR34nsKDg=;
        b=l+TwfHM3nijlewb1lhjy7KUOHRoMr8BW3p8UarZ/WgGiX1ix+0gJTv9MaNx64aWseu
         VIJPOnIu1ErVMObb9XEp+e6am2rd+MTqWhiuaW/ImtFRXsVo/WTnMGYqlsl3fkeTFlLz
         tqaSP9eYoXxwQnYxJHKmNhugnmOFOdheCMohKV+TzZ0ly0kjKNz3pGREM858HyPEC+mT
         EvxYmZpbyMoZStvRoaTpUW2rBJ5rNu6KzeaMNCY1hgsT5iTKl2t1oJseuFV+5peILlbg
         0Ujdx2ys1GFFSaSjk0zczvG5hwPabn/cKGcsNBaru03yogcx105PjJn1rqET/vhFc+PK
         EeBA==
X-Gm-Message-State: AOJu0YxUtx1CqV1YOsXBe3vKXmA5CauRazCLPi/Hsx5xEXqxP9qfNkcH
        wN5ioMSJV2I7AXyIIDKMiyK60w==
X-Google-Smtp-Source: AGHT+IHGNEBg8rgVw6xjuFDKzbtEYPR1BYWdeCfrebYaGtpTwIrpmPf+xcctoii+swBaQ0kw8s6L+Q==
X-Received: by 2002:a81:7345:0:b0:58c:93b0:17ba with SMTP id o66-20020a817345000000b0058c93b017bamr7133230ywc.31.1695683000266;
        Mon, 25 Sep 2023 16:03:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v81-20020a814854000000b00576c727498dsm2652914ywa.92.2023.09.25.16.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 16:03:19 -0700 (PDT)
Date:   Mon, 25 Sep 2023 19:03:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZRIRtlbsYadg7EUx@nand.local>
References: <20230830200218.GA5147@szeder.dev>
 <20230901205616.3572722-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901205616.3572722-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 01:56:15PM -0700, Jonathan Tan wrote:
> > > My original design (up to patch 7 in this patch set) defends against
> > > this by taking the very first version detected and rejecting every
> > > other version, and Taylor's subsequent design reads every version, but
> > > annotates filters with its version. So I think we're covered.
> >
> > In the meantime I adapted the test cases from the above linked message
> > to write commit-graph layers with different Bloom filter versions, and
> > it does fail, because commits from the bottom commit-graph layer are
> > omitted from the revision walk's output.  And the test case doesn't
> > even need a middle layer without modified path Bloom filters to "hide"
> > the different version in the bottom layer.  Merging the layers seems
> > to work, though.
>
> For what it's worth, your test case below (with test_expect_success
> instead of test_expect_failure) passes with my original design. With the
> full patch set, it does fail, but for what it's worth, I did spot this,
> providing an incomplete solution [1] and then a complete one [2]. Your
> test case passes if I also include the following:
>
>   diff --git a/bloom.c b/bloom.c
>   index ff131893cd..1bafd62a4e 100644
>   --- a/bloom.c
>   +++ b/bloom.c
>   @@ -344,6 +344,10 @@ struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
>
>           prepare_repo_settings(r);
>           hash_version = r->settings.commit_graph_changed_paths_version;
>   +       if (hash_version == -1) {
>   +               struct bloom_filter_settings *s = get_bloom_filter_settings(r);
>   +               hash_version = (s && s->hash_version == 2) ? 2 : 1;
>   +       }
>
>           if (!(hash_version == -1 || hash_version == filter->version))
>                   return NULL; /* unusable filter */
>
> [1] https://lore.kernel.org/git/20230824222051.2320003-1-jonathantanmy@google.com/
> [2] https://lore.kernel.org/git/20230829220432.558674-1-jonathantanmy@google.com/

Hmm. I am confused -- are you saying that this series breaks existing
functionality, or merely does not patch an existing breakage? I *think*
that it's the latter, since this test case fails identically on master,
but I am not sure.

If my understanding is correct, I think that patching this would involve
annotating each Bloom filter with a pointer to the bloom_filter_settings
it was written with, and then using those settings when querying it.

Thanks,
Taylor
