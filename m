Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB65C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078AC64F04
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhBXQ5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhBXQ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 11:56:54 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4AC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 08:56:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 204so2755677qke.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OgGfkI8W//pAloX7/4LjCHhE5H6igeENKuoHE3+AxFg=;
        b=A7Er8qvHWlAgOyFASnOYwEe5vmxQIf6KkQuGDz/xeN644/31YTf3BXdJ2Fi2zMKFPn
         mBuZESg8/TSxz8XQpq8P9wEZj6Xtp6LZmO0HGMwrZ1bqO3yMHL9+zYdVcJzxL44PGiID
         gig7yZ2j7qDLb+VTFUQ3o741wsv3MgtkQwJO1QGxJlorFc9GPTdj8G1gn2ZNwiTCkL7h
         TAtlJC8m9h7yPGqju1HA86Zh1INivUWoXyC0x3D2kQ0bRyzol7PASWetAy2AVVLbAmYd
         0mxXfseCrXftmL6+ir97VREuw/nrk2ztc5h6FQMPKgbRoWu8SZtT7Jslto3iUuTEHDfb
         mKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgGfkI8W//pAloX7/4LjCHhE5H6igeENKuoHE3+AxFg=;
        b=BW/yP00BlxZWobDZF+i8fv8QLghmqvZb9+XZtDhwkFctsJFI/GYxuhUnOiB++jGVEb
         FmxqLaSkJ9hvzHYrrFHRL7B24wtSD7Tk5jI2Leknfo1hdcCJcyGPquMSZjX+Ao7wZ1Cv
         t6TgSwOOqDuJX5BfSARSn2aCBJc/ORyovlt5ux9O8qz5UbAp8AaDnKRProbAMudDl3YF
         nRxtdNc86sLbeZgBcXEg6rJWMpj1eeRHa+M3xCtIAcEs3NUUusysJ+LiG6Wgl8aDMXvq
         UvcNTW2x5aZ/2l8IEDZoW1ytFk9LVm7VFykj6ica3XS/GoLSTYyR9cpPtZJ3BSxyQXCQ
         xPYw==
X-Gm-Message-State: AOAM532s+j0t4ZN0rjsl9TCL1gfcjfXgwmJDDk1s9VoaBTooKdI7wP8B
        5Zn8SGTRVhdB/ZrYT4iK8PrX/fQg9Z6ZWoqK
X-Google-Smtp-Source: ABdhPJy55V094YnPXgXHSYLZ/0sD7xYYpMVpv8zJD+emVHz6RJFijD7cSUVJZh9g79L+uQpQFIll4Q==
X-Received: by 2002:a37:c92:: with SMTP id 140mr2542085qkm.177.1614185771946;
        Wed, 24 Feb 2021 08:56:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id c7sm1650605qtm.60.2021.02.24.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:56:11 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:56:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] dir: fix malloc of root untracked_cache_dir
Message-ID: <YDaFKSLawYyWhg5x@nand.local>
References: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 02:31:57PM +0000, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use FLEX_ALLOC_STR() to allocate the `struct untracked_cache_dir`
> for the root directory.  Get rid of unsafe code that might fail to
> initialize the `name` field (if FLEX_ARRAY is not 1).  This will
> make it clear that we intend to have a structure with an empty
> string following it.

I had to read this patch message a few times over to make sure that I
wasn't missing something in the patch itself, but it looks all good to
me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
