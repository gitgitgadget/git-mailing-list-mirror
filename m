Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC3060F12
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhH3UCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhH3UCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:02:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96971C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:01:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so33589079lfa.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ww2D7Wm3P7BIwE+lO56VEliE+HI2012P1uJjgJU2Wh0=;
        b=IiagW/j7Bkd1997toP00dtEklUkfWfyfqCkFOmxhnOo/bZGbgbB5qbCeSZTuHVffG/
         aG9iXvT2FJxHbIkwwAVBCj+awAm9K4kqpNNqa/h6IXnxYSyC6MEq/4iZadxJajjPsBKW
         g5pUdYi0cn1gaXS1qEW+zcoG1CtjGVprOpl3SanzsncKXW76gJAFf6wn72lizg61Sg3Y
         vsDfdWP+UbmhGfNOHGwmuDsx5/SMyLUyiBsgnC9+M3xN677vxgQA9oG0dtDYGDSB6AZ0
         C8YdOdgqbgKxdcCjuICEw0G8d9BoDJfaq0Q0YYPN3ZQTWkvgI4OjPl+r2gs48TTilNr2
         yBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ww2D7Wm3P7BIwE+lO56VEliE+HI2012P1uJjgJU2Wh0=;
        b=BH+bBZYbcc+gOG8UVH0MO8DswimVPUvdNIMxVf5dUWMOY0MiPdYiRXPm3gNEokBD+3
         NgMOaUbNdOrGo5JtY5sopbG8wwDPU5ccs2kUniYd0YNM4Gm9FPrGQm7QhAmpt0W25l+9
         l4prNIy0FxRAfwLEG+WWCZ05pK4GrEu7EjkZfLhVvtIxXrTcxFmcU1iDIDzr3gY8MSUT
         QO3KVV6Zl8SP8bDwjq0ALhzcGu0wb9SB4ZR2Is7gNsH/bvo3uPG0rxjILiutsSqh4zFO
         IVF4zZFBDX3psZ0T2hBjE0aa6ENeGXBX+U/3M2Wd/gfhnG7EKdCxt2icKO75CN+9TPuM
         k6lA==
X-Gm-Message-State: AOAM530OB5qFNVjZZhJrktkIIq7+STbgMuxadtSqDXmARj7CzrgiqjJP
        eyLPnZRdIri63xADmAv0UN4GMiWHvEg=
X-Google-Smtp-Source: ABdhPJxiD+1eQ7oFdf8IP/n7/iWuK4oACD4/esbfF2ci1v1A8PHc1QcL0Lba3r5EudH5QgVLXNSmpQ==
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr18241933lfu.461.1630353668056;
        Mon, 30 Aug 2021 13:01:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z6sm1478720lfb.251.2021.08.30.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:01:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <875yvn9j69.fsf@osv.gnss.ru>
        <YS0f37xPKOHCDHr1@coredump.intra.peff.net>
Date:   Mon, 30 Aug 2021 23:01:06 +0300
In-Reply-To: <YS0f37xPKOHCDHr1@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 30 Aug 2021 14:13:51 -0400")
Message-ID: <87pmtuzoql.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 30, 2021 at 04:05:50PM +0300, Sergey Organov wrote:
>
>> > Is gitk wrong to add --cc unconditionally? Should it do so only when
>> > there are conflicts? Or not at all?
>> 
>> As far as I can tell, --cc had no effect on diff-index, it was just
>> silently consumed. If I'm right, this line in gitk never needed --cc.
>> Then either gitk is to be fixed, or we can "fix" diff-index to silently
>> consume --cc/-c again, for backward compatibility.
>
> I think it does have an effect. Try this to generate a simple merge
> conflict:
>
>   git init repo
>   cd repo
>
>   echo base >file
>   git add file
>   git commit -m base
>
>   echo main >file
>   git commit -am main
>
>   git checkout -b side HEAD^
>   echo side >file
>   git commit -am side
>
>   git merge main ;# maybe master here depending on your config
>
> And then with pre-v2.33 Git, --cc does a combined diff:
>
>   $ git.v2.32.0 diff-index -p  HEAD
>   diff --git a/file b/file
>   index 2299c37..81768df 100644
>   --- a/file
>   +++ b/file
>   @@ -1 +1,5 @@
>   +<<<<<<< HEAD
>    side
>   +=======
>   +main
>   +>>>>>>> main
>
>   $ git.v2.32.0 diff-index --cc HEAD
>   diff --cc file
>   index df967b9,2299c37..0000000
>   --- a/file
>   +++ b/file
>   @@@ -1,1 -1,1 +1,5 @@@
>   - base
>   ++<<<<<<< HEAD
>   + side
>   ++=======
>   ++main
>   ++>>>>>>> main
>
> Likewise, --raw will show a combined diff, though it's a bit less useful
> because the unmerged entry has a null sha1:
>
>   $ git.v2.32.0 diff-index HEAD
>   :100644 100644 2299c37978265a95cbe835a4b0f0bbf15aad5549 0000000000000000000000000000000000000000 M	file
>
>   $ git.v2.32.0 diff-index --cc --raw HEAD
>   ::100644 100644 100644 df967b96a579e45a18b8251732d16804b2e56a55 2299c37978265a95cbe835a4b0f0bbf15aad5549 0000000000000000000000000000000000000000 MM	file
>
> -Peff

Well, thanks! As it does make a difference, it's a pity it's neither
documented nor being tested.

I need to review the issue more closely to give a fix then.

Thanks,
-- Sergey Organov
