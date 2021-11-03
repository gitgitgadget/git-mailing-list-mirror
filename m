Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A1C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0B60F39
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhKCQEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhKCQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 12:04:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF080C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 09:01:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1734425pjo.3
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTld+PhKexeTn2hszwLWk+w6PFA/kDIlDGVSEe8PX7c=;
        b=KiR/yxNQMYACiFyY+3rnrT7XwxlDeqTZnNcm24/KRvePmf9CNg/jfy4zSE8XOw+s0G
         4oifuGmDpSyFI5Z/RoAI1O+XEu5XHWnnw6YY3Z7AREiLGKUKR2LL89ZGVTic9t0SWVuu
         P7p9Q0tjd/1rE6G72dSN7D++wnKFZaqgLMT6txR4eIA83fRvBnRyW2hfkS4tXL0BVR2c
         IUcCNqsEfzJ2Tv1cAKSGm0QnXaEfneiQ56PPj9j6XjXG8/kQspiru08wn3ibP6vfNoKh
         Xz8Yqc6J5sWnspcWYTCsxlADYMohkn+ggcs/Z4ZMmyzB7lq9kRQH1S3p1tt8/kmQSBgh
         bRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTld+PhKexeTn2hszwLWk+w6PFA/kDIlDGVSEe8PX7c=;
        b=Av1JGv8TzfGoochIVjLAYfM1iyq5e1P9EfCELLg4IGI6QNZrvxUznDAhyIxh+Lvzng
         QyZERGlRohMWBDgCpSwXfIbegm6tINbSO0x6uK4EHgYwJL3EyLBAG/+aBUYdIJQpvVeD
         /venXN7uKyNjw8CXTTfuv+2Os9oPtgbr14+dI1Zg0g97AqMvWhBaaEPPWPqck7NiVXHc
         M3ZYNPpBiO9wxeU/1Q5hy0GpcPVHvrz43E6tDkrRWOP2HYPceqLlhQA3AG7V97P5U+2J
         0eIiyFHTeuXV/75wXgkHQvUAf0J+neTdWua+xLPC2I/hGi9pXnHhYL0XsporNrqwlCb6
         y5rQ==
X-Gm-Message-State: AOAM530RAHei+/AXRwjCV45urOD/UE3EeGhrMVLRUFnRb3utkqeqPV0J
        HYo2uHTZog0OFZc2U1HtlHsX2990+bJVYuKVcI1CM6nv+rXoWzfu
X-Google-Smtp-Source: ABdhPJzsuwBVe4mcwSnxT3AYyYlSdh+grQdGRauvRxz9UdFoFMQHPFeVowdm5aVPZYwBRZ0PbkwxGDurKby0T1SS04M=
X-Received: by 2002:a17:90a:4701:: with SMTP id h1mr15594399pjg.184.1635955284045;
 Wed, 03 Nov 2021 09:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net> <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
 <YYJuK70U8Sk7xSYl@coredump.intra.peff.net>
In-Reply-To: <YYJuK70U8Sk7xSYl@coredump.intra.peff.net>
From:   Steven Penny <srpen6@gmail.com>
Date:   Wed, 3 Nov 2021 11:01:16 -0500
Message-ID: <CAP8dQmsbR7V1zX=xpk+ah-5bgkOP3vJGTMBq_25m9Vhw_fADAQ@mail.gmail.com>
Subject: Re: credential-store get: No such file or directory
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 6:10 AM Jeff King wrote:
> Hmm, that's the right output, I think. Even though it's wrapped in
> single-quotes I think that's just how run_command shows it.

Why does this have no quotes:

    run-command.c:666 trace: run_command: git-remote-https origin
https://github.com/89z/googleplay

and this have quotes:

    run-command.c:666       trace: run_command: 'git credential-store get'

If youre saying that both commands ran unquoted, then I believe you. But
hopefully you'll agree that even if nothing is wrong with the code that runs the
commands, that the output is confusing at best, and misleading at worst.

> So I'm quite confused about exactly what's failing and why. At this point I'd
> probably try running it under strace to see what's actually happening at the
> syscall level. I don't think you said what OS you're on; if it's Linux,

With all due respect, I am not going to do that. I am on Windows. I used "git
credential-store" years ago, and it worked fine. Then at some point, I
changed to
using Netrc, as it worked with both Git, and also cURL. I recently discovered
that the Python Requests [1] package will use Netrc as well, and that even if
you explicitly provide an Authorization header, Requests just go ahead and
ignores that, and uses Netrc instead. This was causing failed responses, and the
maintainers don't seem interested in fixing it, with the advice being
"just don't
use Netrc". So I decided to go back to "git credential-store", only to discover
that it doesn't work anymore.

Hopefully you won't fault me for just wanting something that works, so I am just
going to use my AskPass program [2] that I wrote in response to this situation.
Ironically, "git push" is actually faster now than it was with Netrc, so I guess
that's a win. Thanks for the responses.

1. https://docs.python-requests.org
2. http://public-inbox.org/git/CAP8dQmvguqPXy6Rg_RkuFmf4+LPh79HM_EBM+Wi9dYn3N+vrcQ@mail.gmail.com
