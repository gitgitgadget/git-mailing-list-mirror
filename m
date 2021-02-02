Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3895AC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BAA64F5F
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhBBVgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBBVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:36:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7EEC0613D6
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 13:35:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o10so2736357wmc.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 13:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BH2cD5o2i/Z3DYsR4F69imA5KtLMvC1PYW65mo/vXEw=;
        b=A0zpe23uu3fwxBprg2+4QAbrWL0usuNpZoNllbyGqioUwVERc4DAAwkjFdrJjJP4t+
         pEpsz2bGsKObHv4kW+oB4mhFnvAg55moXUBU+aalsLTMgafKlZF0agwU+lINiC5fp6af
         RU4ozrbIiRUAnP5dtkZXVaGnGj4ElJIcfuQP6JQt0/szidLnChCHB9LIoSXv6K3Lq1jD
         cahpwSyG02baMxvsyDHHPcY3UkWtRG+/IYsy6SvxRmAAooGkkbrqXg/VFPDTjSzAYMIa
         kS8nfUhZQ69kIdHIYEixb2mmXAIVf2uuNCFUvRONaVS+xh6XyX0X/Ly90bcc0Sm0liGc
         vztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BH2cD5o2i/Z3DYsR4F69imA5KtLMvC1PYW65mo/vXEw=;
        b=Oa0bXMdoV/YbCcLUj7YdjT6f1REjUwEwIbTL2v+Hp5Ao3GHhzMZ9LikbNcuqHoIVzZ
         jnt7hbgokwoiJpn0SJkkCnvft5QPXxl7SZ4Req0Dd1TtVat/mVo3rgnm+lcUwTOsSbiR
         Rq0ys7UErZ0m3vLZNYqHLh3dlo7CffcCpleY6E01eAWwjD9cA9YbmcjqyT/yMuM5ruHz
         eiYj9+haHnMl+AnT8xSp32pIui/OlB48S58WSB8bwlIL3sv7RmM9cpcemGW6qMlG/jQY
         gBzpSBlckazeFKVBHXApK8FmmYjIADKjtmp8n/Cd40XVETwumDtA8JzT4m41VwmyTodd
         o3LQ==
X-Gm-Message-State: AOAM53032n54QYkPV31Y4OLAbYnXK92VKPW3jGtqKZ7Qk1cqxXQgpUrD
        9ZuW/24jO2urM9B5336LGYw=
X-Google-Smtp-Source: ABdhPJy5fxDRnjTMsm4GJTAhtCjOiZ3U+2e/WOvaUN2rPfvYLnwVqQqPLflYT/8XmcT84x/baL+cQw==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr7639wmb.160.1612301725359;
        Tue, 02 Feb 2021 13:35:25 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id y6sm5246513wma.19.2021.02.02.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:35:25 -0800 (PST)
Date:   Tue, 2 Feb 2021 22:35:23 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 09/14] simple-ipc: add t/helper/test-simple-ipc and
 t0052
Message-ID: <20210202213523.GD2091@szeder.dev>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:42PM +0000, Jeff Hostetler via GitGitGadget wrote:
> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
> new file mode 100755
> index 00000000000..69588354545
> --- /dev/null
> +++ b/t/t0052-simple-ipc.sh
> @@ -0,0 +1,129 @@
> +#!/bin/sh
> +
> +test_description='simple command server'
> +
> +. ./test-lib.sh
> +
> +test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
> +	skip_all='simple IPC not supported on this platform'
> +	test_done
> +}
> +
> +stop_simple_IPC_server () {
> +	test -n "$SIMPLE_IPC_PID" || return 0
> +
> +	kill "$SIMPLE_IPC_PID" &&
> +	SIMPLE_IPC_PID=
> +}
> +
> +test_expect_success 'start simple command server' '
> +	{ test-tool simple-ipc daemon --threads=8 & } &&
> +	SIMPLE_IPC_PID=$! &&
> +	test_atexit stop_simple_IPC_server &&
> +
> +	sleep 1 &&

This will certainly lead to occasional failures when the daemon takes
longer than that mere 1 second delay under heavy load or in CI jobs.

> +
> +	test-tool simple-ipc is-active
> +'
