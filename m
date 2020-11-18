Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89294C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF9A246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCvIfSz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKRX0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKRX0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:26:04 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7334EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:26:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id i8so2595262pfk.10
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2gVJq5TGX/OnvvTTdwI2mixCEJx6fZlK3ONdnyJ14z8=;
        b=ZCvIfSz7qPeIn4vtuwMIJCcWpJosHFsvWfrxTsx7oFu2xj3mka1JIBqPluQP/7d/Vh
         4B5ie/LDS8ip9uUtbyeDUUB/i+qj7iezxAue5xncG6wbfJ0EWzA1lAL6EdX3HXtWTiPA
         UMdK5TVIyIMRfddFulnDoQioUZ6tBhpzOivuQCWq2D7GRcVjqPlblnX7cgqwn8Kd5cmX
         usgjRde6kR0JjnZEwBirWyuZcoq4SVLsMUQjvLZIzMoalfUI8cQ2zcfLXQNmaXGMfJ7A
         RtiPE/PofHoI8iDpGirUfeTiU+RulFKKZYrKMzMXNiazunfhMpvuvLm1IYaE0pK9vgKS
         zDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gVJq5TGX/OnvvTTdwI2mixCEJx6fZlK3ONdnyJ14z8=;
        b=CmPJxd1jgELwxptj03ze74ZHl1r71bN7fJzTfw1B6xQUaxQc2w6ahR5rwX8fAea2Qk
         CH0PZp3hS/sw4aNboBEqkC15jVJYkKJ06uxwZt8s9stfSCYkhwIxJhJnzZFs9Pw3PTIG
         7R2mzfr5XGQTJaZ39AwiKBbYThThxfKeTBhvNnX+vcvvQiUEmAviyukMRF3E5LjFiLoF
         QCyluFeLlJ/TWmVNhCllDUdsysKSpJKooXsnJ2X4gm0s+H2yAJglS2KO+wA3Jix9qC2p
         C00xH0Ro0/D99ocNUrAa0RCylHHMdGlJWqsLvjxqZaMsufZURB+/11aL6aS3iRJghZI+
         QGQg==
X-Gm-Message-State: AOAM531/y15F6LDS1scjfehaEbw3ffotw8mbOzrG3JlhvjvGptJbA5Xx
        idnrkZbFVneoAMp0E/1Ayofkbw==
X-Google-Smtp-Source: ABdhPJxwAPR8qFJLoKtyWu4QEI+/uSVUbzPZMgz4rIsj40RYxnBUmvnswC9Yy2WjetQOgtvIpNhNhw==
X-Received: by 2002:a17:90b:368e:: with SMTP id mj14mr1343700pjb.109.1605741962806;
        Wed, 18 Nov 2020 15:26:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id b80sm27076422pfb.40.2020.11.18.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:26:01 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:25:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com
Subject: Re: [PATCH v2 1/3] dir: change the scope of function
 'directory_exists_in_index()'
Message-ID: <20201118232557.GA3698950@google.com>
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
 <20201007074538.25891-2-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007074538.25891-2-shouryashukla.oo@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Oct 07, 2020 at 01:15:36PM +0530, Shourya Shukla wrote:
> 
> Change the scope of the function 'directory_exists_in_index()' as well
> as declare it in 'dir.h'.
> 
> Since the return type of the function is the enumerator 'exist_status',
> change its scope as well and declare it in 'dir.h'.

I don't have comments about the diff itself beyond what Junio mentioned
- it's very simple. But I do think this commit message needs a rewrite.

Your commit message summarizes the diff - which isn't useful, because
the diff itself is very simple. But what it fails to do is what I'm a
lot more interested in, reading this change: *why* do you want to make
this function and enum reusable? I think you mention it in the cover
letter, but it's not explained at all here.

Explaining the motivation in the cover letter also would help us
understand whether it is better to make the enum public, like your diff
proposes, or to wrap or change the function and avoid exposing the enum,
like you suggested in reply to Junio's comment.

Lastly, saying something like "This change is needed so that git commit
can sort ducks by feather length" helps avoid
https://en.wikipedia.org/wiki/XY_problem - that is, maybe we already
have another tool which is more appropriate, and which you missed; and
knowing your motivation, someone can point you in that direction
instead.

The same comment holds true for your patch 3, as well.

Thanks for your effort on this series.

 - Emily
