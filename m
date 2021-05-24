Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F0C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C930561132
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEXKcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhEXKcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 06:32:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F8C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:30:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j10so13768364edw.8
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rNaz04MnvcKy+V/oVnZSJfX9g2/x8ylP3HxUpfbTZDM=;
        b=LdZEtJPftUyulFCV/mkA/YAZSYs9cbYHzVXPlGrsf4+54oC0Sxt6q2CEG0s/rRVQ/l
         eWNXndizedQWvtUyLrnWBwj8CA2B5ogW5BR6qWkz6kIomGe8IZh6Kvda/qL+b0DijvK6
         hPlmcIUWCcin1fWK1dgjDee+U6HImRZBdMQ1KldCi1TzRMknXMWL3DdqaZfRCPhwc+U4
         BsumTbUdxRnF0dRXt9UWhn7s56BUkvbC5IlHUw/vZJi6ciimqv9EBuxhoSkAuhZQGRD3
         EU687Kq4K7JyX/75hd3MChq7g9oWBvf5hUmXCA6JRmARWrb7OiQa0Ma9SQHzfzr+rEbu
         2/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rNaz04MnvcKy+V/oVnZSJfX9g2/x8ylP3HxUpfbTZDM=;
        b=Ar2/wuc3zMEuwE+NeF2EaaPWQEpY0lUaVBblLxdDsu4zFBjonpKyMmSsQlYeRKzbjo
         QWdObrIvmyhAB3RlMr81huDBLB7R5tpyZ4bkBy63g1Qmi6Ko6UV0ISlAOwGpudyehQYE
         GVRBHv7fhTIida3QqQ022u/GfBLKzJ+AW2IrPA92GQqIXb+m6en/AbNg++JToQvhAd4e
         clAmHtNvVNqPNucAX1mSx+zt3kXy3EqBncb+LGY6S3ufQuZnLaFkkBlh95WRBawn6b3D
         OAtwjSpmNcfE2o2Mw0DAoQ3a2+x68HELJRTvNKIzn3SxjxggNcEim9X+NSXsgvkrINa6
         KQgg==
X-Gm-Message-State: AOAM531EujgdvKZME0FFp4W99BV2saOIS3JM2yI6WKOod/KK60ab2a73
        lEYRRYX5l0vFx2hzRwXY53I=
X-Google-Smtp-Source: ABdhPJzqIn2SY6f2jiiSASB4ZtM5c5L5SojzXVAr9jSUUD32dEvUrP/5pkydBYA0oWgclMfn9mubug==
X-Received: by 2002:a05:6402:30b0:: with SMTP id df16mr24873405edb.85.1621852247719;
        Mon, 24 May 2021 03:30:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s21sm9041881edy.23.2021.05.24.03.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:30:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2021, #03; Thu, 20)
Date:   Mon, 24 May 2021 12:29:16 +0200
References: <xmqqtumyulv8.fsf@gitster.g>
 <60a8352c936aa_55d9020873@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60a8352c936aa_55d9020873@natae.notmuch>
Message-ID: <87lf84o23t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Felipe Contreras wrote:

> Junio C Hamano wrote:
>> Here are the topics that have been cooking.
>
>> --------------------------------------------------
>> [New Topics]
>
> Is this not a topic?
>
> 1. doc: asciidoc cleanups
> https://lore.kernel.org/git/20210514115631.503276-1-felipe.contreras@gmail.com/
>
> Or this?
>
> 2. doc: asciidoctor: direct man page creation and fixes
> https://lore.kernel.org/git/20210514121435.504423-1-felipe.contreras@gmail.com/
>
> How about this?
>
> 3. doc: cleanup old cruft and asciidoctor revamp
> https://lore.kernel.org/git/20210515115653.922902-1-felipe.contreras@gmail.com/
>
> Granted, they step into one another, but at least #1 is more than ready
> to be merged.
>
> I'm sending new versions of all of those.

These were sent around the same time as v2.32.0-rc0 went out. Junio
tends to not pick up new things around the release freeze. I've only
skimmed those topics but they seem like sensible fixes, I think it's
probably best to let discussion on them settle/continue, and re-roll or
re-send sometime after v2.32.0.
