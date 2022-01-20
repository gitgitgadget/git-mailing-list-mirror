Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444CC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbiATWSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347534AbiATWSu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:18:50 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD51CC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:18:49 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p7so8737880iod.2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOS7KK+Qj14RSMfqXwoMOo8ME83Bw/WGAA8x2wzwelE=;
        b=q16ukb6zN82t5eHMh6BdbGVs+pKLOxKB7IuPgLE+EVNJv5u1jeHpxHsspTtmsa1TPV
         l/uNiKBV9JCLTQV327nmm93dzU29GkxhN6CeyDdzN8oPDyixlkVskY+qFOeLZqGr2gPD
         NAqPeqC8hpB21ylo6sebjFxLX4lFlTZKQW9dycw7H9yHKCreWJwzYgJqkkvMdrARKgKt
         yVtBrEGnTMtBgCEEwWDxEUlUjWP9wg67Ml5+SNYm7ezCBkhq8t21RfLXDCPLCEVTnzhK
         eYH0kHT/SDFxFLwsRR0xCqDkEyrk7SJTPef9qxJOUAVWcfjTpSYRRseJgl5okS5nickT
         LS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOS7KK+Qj14RSMfqXwoMOo8ME83Bw/WGAA8x2wzwelE=;
        b=WbjYb/+7rxYAOFWaps0u65ucma/kCTIoeA39w26r5oSeU+zPqzmqpI4E2S1uMcPHcd
         A7+w2LfDyAIyqxpoo3+bIK1/tdlnOOwpmPSkvgCByk/LR123qaJB8z/dxa5IegLwdxSj
         xhN/p4OaE03uQ2VQVetle6xKYzRgnvd7rTwd834E5L4hE07hwRY3Pi52BAyZYCPbDfgD
         bEieI1wWEiKT2fkkbnu8fYMoSRe3lkbXN6JD9sHUmG488vsoVKhANS5YGzU1Gn6LvW2c
         5aLZH7Q24yr1cnd7hGp7Dxl1vJ6H3Cu12kAtcH50ZfUHNIDtHnOA7oIZjdt8weDoRvJQ
         g1lw==
X-Gm-Message-State: AOAM532K9AgSU/CrijfON5UI/RMfmg1ZbhghXxrWTuTfY6YF9+M6v9dW
        K0TNfqLjVDMuqKgQj2vYZv+VQfxcSDPFYQ==
X-Google-Smtp-Source: ABdhPJxc9ZPsezC/REJxfFh9wcYfrgbNLZmU3ksMnJaeCfN1yFzBc1bGpcC1ceIKteOlTX/9dfGnrA==
X-Received: by 2002:a02:a58b:: with SMTP id b11mr418628jam.308.1642717129335;
        Thu, 20 Jan 2022 14:18:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11sm1939089ilr.51.2022.01.20.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:18:49 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:18:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 3/9] pack-revindex.c: instrument loading on-disk
 reverse index
Message-ID: <YenfyK8wE5VXuHoo@nand.local>
References: <3279e2eb9b7bbfcc930e4ee146a3bd2476ef91eb.1641320129.git.me@ttaylorr.com>
 <20220120181545.3104404-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120181545.3104404-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 10:15:45AM -0800, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
> > source for the reverse index's data. But it will be useful for tests to
> > be able to determine whether the reverse index was loaded from the
> > separate .rev file, or from a chunk within the MIDX.
>
> As for this patch and all subsequent patches, we (at $DAYJOB) discussed
> during our Review Club the idea of not supporting .rev files altogether.
> Firstly, because of this bug, we cannot fully trust .rev files anymore.
> And even if we decided to trust it (or to trust it after some
> verification step that I can't think of), that file would only be useful
> for a short time until a regularly scheduled maintenance step
> regenerates the bitmaps anyway.

I assume that you're talking about MIDX .rev files here, not the usual
packfile ones which are only related in the sense that they follow the
same file format, but are otherwise distinct.

We could drop support for the MIDX .rev files, but I do not think it is
a very good idea. There are tagged versions of Git which have .rev files
out in the wild, so suddenly dropping support for them would mean that
existing repositories would no longer be able to read their multi-pack
bitmaps after upgrading to a version of Git which doesn't include
support for separate .rev files.

So there are some backwards compatibility concerns there, and I think
that that alone means we can't do it.

In order to maintain good test coverage of the soon-to-be deprecated
external MIDX .rev files, this patch series adds some additional testing
knobs to make sure that we're thoroughly exercising both cases.

It's somewhat unfortunate that we are stuck with on-disk .rev files for
MIDXs, since it opened the door for this bug to manifest itself. But I
am not comfortable getting rid of them at this point.

In any case, the .rev file's contents are moving to the MIDX, and by the
end of this series we do not write an external .rev file when creating a
multi-pack bitmap, so you are more than free to not trust any existing
.rev files anymore.

Thanks,
Taylor
