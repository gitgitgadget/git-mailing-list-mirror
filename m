Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98637C0015E
	for <git@archiver.kernel.org>; Sun,  6 Aug 2023 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjHFUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHFUJd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 16:09:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622BD3
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 13:09:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-cfd4ea89978so4205149276.2
        for <git@vger.kernel.org>; Sun, 06 Aug 2023 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691352571; x=1691957371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmBcogMohpEPfgPf/wISwXNERAJoFQjrsI1Tha6dWek=;
        b=12YavFkfyxCCVQZRF5mhL+XO7Qib1Kj0/VARRvu0LwEpoo/YY4P0ZDe6MB8k8aFajX
         7Jb8BiIrdV5ivwtYXaqydb4RmbECahEDvrPUejtiFejAzO9yWZ1202IbJ0nLKIDiMfG1
         /lmyvnCDvr8qLhmaJEAyh67TJd4NgRKSoz+TgepVM1rmQElxA6K84xFDR4VQsizr4Hld
         N7e19shhI9d9VGcZnMrOcwrf7DdncMul9A6WM1EsXJGLybGmBr0wQCiXmLAFA5Jy0/bv
         AN3jv9e+OoaJe46iGYYQJ05qlne/Hpa+L1DPAapqWURKeifaDH83h2hRl4tezR2tEaWL
         6e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691352571; x=1691957371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmBcogMohpEPfgPf/wISwXNERAJoFQjrsI1Tha6dWek=;
        b=QmMj6NCIHPa1Fz8jlpHOhRpOP5JV5nmq3wcXd8h+nUyIp6e1jV+V73mJSTSjfD9+nv
         1qoko8hPRu4nr3bquQZVG73/vpRiO7PCcW8i1DjYAl4T7Ig/M1h8bSL/MZHciWOATdnN
         xzblktsbWafbhhsWbjils36mDRr0BYUvCrI/Klg2ecUsMcUHIscqrgRhrIPWiNjxlODG
         xTDoXYtt9N8zCRmLQF0+fZvIrb3RPsERdxVJ9SrPLKoRy2MiV4tQgYKEwkcCKidaRx+z
         PCZzrYvpED0+A/WdXg1BGGYT5RFgr2m4qHO1+1H/QVrp7My8PZNcrc+8Kc0fhWXF/4AI
         CmPA==
X-Gm-Message-State: AOJu0YwyzZk3uzHAIyNEb0UIkXhln6Y8WAZKfNrATpXwzD0NtwJKi9xN
        W7uILr5TMASGNCJfa4isJnY/KUxSsz3qMcmteAe2vA==
X-Google-Smtp-Source: AGHT+IGpbVpwHkJqPQJzkCg07T0SuQGisFJGebkwTvKWp5sFqYfxUviwDn8V8DVEEkIRi+RTf3MGBw==
X-Received: by 2002:a25:73d4:0:b0:d0f:2038:9ca2 with SMTP id o203-20020a2573d4000000b00d0f20389ca2mr8281625ybc.51.1691352571286;
        Sun, 06 Aug 2023 13:09:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m184-20020a2571c1000000b00d06d47fd0b8sm2009610ybc.53.2023.08.06.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 13:09:30 -0700 (PDT)
Date:   Sun, 6 Aug 2023 16:09:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Brooke Kuhlmann <brooke@alchemists.io>
Cc:     git@vger.kernel.org
Subject: Re: Git Commit Notes (fetching/pushing)
Message-ID: <ZM/9+YyOAbWWXQtC@nand.local>
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 06, 2023 at 12:35:50PM -0600, Brooke Kuhlmann wrote:
> I'm noticing issues with GitHub and GitLab when fetching and pushing
> commit notes and wanted to know if there is a correct way to configure
> my Git configuration for working with these servers (or maybe notes
> aren't supported at al)?
>
> Here's my configuration:
>
> ```
> [notes]
>   rewriteRef = refs/notes/commits
>
> [remote "origin"]
>   fetch = +refs/notes/*:refs/notes/*
>   push = +refs/notes/*:refs/notes/*
> ```

It looks like your refspec may not be doing what you think it is.

Here, you set both the default fetch and push refspecs to
"+refs/notes/*:refs/notes/*" which means to update anything under
the "refs/notes" hierarchy on either side, even when the updates are not
fast forwards.

Since you overwrote the default refspec, you end up only pushing the
notes, which we see from the response that you got back from GitHub:

> remote: Resolving deltas: 100% (1/1), completed with 1 local object.
> To https://github.com/bkuhlmann/test
>    5811bd44c32b..0f2422597c5d  refs/notes/commits -> refs/notes/commits

Indeed, refs/notes/commits is updated on your bkuhlmann/test repository,
which I can fetch from:

    $ git remote add origin git@github.com:bkuhlmann/test.git
    $ git fetch origin 'refs/notes/*:refs/notes/*'
    remote: Enumerating objects: 41, done.
    remote: Counting objects: 100% (41/41), done.
    remote: Compressing objects: 100% (29/29), done.
    remote: Total 41 (delta 14), reused 34 (delta 7), pack-reused 0
    Unpacking objects: 100% (41/41), 4.66 KiB | 1.55 MiB/s, done.
    From github.com:bkuhlmann/test
     * [new ref]           refs/notes/commits -> refs/notes/commits

I suspect you want an additional refspec that gathers any branches or
tags that you want to push along with refs/notes/*.

Thanks,
Taylor
