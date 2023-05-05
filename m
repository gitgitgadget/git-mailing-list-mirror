Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DCAC77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 18:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjEESqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEESqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 14:46:16 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999C203E8
        for <git@vger.kernel.org>; Fri,  5 May 2023 11:46:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a26b46003so31152487b3.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683312375; x=1685904375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxcEMFpGjwF21gmsm/HNMrDTPFHlUcyZREeJ3BG9iD4=;
        b=FIt+Pqp4TEEwjxgY2hxfZ/2TIbPJ8eEUAQqyWRatHg6Bqip4oPfUoMbn4mJdjb2czs
         jSmxlgFXD9TwhhUbhYX0CepK7ik37INdPQxlQgg8TOCSft80LyKLTpQpKtGDwN6JoABI
         kIuj3NN4vQAOdfVlnTUQgjlgiOzeP+kcA8XT1Gx6BPI11HMnJEIqg/pYGsXiFzTprXY4
         CNVmcNQb6ksxwEVsu1QTzk/PUiWRvnH9lm4sgpfE8LJzfRgqXysUR/6Ko0FLulo7JHtZ
         /ubgVrGYdHwqC80D03HUGzb5+RMDwrp974Q6fvSoXAWJN3+cGVnEj0lx6vOxlGnnl4EO
         CPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312375; x=1685904375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxcEMFpGjwF21gmsm/HNMrDTPFHlUcyZREeJ3BG9iD4=;
        b=WKsdYv95nkt42zcUZd/oyu+ImGu5OLNyw0sUpwL7IntzIH6cOKht11lc1/fsIcMTrD
         BSV8U8lW5IsP3sWlSxa8+69PubLdPEo6dqc8o6zPGu/FLsl9z7u1N5WJFmCtaPV5T4XA
         kihQdorDTIDbjCUc63RNbcr1fg1Vu/TaRcGOSz1Q0vUSnTT0YW+ZnRMWKyslxugp4N4M
         GIo19Jkm8g7mPW29VagjVVUyku+KbbHdt8bKfqYzH8yGSFjOJWxLhjb9lAm7beRdPsal
         6xH/b/4KKfEQlkXs41jhGDkyWhSxPdcQYxwzMW5yeNRCEY820WLKo/hWTIPJtsMbeDN2
         wfFw==
X-Gm-Message-State: AC+VfDxDfwezMsH4MSQ/hKfZwpPQl3NiM1anK6hl+DGIoHmAcrzseNJ/
        qS9nIZrP4JedHwmXFkHv8oUaZuME6xMCW525Sr9ZEA==
X-Google-Smtp-Source: ACHHUZ6KaMSidCfPs/v+EoW0PBExPZJasxoMUkeIKyxfMezP/Fx3z/UP9SHVugte2GY4l7rOqXdYtQ==
X-Received: by 2002:a0d:ddcd:0:b0:55a:501f:2a51 with SMTP id g196-20020a0dddcd000000b0055a501f2a51mr2852915ywe.22.1683312375218;
        Fri, 05 May 2023 11:46:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u187-20020a0debc4000000b0055a611ddb64sm642254ywe.37.2023.05.05.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:46:14 -0700 (PDT)
Date:   Fri, 5 May 2023 14:46:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] pack-bitmap: boundary-based bitmap traversalt
Message-ID: <ZFVO9kFZ+lr32WxY@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
 <6c8d9142-9013-f3f0-0619-b3780b86b6ab@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c8d9142-9013-f3f0-0619-b3780b86b6ab@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 01:59:31PM -0400, Derrick Stolee wrote:
> On 5/5/2023 1:27 PM, Taylor Blau wrote:
> > Here is a reroll of my series to implement a boundary-based bitmap
> > traversal algorithm that I worked on towards the end of 2021 with Peff.
> >
> > The algorithm is unchanged from the last version, but the implementation
> > has been made much more straightforward, thanks to a very helpful
> > suggestion from Stolee.
> >
> > Instead of hackily trying to write down all of the UNINTERESTING commits
> > between the tips and boundary within limit_list(), we can just perform a
> > commit-only walk, which will give us the set of commits that we need.
>
> Something that didn't seem to get attention in this version was buried
> deep in the commentary of my high-level review [1]:

Oops, sorry, I definitely missed this unintentionally and did not mean
to ignore it.

> > For these reasons, I'm surprised that this patch completely replaces
> > the old algorithm for the new one. I would prefer to see a config
> > option that enables this new algorithm. It would be safer to deploy
> > that way, too.
>
> I still think it would be nice to keep the two algorithms for at least
> a little while instead of completely removing the old one. Let's gather
> some more evidence and get more reps in with the new algorithm before
> making it the new default. I could imagine a scenario where someone
> really wants to spend the extra time to make sure none of the objects
> reachable from the UNINTERESTING commits are included in the output of
> this diff.
>
> [1] https://lore.kernel.org/git/a143150d-7cf5-c697-0e48-0f7af1c6de8f@github.com/

Hmm. I'm not opposed to keeping the old algorithm around, though I
wonder what the configuration option would look like here. I imagine
that we don't want to support the old algorithm indefinitely, though.

Perhaps something like `pack.useBoundaryBitmapTraversal` (implied by
`feature.experimental`), defaulting to "false", and then eventually
"true"?

Thanks,
Taylor
