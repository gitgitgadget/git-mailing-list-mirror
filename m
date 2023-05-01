Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAAFC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjEAQfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:35:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C1E5B
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:35:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f109b1808so541971666b.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682958937; x=1685550937;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9cFYLGMLctBOobSq3Fpupa8P8HUGIYsn/UDrr63PDY=;
        b=YCy1N454Hrv13NsAhMocFal8oB2LsGHOQk658lf++3oe6WOWJOgklEdw2dHNnrBzCE
         x8o+RYZ3YMtWh7nGIIAbFBYIU6oEtKFIo242fVnbBn1iBbjc5fgItWdqQoO3f67kp0rM
         YCGgKiIb4GlVn4La8DXCaw8hyVFILXaG4VDcv0jlStHtlDotvZj7rHnOxTl0/ug5MpOK
         +1f4P6IS5SM7j38+rvYflbHx4YtBWaT7aNWWsCHY23Q/LWKlVgOh/pjGf/fx2Stc77iJ
         snts2znZ/cthJepeq1Y0zEvZ848G9EbOGuL5DbvV15rKHQyGTbnDBXkGfmdZf7DRA0JU
         zxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958937; x=1685550937;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9cFYLGMLctBOobSq3Fpupa8P8HUGIYsn/UDrr63PDY=;
        b=jQUKb35Jst/Oddgae5SLhC8jLUgDnBcyYTxMTna76/wKOwl9BLxUpBCYKuNwZiYd59
         m/kM+lrFhcekd1xdypyU6q2B4qwAphXcQjltEcSNyN8OXZYiLoyEjM8TJElgCePGapNI
         lQEF6zOnDzHy1YXvNuPrf/9G+KX48adzfe42NH+lKoJXIkdUMNsX0jJsM5UpUZMp1PVO
         +NpwCfMni7haF5MJAQ4Yrhh3AZHCqWOErS1vLSfkFkQv+wMCUHsuDa+NzOHWBZ2azBji
         MRqaL4bxcsRY6lPJJ0Nsopobr8pg64hKvug3GPfw0HURuRTRgBVtOona+T59wLQAxA3m
         +f7A==
X-Gm-Message-State: AC+VfDxeHX2xps9jpwCcpk5PzdX562LwMqt2E1bVA0Te3DrXYekV6kS5
        X0LC22BrD86uKbEGJ92txwkBqV+4h84=
X-Google-Smtp-Source: ACHHUZ4uFh66odvlTPndWeQMBmKjsgFsvfbGX1PtyHOWBbz5OqSYNVHoO7o3muRHWBnIZ7WWjSvA+Q==
X-Received: by 2002:a17:907:31cb:b0:94f:a8fd:b69f with SMTP id xf11-20020a17090731cb00b0094fa8fdb69fmr14108945ejb.18.1682958937411;
        Mon, 01 May 2023 09:35:37 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id wz13-20020a170906fe4d00b00959c6b9dac8sm10001117ejb.197.2023.05.01.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:35:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptWUy-000DpK-1E;
        Mon, 01 May 2023 18:35:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define
 from cache.h
Date:   Mon, 01 May 2023 18:33:58 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
Message-ID: <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> S_DIFFTREE_IFXMIN_NEQ is *only* used in tree-diff.c, so there is no
> point exposing it in cache.h.  Move it to tree-diff.c.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  cache.h     | 15 ---------------
>  tree-diff.c | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ad741e70bc2..7a46f300d9b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -10,21 +10,6 @@
>  #include "object.h"
>  #include "statinfo.h"
>  
> -/*
> - * Some mode bits are also used internally for computations.
> - *
> - * They *must* not overlap with any valid modes, and they *must* not be emitted
> - * to outside world - i.e. appear on disk or network. In other words, it's just
> - * temporary fields, which we internally use, but they have to stay in-house.
> - *
> - * ( such approach is valid, as standard S_IF* fits into 16 bits, and in Git
> - *   codebase mode is `unsigned int` which is assumed to be at least 32 bits )
> - */
> -
> -/* used internally in tree-diff */
> -#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
> -
> -
>  /*
>   * Basic data structures for the directory cache
>   */
> diff --git a/tree-diff.c b/tree-diff.c
> index 69031d7cbae..a76e6dae619 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -6,6 +6,19 @@
>  #include "diffcore.h"
>  #include "tree.h"
>  
> +/*
> + * Some mode bits are also used internally for computations.
> + *
> + * They *must* not overlap with any valid modes, and they *must* not be emitted
> + * to outside world - i.e. appear on disk or network. In other words, it's just
> + * temporary fields, which we internally use, but they have to stay in-house.
> + *
> + * ( such approach is valid, as standard S_IF* fits into 16 bits, and in Git
> + *   codebase mode is `unsigned int` which is assumed to be at least 32 bits )
> + */
> +
> +#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
> +
>  /*
>   * internal mode marker, saying a tree entry != entry of tp[imin]
>   * (see ll_diff_tree_paths for what it means there)

As it's only used in tree-diff.c, should this change not be instead
changing how we define S_IFXMIN_NEQ itself, and combining the two
comments seen here (the latter only partially, in the context).

Not that this makes things worse or anything...
