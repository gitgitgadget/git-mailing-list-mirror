Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7539FC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B95161163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhJFKeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJFKeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:34:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6BC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:32:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so8113022edj.1
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=L9dLwK1dX3/jVhuJPov9x7vtVFtBiGUjb7Rfoe1uhBs=;
        b=JyI9h6dhfLDfROEbBh6KB/EpS/7qkhBo/36t5y1EU70cCDsmoOu8EwRE31mJBJjNEt
         bG/+09sO+eXNykSV495jzRrXhTf5p2Gh69yjMqXA19DyT1qN/H4/61TQ7jqRhTQ+unF9
         zNIwWOT4Hqhmy7dM8XdxT8XsrvgqCRGDR8gmxEiOeh03+GLecu2f+y4tZmapmUmeLfbR
         e0INKRzLbRuWK9zmqwcxS6rOZDZRXaQRvluE9UUWSZ0G5VagnYPgiHSV9PejZXO4CasH
         vAXylwZg2bV0i3g1UBm6NIiC8VQtg61RSyGhWMiCdTEBk1I/ct9d/Yx6DwmU/oO8DvTK
         66fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=L9dLwK1dX3/jVhuJPov9x7vtVFtBiGUjb7Rfoe1uhBs=;
        b=4lpi40N7NUy+a2/vMgByRB5cXZkrbATi5f5tQ2o6VaX4xnWgFBTKkqCE7Vy/SS81Jo
         /NdHfrvVFCsaicXfed55c07Xr6qb+B//6D/bSXsFc6ZS8yoSoPr6sDJV26N8h+Hggirw
         wjnaCUMjgKo7SJvZPkvhmUK+qiMg4t+8TvIQSK28XcINGGeWmWZf+9E2uMBzMGDLYkAY
         mFyEv1pYIr899Yob+XWauNy2ncotsZJRWGi9PX2RjkeKJqFEcPbu36H7YnuCtHmDkyUy
         hXI1oKav2w/ZJdnYgZQDQswTnjjO/bO3PPwTMcr9pe9PKYovc28OsmqHeQ5kNXJ6+Owb
         sSSg==
X-Gm-Message-State: AOAM532/wW70FJVr7Ej4fjb6SrkIkQrAR3oEe9qrcsQml19Vk2PXcoWJ
        6XUr20RtkUPgXU4HCCt3kLo=
X-Google-Smtp-Source: ABdhPJxqyEG1w4n/7ck1JyqtBTs0grCH2bpliNA2HMr8+Z3BvEhdBjoiK4UXTOGLutjopZIi28H5aQ==
X-Received: by 2002:a17:907:3f1a:: with SMTP id hq26mr30288619ejc.297.1633516349081;
        Wed, 06 Oct 2021 03:32:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r26sm8804630ejd.85.2021.10.06.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:32:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>
Subject: ab/refs-errno-cleanup & "errno" removal in the refs backend
Date:   Wed, 06 Oct 2021 12:26:46 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87ee8yiguc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>
>  The "remainder" of hn/refs-errno-cleanup topic.
>
>  What's the status of this one?  Meh?

(For bystanders, this is ab/*, but it's mostly/entirely Han-Wen's work,
although I did modify it a bit. It's patch 5-8/8 of [1])

I tried advocating for it the last time around[2], maybe this helps
more: The "errno" variable is still an explicit/implicit part of the
refs API, so any backend that doesn't deal with files (i.e. reftable) is
likely to have subtle bugs or missing behavior if we don't eliminate it
completely at the API boundaries.

This is a start of that, I've got a 8-patch series (largely code
deletion/making things "static") that gets us to that point queued up
after this.

We'll still be returning errno, just via a variable, and reftable will
be faking it up. But once we've gotten to that point it's easy to
continue and e.g. making these backends return some structured sensible
return values via enums or whatever. I don't have anything
planned/written to do that, but that seems logical once we've got
"reftable" in addition to the files backend, and perhaps in the future a
generic DB backends or whatever.

1. https://lore.kernel.org/git/patch-v10-5.8-fa9260f25fa-20210823T114712Z-avarab@gmail.com/
2. https://lore.kernel.org/git/87zgrnjw7v.fsf@evledraar.gmail.com/
