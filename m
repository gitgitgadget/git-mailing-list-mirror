Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D3C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 02:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiFOCS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFOCS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 22:18:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16063240BC
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:18:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hf10so7448028qtb.7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FtFxZnRbaNYXW50jwsgH4LQhUcT01FYp6++Ct0SPPvM=;
        b=OgD5Mrdi5ytw3wzKZLvY39aHbPDC7cE9g6uGv2MZUe0EUaclLJAmsnEw0BWfhkCw05
         V9sb0yK4pR5ssX5dMtoj8/a7h6Cgi1m0dAO5zr6tqRTvX5U4NOviK+nCw0Mqt8rh07e5
         qnSxG/Y8WWk2m8E/GyBmxkKjlPotuvGhpulL4m2KB9dPIyjE+mpqW9Sg8OGkXfKCQPbD
         OE+wkRsjVyv0S3VwUg6+2spQlx4C0Cksr4yietxFql2Nu6xfm5CUVJfuPEHZmRuqW0qF
         tTWn6ghrYCHzBb+VWV+wGHh1YJwG2euHQU9sTsMoqkFuY7xYL7VmRJKYZkgSaizPkVE2
         4ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtFxZnRbaNYXW50jwsgH4LQhUcT01FYp6++Ct0SPPvM=;
        b=IrvafwNhkqGuapfa40zpu9tWTx3BuEMrnc/ioxz51Ikk5DZXpNuX5L4wDeysID0Ia+
         yorrWiTtqfLFfuAJgDqyc6c2DtDZcMJLQ3ruxCnIxfFFKMIqJ/rGSoTtCKwtj+0VsGRU
         WMELzIgDo2caTsZRUn9eAQKp+SO1n6neP6obTK3tYU6DK914v4WunRcSOciWdQHya0fn
         s11g8j9X6gj6rdojuHzoLWNYryVSZPAzLuCe0Of6h2a7i9ZItmANlIUbuK/POB/Hns7n
         OL4yceNFBrFXQF30wOJi7UQUJd6LTyLUXGKNYMw8fzqLsj9MYvkMjX7gkidT1Mqj12rx
         r3cg==
X-Gm-Message-State: AOAM531kaLRnkHFm8BYEpTogt1UGTWXGPaAnxMUr2XMYuR9gbxlX/LNS
        Irtqg8QyydPRYqX4COOvViw2Kg==
X-Google-Smtp-Source: ABdhPJzUAm0Vtdb3l7f97QE9PuuMizynR4VRdCTqPjfDj9Qqyb3BQwmsjA/6MJyYlgzQCTuQjeoq5Q==
X-Received: by 2002:ac8:7d49:0:b0:304:e4ce:3345 with SMTP id h9-20020ac87d49000000b00304e4ce3345mr7164713qtb.508.1655259534193;
        Tue, 14 Jun 2022 19:18:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w2-20020a05622a134200b003051ba1f8bcsm8354884qtk.15.2022.06.14.19.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:18:53 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:18:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Haiyng Tan <haiyangtand@gmail.com>
Cc:     git@vger.kernel.org, chiyutianyi@gmail.com, ps@pks.im,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: An endless loop fetching issue with partial clone, alternates
 and commit graph
Message-ID: <YqlBjET0tf7V9/sg@nand.local>
References: <CANe9W27GVn-w1WSZNTxh5SKEMzHGEZQCF48vmbvMi4AUEg12yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANe9W27GVn-w1WSZNTxh5SKEMzHGEZQCF48vmbvMi4AUEg12yQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Stolee]

On Tue, Jun 14, 2022 at 03:25:13PM +0800, Haiyng Tan wrote:
> I think it's caused by using lazy-fetch in
> deref_without_lazy_fetch_extended().  In lookup_commit_in_graph(),
> lazy-fetch is initiated by repo_has_object_file() used.  has_object()
> should be used, it's no-lazy-fetch.

Hmm. Are there cases where lookup_commit_in_graph() is expected to
lazily fetch missing objects from promisor remotes? If so, then this
wouldn't quite work. If not, then this seems like an appropriate fix to
me.

Thanks,
Taylor
