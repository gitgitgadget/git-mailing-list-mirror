Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8FDC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 14:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKAOgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiKAOfd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 10:35:33 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B01C118
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 07:35:29 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id a13so22079188edj.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 07:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDy28b8zfae0PnmX0u6A2BN5fQ86yTDPWRjrUsPGSoU=;
        b=YrI3twBSpSuBtLObOSPyyoU90DJhnJmD2QudHJ52Zrphz7wcH7Q474ZzuUS6HTgOYO
         ea+dAQ/e9EDxQjyxXnU1lxqPfYWO+UkTC2Lu1bG9wmXc4JvXpVW0BgFsJ6a5lqWHvxlt
         FYt1Mfn2IB5Y+47bbV01vKUKTnis5LW9JCgA5STz5k0LDewrlD0hUaQjLeauZjxIzM+P
         WoQDJL5GDQPzi0UZKzvkAl6cRChVJiFyuLZ63cYRhuHvGcN38I11cqfOQflHdKKHNmae
         bc5yVqBv4O4XBqjb246PfIFMDLFnKL1QKOr09VyUceu8v55KLgGsV+EKQmZzanY9uQcc
         prbw==
X-Gm-Message-State: ACrzQf3U4ELOhLOs+GqIQzNKmjc82gU5cHOnAdOayCerhFd7fLeCeU4t
        VdcnAzaO5+z0wWS25HHGwSlD46yZaJlPRcANGIiz4h79
X-Google-Smtp-Source: AMsMyM5EVO5Ap8n6JHREzaPIipPSh5nx5u7Y48qFoAWmE0eZS4P554S93Pxv/Si/W9S+GoSySCrrsSYmLm8Zn0hALBs=
X-Received: by 2002:aa7:da0a:0:b0:461:135e:7298 with SMTP id
 r10-20020aa7da0a000000b00461135e7298mr19193461eds.242.1667313328292; Tue, 01
 Nov 2022 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <2210311614160.25661@stax.localdomain>
In-Reply-To: <2210311614160.25661@stax.localdomain>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 1 Nov 2022 15:34:51 +0100
Message-ID: <CA+JQ7M81t0Lby=sB5GpUzJWakPgbi-ZNiQUL4va0wjDuk4v++Q@mail.gmail.com>
Subject: Re: Consist timestamps within a checkout/clone
To:     Mark Hills <mark@xwax.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have little to add on the underlying issue or non-issue but some
ideas on how to solve your problem

On Mon, Oct 31, 2022 at 8:39 PM Mark Hills <mark@xwax.org> wrote:
>
> ...
> Indeed, Make is acting reasonably as the source file is sometimes
> marginally newer than the destination (both checked out by Git), example
> below.
>
> I've never had to consider consistency timestamps within a Git checkout
> until now.
>
> It's entirely possible there's _never_ a guarantee of consistency here.

If your makefile depends on checkout, why not
  git ls-files | xargs touch
or if this done in an environment where there's not a fresh clone each
time, maybe
  git diff HEAD --name-only --diff-filter=AM | xargs touch
or something along those lines
