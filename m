Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FCCC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3456561139
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFREWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 00:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFREWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 00:22:23 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF8C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 21:20:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso8401347oto.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8gZZU22N+V3QiheVh/15dAs7IhkSn42JEvfbOoUDZDQ=;
        b=j91iE55aie2XT6Ws0V65oFsGOXoARIqoD6xJHGRkpvFbUV7JkD+yOjz/VUlG156ctz
         +vxcX3o58HXuEdsK7bHcfQvRbbJjftFrwAXnM6JZdxaTgZRnTrBZ7us9Xl1sV3SLfGUs
         1ddjNdeaNuxkk5DTJkMnJCdelazIE3k5ZAuJX2vk+UwxP5cBmDCXkfvon9dJwp8C/SEo
         YQBmPgN1ZtNIUjjnodntB8EQNe+xGNITuF4+NR4PZvigj88LGz9XBSxnd4RXzNtGb586
         2YewbW6k8i+MX6zDdCFM0bfm8TRR34gDAG/mM3vVduKmnhEUzP7cvipljESo/iwWautb
         pdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8gZZU22N+V3QiheVh/15dAs7IhkSn42JEvfbOoUDZDQ=;
        b=AI8I2iGJybu2C2RvzM9lW9tLfqgU+GarmMIzyssALtiIq42+PY+m7XGxpokfMyDirY
         1V3xNxkbbLZtpsAW+lZlmSYk8IJCRqxN8M3unZ6lvHDQnV/AxyAoiaVDvdd9ilm+5XUu
         VGEjayTzC+u6MjnlLlhCPqvAD+1LB1w4BEaa9uL8qQbQH6XaorqUTx+p0l7ceUIJZPyR
         5tTg/EbbOHlcKHOrKd9O3/WnJ23+dFRMWajZH38fZCrSYGw4FL1pNLwBdkZAL54e5/qM
         eR70iwgb85yVkyCUTU0sx1CmOuZFkr8ahEQJLQCm8Jf+qZhItGH2OGu0ResmK3y/h+L0
         KIIw==
X-Gm-Message-State: AOAM531SB67QyVC8Dwhhbc7HphfhgNhkD2qq7nNFXT8KK6swWAJzadge
        WKTp58ey7HembxBR1fyj3Fw=
X-Google-Smtp-Source: ABdhPJzB2nbXV1PUJyD6uRmIfWgS9bgARGN4i318CpgcVBUpVezMVU7Woty+ydXQXpRrJpVcv8nBwg==
X-Received: by 2002:a9d:4e4:: with SMTP id 91mr7339865otm.333.1623990013065;
        Thu, 17 Jun 2021 21:20:13 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 94sm1739320otj.33.2021.06.17.21.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 21:20:12 -0700 (PDT)
Date:   Thu, 17 Jun 2021 23:20:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <60cc1efb4f691_5d7b82086d@natae.notmuch>
In-Reply-To: <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-06-17 at 02:55:26, Junio C Hamano wrote:
> > * bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
> >  - doc: remove GNU_ROFF option
> >  - doc: add an option to have Asciidoctor build man pages directly
> > 
> >  An option to render the manual pages via AsciiDoctor bypassing
> >  xmlto has been introduced.
> > 
> >  What is the status of this one?
> 
> Probably best to drop it.

> I think Felipe didn't want his sign-off on it, and I don't think
> there's a good way to produce an equivalent patch without
> incorporating his changes.

I explained very clearly what I would expect to happen for this patch to
be valid [1]; you don't need to drop the patch, simply state that *you*
wrote the commit message, not me.

Here, I'm copying *exactly* what I wrote so there's no confusion:

  Hard to tell in this frankenstein commit. I'd be fine with a
  Commit-message-by line.

> We don't seem to see eye to eye on an appropriate solution to the
> problem, and I don't feel like arguing about it further.

I don't see what is the big problem. I said you should split your patch
into multiple patches, since I believe your patch is doing multiple
unlrelated changes at once.

In fact, your patches don't not apply to master anymore (since you made too
many changes), while my patch series [2] does apply cleanly.

I don't mind our competening series to hash it out again, but first you
need to send another round which does applie cleanly on top of
master--unlike your previous one. And then I'd comment my objections to
it, yet again.

Cheers.

[1] https://lore.kernel.org/git/609b5c85b7c61_678ff20848@natae.notmuch/
[2] https://lore.kernel.org/git/20210608090026.1737348-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
