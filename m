Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D4C4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 11:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLYLgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLgD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 06:36:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97D5F48
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:36:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 79so5827528pgf.11
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK0W+IMu8cncUtY6f8qgsBgmjwjRsLMXobfmhqCLAI4=;
        b=qWpdFPWP1GslT3RHVNR8Uwag0MHp8fAKx94V1I3xD0ZeIwMm6TYTEfgGGXNuI/cUAb
         3w3eXtm/JgYNG9C0W9hdiAgrA+NQz4kIIs4xB7aXx/GD/wpMNCOrH/XNm7s0DLj4hChC
         hp38GeO2hEyOT/4Rvzan177lRNfQcpxgyJMtCtvzaQHSd/C+wCCGBHZSF7uPI3hhT/tK
         +vEkF7Q0zft2PS5bCAcbyPusZ4p9w1DrCRYzLSazxRbv8bFa9KjggXB4r1Fd+rZVujsM
         R1rZqx/WiDVcCGQmB/kwiJp9jqb+Y+D41lJvnuDFLwHvNfe23ygCc9hW8AWXhcv1Ovoe
         IvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK0W+IMu8cncUtY6f8qgsBgmjwjRsLMXobfmhqCLAI4=;
        b=EXpn/UnKb7BbN6LB1r7msnk2Ra8MHtAnFgTcCwd309HcB7xmOdxug7jc7l0/jQfOtL
         3gp/HXIxRugtrQq9wxiFru5qZzJyXyvwje3OwH9IVb5pxGpsZxhCZRUfQtWX2LDsMreL
         5IQH5/73TqX9V59XSfFHxVaCd5ncckqS8gmNXnHXiL/133qxpjyxomYF1fYJYmMYHRe0
         LstKPZQ8Bh3evT2wQQSGlOs7wweZzUOaw1b3jvrhX3Y/NkgnVgkSG8Tp0oMSo+X+FpEM
         l6cc7Mv4hIWf5lRn4RLLE8cj9AXBQT0zjrY4+4iITE76tFZG4o09giuBSJ8EXSszBKVA
         tiwg==
X-Gm-Message-State: AFqh2kqD+rmn0V3YtfeNK6hvtWu2bTDLxSIJ7nEbGiGI6uTeIYwTLFpO
        JfxwmZfS6huIre1alJdS5m8=
X-Google-Smtp-Source: AMrXdXvfAYmkxCnz5lIMbtl61UDt7AMHRj/xXGZrtDhx8k70Df6/JLO/pUpypu3UPn6yzs3kdvRAIw==
X-Received: by 2002:a62:1d07:0:b0:56b:a2f8:1d0f with SMTP id d7-20020a621d07000000b0056ba2f81d0fmr31563443pfd.0.1671968160209;
        Sun, 25 Dec 2022 03:36:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 189-20020a6204c6000000b0057691fb0d37sm5117742pfe.193.2022.12.25.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:35:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 00/11] Bundle URIs IV: advertise over protocol v2
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 20:35:59 +0900
Message-ID: <xmqqilhzogv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This version includes squashed-in versions of the fixups that were
> previously known as ds/bundle-uri-4-fixup.
>
>  * Some unused parameters are now marked with UNUSED, since we are
>    introducing those parameters for the first time. In one case an unused
>    parameter should have been used in repo_config_...() instead of
>    git_config_...().
>  * The GIT_TEST_BUNDLE_URI environment variable is removed in favor of the
>    transfer.bundleURI config option in all cases.
>  * A stale commit message is fixed to no longer refer to a rename that was
>    split into a different commit as part of v3.
>  * The documentation comment for fetch_bundle_list() explicitly defines a
>    non-zero return value as an error.

I guess that sprinkling the fixes from "4-fixup" series into the
original commits will resolve many comments by Ævar about the
logical ordering of changes in the "fixup" series, mostly by making
them all moot points?  Thanks for working on this, and let's start
merging it down to 'next'.

