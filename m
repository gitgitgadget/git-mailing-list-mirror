Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1CCC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8008A64FFF
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEATV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCEATV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:19:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B08C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:19:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t26so130688pgv.3
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ikfCTwEbDg86NEXUuXvPwidoS90Y53fyKcy0PZBXRo=;
        b=QKfYhk6OE3b6TJTEMSLYjALkFI/IBJuxHJaCv5akMwLUSdQtgb4g8RfJiSP4Pn5CTK
         0IfIdbwOmpFjoqOroZH9uMhdz2fHG0o0MhPdnvuaUZd2Ji2NIkn4iYCAPr37YYqLLWOM
         bW7bJ3DldPecmvDqE9fkbwvONHQm7XE4vEFnwievp1aX1/VznhyToF8JLpXtcJzP/HVW
         MONz1oAGNgnEm/IQ1/ncNknch+vYcgxLAIFaMYeRT3neS9kVlvQtfy9M1gLpfsEZjhsm
         GCkQb1ZXd5Ianh4JCMYXcg+4TzKyAB97dpv8JGkYo/FigFsUQViJHCLjIXRyqo1VcrZ2
         dHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ikfCTwEbDg86NEXUuXvPwidoS90Y53fyKcy0PZBXRo=;
        b=hLzqMcHlyGu2YLhK8gag27YwpJjospQr8yMbZunZBHMtIw/BWEWC8AoSNrTGB3yD1Z
         SHuMDDEaX3x7SYqGPudekVNepicUS4QGJ7TFEMpNqM46jGdQKXzy8cvFD4w6bHEka3Ry
         vg71nW8gv1qyf4vnZmpokqyEdTt6eGIndRHJSRd4K13W0vK9K1lX0ta6h/5s+h/iNoOQ
         Y/6njmJv89kcJX8b2KOXdoV4C8fwvuoquWUPwilViM+H6h/l1rye8mAXt6Dm5KzXQxkj
         geGCyqQz4DGbKjm1MClpCm1+uFPlJ+arg82zrNv18QCzr8DzI/4VwCigZfBITQA/fAxz
         ybgA==
X-Gm-Message-State: AOAM531Fh09BaYMKFeADjaURfKs9ls02v220Rv9q0nk1JoHZlOrCg8oP
        1t4dcDSIjLCODpN/s2jrUuM=
X-Google-Smtp-Source: ABdhPJwialbkJJ6ra1LRDoJauRobqoye+UEziX5jw/ZDfr/toy/uiZ33hLePODFOm1oSCiY2B52TJA==
X-Received: by 2002:a62:2acf:0:b029:1ed:5dbb:717a with SMTP id q198-20020a622acf0000b02901ed5dbb717amr6002950pfq.39.1614903560851;
        Thu, 04 Mar 2021 16:19:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:199c:b0c3:47a8:7430])
        by smtp.gmail.com with ESMTPSA id h186sm470118pgc.38.2021.03.04.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:19:20 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:19:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        Nathan Mulcahey <nmulcahey@google.com>
Subject: Re: [PATCH v2 2/4] http-fetch: allow custom index-pack args
Message-ID: <YEF5BfE6eXmhhiAf@google.com>
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1614021092.git.jonathantanmy@google.com>
 <57220ceb841056aade08705ca0ac73ccc69f05ab.1614021093.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57220ceb841056aade08705ca0ac73ccc69f05ab.1614021093.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Tan wrote:

> This is the next step in teaching fetch-pack to pass its index-pack
> arguments when processing packfiles referenced by URIs.
>
> The "--keep" in fetch-pack.c will be replaced with a full message in a
> subsequent commit.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-http-fetch.txt | 10 ++++++++--
>  fetch-pack.c                     |  3 +++
>  http-fetch.c                     | 20 +++++++++++++++-----
>  t/t5550-http-fetch-dumb.sh       |  5 ++++-
>  4 files changed, 30 insertions(+), 8 deletions(-)

This is producing an interesting symptom for me:

 git init repro
 cd repro
 git config fetch.uriprotocols https
 git config remote.origin.url https://fuchsia.googlesource.com/fuchsia
 git config remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
 git fetch -p origin

Expected result: fetches

Actual result:

 fatal: pack has bad object at offset 12: unknown object type 5
 fatal: finish_http_pack_request gave result -1
 fatal: fetch-pack: expected keep then TAB at start of http-fetch output

Thanks to Nathan Mulcahey (cc-ed) for a clear report.

Bisects to b664e9ffa153189dae9b88f32d1c5fedcf85056a, which is part of
"next" and 2.31.0-rc1.  Another report of the same is at
https://crbug.com/1184814.

Known problem?

Thanks,
Jonathan
