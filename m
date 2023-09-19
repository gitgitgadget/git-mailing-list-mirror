Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AECBCE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjISSWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISSV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:21:59 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938290
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:21:54 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59bdb3d03b1so59740367b3.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695147713; x=1695752513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyrZFcSGaiBmXOJVPg7QGiC+jnVnfH2S1ZA2OWC1yGw=;
        b=qQX0fleo1Z1hfCu3z2yfSdnswgxqwIW7Wmfp9uE3FbHses9JJhOVdeHZq5LIIzocYh
         ZxyEwaBym3z8Wh2oLOSqVi1s+Hfu/PVu7cdBXHjQkdIo/w4l1WZN+TLVCXLR2ER8IwD8
         ctkQlhaJVj86rm3YwBioDS8THVb6WqBGuvpXuUw85Vz7UUfjnpUz/Cp0HXT8XeboRriI
         tTg+R3S0SJIUPRV6AUeZzpjstyy2MrIcZ7aGpizCOc6hbrQErUoo2NZsMX5q9scMlvak
         l8bAn38IyGyKcIrty9zlZEtrHYHxPasFNq8w6dcy+xfFiYhaiMGlInrX4/frUNMXRLjt
         Epew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147713; x=1695752513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyrZFcSGaiBmXOJVPg7QGiC+jnVnfH2S1ZA2OWC1yGw=;
        b=hKsFY3zMX3borOD66J74Hs+0f3uxhsANvqQVyb490OBLirCKe0aGK52195MgZ6GJ0i
         zfaCHL57zrv+2rs68euqA3fdajo7m1oN2CaKwtzgzbK8zPcW7wuQ6FfQjO9HUTqruaIP
         SYGIkaRZsry7/Jjw6EzW/aI5tcylHvpdMe/rTLDOVm9HjmjQ5+Ko5CjM/HiMBCL3MJql
         HSWsHk2Lx1cD7IEeY9OMUR84t+R9h2julldM9pGkghTSaQpDRBok9mfFAOLXrcxgoLyN
         sQY3sGe3bGwz5i0nmEmsPp7zYcgfyjyl8W2D+d7qvkfUNpT8mAFxCRpng50hccI4yhuN
         Gh2A==
X-Gm-Message-State: AOJu0YxjIg8EuX0EGeZPvaytKVQNpJrWzCIzh6RgE937vzSzbaIgGk38
        eCvSt/MWiDd8u19BFd+4p2yBxA==
X-Google-Smtp-Source: AGHT+IHuV6cwxH14UI9JalhKZCijbQH2TYPQSjVb0xMW1TO7xd6gDO+GDqnCzFTv9Y7dJUqY+d7ihg==
X-Received: by 2002:a81:4f86:0:b0:56d:3b91:7e76 with SMTP id d128-20020a814f86000000b0056d3b917e76mr294274ywb.12.1695147713548;
        Tue, 19 Sep 2023 11:21:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i130-20020a815488000000b0054f50f71834sm3334559ywb.124.2023.09.19.11.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:21:53 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:21:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, derrickstolee@github.com
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <ZQnmwID4PNlB5ME0@nand.local>
References: <20230911223157.446269-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911223157.446269-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 03:31:56PM -0700, Jonathan Tan wrote:
> SZEDER Gábor suggested [2] that we change the revision walk to read
> changed path filters also for root commits, but I don't think that's
> possible - we have to tie reading changed path filters to when we read
> trees, and right now, we don't seem to read trees when evaluating root
> commits (rev_compare_tree() in revision.c is in the only code path that
> uses changed path filters, and it itself is only called per-parent and
> thus not called for root commits). The alternative is to not generate
> changed path filters for root commits (or what I did in this patch,
> which is to generate an all-1 filter), which seems reasonable to me.

I think between the two, the all-1's filter is the more sensible choice,
since not computing a filter is typically reserved for blowing past the
`commitGraph.maxNewFilters` setting.

But, I agree with Gábor down-thread that we could instead teach
`rev_same_tree_as_empty()` to be aware of Bloom filters, which I think
would accomplish our goal of reading Bloom filters at the root commit
while not having to tweak their generation.

Thanks,
Taylor
