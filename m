Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CE7C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE358613E9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFCCV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:21:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB425C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 19:19:29 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id br4-20020ad446a40000b029021addf7b587so3303509qvb.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=53lBjGEarBgfCI66hGS/bgWWiKyKJcUvpVawd0WZ/+Y=;
        b=PAGbKee5OmGngeapWjwJ5oKVF3lrIGFsgpD7Agh5fptrywmwV05f2Rh3pjv06QlySR
         VslatyGj5QZKJsYas3Nr/EwYH5Wy8CZW2PRy2FGIDSXH7QRr9WzYLPTPhgJMPBagOSAO
         kECj1AmDqpy+HU7VX7aKZ6zo+9o9kutnmissEdA9g3fzJEd15lP83d07Iv77/fFr0pDN
         GHDmR1pIm9MtJ+VrSg+9wRoZZxagddUfYMssK3rJEpM3V/HnhtmKRwbkXS51L5nrVQQV
         wL2TaZ1tc0GrAeNHkjEtPJTumSGW8Vo/pcF9Y0bK4y/6niTR7CUyb4VCZ/u5AjNo9N2Y
         o3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=53lBjGEarBgfCI66hGS/bgWWiKyKJcUvpVawd0WZ/+Y=;
        b=gusjW8KqhzwRGehZK+I4MRRyluc0lTdNBQvZWilOUKegrdM2UMZxzy7HygArFvHMqt
         026QLz/0R+sgZr8RpxvsHd4UXwk7bofeXTor4iL3kw/RlFWn5yYAIei7nPCmfiQ5Yc2O
         ZMIwz/c/Duk98vFtmxOHqNjb1BzKNDruIjOn7PhBprvvqBxXK+eXVUkZhcrc30veWkGw
         vpvlArDg+fDNIJObaMaYU4Ds6U3rnerlu9T6a+DoW2zL7sV4EDMwAYgqMVmPM6CcU9oC
         RPvXIuWEJgM/nLd1FRKYVVICtP/7yGsiF4ED7xkNJCke2rUpEnojrlf0EuNRLvlKZ1uR
         hVtg==
X-Gm-Message-State: AOAM531+I+u1ETW/NvNYx1VxiaYhWuQeNp2PuSkxjrcEq0AEAwIIlWYL
        Db9o2uUFEVc8DUxayPzN4dr7spUK/o44SbMRSc52
X-Google-Smtp-Source: ABdhPJyqHeh/KeTaz7hw9qyrTg4Fe6qg1hcGGYz+0XAAchu+MYhBUXG4t1rmhVDuvKEC8oZMlyL2THiFlAK7WAnMkAZ9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:c492:: with SMTP id
 u18mr31307846qvi.40.1622686768993; Wed, 02 Jun 2021 19:19:28 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:19:27 -0700
In-Reply-To: <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603021927.343351-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 1/8] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
> references.
> 
> The files ref backend does use EINVAL so parse_loose_ref_contents() can
> communicate to lock_raw_ref() about garbage following the hex SHA1, or a short
> read in files_read_raw_ref(), but the files backend does not call into
> refs_read_raw_ref(), so its EINVAL sideband error is unused.

Does this mean that there is some code that sets EINVAL, but no code
uses it? If yes, that seems to mean that we can't remove EINVAL from the
documentation, since some code still sets it.

> As the errno sideband is unintuitive and error-prone, remove EINVAL
> value, as a step towards getting rid of the errno sideband altogether.

How is removing one possible value a step towards getting rid of the
errno sideband? I would have thought that we would be working towards
transmitting all existing values to the new sideband (the out param).
Unless we are planning to get rid of all values in the sideband - in
which case, this should be described in the commit message.

[snip]

> ---
>  refs/refs-internal.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 467f4b3c936d..29728a339fed 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -617,11 +617,10 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
>   * properly-formatted or even safe reference name. NEITHER INPUT NOR
>   * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
>   *
> - * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
> - * and return -1. If the ref exists but is neither a symbolic ref nor
> - * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
> - * EINVAL, and return -1. If there is another error reading the ref,
> - * set errno appropriately and return -1.
> + * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
> + * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
> + * broken; set REF_ISBROKEN in type, and return -1. If there is another error
> + * reading the ref, set errno appropriately and return -1.

The rewrapping was unnecessary and makes it hard to see what changed.
