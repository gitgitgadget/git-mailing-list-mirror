Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A35C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3C260F12
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhIAC4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhIAC4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:56:16 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD52C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:55:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x5so1894705ill.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpHtluw7PP0JPCZSHCoUPKGKe9ankQD47mT0JXq7HJY=;
        b=EkQxTGJLtvqmzqzUIjw+0PoaHr04DTds+WDQpSjYhUiOfyXAmB7tuh2D8zTajgzzhg
         qNXeKROyf0bCgOzwijEVt0TdpwwT9dowEYqF6o7aIYDJv7wPtl2jqKSAnCuBJELzCw8K
         /IuILevXVVOiHudjpNvF4Qp9jAgXwlnreylSWf3zIeKA0Xd/pijziKWb6zGmRMLe4sNv
         rnzdOt7qcSfA+86SkcjPG0wacHRjmJp+B5qMTb6gWaZP1hFtuEFH3Sl0ceBRKQC+i55w
         o+zwOKq7ccFHVqXUWksruV1QU1/FGofZPKib1Gcrc/42w7mcB5+NvP6GxKujnLzt052Y
         lGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpHtluw7PP0JPCZSHCoUPKGKe9ankQD47mT0JXq7HJY=;
        b=sAnlDEZuMlLSIMpY5dTgP72Tr2o1cA/nijw+bOLKLAjyfakdFealsP/+EXnibU3nTt
         CLfdnqZCmfy1Zo0Dk8frluZ9O0Kz3fvTkOy/NjbFcFCmuXD7aYFxGqJafYoBVEMjsVo1
         5y1K4RhsQWRTdDQ5K+HSJvTt3owkKNUI2BEz+ZWsJnQogGlm1wlbgrSaE21moDiFhhDJ
         5r0qjkfFNhCaunrAdj5K9XwFTnuupIcnb/O5I06KcKzLq7hG3qry1pkf0+VIx8Ihnzwh
         cIEF2djOxGfpoc9ZX43PF5wPc/+GseA+y3YMTs9D25XcezG24nby4Nokd05ggP6+d9II
         2i0w==
X-Gm-Message-State: AOAM530uWXn8FXt5djHZA8MK6WuSpjo/x2UEmVjSEGg8lBDbuk+z1VRk
        ZTMxulKLfr6sPS7GxJmC7meULn22F6WTNaVH
X-Google-Smtp-Source: ABdhPJzWY72o0Nvg4N5GzdYLlhevAqpIUNI4h8V5vmeK4EhpDZdYx6gxy8x986n1JKQILuBXq34gHg==
X-Received: by 2002:a92:6a06:: with SMTP id f6mr21584735ilc.16.1630464920318;
        Tue, 31 Aug 2021 19:55:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p7sm11144654iln.70.2021.08.31.19.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:55:20 -0700 (PDT)
Date:   Tue, 31 Aug 2021 22:55:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Message-ID: <YS7rl8ynKD0fAerG@nand.local>
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
 <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 01:14:55PM -0700, Elijah Newren wrote:
> > Now I have spent zero time looking into actually coding this, so it may
> > turn out to be much trickier than I am suggesting. But this seems like a
> > much more fruitful direction, where we can protect users in cases where
> > they benefit (and give them sensible and actionable error messages),
> > without bothering people in the majority of cases where their cwd
> > doesn't go away.
>
> Ooh, this sounds intriguing to me...but what if we changed that rule
> slightly and just decided to never make the cwd go away?  Currently,
> the checkout code removes directories if they have no tracked or
> untracked or ignored files left, i.e. if they're empty.  What if we
> decide to only have remove_scheduled_dirs() remove directories that
> are empty AND they are not the current working directory?

Hmm. My first thought after reading this is that it would cause
surprising behavior for anybody who had 'git add --all' in their 'rebase
-x' script. But would it?

I.e., imagine somebody doing an in-place sed in a rebase and then `git
add --all`-ing the result at each point in history. If the directory
they were in ever went away, then the *next* revision would add that
directory right back.

That behavior seems somewhat surprising to me, or at least I could
imagine it being surprising to users.

Another thought is what should happen when the current directory goes
away and then comes back as a file? We wouldn't be able to checkout that
file, I don't think, so it might be a dead end.

Thanks,
Taylor
