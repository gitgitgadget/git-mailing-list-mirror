Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3733C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbjDEP6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjDEP6K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:58:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AD107
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:58:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 8-20020a250508000000b00b7c653a0a4aso28202575ybf.23
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680710288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQlqdGJSnD9tB1Cn+j+VJxMpW8I4DxuPuz+qLOuiqa0=;
        b=DlkjEWA5NYYWI9CGuN0dWLk7SfG3SBirTwqicTadLenYe1AyiW1cVkVcmvCdT0+Iyz
         nCyTWxHfHm1w0TbGYeDRXRxu3eyNOZHCx4DWtQmoGkdQRM2BD8WmMWD25GFDHlzjPtTk
         9qKE7qbKBEOuvBGIUqH4qbef91cN3rIvvwynfUtMUQNCtSYG8V9EljzMespo0Q2A/LDe
         P+3NW27CpwAYR/efNX+sgD+39jn0YUlNcf8UDfThiETVqxhy0z7yr5s8c903+8W6LBKx
         DRlUa6a9GfV2qMbz19AKeOuGtMAPMYOqn07ySM7yifbpAye4EGilrYXsdxyMiGTG2VMn
         PxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQlqdGJSnD9tB1Cn+j+VJxMpW8I4DxuPuz+qLOuiqa0=;
        b=6NVWt3K7Jw3NmDhS1+1+GCHw2Wlla4s9ClcDChnEvK6+0yjxmb3YqMQFmQzf+Fr/L4
         HGLQmOEgA+FqS+AFAgfDQeuFLqkDi7/92tJ+q/p8dc3sso8B/xIS855fcJnbGuMZTSPe
         mD09da83HAJmNe3lxDqfY61i7poDoeiFryxd1+h2bs6MS1Szx20OIpl7SH7IYtPVSEdT
         GHk3IS/PjYuvLJ5pIcYysen8jAzleAoFtx9zWOd7mDLL9Mnd2kcXOEJDC1AN/3Vpj5+m
         C7j3ODFDibWjfDVX+FYh0lcZnpb98H+OFYoHA1HgASFGM5AYobeMi7tmvSo2H/062V7u
         8VhA==
X-Gm-Message-State: AAQBX9cj/YJsTC/Uc8TUQ2aMTfS0jhZt+Y1MFW3BCgisYy3KHjc0FKt9
        HAA7QbSSwkPlC4r5lkbrTnlDgbDpEv0=
X-Google-Smtp-Source: AKy350aL0Y7mC9Iahp6gzq4u45QdW24MlFxOnxv9hJPNFw42sqPAx3LSjKn9VOYweu+sW7XE99Lhq7fFg6I=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:734a:0:b0:b6b:6a39:949c with SMTP id
 o71-20020a25734a000000b00b6b6a39949cmr3851089ybc.6.1680710288098; Wed, 05 Apr
 2023 08:58:08 -0700 (PDT)
Date:   Wed, 05 Apr 2023 08:58:06 -0700
In-Reply-To: <CAMP44s128zFcMrK7URUK73ZmzETDRA5SNkWwoHgukZ9Q3f+5Qg@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
 <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com>
 <owlyzg7mubui.fsf@fine.c.googlers.com> <CAMP44s128zFcMrK7URUK73ZmzETDRA5SNkWwoHgukZ9Q3f+5Qg@mail.gmail.com>
Message-ID: <owlywn2qtj75.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
From:   Linus Arver <linusa@google.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> "We" probably don't want to change it, *I* do. Because in AsciiDoc
> there's a difference between a listing block and a literal block, but
> the Git documentation does a very poor job of being compatible with
> AsciiDoc anyway.

TIL. I'll be happy to apply the listing block -> literal block changes
you suggested in a separate follow-up patch (probably looking at other
docs we have as well, not just for MyFirstContribution.txt).

> It doesn't even use the modern syntax.

I am new to asciidoc; if you know any other examples of modernizations
we can do, feel free to chime in. Thanks.
