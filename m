Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8DC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 11:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhLKLFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 06:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhLKLFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 06:05:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39785C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 03:05:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so38108932edu.4
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 03:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRS75HPB28DHQFZ+RARUyZQ8FbtOjaxRTd7g8rd5uW4=;
        b=kDzPixxWNQ4/mddqDJkjhuiDQjJKd/vrI0aQ0uEIa7hYUFE0F46J0Ko+QMpHb8VQv/
         1FSozcqbrfuntnxeb5zPnGLkwGqn5xtU2s253ghYRT3R7TuGeGXMS41yTNhXAC34L18z
         3BDppS+kItZKoLbrpcou0yqifdkkECtuodEckN/04qk1W/ShkMHEMdgwWHb4CGSEOT4Y
         M+w3SWqTjv7/mFDBUcUN5v13jflzl+P+S/ErExG2IPsEUpK17GkYKC2+X3PdtIVZFRyi
         vWhENaAUrdirWiKZJLDV8uCSNP7aAxnxuIT0WdaZM3qJfE+4Jap98oJagYiK3iUre4QI
         sk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRS75HPB28DHQFZ+RARUyZQ8FbtOjaxRTd7g8rd5uW4=;
        b=u5gwUHHGOP4+AcPtgWMTmvkH5OMWJ4KvSkzZ7r+vu8VE5JchYl9/U3HN3yxTOgoOi7
         M9H9j5cP47WZ/27tYKLu5290ic7IrOJhJcMiJJSxhps/4K3NTs5RB+jY0ksaiNOXVqHd
         3XGRWXg0E4SAuDZOoyylwWGBKRjphahJF6Ymr9ngw3bPpampqUHnH9+C+5aCeAwYkzB4
         R/wuoJIOfy95GtDP5XBTA0lGkxEl3GPfy2FeicsZgAhSboaqcgF1J5J4IQkcoVm4REhL
         msc3DsXsLKA9FNUwmcFp8ub5y/e3xQi3suG5GZcC0M9+Vz1hIMVUTBeBzJQhXc5ZCi1u
         bXIw==
X-Gm-Message-State: AOAM531WWJlLRN+zCD+dJZRs07KVnfq5A/ZJ6/vNFJdLr6KefkrfoVb7
        XRkqkPKx+flmIXwQ4Fa96CKnXBJKdhDvSEhVMGuWcn5D
X-Google-Smtp-Source: ABdhPJwIhx3sVMtMNVXD5inanSqyiQxFPnwZIyoKu9wlUg6wqQzZqFrXh6fjGq7y155x5Gch11Wni963RjwtH94JaXA=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr30472489ejc.443.1639220735742;
 Sat, 11 Dec 2021 03:05:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com> <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Dec 2021 03:05:24 -0800
Message-ID: <CABPp-BFopbtU7uNmf_7Y7rR3o7iZKt2JL8hX8k9HfCLjTVAxJA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] rebase: reset_head() related fixes and improvements
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 6:58 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks for the comments on V1. I have tried to improve the commit messages
> to explain better the motivation and implications of the changes in this
> series and I have added some more tests. I have rebased onto v2.34.0 to
> avoid some merges conflicts.
>
> Changes since V1:
>
>  * Patch 1 - unchanged.
>  * Patches 2, 3 - these are new and fix an bug I noticed while adding a test
>    to patch 4.
>  * Patches 4, 5 - improved commit messages and added tests.
>  * Patch 6 - reworded commit message.
>  * Patch 7 - split out some changes that used to be in patch 9.
>  * Patch 8 - in principle the same but the range-diff is noisy due to the
>    addition of patch 3.
>  * Patch 9 - reworded commit message.
>  * Patch 10 - unchanged.
>  * Patch 11 - reworded commit message and a couple of comments.
>  * Patch 12 - minor changes to comments.
>  * Patch 13 - cosmetic changes to commit message and tests.
>  * Patch 14 - cosmetic changes to commit message.

I don't know why, but I seem to have gotten interrupted a lot more
reviewing this series than others; I've come back to it multiple
times.  Most of the stuff I found had already been noted by Junio; the
only new thing was some tiny grammatical comments I left on the commit
message in Patch 13.

Overall, the series looks very nice; thanks for working on this.
