Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBAEC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiBRTfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:35:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiBRTfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:35:36 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80003488AE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:35:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id c7so6792601qka.7
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZVpC3VAJ1slv7Jm0CDxNjvOPayhEhtQcFstvhvTjCho=;
        b=sjoL9/RmzxFlRkDiC2+tv6TiLZ/1rlJNELkF3j//QQKHdJFTVfuBhJtlYgVlqS6dnU
         H+nr+mnJW8FDmstvOSjKFTnXaG0nQBeCmmHsbpYxhNK2j1PstYkWtbCTiYkskPa6eaYs
         iRcPdOMc1KUsuObzaNfUW8lqiUhizhi0hCvHr9DaXxnIJkAQwI+0Wfy+yaxjPrld6w6H
         ifu2MGp5YLpN7RQgDyqirFCLTrG/VO0yGM+w+/K/v+TUgVT90CsQzZETo9ZRhSJFRv59
         l8GtKhRqW6UVJaZvy6xh3JxGklCiYNrTMNHNkroviIaDAzGVvf6lsQ3WoVTMcZ9wVKjj
         QFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZVpC3VAJ1slv7Jm0CDxNjvOPayhEhtQcFstvhvTjCho=;
        b=o/0RbF1uEZnrBySk0K8d4iCRpeom35EtlehobsQYJ+FaZLBNY182T8YJPiYingCHYE
         f1zsdBjSTRPFOqSIv9lZTB1tWOso1i5OWmf7lUEYkWr/p1x8bSzn4LexmA/twxtam6oS
         veNIybRoeu1T0gdJRj5iSh1Cgjdr/mutaiK2ZH4c26V2WBmwSU/P3m9uRtsm2RLTDtz7
         X+b7ZgobzsxQolKWvcHMeE9TMnhtPA4hRfA+0Oid9v6idj0wKoFvu+gRvj1gHYLsc3O1
         FjquuL5s2WG0Ht4Xtwc+u3D5d/9++xHRfkeduq4/pRBBx1I4Sb/J73U5lbcWxL58FX8v
         0tSw==
X-Gm-Message-State: AOAM532q5tK+uTnBSwsJYr1gPcrxRsw4rnRIrfj/+6fY36ESvrHKv69F
        8hWvbOG4imTOY8+667WzvIUtcw==
X-Google-Smtp-Source: ABdhPJwzdxew6HmGDYQ+lDRsIat0E7cSvm40Y+9wIlfgqOxsSaNRg+IHSEk28lLt5AOeaSJEtKLpbw==
X-Received: by 2002:ae9:ef09:0:b0:506:aadb:1f1b with SMTP id d9-20020ae9ef09000000b00506aadb1f1bmr5732060qkg.609.1645212918615;
        Fri, 18 Feb 2022 11:35:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g24sm22381740qkk.76.2022.02.18.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:35:18 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:35:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Message-ID: <Yg/09XYTruPJQVV/@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 06:40:45PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>
> Currently stash shells out to reflog in order to delete refs. In an
> effort to reduce how much we shell out to a subprocess, libify the
> functionality that stash needs into reflog.c.

Sounds great. For other reviewers, looking at this with `--color-moved`
if you have the patches applied locally makes it much easier to see what
is going on here, which is basically:

  - All of the implementation that used to be in builtin/reflog.c moved
    to reflog.c.

  - The function signatures and structure declarations moved to
    reflog.h.

> Add a reflog_delete function that is pretty much the logic in the while
> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
> builtin/reflog.c and builtin/stash.c can both call.

As you mentioned, the `reflog_delete()` implementation is indeed new. It
looks like Ævar reviewed most of it already, so I'll take a look at his
message before I end up repeating everything he already said ;).

It's worth noting that the subsequent clean-up to rewrite
cmd_reflog_delete() in terms of your new `reflog_delete()` happens in
the subsequent commit. If you end up rerolling this series, mentioning
that here may be worthwhile.

One question that I had which I don't see answered already is what the
plan is for existing reflog-related functions that live in refs.h.
Should or will those functions be moved to the new reflog-specific
header, too?

Thanks,
Taylor
