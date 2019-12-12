Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9DFC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E9206DA
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 10:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgsH5det"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfLLKrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:47:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfLLKrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 05:47:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1824187wmc.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z+jMF3XPJ5wZIvUtCF6ai5Bwmr2C5UmypSglyELztEU=;
        b=WgsH5detYkJybw3jgstRZ5oBDLLRq1tDUh8WViGIBSWBNV2CRePT3+Fx0sGSSznfjl
         zk3uYab4xX4GgD3Iklhn6D/CV9OtkJYpzqSOn3nfKH2GFU202wTePHsj+1j+WQkHkHC0
         Tfrhg5iWxXu0cy3Eg9dMV4mPKMKnMNsn9QM+Un7rWuO/juMImhce/lvhg6Tb9H8UVeCh
         qdj/y+Bna3GhCmO2BJqgXTDejptNqw62jwiN8RWt1F1M7jCN3WXjSpLXICYPxBtM8wUB
         SymQozfTZiUw6l57jvlj91RnjFGb1Sdfje0lZZjArMVHAsqd5GlcYiVfIlxZBmVPQhMg
         7HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z+jMF3XPJ5wZIvUtCF6ai5Bwmr2C5UmypSglyELztEU=;
        b=T1nbQCN5OoGtCGwuaQzlXH69Q3XSOcJtYxhfoHBdLf4r1CTkiQbwQLERp+8DgwqE9C
         jN3GGfJjU00urgYy1cTxa4v3zY6Jx9vPTgUaNJiaUDwl5miOnjfCDj7VwFYyHBTBVqX7
         sT4CjuI2DDMT/de4U0J+npy0QgG1i66JTQyo4oN9CGINepxho//MSlvrULvp4camPU9E
         l+v5AHgiPb/FzZ2uWjQ5NDBUk6OmxfDXkcDvta1dg/xxi5a1K5Whq6HY4RUT/Hylnch6
         0tJHng7g4qZcjTiyznDIXIGihU4NX+OqDe5ITssPFaRRW4NXqMfzqfyQHed+Vi/5UOM/
         q/dQ==
X-Gm-Message-State: APjAAAXuHimCgSuVq+qwRngDsqvAfLPAF48d4QpWS3bEgQndNnjMyLPd
        jKtQnXhnPhA9oupXVWYTxMU=
X-Google-Smtp-Source: APXvYqytUFbMa1bmANS8Z5PaVUMzr9Sf03sBcFcw6FJMMTjaZeH2o8WHsmpFHxKEdlvTd1loj1LWJQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr5451659wmc.114.1576147624154;
        Thu, 12 Dec 2019 02:47:04 -0800 (PST)
Received: from szeder.dev (x4dbe262b.dyn.telefonica.de. [77.190.38.43])
        by smtp.gmail.com with ESMTPSA id g7sm5607699wrq.21.2019.12.12.02.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:47:03 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:47:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] hook: scaffolding for git-hook subcommand
Message-ID: <20191212104701.GI6527@szeder.dev>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20191210023335.49987-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210023335.49987-2-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 06:33:30PM -0800, Emily Shaffer wrote:
> Introduce infrastructure for a new subcommand, git-hook, which will be
> used to ease config-based hook management. This command will handle
> parsing configs to compose a list of hooks to run for a given event, as
> well as adding or modifying hook configs in an interactive fashion.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .gitignore                    |  1 +
>  Documentation/git-hook.txt    | 19 +++++++++++++++++++
>  Makefile                      |  1 +
>  builtin.h                     |  1 +
>  builtin/hook.c                | 21 +++++++++++++++++++++
>  git.c                         |  1 +
>  t/t1360-config-based-hooks.sh | 11 +++++++++++
>  7 files changed, 55 insertions(+)
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 builtin/hook.c
>  create mode 100755 t/t1360-config-based-hooks.sh

When adding a new command please don't forget the steps noted in
4ed5562925 (myfirstcontrib: add 'psuh' to command-list.txt,
2019-10-31) ;)


> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> new file mode 100755
> index 0000000000..34b0df5216
> --- /dev/null
> +++ b/t/t1360-config-based-hooks.sh
> @@ -0,0 +1,11 @@
> +#!/bin/bash

s/ba//

> +
> +test_description='config-managed multihooks, including git-hook command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git hook command does not crash' '
> +	git hook
> +'
> +
> +test_done
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 
