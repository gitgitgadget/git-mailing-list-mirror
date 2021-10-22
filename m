Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A4C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BECE61A0C
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJVDqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhJVDqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:46:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB86C061243
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:44:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 75so2142781pga.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=30gPcvvO5aNR/eo8Kn5e1wRBZcRq7j+UzWookinnOdk=;
        b=Ou37Fiol5c1VkFnfjlYLYTwyQEKmW78amPk7S//7mXSZMxUam0T8z9FsDuIvmcgWnX
         seZO+ey2bSviEYxfYCb3Vlhf/0vhHkqZASwgo/aOahqfzuj2YvWIfVSOyWI+zj+s1HYt
         lVd8qeoX2wEBhufKtuNRkN+xxxjp9sbi3+dd+DUT+jJhMCz7lk69+MtXRmuxX1+gbQDc
         4UcS1Ea6FBo/ci0VFJK59eYfD6zo2s31vZQ/Dg9JEeQm+CbCJzS04Tiew4ldxi/FnaUB
         eBdxuaw3vNvF2d5HK7OXN3dLb8XrizT/FfHDdXylGrgxzkVXn65nBO9/N36/UhJnLih8
         AY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=30gPcvvO5aNR/eo8Kn5e1wRBZcRq7j+UzWookinnOdk=;
        b=iaaeXJfH++01ir70nLDfm5G9YeO9/lhQzypOgYlwC6qx8DDMkD6GwS5hXVXVw3Tw7G
         WHGVZKM2xD1WVOISqa+8iY4U6GHpby3VgHtZZNlb2PMNLueqkxfptIqcEhDA3ywsMVlh
         8AMOB4snXYB6CWQK//s16ltmlsHESODnU9xDjIWQbffJosBbTMVUa/X8vegdfVWzm/Vg
         1tdE8jg9NAskCyHGn4AWOIjf6g+xs/01HxPiUwucU6KX2Gi54GFATixldvM4DK5WKMp/
         jQcLm5uIflTH7puVOdV7JznSCH15YFxjHEwUi4OPu6s2LRdjDj778WzMFxdN/f0aooff
         ZEAg==
X-Gm-Message-State: AOAM531SffbKWIT8jwkgLJ4PnKCbM/XgDHswKZ/8+5PISL0NfSE1FCRG
        +w2q81b9B1/Oswv/V0oV+W9fjA==
X-Google-Smtp-Source: ABdhPJz2xM90jH+bj5/lrnBamUyRCmufBYzYcAtG3EEj4T69B64UOPGP7q3BvH3E48Xwq22jUiB5KA==
X-Received: by 2002:aa7:8752:0:b0:47b:a7a5:6aba with SMTP id g18-20020aa78752000000b0047ba7a56abamr3094884pfo.1.1634874255513;
        Thu, 21 Oct 2021 20:44:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id bf7sm7332268pjb.14.2021.10.21.20.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:44:14 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:44:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 00/10] progress: assert "global_progress" + test fixes
 / cleanup
Message-ID: <YXIzitjDUpJcFOcS@google.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:16AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This series fixes various issues in and related to progress.c, and
> adds a BUG() assertion for us not starting two progress bars at the
> same time. Those changes are needed for subsequent changes that do
> more interesting things with this new global progress bar.
> 
> This v3 hopefully addresses all the feedback on the v2, thanks
> all. Changes:
> 
>  * Fix a memory leak in 1/10, and make the progress tests use the
>    SANITIZE=leak test mode.
> 
>  * Simplified some of the test-progress.c code (no more "start"
>    handling, the "total" count is mandatory now.
> 
>  * Split out a formatting change into 2/10 to make 3/10 easier to
>    read.
> 
>  * A new 9/10 makes an ad-hoc test recipie in 10/10 easier to explain
>    (in response to Emily's comment).
> 
>  * The BUG() assertion in 10/10 now has a much better message, we dump
>    the title of the two progress bars in play if we have a bug where
>    we started two at the same time.

One thing I noticed (and so did SZEDER) was the addition of string_list
to the helper; I made a comment accordingly in the patch where it was
added. It kind of seemed like an oversight - but I remember you were
wanting to head in that direction (multiple progress bar support) so
maybe it was paving the way for that?

Anyways, with or without it the series looks OK to me in this round too.

 - Emily
