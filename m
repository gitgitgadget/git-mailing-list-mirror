Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60ED31F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfFTKLa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:11:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43647 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTKLa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:11:30 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so639952ios.10
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQnqsFUtchbhbo6ToGzk8kDXEUO2gCFXBIW0UYY/zA0=;
        b=K/olxyPvQDsxrKepDLhcPYhaWlB/zoSYmn+IBU5uZvxu9YeKJOZBiPHeBdvySFbYGF
         3GeZpoqoWpZKIrg0XlP3P9p9G5eFCN0mA9MPUzVheVaWPe3TkaJlIDqAt7AC7ivgzxqW
         7ffMR5xn0ZEjCmnOt3dYlZWQhn5mtRFTb+GCNpRfUxpFIU0kOZYOXG1XPxfcecbbj2xK
         cIXpT8LkPfbxg4qSsItLKE9U6FIXUygUAWSaTDBbtRezQZH/R1rN3AIpMg/nNrG6+gkq
         T2S7ZjsJwGX9p55ZMezpcuAHRp5lts765rK8CFZKo00b2iqGMeupRs7imuHdCQWzJ5Y3
         GFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQnqsFUtchbhbo6ToGzk8kDXEUO2gCFXBIW0UYY/zA0=;
        b=GEY+cxdCDJ50cUwUgqWq/+jk5nxGu0a8sJgb08MnqcVRRrsevGH465WbXy/nInGrKf
         ROtbo4QCIGiHejyJZmyyQNi7fQ9ZTWlkBjaUWE676d+/In+mD8yjYeKpsyS8tUVvN+jn
         eJanCEVX9ZiCvupVsCtFiKU3BvwRKeDE2G2FTav7CTDkcR2UQICYow/l6Bw46JayEhC/
         KtJqdmK0d1CtlvDO8xcCZVfsGC5wXWWqzOj39FBbjJzgSjx+6nr2oYItxGlqbiLTNLRS
         8ZkK7FAMktsRfE/bhoSGYbkBG+LfFj29ianktKXfgA8aWelCGOky0g4YJxyDfzCJJH4h
         Na2g==
X-Gm-Message-State: APjAAAVKeyxCf9zv5qLQ6chPi9quHmjpOIWG94JIik/tX0ZaTlWB19U4
        zpUn+HpAW/RUVvBH+LCy/nieQOycRSNVW6Rd4Oc=
X-Google-Smtp-Source: APXvYqxidprwX36Lm3eO6T7VpaocW2Dz1ktvM34qnIekDYUyeZlmzemBT14VInLgsm6CZJp1QwkK3hvOdMi1dGdc5pM=
X-Received: by 2002:a05:6638:63a:: with SMTP id h26mr15481199jar.92.1561025489676;
 Thu, 20 Jun 2019 03:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190619094630.32557-1-pclouds@gmail.com> <20190619185934.GC28145@sigill.intra.peff.net>
In-Reply-To: <20190619185934.GC28145@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Jun 2019 17:11:03 +0700
Message-ID: <CACsJy8A5K4hNKy1LupQJ8is4AgTAyzfW+qhMYkcBmS_kvnE23Q@mail.gmail.com>
Subject: Re: [PATCH] fetch: only run 'gc' once when fetching multiple remotes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 1:59 AM Jeff King <peff@peff.net> wrote:
> I was surprised that we needed a new command-line option here, but I
> guess the sub-fetch processes really have no idea that they're
> subservient to a multi-remote fetch (they do get "--append", but of
> course somebody could specify that independently).
>
> Another option would be to just pass "-c gc.auto=0" to the child
> processes to inhibit auto-gc. But maybe it makes sense to have a nicer
> interface (after all, somebody else could be doing the same "let's do a
> bunch of fetches in a row" without using the multi-fetch code).

Nah to me -c is much nicer (and flexible too). The only thing I'm not
sure about is whether a user could override it. If fetch.c adds -c
gc.auto=0 automatically, and the user wants auto gc back, will "git -c
gc.auto=non-zero fetch --multiple" still work?

I haven't checked git_config_push_parameter() carefully, but I have an
impression that the parameter order there is "wrong", at least in this
case.

> Though there I kind of wonder if this would apply to other scripted
> uses, too. E.g., if I'm doing a bunch of commits, I might want to
> inhibit auto-gc and then run it myself at the end. Should we support
> "GIT_AUTO_GC=0" in the environment (and a matching "git --no-auto-gc
> ..." option that could be used here)?

export GIT_CONFIG=gc.auto=0 ?
-- 
Duy
