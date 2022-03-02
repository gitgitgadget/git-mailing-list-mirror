Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiCBX7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCBX7N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:59:13 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A845D648
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:58:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s15so3220820qtk.10
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e5wQrAfek/p82DAlMLvTvPmOi0zWUjpQsn7qt5hDdWs=;
        b=U4FdXlEwaIcxoOvlGHRH7xhCm0iCnS0AjQ7xhSiu3mzGpHkgcnsx7VZ9MXQwghamLF
         bE5gXjCY/KkNhYViWIsQGJd/GElt+U5yqTiFIysd17JQ26dQm81o9edXFjS41zM1ecod
         TiFtyFPixZnnPovIqS3LBjhYydCKiqFebZLB1p0NYBB/O3Tvn11RNXF4KhMFn2mgWe2C
         Vr+cSQJqlGMrV6VIZIuyDQ+qaHdTQF0OrrFADyUyB74Eji1L8IRAIbvhMpBnFRKpMbbd
         jxJFzD5TNhe0hLfdcUoSWM49BAtJ5dErM4Y3rLwutwvN8X5gdSblcsAnTHLgC4FC8/9L
         ywRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5wQrAfek/p82DAlMLvTvPmOi0zWUjpQsn7qt5hDdWs=;
        b=Sjy8YRkuR9yytB1F1OAjEFGhE89HVjIfb1kxr+zrG/0iY9HeSaJijL3alSKWuILdTO
         NqAGWzl5nQN0ektRXrpqMjvQHQ9IxEFJwWbZ+DggahExVXJCi3rMvevaTuyVYb6OoT3M
         OGhUgrnW+RilCFloviDHTRPfY22Im/uS7jccPhPdyVPFFsWhc7Z1rASlN4iDaQsp20gx
         621ErsfXHGJEo6cDGoX61RivKFNsoEHWauiiz1lNJ5Ev3KlPlOqMJ79P9aoGAu4LRUko
         OJbQSbA/+En7iETpMf6KXQcNNJguxGnilHjl8zlha06LnDyRuKRb9E0nCEtYwmyvx9LY
         VY2A==
X-Gm-Message-State: AOAM533VapcVmTAcg6zYfg+G9yVA1pWrRgzxYz0UzcQtTYkJHJ+4/3+m
        862Pso1sE/m0SOVC7uJBEXRjukxtfuDCxm7T
X-Google-Smtp-Source: ABdhPJwglr5D1D80WwpoSVk83aV//0HZfTCkkkbsGcT1XOtKEnlfpdZyoXg2CZb+S4zAsH80dPmpMA==
X-Received: by 2002:a02:a797:0:b0:314:c435:12fd with SMTP id e23-20020a02a797000000b00314c43512fdmr25601178jaj.190.1646261823115;
        Wed, 02 Mar 2022 14:57:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4-20020a92b504000000b002c21ef70a81sm243989ile.7.2022.03.02.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:57:02 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:57:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <Yh/2Pkc493ABWv46@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <Yh/t3HfKiEMx957i@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh/t3HfKiEMx957i@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 10:21:16PM +0000, brian m. carlson wrote:
> For context, I discovered this when I tried to rename a remote with tens
> of thousands of branches and it just ran silently for an extended period
> of time without any output.  I actually interrupted it with Ctrl-C
> because I thought it had hung, so I'm hoping this will provide a better
> experience for users in that situation.

Thanks again for pointing it out to me. To be honest, I'm skeptical that
this patch alone will improve things much, since you still have to pass
the '-v' flag to see the new progress meter.

But perhaps users who suspect the command is hung will re-run it with
the '-v' flag instinctually and get more helpful output. I'll look at
making `git remote`'s `-v` behave a little more like `--[no-]progress'
in another series.

Thanks,
Taylor
