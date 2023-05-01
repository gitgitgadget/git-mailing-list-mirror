Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C94C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjEARPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjEARMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:12:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4E3C14
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:11:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f4b911570so455574666b.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682961056; x=1685553056;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpwHZQp6E4mSWdj1SrmtBLkcd6xkBVv86fl9NSieQEE=;
        b=BXeRPYXJyFHpnIH4JJft3xBtbd7UgSY9ioW8AjGQJDK5dGPVIEMvYaloQBHrC8av9G
         rNe0+JGZbTmJSNNSfDu2sCMnyYO8v99XDrlvCni1q/3yvH6vOQmJAGzOTHzyCc1d3gz0
         3Eq91+COmWKT3d82dzcS650EBatEg1qGvY0O1e4tA1e+xgyEF/z7wRzipHUEjFSq8yPQ
         MGxxNuI4NJqUS8SFjnaa64GpgDEPz4rJ/29Og2TdJ9skmY2pcKNZdOc1lGlqebUndYlB
         een7BPd9KlIXiPRwGHEIhGXsIJ9atS/34Je1qeoh9N68d7ox/zYXInQ1g/P5EoUTVBBW
         ZhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961056; x=1685553056;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpwHZQp6E4mSWdj1SrmtBLkcd6xkBVv86fl9NSieQEE=;
        b=jL2k9dDPkIWyZ9liRFIa9OMLfVOql4YJf8XderH4HIS5Dlbuvdm8NzG2XbhjYi/N+W
         AvPsExYRAc8CGFTRBBxS2aKoVLprEyh8CeYtgra+yQIoKTGTJuZiSfcA11/YSK7adkhW
         HoljVMJ2WiDz8vrW3+SWodyz5tRzLl59HlKzgUGLK9BAji5rYLIADmp8uBJRhf7e/7d4
         U1uxhmCvAdp2fpY9pjSnDGOJ42N54DqGDQBjvVQyXCaANsBKAGGybDq/vWCNcCmKheUW
         XWuR47Dl2K+56ccGca1aBiDhw0i2kbZIcCz1GJpXgyTUte5OJGSiBUlSlaHjWfyrF6QG
         1ljQ==
X-Gm-Message-State: AC+VfDxPQt+kQLWJr19+4vNHhhuZ8fqQKTa1kQUAmTNYpgmXxFz0j2RS
        Xix+flUhUXWwL3CNZS/eVpcLR+pe1XQ=
X-Google-Smtp-Source: ACHHUZ6msDeIQmboNJnuAv0V75XX4A2LzQVO0Nj06MwOvOyUgr6FUfL0B7HH95Bz1PpTyeuAGdmILg==
X-Received: by 2002:a17:906:fe47:b0:94a:74c9:3611 with SMTP id wz7-20020a170906fe4700b0094a74c93611mr13923664ejb.35.1682961056415;
        Mon, 01 May 2023 10:10:56 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bv7-20020a170907934700b00959c6cb82basm10061244ejc.105.2023.05.01.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:10:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptX39-000F98-1e;
        Mon, 01 May 2023 19:10:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 20/22] object-store.h: reduce unnecessary includes
Date:   Mon, 01 May 2023 19:00:57 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <7705cbc2733a52cbaa53adc3dffab58f41eb4105.1682194652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <7705cbc2733a52cbaa53adc3dffab58f41eb4105.1682194652.git.gitgitgadget@gmail.com>
Message-ID: <230501.86ildcht9c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  object-file.c      | 1 +
>  object-name.c      | 1 +
>  object-store.h     | 8 ++++----
>  submodule-config.c | 1 +
>  4 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 8e0df7360ae..921a717d8a5 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -38,6 +38,7 @@
>  #include "packfile.h"
>  #include "object-file.h"
>  #include "object-store.h"
> +#include "oidtree.h"
>  #include "promisor-remote.h"
>  #include "setup.h"
>  #include "submodule.h"
> diff --git a/object-name.c b/object-name.c
> index 5ccbe854b60..88d839f70bc 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -14,6 +14,7 @@
>  #include "remote.h"
>  #include "dir.h"
>  #include "oid-array.h"
> +#include "oidtree.h"
>  #include "packfile.h"
>  #include "pretty.h"
>  #include "object-store.h"
> diff --git a/object-store.h b/object-store.h
> index f9d225783ae..23ea86d3702 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -2,16 +2,16 @@
>  #define OBJECT_STORE_H
>  
>  #include "object.h"
> -#include "oidmap.h"
>  #include "list.h"
> -#include "oid-array.h"

It seems to me that this should be split up, there does seem to be an
unnecessary include here, as the subject claims, at least the
"oid-array.h include in object-store.h seems to qualify.

Maybe the same applies to thread-utils.h below?

> -#include "strbuf.h"
>  #include "thread-utils.h"
>  #include "khash.h"
>  #include "dir.h"
> -#include "oidtree.h"
>  #include "oidset.h"
>  
> +struct oidmap;
> +struct oidtree;
> +struct strbuf;

But as this shows at least three of these weren't unnecessary, you're
just replacing them with forward-decls.

I think that's probably sensible, but I think it should at least be
discussed.

It's also not clear why we want to just stop at forward-declaring
structs, maybe replacing the dir.h include with:

	int fspatheq(const char *a, const char *b);
	unsigned int fspathhash(const char *str);

Would be too verbose, but if we did that we'd spot that
e.g. match-trees.c is relying on this header to get its "struct strbuf"
definition.

I'm perfectly fine to leave that can of worms for some later date
though...
