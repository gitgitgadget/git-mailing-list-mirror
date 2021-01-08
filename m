Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E20C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE18623A82
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbhAHSdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbhAHSdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:33:14 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6158BC061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:32:33 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e7so11196530ile.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GnhaWCTE6vnEB1bjtkHX0b5N4cAcpIhCtD99svOEwGQ=;
        b=dKuX77WQXj25mNrzKO3d8zAdHIxJ6/cTCoYRqF/KebVuKibtGWrOH4XcnqMAWiUv9B
         l9gW0UXuERoyW9gjjfjeMXlTs3xqgEsl3/ipWYS4oyr5CNy+NAIGm3Du/auUXryk8BiB
         gl9aMgdGtj6+v0GQEzP2g4B0uMaecgohR5TGPhyBiMUFtkeZBuO9BEPa5EPCm8dbOPvO
         CyYHVGTHVxAIiRSrn9thw/7+UxJUKbNLcjkBz6JGt1uGCqWJGWeP8BbHE0+S8bz4Q0bQ
         JyPevTouxN0bYqpPdkGkJ8duumo0IWBQs6htX2uO1//F0HEWS0WbWdeBvME42HcrmXte
         LR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GnhaWCTE6vnEB1bjtkHX0b5N4cAcpIhCtD99svOEwGQ=;
        b=rzB+V2xC25GeXG3CVgLkCXsRyrbyd8+WOe7xkKlMleA7cdzBGz9UqqZw9PUSe4BdO/
         6IKQag7bk9+hvQ6WLpQXNqJk5bU50ELXM3bUOk8ZG8N57vX+jHQxtrWF0BUBItI46Gar
         sPmTD2RgnCfmGN7rWByGUB3vW0Lb72K5rUJ55xOU1n4M9t6WnkBqofjcEJya1yycg4jV
         4it/0+I5SaNdakdkKW0PWyGfiQ/fGfJF2fG3A9rTyE6gB5db1l3eLTZfSlvOnFloj/eJ
         +xxfzE+NKFdw2CS4U34/0mI7zLKzDyNmdyZ6UQ79dhy4JiAxYfdaxHpDi4z2w88TLI8i
         KnUw==
X-Gm-Message-State: AOAM532+M/QUQyT2hy6BaqDIDFISyHLLc4acLEmLEuYNn1E23Frku3sx
        qrImuDaiO1q+/0H0hNa6BqkUCw==
X-Google-Smtp-Source: ABdhPJwJJyMK4JO/HASXFWFNkhUrO+8Fr+Bme7rZEPwE8cyRvOQoj2bN3AOdxleXWwVRNPN4R6nPDw==
X-Received: by 2002:a92:8419:: with SMTP id l25mr5005831ild.100.1610130752770;
        Fri, 08 Jan 2021 10:32:32 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id t14sm5802036iof.23.2021.01.08.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:32:32 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:32:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utku Gultopu <ugultopu@gmail.com>
Subject: Re: [PATCH] doc: remove "directory cache" from man pages
Message-ID: <X/ilPZ71woYI5vT+@nand.local>
References: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Utku,

On Fri, Jan 08, 2021 at 04:54:56PM +0000, Utku Gultopu via GitGitGadget wrote:
> From: Utku Gultopu <ugultopu@gmail.com>
>
> "directory cache" (or "directory cache index", "cache") are obsolete
> terms which have been superseded by "index". Keeping them in the
> documentation may be a source of confusion. This commit replaces
> them with the current term, "index", on man pages.

This patch looks good to me. There is another mention of the old-style
"directory cache" in the user manual (Documentation/user-manual.txt)
which could probably be removed:

    Note that in older documentation you may see the index called the
    "current directory cache" or just the "cache".  It has three important
    properties:

Thanks,
Taylor
