Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9BC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351302AbiE0Mas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354415AbiE0MaW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:30:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEFD17CCA4
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:08:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f9so8446444ejc.0
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4FelNuEFcbepXijxhD6rnFZIDhPRrQ53RL3WiWoZQNI=;
        b=TamXkFzoz9qTu9wCODmN5d/Ghwm7rOr+EwRfW5QwHIR3BjYyUJXWhwoOSRdbC6MOM1
         WCmEFpABoqxloxMnoEl6C/nVEWCDeEaLF9xw+Dpi0DicZYVjpUaj4IwQHF2QXG1f1Mrq
         YZa09tcYgfgN1hUCONRHXNt9CF5tCRI8njXKlVs/2S/J4LxcEhqqUWXo4MxDltQG3R05
         CuIPbBoVuQmcGfim1RGfLICMxm54y6SIH7n+GmneSYBODhZ9b9k95j+W08AugCcZkXVT
         jyWACxW8xlqxQ1vACgfd8jppXvzUns3Hpu/hxXvoVGKuQkOqFDo5pGvGrO6iKdwesTvO
         2YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4FelNuEFcbepXijxhD6rnFZIDhPRrQ53RL3WiWoZQNI=;
        b=MPdZmKii4njeroM9MNU2T8J6FzvW5W8Zl+1+nmFJqB4tVU/y0Vk3YV6Reomby1+lWL
         66P9WFzEk9Hi0JOLEyZdZxIzFAuNlL2ptahLruC72pzDOuPfehythYbq70S7Of9mpf1Z
         4BbfqWGpRmKdpJeK2q45t+C8eU6GuLhn9uVhWtxSbbrnlEJaBwkoWp6Yv8iR/bWpfdUR
         rBttMkynleJ1B2NJ4QnjjtNXoWLQgRZV0n8w6HxM/uKsU85Ep3TjkoqLdt/aWTgk9PsK
         5BZTyZubbRbNDMAt28Ya+/6YZMhc3l01Sx8Tm4lFVfJLYpf6k7wmPwU+rQkKSPqeleNk
         Vvjg==
X-Gm-Message-State: AOAM530VJ9CR5g9Zr4/gP3TiGbqxeg4wEQoim7oY6sanRtcTi0XmwoIN
        mHBFD6QHpAFj6+GKaejCzediEjgre8mhRw==
X-Google-Smtp-Source: ABdhPJx1KZuBdRvlB+Cqm25SdbQFqdShK9BYLceUu/JmBmC93lSn1fp6entF26n/OGdK1LKfkp4YWA==
X-Received: by 2002:a17:907:7fac:b0:6ff:1926:8a8a with SMTP id qk44-20020a1709077fac00b006ff19268a8amr9851450ejc.24.1653653335961;
        Fri, 27 May 2022 05:08:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906255800b006fee2570067sm1373174ejb.23.2022.05.27.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:08:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuYly-000Rlt-Nl;
        Fri, 27 May 2022 14:08:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com, newren@gmail.com
Subject: Re: [WIP v2 1/5] t7002: add tests for moving out-of-cone
 file/directory
Date:   Fri, 27 May 2022 14:07:46 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
Message-ID: <220527.86wne72n55.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 27 2022, Shaoxuan Yuan wrote:

> +test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&

We don't usually use "touch file", don't you mean just ">file" here and
below?

> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	test_must_fail git mv folder1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'can move out-of-cone directory with --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse folder1 sub 1>actual 2>stderr &&

use e.g. "out" and "err" instead of "actual" and "stderr". I.e. when we
test both we use something like that usually.
