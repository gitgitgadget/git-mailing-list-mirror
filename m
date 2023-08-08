Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0356C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjHHUhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjHHUhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:37:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470364F1F3
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:04:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso6467861276.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691525061; x=1692129861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXtNL6jYzhcInX0FJyufL4pvgOZVe2k576NjU0PvokU=;
        b=kc1CI66pQNLM3Uf0ZyhMdpTfHk5JuoG5SjtnhKmBoFwOuVzP6Cn51HzsrhBRbvG817
         ijpI47GeFLW/XEMLYIkN+5dIBmAchpm7okjSFWb7ULnyC/dl7fFvnNdGxoZQXQwEfkXZ
         pgLaQmnkZ2fN6Q8cFiJ1PBb1HVv7uCBMjO8eaNitKUsKhK/bcrMKmfWN/pOKqZWZmztT
         3GUSVlf69uflA8Olj9UWxeI59RqC3mzsp3fG96EOuLmsv22eivGRXAXde0CuaKDR41B0
         bNaNwlnxCOYBdaHWgI+wcb25KWv4LNjAwunaqVaZCMTBsXrXx9zAtXkQllVp4P/L466W
         CyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525061; x=1692129861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXtNL6jYzhcInX0FJyufL4pvgOZVe2k576NjU0PvokU=;
        b=G5bPQfDhXiJqs68i6bOSQjuauB8JAoNExBZZVqwsiYPgY1yGlk9rivrpHsCCRUPaQ+
         W1AA/yXLwSXMTlkJ8aUjG2kgT+zxuBqmr5/CHN6hh+7evdvglj0jxsj/w0Z4928T142E
         0VIMJywNy/TPD+0/npDQfEoTjJl7zBIDEBI6/NIsC0QkqsLFVwhF2XJSVPUZtZUoZARl
         GpNhuCfsI5vIVXQLp0AiROc0Eih6WZZ9T2nordhFvFDItYs2d0W4bhLoBfh6OsbxxFOe
         Z8VVbOqT6g9XeqZLJGxOXMJbLzrZCjdtIGL5NGGYggYOlI76Y6rUcPUdmNvzZ0aVPInQ
         qCWA==
X-Gm-Message-State: AOJu0YwcMMcOhFcF5tHwSnMwejCG2C5rWETaKCXTQ/41LIwQc4+qq8Nf
        TRiRTD70OLK/omtZP+lqOv9Mhg==
X-Google-Smtp-Source: AGHT+IEa/w/mQPdA7lF4nR5QIi2XVZsNlfxI42Ts7pMb6NP9WLd8YQc1Sy7S2w09hbabhKJ0HYYAPg==
X-Received: by 2002:a25:41cf:0:b0:cfd:58aa:b36e with SMTP id o198-20020a2541cf000000b00cfd58aab36emr558977yba.9.1691525061472;
        Tue, 08 Aug 2023 13:04:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j11-20020a5b030b000000b00bcd91bb300esm2873520ybp.54.2023.08.08.13.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:04:21 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:04:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Message-ID: <ZNKfxOWJAuJ5DxAN@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
 <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 01:28:50PM -0400, Derrick Stolee wrote:
> > So I think this is kind of outside the scope of your series, but I
> > wonder if we should have a git_rand() that automatically initializes the
> > PRNG with the value of getpid()? Then multiple callers can grab random
> > values at will without reinitializing the PRNG.
>
> I see you're moving ahead with removing the srand() from the lockfile code,
> so I'll focus on creating a `git_rand()` that centralizes the use of
> srand(), but won't touch the code in the lockfile so your patch applies
> independently.

That thread may have progressed a little since you last looked at it.

Instead of using srand() and rand() (which would make sense to wrap with
git_rand() as you propose), we can simplify our lives by using a CSPRNG,
which only gets initialized once, as is already the case with
csprng_bytes().

I think Junio is picking up a lightly modified version of my patch
there, see [1].

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZNKfKs1mLQhnybvF@nand.local/
