Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2B4C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C14613D8
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhDWUVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhDWUVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:21:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5ACC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:21:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d6so19066445qtx.13
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nUVye4fpLEO+4cBm7OmJ3cGzC2nQvxXcQi0Wcczr4E=;
        b=1L1VxZb7t7gDdVt+CKMMBLk0LbbZuyjWtZG79sNCnavwnVMTXUDYclanC6JVIeX6hc
         OOW0fQfDreCObqIuuwpNjhY34lNHOIuvKlkMyOw4kPu2W6fSFrmSmM4ljH1Rn/jStIDG
         hKVpAA/hwivWh5lzx+Fng6aT9MSAf8sKCsXFmK/pQX6AozrXejMTRA5eIeQ4XdrVKQQE
         PCP0zd0ZM5hIqv8V4OgjopJzqjbQWOIFbbeU9rw9KMYsXxyYH7Ru3zmNK0/i3iGYGZ2g
         iSFWipaZe4vHvAhj+8L4FYlCnLh85/BzQi/iisa5MSAUXtLrymAtCKAB5Hvc05IgexIs
         GGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nUVye4fpLEO+4cBm7OmJ3cGzC2nQvxXcQi0Wcczr4E=;
        b=G6wSkwc2e2GbiF3K3BMjsIavdS4+N1rc4/2k09l46q7NI3bDmGhl9IIg8OCjUCYSLQ
         4uGq+pUxF2PA6yNriIhOnf7KTpXJX9Q9EPwMsy2Kfb3zG8iL379UM/SqGamtlD27lM4+
         7S9G93R+1cdsd+E7cCML+hfhMXLn4gS+gIvZChcpvi3kGWeX0mpiYCaTRFy3GSdZSH/j
         EuYB/9yKawgfejb9HUwweg0VpGAKcmnSbIO8Jny9FwQO9gcDeQSrcgYTxpCqHFpehaZp
         bIg5hXj0YM4R3EFNwttIaIJCJdRTrQknP+tZ4wva4G3pLbUTdr6813MuJ31qDpuIM95/
         9Qig==
X-Gm-Message-State: AOAM533lb+05Mg+q+4lRPSlRLWmulBSm7Cxm8U1ZA+heIzIbaB8qIsxX
        URNKqnly3bdmjU1JKfp80Z1MDg==
X-Google-Smtp-Source: ABdhPJzUtX8C41aJ/6iBR057zJkPRJmhTAcGw2ee94NQo+QQgQ2gb5qM8Q4o69O9SjygQaxcwTG2sg==
X-Received: by 2002:ac8:6a19:: with SMTP id t25mr5493875qtr.35.1619209275838;
        Fri, 23 Apr 2021 13:21:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:12af:f0c8:3e42:7659])
        by smtp.gmail.com with ESMTPSA id v10sm5075657qtf.39.2021.04.23.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 13:21:15 -0700 (PDT)
Date:   Fri, 23 Apr 2021 16:21:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] pretty: provide human date format
Message-ID: <YIMsOV/O2Ss+qaeK@nand.local>
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Fri, Apr 23, 2021 at 04:27:25PM +0000, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add the placeholders %ah and %ch to format author date and committer
> date, like --date=human does, which provides more humanity date output.

I don't see a reason why this shouldn't exist, and the patch that you
wrote below looks pretty good to me.

To refresh my memory on if you had missed any spots, I followed
0df621172d (pretty: provide short date format, 2019-11-19) as an
example. You did a fine job here, and I don't think this patch is
missing anything.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] pretty: provide human date format
>
>     Reasons for making this patch: --date=human has no corresponding
>     --pretty option.
>
>     Although --date=human with --pretty="%(a|c)d" can achieve the same
>     effect with --pretty="%(a|c)h", but it can be noticed that most time
>     formats implement the corresponding option of --pretty, such as
>     --date=iso8601 can be replaced by --pretty=%(a|c)i, so add
>     "--pretty=%(a|c)h" seems to be a very reasonable thing.

Just to make sure I understand what you wrote: you're saying that the
pretty formats "%ah" and "%ch" that you propose here could be achieved
with --date=human and --pretty="%ad". Makes sense, but I agree that your
point about --date=iso8601 having a built-in pretty atom makes the case
for having "%ah" and "%ch".

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/939
>
>  Documentation/pretty-formats.txt | 2 ++
>  pretty.c                         | 3 +++
>  t/t4205-log-pretty-formats.sh    | 6 ++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 45133066e412..9cdcdb8bb414 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -190,6 +190,7 @@ The placeholders are:
>  '%ai':: author date, ISO 8601-like format
>  '%aI':: author date, strict ISO 8601 format
>  '%as':: author date, short format (`YYYY-MM-DD`)
> +'%ah':: author date, human style

There's no sorting here, so this place (at the bottom of the author-date
placeholders) seems just as good as any.

>  '%cn':: committer name
>  '%cN':: committer name (respecting .mailmap, see
>  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> @@ -206,6 +207,7 @@ The placeholders are:
>  '%ci':: committer date, ISO 8601-like format
>  '%cI':: committer date, strict ISO 8601 format
>  '%cs':: committer date, short format (`YYYY-MM-DD`)
> +'%ch':: committer date, human style

Likewise. The rest all looks good to me, too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
