Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717FC56202
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7402B2224B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQQWQVD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgKMJ5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJ5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 04:57:54 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B92C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:57:53 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o9so12511503ejg.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bzbuPJTWMrU38Ds4CK22MDDehMpkP8yk/mEcC1hdOUE=;
        b=vQQWQVD4s6A+jK6UHM1qL8ZzX6rl/PRESkHySJkQoc8qBmTmDUlirTVApi8XV0iaNY
         ISLYXnrZlggI1fQncBIHj+MX67b1artpkpFu6uI6bz/bp3e5Tqnv0m41fEi9p+1YQ27V
         wP+iIEtU16ADfDKRAOUeOBH27nkpuTB1Jz0OSlHSoEIqWd7vyVBgH59sauiBGaZJj6tD
         +liNl9fkqSHApGLPDJXXvYez5rK3nQEoj3YaQ+VH4+0muwG0N66WuAvbHY3e0fbBcvTw
         sdhDtbXbKAnr9Kg7OAr61YyLuNMosdev2vpxMX2xDpoBopC+JBKaTyIaH8wLzInPmmwL
         opDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bzbuPJTWMrU38Ds4CK22MDDehMpkP8yk/mEcC1hdOUE=;
        b=rZe7cvpfFoCzGnwLBXAcUJM5/2DvTdemf8TK/qeSNzgC1BKRSnGor58X4SmCqGxkh7
         yTWsJdwqJyJz/30UE/Y6Ch93Bv4Bgiop4+pwaGQHaSPUXA9Nu8H4gaRGiRZ3uk8TvK2J
         bcj55WvRx/306JTiGb5aFETZxJeKo58Ejv5H+x2gxkyFP0bHychhpIa/t+eYGaVd7MP4
         e38orNDBhCtUFBjIKduDyRRtQffmVDBEaMR/WVVngi7jFV2asfATovSekhhzg6IlP3rn
         bke7k8v2yxU4NEKyw4q6qVHo251kipXMwxv69Lzxl0QkRSl3v+AIEaLV8uPbh+csb4qe
         H11A==
X-Gm-Message-State: AOAM531Cc6duwiNE/0+vYHiUwYhqMNo2YxSyEIMmShWhqH6IsVjWzPn9
        eUgLu0aJfX5SaHvm+lT7Rno=
X-Google-Smtp-Source: ABdhPJy+0Xok2LxdZY1eQ11oBHsaobdN38Sa7jTaSbZyxsAHTKf0ExXXpIC1+sYs6oavyscHK3CfQw==
X-Received: by 2002:a17:906:2742:: with SMTP id a2mr1085454ejd.219.1605261472520;
        Fri, 13 Nov 2020 01:57:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id 64sm3543903eda.63.2020.11.13.01.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 01:57:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 28/28] Change the default branch name to `main`
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <f853fa946f5840518577584a5b8c51660da06928.1605221040.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <f853fa946f5840518577584a5b8c51660da06928.1605221040.git.gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 10:57:51 +0100
Message-ID: <87v9e9fujk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, Don Goodman-Wilson via GitGitGadget wrote:

> The current default name for the initial branch is a loaded term, and
> many Open Source projects renamed their principal branches already. A
> common choice appears to be `main`.
>
> Let's follow their lead and change the default of `init.defaultBranch`.

I think it makes sense to split this change off from a 28-series test
cleanup series.

> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index bd3fa3c6da..1b0abcb0f8 100644
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -144,7 +144,7 @@ create_lib_submodule_repo () {
>  		git checkout -b valid_sub1 &&
>  		git revert HEAD &&
>  
> -		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
> +		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-main}"

Earlier in that function we're doing a "git init". With all this test
cleanup I wonder why not just "git rev-parse --abbrev-ref" to get the
default name, instead of carrying the hardcoding forward.

