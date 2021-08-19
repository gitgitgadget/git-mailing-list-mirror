Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6692DC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ED66044F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhHSSDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhHSSDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:03:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B706C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:02:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e15so4366989plh.8
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=65gQPFWUNB4lGwFlkCbkfG0+E44qQ98B0RdTAGYyXao=;
        b=s6/8Zc/Vz3yIOLGTdSPtNWYSwDXbBDvILXsrbRb47OecD80KzWrKdy/zKX9Ej2fiYH
         mzECBmaRo5LzO7v6Ra190fOiLEDpra+6kVJlkjcKbiqjeJF+VxH2jirXqZch9Fq+Jjr2
         8jpmXpCrcXDALSdnshHFXlsjakOnqjL6e2u9uHzDx5IY7DxEMazivJYd1U5U6PS6KTl6
         eIBIJwM9E3+RVNghJt+oMt4B25UvcVbSskgxXwTOx4u0t1qkmOiJkLVVGOvmVPlP5fF9
         CzpF9TsfASWE6/0zJSomWDKixSW+WKP/S/rc/jGXaFVUV+Y+GNYMa3ELt/Vn0CIwfbsq
         KgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65gQPFWUNB4lGwFlkCbkfG0+E44qQ98B0RdTAGYyXao=;
        b=n0pTVxSDIEQbsKUZL8pr6ZSUR9O3blis+oJyKAfT2SP1IEYBB/ic0bI9ZknokSEe/r
         RwrRS2wGpe6xbCVrYJvOvGKqj3Xu2xSbmPm12W1Lb6DdNoviwHpGqdjn+ua4Cis/NWn2
         dq9+cZyYjlZA0QAlswYA2lG8LBaLC9NLl+OBvS4WhXZ0WYN6zM6b/+7DQtMNRf7/edUe
         Ngupl9jrpAf+N/M1wUjTk7bPa1awNARZdpZuR1cpJjBbhIibMnilMGVEB81TWXlFubh9
         qqWjw6gUFl7RE5ee/sSwFE0YWC1ShqLPjq4hqbmnY2rUianKg1Ntt1MtfxDCsTzAHJ3q
         nX2w==
X-Gm-Message-State: AOAM533jRa57D4/huxbFLrTEGj/VlSgyEzXjJbeRN8fw8HTVyAB60ckP
        /w09RdWb7irdNTqKrlFf5Y5bzQ==
X-Google-Smtp-Source: ABdhPJzvktesBhYkrdhwSmw7AxKtmX05EGhn/0GiM10p22+dJFFCMp8q+VaXhhkg4sPiDk+lh+tUsg==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr16107786pjg.101.1629396145530;
        Thu, 19 Aug 2021 11:02:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id o13sm99998pjq.7.2021.08.19.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:02:24 -0700 (PDT)
Date:   Thu, 19 Aug 2021 11:02:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] submodule: cache superproject gitdir during
 'update'
Message-ID: <YR6cqbGiPRXZ9GxU@google.com>
References: <20210616004508.87186-5-emilyshaffer@google.com>
 <20210727175151.2462983-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727175151.2462983-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 10:51:51AM -0700, Jonathan Tan wrote:
> 
> > A cached path to the superproject's gitdir might be added during 'git
> 
> [snip]
> 
> > +		# Cache a pointer to the superproject's gitdir. This may have
> 
> Patches 3 and 4 look good to me except that for me, a cache is something
> that lets us avoid an expensive computation. But as far as I know, we're
> not planning to perform the expensive computation in the absence of a
> cache. Maybe the word "record" would fit better.
> 
> This is nit-picky, though, and if others think that the word "cache"
> fits here, that's fine by me too.

Thanks. I switched the commit messages around to use 'record' and 'hint'
when appropriate instead. I'll send a reroll with those nits as soon as
it passes CI.

 - Emily
