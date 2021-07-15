Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C7C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074E613D4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhGOUnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhGOUnM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 16:43:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22201C061765
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 13:40:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so7609333otl.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTMO72LQ3K9g4m0lNEEJ2dxUURzrJ+KdRGpUldivlIQ=;
        b=rhsyVAQzgFKyHbdfWlKAML7ou71xwRx65Pww9Ax2aT4cNZkWl/YU+F8LVsMyQv4L55
         e4VN5KaUSn3WOJhcXZX90B3j+BPjf2m0ZOQsB0nMpKCliGbuG0yTn9ITAFk71Z9ihWS1
         AW+N3NHF9XWfURGUfYa4/qRa0jZaNCDgRRU66GQDhadV+poyY6672JDxGYSXzZTjT4tl
         Wvu/zWhmMBSb0eENWmC9NMExn5zVrlulmFgL0WsHthavJ4TV2tQCG7aAczwCr5dT4I4T
         lw7UAz/YLpbVarjRMezvKQP9Yg9mNHDalDZkMTM1kNG9krUJCQzYLax/c6Qpq9R+wdtS
         Ve2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTMO72LQ3K9g4m0lNEEJ2dxUURzrJ+KdRGpUldivlIQ=;
        b=TpkGmPKzFICXiJ1dAzm+oigCyBchG/iTOTZgBfv7Vq8O3zK3oEkhOCDWhVeyUFWQB5
         LdbX3i0Pb2XeB+GCQ+fd33N8nP4UrikBRdiTc2ExzDmIe1JEQ2CtImR5wlYgce+is3ck
         +gP12MVjRgEdvJ9338JJL0i8tj3KJTZg2X/xuzOzjE/wBZDIKjuU6HVSVzR7TH3lceuA
         K6R6dhOhmr2vxkvqBZ8x3jNo6MRPQmEPrTjcXBmNzI6f2VqE865KREeMBIkBc6nH8snl
         Fi7VPxAoSp+pSX4Yo5gIpwdbVNwkSDMj/tF43a4f7JlBWqZ3eNxpA/MeIBm1YQGgMDmY
         v/iA==
X-Gm-Message-State: AOAM533dWqPgIlU6VivbMtiEXonOIankn1L4HgJJZJMzTXdtBARrFtLU
        17eCvch9KseePs04h9BulCwaBduxiZaBIn9D/1k=
X-Google-Smtp-Source: ABdhPJxCR4aKkZ1l1/SraR82KuYCltWFzdUTNZdKaShmCE3Lq99yzQdP5oM6A71oWKxYBYme+Up0mm1xe/D+QPwuqVQ=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr5184342oti.316.1626381615567;
 Thu, 15 Jul 2021 13:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g> <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
 <xmqqpmvjs61c.fsf@gitster.g>
In-Reply-To: <xmqqpmvjs61c.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 13:40:04 -0700
Message-ID: <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 12:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Let me ask two questions:
> >
> > 1. When is it beneficial for users to set both pull.ff and pull.rebase?
> > 2. Is it harmful to users for us to allow both to be set when we will
> > just ignore one?
> >
> > I believe the answer to (1) is "never", and the answer to (2) is "yes".
>
> I agree (1) never gives you anything, even though it does not hurt,
> and (2) is "meh".

Okay, let's drop this series then.  Thanks for pointing out my mix-up
on the rebase --no-ff thing in the other email.
