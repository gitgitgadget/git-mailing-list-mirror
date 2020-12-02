Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E17C64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAF7221E9
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgLBQgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbgLBQgc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:36:32 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A0C061A4E
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 08:35:37 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so1261065pjb.4
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SGWo4vbYhAFdSecMkrAM+rLNnl0nHddCQAT+AJ/IrkU=;
        b=1IPozY24E+uT1Da/UF3DN3yeUQRIYbdneJbzOwpkQXa9wpKyMIOTAoGHJN8DTmliVJ
         uz9em5GMyXA4rdulLimBeOInVLNblpkYRD2GJ2eC7sGvOVrZWgOZWhBnl2YLf9fvKFKG
         kU8xjOPt9FUHp4rrk3GNQZA00WC6DFkjZZlQmvLd2TrFV/XOLXpvS4+Du7nq3eNCvRGY
         8ycZta9uapivh96bRDUuGbZF58WoaGo8psOzCSwiaryrcDjE1ggpuFBI2cKatJMvyP9G
         Wj9rzSDIetZsIgqa7UF297up+Ngbwrk4HDSrQgQHaVDQJjScM+hmMur7GwxqI2hWZJcA
         6g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGWo4vbYhAFdSecMkrAM+rLNnl0nHddCQAT+AJ/IrkU=;
        b=ng5ZAQnRxjkbKDy0RVY+cyMDT4sDqayaU6fbIwChGu9ikQ61arKVZB4BUOQsSF3isj
         M26SfDS/bj7d+fMiaW24Xji3gXvyqR3k0lDoG+jienhWshLHtDVjeDrSVfvfshd36eme
         /IGJf68x9fGDNAYyVGZg4IbXVfGDqk6m8o+RPzVU6t3updFu80jlV8KBRI6FHCW15iLP
         o1BpyGHkRYztL9A+vkgUnGtm3ZMaHFdCUJ0XIwonjrlE2uNVoiEu7NkLlNKub0l2Fo2P
         jzM9tb1kvrwR7pOJ6aUkiy6wJBoT7ktdzY+Eyp8gQjYC7nED3C2smIkqDyS+B+zFKruc
         fORQ==
X-Gm-Message-State: AOAM533JwvSV9rjUiOTUJHP4x1aoES9REIsdaJSEbmJPWE2qIAKrYfFm
        4Rfx6UGpRHG9MhOFWaE/2LPBhw==
X-Google-Smtp-Source: ABdhPJw72qmU8uic70FWLyOwk9//4/Bp4RZyKGi06zPjvPumqmWrsvJbh+cUx/IAz0lFDjbrp4WRdQ==
X-Received: by 2002:a17:902:a415:b029:d9:ef8:afa1 with SMTP id p21-20020a170902a415b02900d90ef8afa1mr3256016plq.66.1606926937221;
        Wed, 02 Dec 2020 08:35:37 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a16sm311531pfl.125.2020.12.02.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:35:36 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:35:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
Message-ID: <X8fCViBtnDek6oAI@nand.local>
References: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
 <20201202080808.3482917-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202080808.3482917-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 02, 2020 at 12:08:08AM -0800, Jonathan Tan wrote:
> > +			c_ent->maximal = 1;
> > +			p = NULL;
>
> Here, we're setting maximal without also setting a bit in this commit's
> commit_mask. This is fine because we're not propagating this commit's
> commit_mask to any parents (we're not continuing the walk from this
> commit), but it seems like a code smell. Suggested fix is below.
>
> > +		}
> > +
> >  		if (c_ent->maximal) {
> >  			num_maximal++;
> >  			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
> >  			bb->commits[bb->commits_nr++] = commit;
> >  		}
>
> As far as I can tell, this means that this commit occupies a bit
> position in the commit mask that it doesn't need. Could this go into a
> separate list instead, to be appended to bb->commits at the very end?
>
> We could even skip the whole maximal stuff (for commits with existing
> bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
> we're going to append to bb->commits at the very end". That has the
> advantage of not having to redefine "maximal".

Hmm. I'd trust Stolee's opinion over mine here, so I'll be curious what
he has to say.

> >
> > +		if (!c_ent->commit_mask)
> > +			continue;
>
> I think this should be moved as far up as possible (right after
> the call to bb_data_at()) and commented, something like:
>
>   If there is no commit_mask, there is no reason to iterate over this
>   commit; it is not selected (if it were, it would not have a blank
>   commit mask) and all its children have existing bitmaps (see the
>   comment starting with "This commit has an existing bitmap" below), so
>   it does not contribute anything to the final bitmap file or its
>   descendants.

Good suggestion, thanks.

Thanks,
Taylor
