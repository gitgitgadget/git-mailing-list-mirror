Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E9C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiDMStp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDMSto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 14:49:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6515D1B9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:47:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so5776100ejd.9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VWNvNFy1S3fQf1t34kR6D9ZuSvWt0Jg1y1qfgKWn8bY=;
        b=f2fW/BefhPBmvT32R6kAilYpg34mGH6dEj/2N52TtFwGM8mI2TtP9WDX7jS/6GY6Eb
         TU3OFShyEjNGywMiKo/GTtpJltCdShuy7u7qbp+jENKkEdo/BHdDk0+xFX+4+ifJgH/f
         VFT3r/plPWNuC+kV3LYOD5IgyUxw8YN7NBeYp+/eAzDg1gkLqkc1YeQ+ROQpwe4h2fuL
         motnGFNnDDfL674a+7prJEDV9XTjJQUZvhd73TcakWtq17LBpMwLBmmzJRB8KKOQql+2
         Rp2+f+5ohkqJYr8qpUGOGAMQdMJsid+7qM0+aZ5nK9yzJJV3VA7iSnhRM1iy2Ebri6c8
         HTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VWNvNFy1S3fQf1t34kR6D9ZuSvWt0Jg1y1qfgKWn8bY=;
        b=z3QGYO+BF7TLpc1CW3kYV50pBpq8CtBwDkybC4X1iYQBizE0daTxRRZHvQM8wf5CIv
         sxQfto6oJGpDORDAeie+rl+uee5ZRAVSjs7WEuzOd9pcSVKpyUcI2TODJetinq1TUhUH
         dHB5hS/ThnxSeT4WWPPp3TwrZ5gkY1bbHj+l5OaVmjcCwvpL828cPZSgdC1kXw/6sCLF
         sr9/FNZoiZQguMNmSSWi3bhrxQN9WuNr8BpyrZYd9JVGmoKqeMaauf2d/WwlDUa+bNjq
         mC31FHJGyxAu1J9andhJM78Hq2HZy0h7E+82f2C1ihHD4UQgEdNGn/SLqxmh9UpVTEsG
         hCdQ==
X-Gm-Message-State: AOAM532iUg1n1iHh6Ju9NiZ7iL8zjwWXaeOGwp3D5Pi5/ObkaWQVg4kt
        3VDkskbJfGjXzXbimv1yqq5s6xQbXPs=
X-Google-Smtp-Source: ABdhPJyRYpZ/DLi92T62WDrrPapvDvn6QC8DhHhZqCsjAdIsTmdSyEiPUxoFGmljEUXSy76WRl2/+g==
X-Received: by 2002:a17:907:980a:b0:6db:799c:cb44 with SMTP id ji10-20020a170907980a00b006db799ccb44mr39837087ejc.485.1649875640013;
        Wed, 13 Apr 2022 11:47:20 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1544392edl.22.2022.04.13.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:47:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nei1P-0059Nq-1R;
        Wed, 13 Apr 2022 20:47:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory David <gregory.david@p1sec.com>
Cc:     git@vger.kernel.org
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
Date:   Wed, 13 Apr 2022 20:46:01 +0200
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
 <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
Message-ID: <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Gregory David wrote:

> [[PGP Signed Part:Undecided]]
> Thanks a lot Aevar!
>
> Don't you mean this:
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 330b0553b9..2a5c31729d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -881,7 +881,7 @@ int cmd_show_branch(int ac, const char **av, const
> char *prefix)
>                                        get_color_reset_code(), ref_name[i]);
>                         }
>
> -                       if (!reflog) {
> +                       if (!reflog || !rev[i]) {
>                                 /* header lines never need name */
>                                 show_one_commit(rev[i], 1);

No, but my "suggested" fix was just enough to compile and get past the
segfault, i.e. we don't reach the puts(reflog_msg[i]) branch, but of
course rev[i] may be NULL too, I didn't check.

For this one though: I haven't tried it, but reading show_one_commit()
one of the first things we do is dereference the 1st argument, so surely
that will segfault too...
