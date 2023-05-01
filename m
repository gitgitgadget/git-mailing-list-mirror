Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E92FC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjEAQuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAQui (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:50:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2B10C2
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:50:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-956ff2399b1so568242966b.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959835; x=1685551835;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WlXfJJY6btS0bSzoaM2URq2GEDoeMXRRE6XyWOd5pE=;
        b=EPiBasaqd4Rkd/Aklr84/AVKoX60rl9XZ1aGZycr7S2uU65x9Cj6wMXbiEi1lK9ji+
         QjPFX/dJA/KifPCry/88U8zK//iZHFtMeeWqqc0LMa42OEFXQwnHIRMexZWWJf0cJvKK
         pxuu3s1NW2bSK9LkXMLOLTX+3tJ7hUO1OrthCHx2S/oGyG6uCkrq+UcxJasvE0CmmDYj
         GU4BUnDw2S/IVzzTRadghdhUIAwUQHIZOLy79BsJz8SdXEGsQL2aAzySftKE+jz0ClJA
         807tCtFoXbomqbS5tPsxCtNwcLA7QQEeIJlGOfAK9GmDfTloDVxvvqqefIiV48nTJb0w
         cTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959835; x=1685551835;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WlXfJJY6btS0bSzoaM2URq2GEDoeMXRRE6XyWOd5pE=;
        b=iRc13BvSX3zOqXKaYt4fS5H/vUYymd8f08umcIJl1ZTe2g/R/6lYZhHn3QMTnca0Ti
         WtDmyhrAfs1Pe8nWwo3R9P2RR4TQEnGBkFfXy+jDKsfmW2HPIgNKwIbIdRuVhut0CYHp
         SX+P53KFvzxbEpP5QpPi88yAS/dTSj491VNYXuD4ND2k2druXS7xBZGETx0r2tiWXyj9
         B2vV2kxtB69CyaG5AnOWu7s8LDxo2VDba3YYW8MB4ZLXugO3WL/bPQcLqDa6JT2O4rUY
         urQnj5AhgX+xZVHUKg5S9SgNfhbcEeOgC4C0lLRueaBVWsBEwfEWke5sA5DPQtqTg2On
         MWMw==
X-Gm-Message-State: AC+VfDxXp6b7DpdaTMvI8Adf2iWDfOjOP+SCC0sYe40vP7tjS/TUf9BE
        oeL55YgFWzUJP9kFJ6NvFuiPeuzcLF0=
X-Google-Smtp-Source: ACHHUZ7rifOTG3TMquqXMS7sfEzGb1/jSUneNxAfpk8pSYneoEPxhxtPZ/4NsFUpmqT+hAHrwd6L9g==
X-Received: by 2002:a17:906:d54f:b0:94f:2a13:4e01 with SMTP id cr15-20020a170906d54f00b0094f2a134e01mr15851302ejc.74.1682959834869;
        Mon, 01 May 2023 09:50:34 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090681c100b0094f67ea6598sm14955387ejx.193.2023.05.01.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:50:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptWjS-000ESe-05;
        Mon, 01 May 2023 18:50:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 17/22] cache.h: remove unnecessary headers
Date:   Mon, 01 May 2023 18:49:29 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <b459b60de89750d0226c7c4f1c7c28de249b475b.1682194652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <b459b60de89750d0226c7c4f1c7c28de249b475b.1682194652.git.gitgitgadget@gmail.com>
Message-ID: <230501.86r0s0hu7a.gmgdl@evledraar.gmail.com>
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
>  cache.h                              | 2 --
>  compat/fsmonitor/fsm-ipc-darwin.c    | 1 +
>  compat/fsmonitor/fsm-listen-darwin.c | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 591c67b0595..bdedb87e83b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -4,8 +4,6 @@
>  #include "git-compat-util.h"
>  #include "strbuf.h"
>  #include "hashmap.h"
> -#include "gettext.h"
> -#include "string-list.h"
>  #include "pathspec.h"
>  #include "object.h"
>  #include "statinfo.h"
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
> index e62f093cc19..bc68dca0cae 100644
> --- a/compat/fsmonitor/fsm-ipc-darwin.c
> +++ b/compat/fsmonitor/fsm-ipc-darwin.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "config.h"
> +#include "gettext.h"
>  #include "hex.h"
>  #include "repository.h"
>  #include "strbuf.h"
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index 5eb6402ab82..18c0e3913dc 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -29,6 +29,7 @@
>  #include "fsmonitor--daemon.h"
>  #include "fsmonitor-path-utils.h"
>  #include "gettext.h"
> +#include "string-list.h"
>  
>  struct fsm_listen_data
>  {

If I rebase this topic to make this the first commit everything
compiles, i.e. nothing here relies on what came before.

Given the extensive earlier moves I think it would be better to first
remove unnecessary includes from cache.h, before starting to split it
up.
