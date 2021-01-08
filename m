Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC89C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E823A23AAA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbhAHTxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbhAHTxb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:53:31 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB8C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 11:52:51 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id y15so7399273qtv.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pe9tNNZr/SZ7FeGewoVi/QLDSVtJn7TZLSGgj6CEdoI=;
        b=PCAK3Gwtb559c18Y6AyY3IzD++rZonKLneKiwrPqySuK6pHDVHC+3YBHy57AUXzNzg
         BWhEliiZQHw5l+Dny2vR+6avNph68nJ+5McGwz/vg9jaL7vhdx9TU/rH77umYnR/Jr1K
         WrWu7CB8X9r0JpwMJCfPOaKWgkdtlHhyooBT5WitOrEUV4HsysWapdkL2YeZUT1BspsQ
         bliT2pd1aFQ5zG633E+F8VVgslEfeEQqVhB5UOncAGYPOvL1JYX3vIxSNrJHv/+K29Sj
         wsL787MXArcxAZz5EqZZIE3lodeEZf+JhCgtJ2wKxXt8NmCBDtX/7RuZBgaD/Id+fuyA
         oozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pe9tNNZr/SZ7FeGewoVi/QLDSVtJn7TZLSGgj6CEdoI=;
        b=gfVcF8lM3Z+btOnY5793IZaUIumycK4f9LvXH8y8wsqhtnzX9kiwgpBSDGGPYTExSu
         inOuLDwBGrqSPU3cj0Gr7PLwB15OdFHat7KAguElBumF18jiz53mwU1aFuDiPmRcvKk7
         qgmSPL8oSpMRutHHnLlWw1UrWLemAtSl9B4JFPNLLsptO+aEcdcMEnqD0jorrQU22REw
         oBT3Xw3fRYwqXs5mCZP/y5hAlOPOeu8XDGRoqX0Ca2wdA225GDeNxx90w96WgjciawQG
         S7pBThFllB6wKTUukb2GrEk+NEhRKo4h6E7g21w933s8LSwlNqahYyUGSPPv4Edw+X4M
         Dqxg==
X-Gm-Message-State: AOAM533OrG8VLrAkc1V7fpGl6vbDzryaC19LlXxcStj2HZHGMv/Hu+QY
        iH57DesrOnropZiXa59yO52VfQ==
X-Google-Smtp-Source: ABdhPJw3+MFiOVzMQ32zMCMlk9zsKjWyQyQ1dU6Xsce4J4m5q/SCfhQW8E2LMRT4XB8uTeb36E3wgA==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr5020852qtq.214.1610135570824;
        Fri, 08 Jan 2021 11:52:50 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id l1sm4977956qtb.42.2021.01.08.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:52:50 -0800 (PST)
Date:   Fri, 8 Jan 2021 14:52:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Utku <ugultopu@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: remove "directory cache" from man pages
Message-ID: <X/i4EMmpCzFVtDiT@nand.local>
References: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
 <X/ilPZ71woYI5vT+@nand.local>
 <EB7BB287-A18B-45FE-B147-F3CF92FE3114@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EB7BB287-A18B-45FE-B147-F3CF92FE3114@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 02:51:05PM -0500, Utku wrote:
> On the other hand, the document clearly states that the terms "directory
> cache" and "cache" have been obsoleted by "index", so there is no source
> of confusion there. On the man pages, there was, which was the reason I
> felt the need to make this change. I thought that keeping at least one
> definition of "directory cache" (where this definition clearly states
> that it is an obsolete term for "index") would be helpful.
>
> So what are your thoughts about it? If you think it is better to remove
> it, please let me know and I will remove it.

I think that is a good reason to leave it as-is. Since you hadn't
mentioned it in the patch text, I was wondering whether it was an
omission, or you had intended to leave it that way.

This patch looks good to me as-is.

Thanks,
Taylor
