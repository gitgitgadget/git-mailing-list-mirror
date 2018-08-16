Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8781F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeHPViN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:38:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52102 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeHPViN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:38:13 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so7635065itf.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzHK//KD8eSVbgPyHXxKXAgabSrE0hEVoQ0Xdb47z7g=;
        b=RC/kSbraqN+NeqMd/t8yyZQW0bnrnrk8JGGH7icK1e8cOu6w318JhPpeyupJi04Thu
         Cl4NOr6genqPKhlh4B07iObuEYCw82oRQzF2EVvdJO74Y25xa0+PIEd6DXdKDFusTRLk
         zp0IH18Qk4mFv650WIIcWsPu4rl1eaOFAsdY99nwmOgFDmF0TtHRWEhTgRJ1IaHJ0OWi
         4MW+fhOMWlpr4usN6Ot1fUz0WvZkX+MUNbqhYzFv0prH/EDfQUDgRnHfTeG1jRGB5aCi
         8OFwqfiFyqFJ/PMYYKI/V3bBRYJ4QPuA6kTparLEdEt47z8ORpgLNMxaD1c6Vw/mTW3V
         RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzHK//KD8eSVbgPyHXxKXAgabSrE0hEVoQ0Xdb47z7g=;
        b=FITd7ZF35h0zgdjIZIceXQwEsneSc7WYuDAajGdYKvYH76MRrEM93Zo+vPszKDPaRN
         gWzvmU6y9vqFyMS9nia3j61hjM/IH0Bas8IT68UWbn96IrDoa8/6Uv3YCsrZwm74so6a
         oBLuMX+3rD3SvukQltlDbjiwDRoHYc4HGSRSjcRkgX3hdAbVw78MANZM9V0bkKPv/rz7
         Hegw4W+GoAxyFfaRgAALOGosIvIZTXSJs0XZ1ntjBvc06R0ngpEq2cfctbZT/Z53+/Y/
         UgFqoffMR2DUtfXIGO4qzH4SPvIXV0zHFp7l0s6F6CVrLKQSKMk7mx1PWqOOpm0YL9qU
         aV1w==
X-Gm-Message-State: AOUpUlFGWpYDyr9v1hiEeSHbsMf0r8N6WmyGp9YZKEQ6MqnFymAg1vBJ
        Aq1Y0UueMPumrosYSUYgyB39GPLkmrufqgyVFCY=
X-Google-Smtp-Source: AA+uWPzI6HayxOObclgfQejr/1Vsvaq6rAAZKrDGBVm+u7XxqNgrOlhXH6j+vcm2+86MGMMVwbyngGcIxqNsXTe4p80=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr26665919jad.94.1534444686944;
 Thu, 16 Aug 2018 11:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com> <20180816182653.15580-1-benpeart@microsoft.com>
In-Reply-To: <20180816182653.15580-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 20:37:40 +0200
Message-ID: <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 8:27 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> From: Ben Peart <Ben.Peart@microsoft.com>
>
> Skip merging the commit, updating the index and working directory if and
> only if we are creating a new branch via "git checkout -b <new_branch>."
> Any other checkout options will still go through the former code path.
>
> If sparse_checkout is on, require the user to manually opt in to this
> optimzed behavior by setting the config setting checkout.optimizeNewBranch
> to true as we will no longer update the skip-worktree bit in the index, nor
> add/remove files in the working directory to reflect the current sparse
> checkout settings.
>
> For comparison, running "git checkout -b <new_branch>" on a large repo takes:
>
> 14.6 seconds - without this patch
> 0.3 seconds - with this patch

I still don't think we should do this. If you want lightning fast
branch creation, just use 'git branch'. From the timing breakdown you
shown in the other thread it looks like sparse checkout still takes
seconds, which could be optimized (or even excluded, I mentioned this
too). And split index (or something similar if you can't use it) would
give you saving across the board. There is still one idea Elijah gave
me that should further lower traverse_trees()  cost.

But anyway, it's not my call. I'll stop here.
-- 
Duy
