Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0030C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 21:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBCVKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjBCVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 16:10:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E40D505
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 13:10:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jh15so6529199plb.8
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 13:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb4lJ2D+47ySNkN+gGKZ1F+U8uo4AJ/sxjR7rK3fDnQ=;
        b=lshprBufd/1MbzSyHGkRb7k/ZnlxR9dm49YY6HI3lEjPySe++ZO0Cf7GWMAJh3187+
         rOuihbGHoI0rA9bmKOEsHjGQ4V4Fn7JBravoVSKe5aHk43F6H5zaBUTvhMT80feQODni
         hSyMemr6JmRNw5Tcyx/cig3lrUulxwYWIMgIqjoIkbS1PVljHuU1ER0oCMqe78T0zdmp
         RZkH4YHPHFYppYtuaDZFQxgUXJmEiuthr649VTSi4WkDFJWCDOWl5qo+/Su6X6Y69lqx
         tfDzwDZbDew/ieQqpKLSKLYUKwbfxMlQn0kmpP5C4TeI6V8RU6DdWMFmiqKhh8w7BQKU
         QfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jb4lJ2D+47ySNkN+gGKZ1F+U8uo4AJ/sxjR7rK3fDnQ=;
        b=2NwBJqGVU9Q8fzFJIFW9APb6zrQKnLLB48dpYPq28/9RSG6qxya6T2HAVqyy+AquZ7
         FDePn3vQF07LzRnaW6BoD8tUnGo3nZcsUnqaNYJ1KTrum+OMurlD2wb0mWfGFdiBGa23
         +Uj7IyFTee7BgShHHMBkOWitEQM93KNxPJp6SjzWrQe0L71F1bpX8jH8IoIyDI6mPxx+
         ZCyL34gn/bLf4IVrmdvap+OwJcwHyafYTWedrSzYH/Z62kjYUQSskb5z1kYI5vpmUzBa
         vXcOifF1K89ar55uBFoHJCbw8jREA9xRZdQjW77NwYWO+FtI+T46IVghInHOgHKWOBg1
         vg7w==
X-Gm-Message-State: AO0yUKVqpAgiDxFxeqXfPkHyY0PdGgsz8ylp34vNYw+FkvVzZwJRsURS
        LnlRi5F6l25j9Ya/RuYMQMU=
X-Google-Smtp-Source: AK7set8qGl5zmpFVrE9F9EiHdTWtVpHEw1FW4tGqKwSYA89qHx+Y2T8R867Lip5pME+z6PE/xiMRxA==
X-Received: by 2002:a17:902:f10a:b0:198:e5e0:abe1 with SMTP id e10-20020a170902f10a00b00198e5e0abe1mr1758270plb.55.1675458599956;
        Fri, 03 Feb 2023 13:09:59 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b00174f61a7d09sm2020432plc.247.2023.02.03.13.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:09:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Defaulting --rebase-merges overall?
References: <CAPMMpoj6E-85a59EaHD2aR_oKA=_u78qRV+wp8mqXkR39KctmA@mail.gmail.com>
Date:   Fri, 03 Feb 2023 13:09:59 -0800
In-Reply-To: <CAPMMpoj6E-85a59EaHD2aR_oKA=_u78qRV+wp8mqXkR39KctmA@mail.gmail.com>
        (Tao Klerks's message of "Fri, 3 Feb 2023 19:19:00 +0100")
Message-ID: <xmqqa61uo3q0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> 1. Change the "Need to specify how to reconcile divergent branches"
> pull conflict hint text to offer "git config pull.rebase merges"
> instead of "git config pull.rebase true"
> ...
> As I think about it, the global option sounds like it might be hard to
> prove the correctness of (and compatibility with the hosts of other
> options), so I probably won't be qualified to do this. Is there any
> objection to the simple hint change, at least?

I think suggesting "[pull] rebase = merges" is more in line with the
original spirit of suggesting "you want to recreate your work on top
of the updated upstream".

I do not particularly find it a good idea to suggest configuring
"git pull" to always rebase (whether it rebases with mergesor
flattens) in the first place, but if we were to offer such an option
anyway, "merges" is a much better choice than "true" to flatten,
simply because that matches the goal of "to recreate your work on
top of the updated upstream" better.

The only reason why 'true' is in the suggestion is because 'merges'
came much later than "when tried to pull and got a conflict, you'd
rebuild your work on top of theirs" suggestion was introduced.
