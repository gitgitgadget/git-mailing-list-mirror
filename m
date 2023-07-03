Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804AFC001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGCRSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGCRSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:18:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB3137
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:18:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so4275404276.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688404688; x=1690996688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAjwmU9/uSuVe1GCPKqAhqeG+bQt3BW34KLBZc+5F80=;
        b=nhdiS8yuks1su1i627OFmflBCB37CAnafebcHOGIobpQ9GcgxQH6WRPddSMNPc1YgG
         MHbVmKw87yiV1eCmwbqvy/WBhi0rHICopk/vkWEvqq0o7QocsYftb9TbKEXaiLqboAuJ
         Pc95CeIxE2QCbW1EKIYp4YmKLeBkP5TxLc9AF7cbJkEaDFZxEJpAi5IFoJLNSrmMDYJ+
         mRFPb6ylsoTOUh7kgT/gqS6en/uYYC0yDdnNy3tmf+nedBoQ57QSUwniH0Pqc///suvS
         VycEtCXPM3/gLXJjXkAX/K97yXiLWC+vQTO1gS6VO2FyYn0aznEb0YTy4ToH9zKr+K2W
         JT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404688; x=1690996688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAjwmU9/uSuVe1GCPKqAhqeG+bQt3BW34KLBZc+5F80=;
        b=JNemVLv1+EUhseLlKrYi9Gwbn+D1Fe94DUITvBGZHtjyeLzmfEJDV+W+FFft2S1Wm4
         7wQHLJLG8uA0PkN690wPmL/9jrzp6R2g/rRLAKzSmJXkCBiF1QgbIXBMAMozZBUTwR5g
         E4wRRFc6r9tCHWWoi6A6vjoBLjS1G/wV+Kq1A9nUXO+oK9DZhTL9hWcTsBMD5TmmFtVq
         gu4f1V7OytCfpk1+WJplrbIcfKD541xY055WFPVOCKcuM5JEsXRSxC/W1lAI7o4E2fQT
         +DSD68TN3DFZIte13Ld2y3MiccfzqM/6fg2ZUdvFSDienrjnCIUelON5j8qYOWCnTbfr
         fGbw==
X-Gm-Message-State: ABy/qLY/SBy8wMadVZQoS0Ln0cZcI0bVt0NjiyVcvcW+CiW64+3NVvnX
        lODMxmK+68rRjuceXt/RkhXSBw/oOZW3FEwe/hKkfQ==
X-Google-Smtp-Source: APBJJlEy+bvjCI3vO3a/39QdtxCPiu8lzD35xC41WWOTZEX7zgmhJFcM1HaSQNkVawVKEFiLff9E6g==
X-Received: by 2002:a5b:4c3:0:b0:c1c:df23:44ef with SMTP id u3-20020a5b04c3000000b00c1cdf2344efmr9571518ybp.41.1688404688113;
        Mon, 03 Jul 2023 10:18:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g64-20020a25a4c6000000b00ba73c26f0d6sm4529008ybi.15.2023.07.03.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:18:07 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:18:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <ZKMCzow9EH2BJIfp@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
 <20230703052724.GE3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703052724.GE3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:27:24AM -0400, Jeff King wrote:
> On Tue, Jun 20, 2023 at 10:21:21AM -0400, Taylor Blau wrote:
>
> > Once we start passing either in, `match_pattern()` will have little to
> > do with a particular `struct ref_filter *` instance. To clarify this,
> > drop it from the argument list, and replace it with the only bit of the
> > `ref_filter` that we care about (`filter->ignore_case`).
>
> Makes sense, but...
>
> > @@ -2134,9 +2134,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
> >   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
> >   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
> >   */
> > -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> > +static int match_name_as_path(const struct ref_filter *filter,
> > +			      const char **pattern,
> > +			      const char *refname)
>
> ...wouldn't we then want to do the same for match_name_as_path()?

Yes, definitely :-). I'm not sure how I missed this, since the patch
message even says that `match_name_as_path()` gets the same treatment as
the other function.

But in any case, I obviously agree (and the diff below makes sense to
me). Applied.

> Also, I noticed that you declared it as "const int ignore_case" in
> match_pattern(). That's not wrong, but we usually do not bother (it is
> passed by value, so const-ness is irrelevant to the caller, and the
> compiler can see inside the function that the value is not changed and
> optimize appropriately).

Indeed :-).

Thanks,
Taylor
