Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31ACC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC5764E40
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhBJALG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhBIXh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 18:37:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC83C061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 15:37:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cl8so78750pjb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lqi0EHvdNPB9uYZi5gGs/qbXkiBaeVpUv2H0LDx5YVs=;
        b=mXuqz4xGy//hsBH/c8HVSQK8eastlG7Z/zFTaEXfBTjdpeUVKoztAhE5F642ST+QW2
         oSN0NZr6xl+8vlLS/oa6DPKRmeoV9QQO1gvggEUV6jZw+KvHqYwbtkRCfo/oynLj2FaU
         ITobVdtkMXS76bC12Wc8Oeb+9PY1cfn8a101P3LCyDVxav/XI4+mcUE1feqPsFNpAIfX
         SceGe7hW0vof8q5I98zZ1K5/Uo2gz06F4YUnOyOWETmhq3rUGytcQp3QtBbGQiXbZg96
         YGgQyBao3nY/o1/T0PPLDiPit9YrTQhsCi7yFPNBxBmP5Lwh2n0Kjri/jJ9yX2b9yrn4
         gRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lqi0EHvdNPB9uYZi5gGs/qbXkiBaeVpUv2H0LDx5YVs=;
        b=EC4pluZcdMdwSoaWfNPtDHh+QJPw2jFKHHDJ9L6mHC71OvUBvLQE9+s3HGRnPtVNp9
         mnDXOxqcsZtR8O3iNvsMr0A7IkOKmS/Kmy1d5UUQp4pmAIRyfnrawXdtQtwZ4G/UEu/7
         7cFDGL4T8SttW2hUAqG6a4lySynHjyhdBSYgD8VpBeQNql8CrFq5OXRZOheqFQ2xMmlF
         NcYXtabvqz/EbO/pq3D+o4bR2IQISQuvyvHiSVLQAEcBZ7pSs9WOB1i8f0qW9SCkp87j
         gk/A2cKvY20HT6Cdsi7u2hFOamE/AKI2zK3NGT/QA6hRGh7SJeWujFpDejG+93xbd1S5
         xE7w==
X-Gm-Message-State: AOAM532qZwwkH+ZlSO0guBiFus+NgJekgGDcyCzBkq9QcVsrekKb3z1F
        jD9WX9o6KpM6Fa28zE/jkHc=
X-Google-Smtp-Source: ABdhPJxpIKBKqsUzIlKS4Ja/wuACUT4GdeWQxZpKsSHggW5yc7KheJ3o+c+V2lp1ZE/A5VU6kJASrg==
X-Received: by 2002:a17:90a:550c:: with SMTP id b12mr305166pji.144.1612913830020;
        Tue, 09 Feb 2021 15:37:10 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gc13sm145843pjb.11.2021.02.09.15.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:37:09 -0800 (PST)
Date:   Tue, 9 Feb 2021 15:37:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 12/12] test-lib-functions: split out {debug,path,text}
 helpers
Message-ID: <YCMcoyDVNnc8Lkdp@generichostname>
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-13-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209214159.22815-13-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Just a quick drive-by comment:

On Tue, Feb 09, 2021 at 10:41:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/test-lib-functions/debug.sh b/t/test-lib-functions/debug.sh
> new file mode 100644
> index 00000000000..4393bf82f02
> --- /dev/null
> +++ b/t/test-lib-functions/debug.sh

Is this supposed to be text.sh?

> @@ -0,0 +1,99 @@
> +# Included by test-lib.sh via test-lib-functions.sh
> +#
> +# Text munging functions, e.g. wrappers for perl, tr, sed
> +# etc. one-liners.

[...]

> diff --git a/t/test-lib-functions/text.sh b/t/test-lib-functions/text.sh
> new file mode 100644
> index 00000000000..e5f438ffd31
> --- /dev/null
> +++ b/t/test-lib-functions/text.sh

And is this one supposed to be debug.sh?

> @@ -0,0 +1,33 @@
> +# Included by test-lib.sh via test-lib-functions.sh
> +#
> +# Debugging functions, not intended to be present in submitted
> +# patches. Be sure to remove their use before submitting.
> +
> +# Stop execution and start a shell.
> +test_pause () {
> +	"$SHELL_PATH" <&6 >&5 2>&7
> +}
> +
> +# Wrap git with a debugger. Adding this to a command can make it easier
> +# to understand what is going on in a failing test.
> +#
> +# Examples:
> +#     debug git checkout master
> +#     debug --debugger=nemiver git $ARGS
> +#     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
> +debug () {
> +	case "$1" in
> +	-d)
> +		GIT_DEBUGGER="$2" &&
> +		shift 2
> +		;;
> +	--debugger=*)
> +		GIT_DEBUGGER="${1#*=}" &&
> +		shift 1
> +		;;
> +	*)
> +		GIT_DEBUGGER=1
> +		;;
> +	esac &&
> +	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
> +}
> -- 
> 2.30.0.284.gd98b1dd5eaa7
> 
