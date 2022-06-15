Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 02:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbiFOC2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiFOC2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 22:28:45 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B224D9CF
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:28:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u8so7795210qvj.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zQTL1YFRCILY0ZCgM+u9rwC4ggVJ4wrpviJmD+HC+LQ=;
        b=iRQ0WesNyZSLLdNnzO23uAgb+wCCgy/V7QVVGqnl8bwDBHNJ3cIuMl/sXFb7ASijo5
         Hu0+M5UmfPzdIWp7UQy7X+q4i3C8Z3bl2o9cvKdWVX2jjcKhQflDdZR+MiapO0lDRlIN
         ydwBkk3hED5djK2wkjFPhoFujc+/F0t4X5plV8ncxYMFW6fF8W94OEIrrIvxCHYGcWjw
         qLhlee/Kvo3H8fjNM/hBvRe5vnkQ49ZBHC99KyJERnKQQcOsIRjOjgp0glRLF6LkFD6q
         BNtTerRgdGgFk62pNQVkUQ/dEzuEs3WrKRLgVl406UpYLOE9faskTzAT0rDcgzLzq3tf
         bcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zQTL1YFRCILY0ZCgM+u9rwC4ggVJ4wrpviJmD+HC+LQ=;
        b=V1dcL8Jvq87O8BhnuM1iTYVfK8t2HKjuKh3qf2Py3BVvpHPIxTrLbP36vkje4SpfnP
         mpOsNkoyT3gqh6gHZfplUYVPu52vnSLpOtsF9qPJeAh/Z4n9m8BrDi83phOHiYpu4Xff
         4EKmsjp2jzwRrKSY7erfIEZbE6/xwN5X0+pJuSR2Dpm82Dgnv24cMKm4SJJFtgO2jHYI
         ZX7t1JAFTR6aDhWHJ+rNaiOGDn5+lR2q4KAoyzaH3T92u6+73E3yATd4RhPgOVfUEIPp
         5wg3+P49TF3rNOzwmlYQO7ULQ+YJhSy+BqW/LsDdDcutYF8VnZHemQjnt3/1X6mDDCL8
         4Rhw==
X-Gm-Message-State: AJIora+IOvK1DhhYjmQHeib4iNlbKcZfU7NTFVHVcNH0A1VOjxeF8N7K
        jQO4hBXOnM1ynMnrxtgeLMkySVaig3GJkKg8
X-Google-Smtp-Source: AGRyM1vsfGYyxs3xA7QZ1BWBogSl0Y6joRBlX/jcP1HWPJNUW/NSxm3yxBqgPzzXKLKiDZowGieygw==
X-Received: by 2002:ad4:4ead:0:b0:464:57b8:ba8b with SMTP id ed13-20020ad44ead000000b0046457b8ba8bmr6162634qvb.38.1655260123920;
        Tue, 14 Jun 2022 19:28:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u63-20020ae9d842000000b006a6a4b43c01sm10643141qkf.38.2022.06.14.19.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:28:43 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:28:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 0/3] bitmap-format.txt: fix some formatting issues and
 include checksum info
Message-ID: <YqlD2qtwqmIKG9lo@nand.local>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
 <xmqq8rq4fo6p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rq4fo6p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 10:01:02AM -0700, Junio C Hamano wrote:
> "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > There are some issues in the bitmap-format html page. For example, some
> > nested lists are shown as top-level lists (e.g. [1]- Here
> > BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
> > top-level list). There is also a need of adding info about trailing checksum
> > in the docs.
>
> Quite honestly, I am not sure if a piecemeal "let's make
> <pre>...</pre> a bit prettier" is worth our time.  Especially
> relative to the importance of adding missing information to the
> documentation.
>
> So, if this round (I haven't looked at the formatting changes at all
> yet) turns out to be still not doing the HTML properly, I'd suggest
> shuffling the patches around, add missing information so that readers
> can get the corrections in text regardless of the rest of HTMLify
> effort.  We'll see.

This version of the series significantly improves the readability of the
generated HTML, and I only had a minor comment or two.

So I think that the improvement is worthwhile, though if others disagree
strongly, the third patch should get picked up regardless, since it
addresses a legitimate gap in our documentation.

Thanks,
Taylor
