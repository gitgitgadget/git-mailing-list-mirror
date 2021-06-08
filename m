Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F5C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0740361375
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFHRbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhFHRbO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:31:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B6C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 10:29:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so21101997otl.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xQwVeYLBln2/RU5GK/u/7XCDlEmpNQzNGihz3B8e8Q=;
        b=SOjXj12rEeLuW9gB4nEN5J34YihoCXZMxrVJf9/nIVMGw155LCLlgV8+mCW8s4vQt4
         VtenDJjRuYQWDhZqkFmdQndhDXf8LREf0aGHoGB7tiL2FSINDqx5YYtLv8hJvhS+lnLJ
         hW/Ym6JxVqYcYs8NSMDARKZfnCFjWRZZVTOnF8KlQanP65SVnD9w8rBjwhHhWPlrzdBJ
         eQ1IXGOH/sJ+f3IqzlNDE79D51FJHA7xdsenB6NgwJtEKmjtsGc4ttxYCs4OcDsVFWVo
         D85RlXdo4MtJa3a3LKe6u4D0NG15YSFTYHicNbKPcUzWhiZuis6b+2O2iyvCWou7jvp1
         Ss0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xQwVeYLBln2/RU5GK/u/7XCDlEmpNQzNGihz3B8e8Q=;
        b=AyOpfjwQ9Hbt5FNjbPcwH2TPkiOpQDOhxkztPQ5XtC4u285E4aGM6yiPiIaFe+dQg/
         W2ESGgsSE9HEFpY2hAKc4p7OSkxb5FejgQFHQPRAMtz8r+uHITCNdvJNuil4jmPs1aXq
         jWtNU8Jg2n75YDR9dgA3K+vXvJobYncPDamCTIC08sBIVRXMOWE7cmf4QZzvc6YyTFg4
         OS/N5blLA/PjJvfAalZP7T83Hzk7vy2ZK77d+T2dYGrNCyhzvHqcy/5dOdmmphqdCCyw
         Ch3kFBhzcgw4u3PXWbkh7U5wTZIMfDFYD2gAl6lNTJiWPU5KNhy+q4/hAwW2Su/BkHe9
         Deuw==
X-Gm-Message-State: AOAM5317U2jzoO7cFjRc0mU/z33NNIcVh+SjS9vVVQu/IYQc/MfoJYkN
        VBpFotWHwn4r7sKcWn51esds5QZcHnVtCg2rjWQ=
X-Google-Smtp-Source: ABdhPJzXcYDMQt2DS5uOsRSuYC9wDJ+CuR69dLOAKorKwuDcXPaGvvfIrDe2iP0Pi1DkN47u2MKOJt+FblzbnzGUD5Y=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr18704942ote.316.1623173343947;
 Tue, 08 Jun 2021 10:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623111879.git.jonathantanmy@google.com> <07290cba86fda73ee329a47db8e524b32dba25af.1623111879.git.jonathantanmy@google.com>
In-Reply-To: <07290cba86fda73ee329a47db8e524b32dba25af.1623111879.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 10:28:52 -0700
Message-ID: <CABPp-BEn+yksK1KhncL8jWAya+ikGPUtsWpoZhrJrgRH2ORajw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 5:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Currently, the reading of config related to promisor remotes is done in
> two places: once in setup.c (which sets the global variable
> repository_format_partial_clone, to be read by the code in
> promisor-remote.c), and once in promisor-remote.c. This means that care
> must be taken to ensure that repository_format_partial_clone is set
> before any code in promisor-remote.c accesses it.
>
> To simplify the code, move all such config reading to promisor-remote.c.
> By doing this, it will be easier to see when
> repository_format_partial_clone is written and, thus, to reason about
> the code. This will be especially helpful in a subsequent commit, which
> modifies this code.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  cache.h           |  1 -
>  promisor-remote.c | 14 +++++++++-----
>  promisor-remote.h |  6 ------
>  setup.c           | 10 +++++++---
>  4 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ba04ff8bd3..dbdcec8601 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1061,7 +1061,6 @@ extern int repository_format_worktree_config;
>  struct repository_format {
>         int version;
>         int precious_objects;
> -       char *partial_clone; /* value of extensions.partialclone */
>         int worktree_config;
>         int is_bare;
>         int hash_algo;
> diff --git a/promisor-remote.c b/promisor-remote.c
> index da3f2ca261..c0e5061dfe 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -7,11 +7,6 @@
>
>  static char *repository_format_partial_clone;
>
> -void set_repository_format_partial_clone(char *partial_clone)
> -{
> -       repository_format_partial_clone = xstrdup_or_null(partial_clone);
> -}
> -
>  static int fetch_objects(const char *remote_name,
>                          const struct object_id *oids,
>                          int oid_nr)
> @@ -99,6 +94,15 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>         size_t namelen;
>         const char *subkey;
>
> +       if (!strcmp(var, "extensions.partialclone")) {
> +               /*
> +                * NULL value is handled in handle_extension_v0 in setup.c.
> +                */
> +               if (value)
> +                       repository_format_partial_clone = xstrdup(value);
> +               return 0;
> +       }

This is actually slightly hard to parse out.  I was trying to figure
out where repository_format_partial_clone was initialized, and it's
not handled when value is NULL in handle_extension_v0; it's the fact
that repository_format_partial_clone is declared a static global
variable.

But in the next patch you make it a member of struct
promisor_remote_config, and instead rely on the xcalloc call in
promisor_remote_init().

That means everything is properly initialized and you haven't made any
mistakes here, but the logic is a bit hard to follow.  Perhaps it'd be
nicer to just write this as

+       if (!strcmp(var, "extensions.partialclone")) {
+               repository_format_partial_clone = xstrdup_or_null(value);
+               return 0;
+       }

which makes the code shorter and easier to follow, at least for me.
