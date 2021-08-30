Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1DC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8926860FED
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhH3WnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhH3WnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 18:43:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB389C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 15:42:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so34398014lfa.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dAo/6DM5rad5W9zBL76dpDStKmiKfw2+9xB3ymYFhOI=;
        b=JR+bnW1ezM0dnj3VTqdXLNDebx/GvIAOFmjm2gJaMG8/80UEZrVIj1EickzMBC30vI
         qe8KYAqaUXx4pSJWEklsV5l08mHfZKeqaO/VDEJFb3emGLtgvEdX6EuWBL+u0aSRD1O7
         rr+2E7Zjt2gBc+u5RIUrJ+KMk8MNtq8WHp5n9D9sg1nPjvX0gGQK0aaWvwJjL+t4orC5
         pnfMAMyThXSJVUTcFqTMBMYY/Ew3YJqAVaBuO/Xo30ERGA62hNB6bCF+dyEF44i8j5mx
         NI3MqZuyGVZb8K+dcHQjyrBcApwVXzwiZNW5xbGYtBO3jgog8R2EeQyCbHlW08o9E1u5
         wUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dAo/6DM5rad5W9zBL76dpDStKmiKfw2+9xB3ymYFhOI=;
        b=sk/fs/vT1hwyW43fPY/V3pcFnUR0vBQBGcIUwOARKJRI8vUFs+CEqXzxc+842OByOz
         rKiC6Dg95CxJ1kcYe5/tM0vE9dK+nrba1EmPZIXXXr9g5woR5484CU7rc9y/y2tzSXRy
         hFPwdDQmxXwFXYRNCC/3qvxunPY8i5UJAG5ofszeC5kxKViLmfqSwo7w3Wr5xqVzccfi
         o6ftX2uS36uksAnM5GFzPFqHRpdIUdR3DQmtwD6dFOL/fANww4TSqz0kMEhkXX6x3d3w
         fimVsiEXhWhDqszDLm5kAs0mSy95Lod1EeGwWZPIyE020UYbkQHofj4Vn2+2+93QH2cS
         K0Jw==
X-Gm-Message-State: AOAM531lgne8sbHQppMKtgj4ww0vDqgc8rFBignrfcyqeFr/6hKm3IKy
        lsa0mTIPd2H0CAVvwY2XZi5n+pVzi4jr/A==
X-Google-Smtp-Source: ABdhPJwBz3cG0BDv/EkxNE6IzVCDWnhzPShd88u4wFw/08+iTCEv6D8mHNOKOxXjx58OKp6fbxJ/mw==
X-Received: by 2002:a19:48d5:: with SMTP id v204mr17465748lfa.70.1630363337143;
        Mon, 30 Aug 2021 15:42:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bu1sm1516654lfb.306.2021.08.30.15.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 15:42:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B4926102EF9; Tue, 31 Aug 2021 01:42:15 +0300 (+03)
Date:   Tue, 31 Aug 2021 01:42:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830224215.hay6rjbt3vk26nk5@box>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
 <20210830182845.pnv7ywnc364jnblt@box>
 <YS1Bni+QuZBOgkUI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS1Bni+QuZBOgkUI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 04:37:50PM -0400, Jeff King wrote:
> I am sympathetic that this used to work, and now doesn't. But this proxy
> case is affected by the problem that ae1a7eefff was solving. The root of
> the issue is just that "socat" in its default form is not doing the
> right thing. So I'd prefer not to try to make any change to Git's
> behavior here.

As a kernel developer I learned hard way that breaking user experience by
kernel changes considered a kernel regression, even if userspace "does it
wrong"™. I'm not sure what standard of care for Git users is.

I'm fine adjusting the proxy script and make my colleagues aware about the
issue, but the approach doesn't scale.

> But one option would be to limit it only to ssh, and not
> git:// proxies (we already don't do that half-duplex shutdown for raw
> TCP git://, for reasons discussed in that commit message).

I wounder if it's possible to detect the situation, warn the user that
gitproxy has to be fixed and retry fetching pack without closing fd[1].

-- 
 Kirill A. Shutemov
