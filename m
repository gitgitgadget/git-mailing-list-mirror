Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CC1C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiAULnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiAULng (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:43:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F8C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:43:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m11so41826281edi.13
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6dM+29gNc613S4J9T016DeOVEMv9WQeK5vaZGNF1LrA=;
        b=IMUbri3iMxzxIHgtDnVie8TlDo3BehQJ/deOqT20Z7AYfqC8Jefcc0YvFvDjW4vL+A
         5tbyUnYoCM8eSHocXU0zC8PlrD/hmeW3+JvUk9I8YUHAQqtUkFWuTtp04kyLPT6LurgX
         QMZUNCz9V0/RIYSwSjMwE3kXlUXnG9NOdlcqh0qKjTe+nhrEapmxGMnS4G7e/qtq0nbS
         7FIxsolJii7fplH7tuONOV2ExsmrsS6C2xa/FIbNtlK1ciGPAE446p903tRh1PcWQlDz
         lXilD7CAZ0GHm21R6cMj/lt+HkH5P84PPGB/+2EnOyCmDXuUpARpLPKsJP7qCWtrq8y1
         1+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6dM+29gNc613S4J9T016DeOVEMv9WQeK5vaZGNF1LrA=;
        b=ls8G2OgHXzKNhphAvq2WU8VxtuzLDm50j2dnnI6RAYm/aLytZp858NH4VrlG4GIrkZ
         aXtKvi7oMgzHK4WEO/CD4fAzrBmutbVwSaP0kYMqq6fBycKNiyGGnBCsXq7207T8/l+v
         lYD9w9hqJ1Vf5dQQT/DwOL8PY/rlygPlRcWvyNeH9kkDXtC/7iYPo2W70K+xU1s+b/0G
         8q6ymVWVsPA/yEIQRZDqOeSTJEniKjoOMO/rTyvd8AEKj4+hLiZa9e0XZ85BmDORAhr3
         SZbynJA9U1nogWBEqI+sn2eWCFSkdVUptiucT9mdfdw4FB+IVuu/uamOjyqDmvry8Rb6
         ON3A==
X-Gm-Message-State: AOAM5339682tzVD4aHgdlG0eJKbRBCBrZE2V4CuGdwkKS15qj8Mm9dT1
        BM3otf0Oi3bXz7mh+ZVaf0MDfU9//MONcw==
X-Google-Smtp-Source: ABdhPJxY+keVL5yR0yW90eJyL2dhPCnC6POx23mo7I2WY458jpY61KfR34oatXKr9khSWnO6bR+oMA==
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr3126876ejc.172.1642765413812;
        Fri, 21 Jan 2022 03:43:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g24sm1984630ejx.11.2022.01.21.03.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:43:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsKK-0027Na-OY;
        Fri, 21 Jan 2022 12:43:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 02/15] reftable: fix resource leak in block.c error path
Date:   Fri, 21 Jan 2022 12:42:21 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <315ce62e710e6e80dc8a4d959e5532b5f9142669.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <315ce62e710e6e80dc8a4d959e5532b5f9142669.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.865yqdl3ff.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Add test coverage for corrupt zlib data. Fix memory leaks demonstrated by
> unittest.
>
> This problem was discovered by a Coverity scan.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/block.c          | 26 +++++++++------
>  reftable/reader.c         | 23 ++++++++------
>  reftable/readwrite_test.c | 66 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 18 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 855e3f5c947..6c8e8705205 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	uint32_t full_block_size = table_block_size;
>  	uint8_t typ = block->data[header_off];
>  	uint32_t sz = get_be24(block->data + header_off + 1);
> -

stray extra whitespace being added in the middle of variable
declarations.
