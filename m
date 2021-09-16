Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54982C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4FE6113E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhIPFob (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhIPFoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:44:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BFC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:43:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b7so6524752iob.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ocDMXb+JBiYJQ5ezb04lvEQt3iLi3otv+xhn3vdUaKM=;
        b=lUZ1sziVzP3Wk3bxfeyt/xGQeUV4LULUGiWn+q36wKaIvwkPD4/G4za7CRYX41kXyb
         GOfp4xosQJ29CaoVVH88iyxY/Csuma5HSYTdb5uyok4lx1kSBM+L9bWQk07xgjshUHOG
         jCh/B66ydP0gvs/oD5bjaLCQSAGTlet3MssRr3Ed6Jniur6b3c0ZuMKgBRjQREY9YmOl
         0BraIjZzlJ0xM4bYKVVqjxJb5RfDXOLmiyDfsVzCCVKowvlCF91IJvKu3E4TE3FHhBPF
         JJqGfg8jv+Tv3Mf+hf/kjjc5PFS5bvjSd5mZOpKoATsSmQX7CsAS6e9FlgZZrDubaSiG
         8xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ocDMXb+JBiYJQ5ezb04lvEQt3iLi3otv+xhn3vdUaKM=;
        b=IGOK8tMtp0fak7Ditr2ADW+zkOSnaE41/4O6iM3Ozv83O0YOpN1VrtkveG6BpTueCq
         YTiZ/hpbosoRWlcCsuzLLRw5Y0NjJT88BIHbACN2oZmO5e8dTKttZH9qUvLbkt/3yqTG
         ni58DRs5fugrc9QgLpBNcBTAYwwYPTDX7CX8XxGUnF46uCuY/OZhoUI1zRs0q/lNpg+Z
         FehGk1UDvTcq3YzL05FRanhySphLK7r5MyrcIwY1TK8HKPI/44YeEJC36HlUQqniZ1Km
         Hj1xpTN7+jHxSO2pLEDSWIWlOqKVDeDGrhkxleNKiLEiRaE2fC9PJdqMpABc7cf3/xYU
         H6nQ==
X-Gm-Message-State: AOAM530ivHzOlMmHTyqgz6Jjv8kn4ohirkJn2Z1LQvh9qtHcIU43l+1n
        YOMBbujvl5hP2LwrV/MupW0uIw==
X-Google-Smtp-Source: ABdhPJzEnTO+7gp3eBcBhuyEa0LWj0o9OwfimyV3b+ZR3N1BWetol3/d7bA5NxOdZU0Wbj47KLX80g==
X-Received: by 2002:a05:6638:3813:: with SMTP id i19mr3024932jav.16.1631770990041;
        Wed, 15 Sep 2021 22:43:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x21sm1083101ioh.55.2021.09.15.22.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:43:09 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:43:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
Message-ID: <YULZbQgxuyw8iJ/R@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
 <87fsu5m649.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsu5m649.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 07:35:59AM +0200, Ævar Arnfjörð Bjarmason wrote:
> So I think this patch can be dropped from this series, since it's exact
> duplicate of my 48f68715b14 (tr2: stop leaking "thread_name" memory,
> 2021-08-27) in ab/tr2-leaks-and-fixes, currently in "next" and marked
> for a merge with master.

I agree it can be dropped.

> When submitting a series that depends on another one it's best to rebase
> it on top of it & indicate it as such in the cover letter, Junio can
> queue such a series on top of another one.
>
> In this case I'm still not sure why this fix is here, i.e. surely
> nothing later in the series absolutely needs this stray memory leak
> fix...

But there's no need for Jeff to depend on your branch, since (as you
mentioned) this cleanup isn't relevant for anything else in this series,
which is a sort of grab-bag of miscellaneous clean-ups.

Thanks,
Taylor
