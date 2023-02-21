Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AC4C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 19:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBUTK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBUTKT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 14:10:19 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3202FCE9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:10:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y3so2322447ilb.6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QF7e12DXjcpgmPRZLI/9IyxlLK+VkwefbsU1mD9UWo=;
        b=iIbqia2VgH2DkgmqwJ8VTwSCGWr67GmbE0dPefgDp88sGF5jjzsNGZjsBuvc3pvy/l
         8aKrk8lOvjp0uUaLDrhT2FSVlcm8GvMArsjl75hkDcFemWog4pFZl3XY4kLaZAtm1mfq
         IXydKH5EopwbglfC5nBP/wGGf7egAmKa4HmLyyWryGwTYzeZAUdv/EpMB4Qu9vsDvjJZ
         x1FIhgd2OdL9nEWU2kkyeU0Hb5Ef4iR0y8NkQt/DTlYWXGMQQlrMSemJr4+j7mAEzZpZ
         FXLdEG3QcJva+wEasxF4XBHVn1azIJdvTjLmw4AIWqEhkXvaM3eGHiW2lbAoqvW/p4vH
         y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QF7e12DXjcpgmPRZLI/9IyxlLK+VkwefbsU1mD9UWo=;
        b=58bVO6av7Htkw2YAG/Acz7JwCD0IoN3RcGipFbIYv/1UW7cuNRDAzqm4rMBBeJRoKJ
         Tr0eJyx9XVngfFpdnF+gfLPPXxJ4YVyUIJRk79curwjAkNN7iu+rwN0jU3+iObM+fqjn
         QKeDQg6h6sxr4g2s4mLT4wa3jT9zOumVjSV72OM3golYUTi/w4qpxH1bqAfjtAud11PN
         bkB0p+CgvW0sabR318izYX/72zy1EgOzH28OLNl8pAbZvctjZOwjRMBl5Ihg1lqzX6sT
         XMx4LJPkkbLj/medlrwtOyNVMFhqaVkGjtQOb5g9P6fDfl1nbGS08MmPUembhmp22pF6
         hX7A==
X-Gm-Message-State: AO0yUKXUgntY2SlFYuEqqWAjNw5tgdSFlxoNwYSv0xRYQgitFfW4I7lc
        o07RmTMc6P3Bc/i142dnXrm+pA==
X-Google-Smtp-Source: AK7set/D2amsUdpJfQw6I1qSN5DI/LSnJghI8mP06AAikhRbV3dPbP8VFLVU3rp+z95NP/1a4gqqaw==
X-Received: by 2002:a05:6e02:1a08:b0:315:554e:e73b with SMTP id s8-20020a056e021a0800b00315554ee73bmr6441640ild.21.1677006609806;
        Tue, 21 Feb 2023 11:10:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g3-20020a0566380bc300b003c4d71489aasm1563147jad.6.2023.02.21.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:10:08 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:09:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/UXBw3Y9YnXUBIN@nand.local>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 01:12:23PM -0800, Emily Shaffer wrote:
> This turned out pretty long-winded, so a quick summary before I dive in:
>
> - We want to compile parts of Git as independent libraries
> - We want to do it by making incremental code quality improvements to Git
> - Let's avoid promising stability of the interfaces of those libraries
> - We think it'll let Git do cool stuff like unit tests and allowing
>   purpose-built plugins
> - Hopefully by example we can convince the rest of the project to join
>   in the effort

Like others, I am less interested in the VFS-specific components you
mention here, but I suspect that is just one particular instance of
something that would be benefited by making git internals exposed via a
linkable library.

I don't have objections to things like reducing our usage of globals,
making fewer internal functions die() when they encounter an error, and
so on. But like Junio, I suspect that this is definitely an instance of
a "devil's in the details" kind of problem.

That's definitely my main concern: that this turns out to be much more
complicated than imagined and that we leave the codebase in a worse
state without much to show. A lesser version of that outcome would be
that we cause a lot of churn in the tree with not much to show either.

So I think we'd want to see some more concrete examples with clear
benefits to gauge whether this is a worthwhile direction. I think that
strbuf.h is too trivial an example to demonstrate anything useful. Being
able to extract config.h into its own library so that another non-Git
program could link against it and implement 'git config'-like
functionality would be much more interesting.

Thanks,
Taylor
