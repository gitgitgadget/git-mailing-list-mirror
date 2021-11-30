Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5FC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhK3ATw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhK3ATv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:19:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7EC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:16:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so79205293edu.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcQANuwMVsfVeTlJtKM7OPY8i3NO04NlAHvM2i8Ma08=;
        b=fNegswpgNL217dawZl6ZmJlBo0Lpf+2ca3HKlsroG2PX2xK+rZuFi/HgOYQcghvZje
         v1Xg+3Bxs63G3LqJCjUrdPVVPGQ6cVMV7CdE7II0dVDES+MwNt0w7HkeuvdF5kl5chqs
         5SWJlujoKmNju1UfmFhXjPMygfCkb3cyO4YvFSP8awMQEtH00bF4GgK5etIOztbz1oFy
         iNjKZba8DU/denOA0eBMG41EUXRvd3RMVcPexwfvWkg/jqepauhJW2G3pwKHICy3ovqq
         q2ZvOfGXiFDmRUDH8Atjyvkv9MFTZV7koPx+K1gJ81IORH2Su5hsVwox8zJMyWe1yQBl
         MORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcQANuwMVsfVeTlJtKM7OPY8i3NO04NlAHvM2i8Ma08=;
        b=VK1xT8cfCf1pML8h6+kIxywhZiIDs84lH0RO9I3sLVrGXcIlegwfWduHJwhf+jl5PU
         u+I6NOfq7O89g3O33gP3BcrWexVPQYuIdzNWJuhjna8GXDOhvHXeHgIUtGYn+isSfZsU
         oyygsRl751rvuqd84Sv3DIYOcnRJCASacfhzwvALrgb/aUvxLscrfO+8o5Xb+mEh+AQy
         QGgQD+7iPTLXoEjvdFomuO4DTlyPlwdgQ7T2UihgvIbhkxFmNAsM3/Ll3gBR+RFxkORo
         lo8wYO/WYnRxjKtRRCUCftjLpqvOo1b1H1BQCibk5d3/yl57d4xJLAYLAF+ZIHwHXoSx
         8k2w==
X-Gm-Message-State: AOAM532CVVtFvbpRyLkfS5YcDaPxHYJbESyv2XZXLoCTJRYVah41YaxS
        gdJWsKYMiW+SkIRdMqCoRKHhq1P8e8HFJpI2uJg=
X-Google-Smtp-Source: ABdhPJzyQZJ8V3RiDDHD0lMQzli14ZMes06WEN6pPGujd24q7hYU604vWZQ/qfqyaTKApC5ibqHbu4I7U9kS9tKbEZM=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr63808389eji.434.1638231391724;
 Mon, 29 Nov 2021 16:16:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com> <CAPig+cToMeDdO2jnf18A8gPOZy_Jc=yN-uPTmBSuYJA6O+RMTA@mail.gmail.com>
In-Reply-To: <CAPig+cToMeDdO2jnf18A8gPOZy_Jc=yN-uPTmBSuYJA6O+RMTA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 16:16:20 -0800
Message-ID: <CABPp-BFTYNGeEoxnnuoz_8YiVfGf-fd2Du2g26yOCJ8uTDy-hQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Avoid removing the current working directory,
 even if it becomes empty
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 3:38 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Nov 29, 2021 at 6:10 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Changes since v3:
> >  * fixed bashism
> >      -+         if [[ $works == "success" ]]; then
> >      ++         if test "$works" == "success"
>
> This and any other instances in the series should be using POSIX `=`,
> not Bash `==`.

Ugh, I had them removed by the end of the series but somehow missed
checking the earlier patch.  I'll fix it up; thanks for spotting.
