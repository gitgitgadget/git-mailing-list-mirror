Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0402C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEAQs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:48:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D70E73
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:48:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f4b911570so451648866b.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959703; x=1685551703;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StMDfSWSI2OaoSOo/hs8fditdpseTtAhAaFdeykdGNw=;
        b=Ba+BgfhBdfiiU46pbPJiJAisMsl18D7nAsU+TFUfj0emRrXL6oKe+S7MYjPQTcoNbi
         guoOU6jMKsbWpge29Gx157hOEAQhgHceU4iz2w42IdKReIjFAATfVMM6v6tJVIAY2gW1
         epIcn5TlwLsnmYiaSaUX8KgJBoLMkQsWKzNtozgb5mux19zwFcrQPJ6ahEp6fHU9VyY1
         jdgVTRdue5MueVRWpbYxErV61F3TxEIcwp1mRdGQ9DDalQ8av3iZKB6JFf2MxsN5UR9y
         A9mEA0cAkFLfwoBjl4ndD7bT+CMRtMGjdBeuYQuUvwmaTJJil0LlLRbAQE3qFSkB7+eo
         7kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959703; x=1685551703;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StMDfSWSI2OaoSOo/hs8fditdpseTtAhAaFdeykdGNw=;
        b=E09HVFausns6MRqFeFW4/XfCgNAug5AMhKaGsyZkD8j2wXrgs3YP/Vcuh2fF3EH/EV
         a6WP7PR2NevNTZ3ZkjL1fj/u5ADLEems4VAzzwZ6zXCb64DYT8vKNNo0LWn0v7moyNva
         7eGKU/YkEZsTHmYcGTKJiUs6JBszILBxb2P1qb95p900bEyAMJ0CqjhraJUg8cDmf7g5
         q/TkWesDNLWe9RN+lxKUvsMwl8vidwoHQglBs0KH1QZLjjsN5dWTaUl5PrPbbSlnwjrn
         K+Rsu+U83m0jmuxa2BKnJCaPYdJsFoC8T3NsJ1k2Gzr5IRP5NgpIW49ilWSB3gRUH1FJ
         NkXA==
X-Gm-Message-State: AC+VfDyzhuIkdCNmOe5rvjb8dwPHzh1P6vtG02f/8lxR6s1Y1BlfBlYk
        dX/T1ts9IwkpE9apN8HCEO3/quqjjSs=
X-Google-Smtp-Source: ACHHUZ4K03SWlPNH2Wcww0rRxcuLLavWQNUna1QzXGfzJ1aTNSEsWJ4g4qDLaw3d8A6s9NOs2Ggmcw==
X-Received: by 2002:a17:907:1ca8:b0:94e:fdec:67e3 with SMTP id nb40-20020a1709071ca800b0094efdec67e3mr12821223ejc.56.1682959702759;
        Mon, 01 May 2023 09:48:22 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090648c500b008c16025b318sm15040928ejt.155.2023.05.01.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:48:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptWhJ-000EN1-34;
        Mon, 01 May 2023 18:48:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 16/22] treewide: remove cache.h inclusion due to
 previous changes
Date:   Mon, 01 May 2023 18:44:36 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <960b5438ce494a29cc93501cdf4ba4745740f374.1682194652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <960b5438ce494a29cc93501cdf4ba4745740f374.1682194652.git.gitgitgadget@gmail.com>
Message-ID: <230501.86v8hchuay.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

The "Subject" says "due to previous changes", but...

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  archive-zip.c                 | 2 +-
>  bundle-uri.c                  | 2 +-
>  color.c                       | 2 +-
>  combine-diff.c                | 2 +-
>  common-main.c                 | 2 +-
>  config.c                      | 2 +-
>  copy.c                        | 2 +-
>  credential.c                  | 2 +-
>  daemon.c                      | 2 +-
>  date.c                        | 2 +-
>  diagnose.c                    | 2 +-
>  environment.c                 | 2 +-
>  ll-merge.c                    | 2 +-
>  match-trees.c                 | 2 +-
>  midx.c                        | 2 +-
>  object-file.c                 | 2 +-
>  packfile.c                    | 2 +-
>  pkt-line.c                    | 2 +-
>  range-diff.c                  | 2 +-
>  ref-filter.c                  | 2 +-
>  t/helper/test-match-trees.c   | 1 -
>  t/helper/test-mergesort.c     | 1 -
>  t/helper/test-oid-array.c     | 1 -
>  t/helper/test-oidtree.c       | 1 -
>  t/helper/test-parse-options.c | 1 -
>  t/helper/test-read-midx.c     | 1 -
>  t/helper/test-string-list.c   | 1 -
>  tree-diff.c                   | 2 +-
>  tree-walk.c                   | 2 +-
>  tree.c                        | 2 +-
>  wrapper.c                     | 3 ++-
>  31 files changed, 25 insertions(+), 31 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index ef538a90df4..d0d065a312e 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (c) 2006 Rene Scharfe
>   */
> -#include "cache.h"
> +#include "git-compat-util.h"
>  #include "config.h"
>  #include "archive.h"
>  #include "gettext.h"

I tried making this change before this series was applied, and
everything compiled...

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 6d44662ee1f..ec1552bbca2 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "git-compat-util.h"
>  #include "bundle-uri.h"
>  #include "bundle.h"
>  #include "copy.h"

That's not the case here, but this could instead be squashed into the
05/22 in this series, i.e. as soon as we add this copy.h, we don't need
cache.h anymore.

> diff --git a/color.c b/color.c
> index f8a25ca807b..83abb11eda0 100644
> --- a/color.c
> +++ b/color.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "git-compat-util.h"
>  #include "config.h"
>  #include "color.h"
>  #include "editor.h"

I did not look further, but all of the rest of these look like they'd be
better off squashed into the respective "split this out" commit. I don't
think keeping the "move declarations for ..." as "move-only" commits is
worth it, as opposed to getting rid of this one, and making those
atomic.
