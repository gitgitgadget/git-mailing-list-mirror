Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05052C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 08:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiKOIIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 03:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKOIIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 03:08:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618376306
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 00:08:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so20751100edc.6
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qhlBxQsJumAbdMqajgsRu6nV2F8DYJkze4mLtiVz9A=;
        b=mLlZLsX2hJNbyJZeWtwgygQzfGtneKXBlsgHHC81DHtBt43V0zAIvYnjRMQDGw5smi
         y2fL+Kj/WY86vlnLtE9xUOH24i2GQyfBFlgtfI1WqJdXc+UWSojUN54X6WCMftjU+HYu
         j5P22qL0ncTzeTKuQEzgzySZJpq+qg+obZ34v/iDFGwGlXfJllskX7D7FyjYKQr8wXSH
         nHSoObxYPBkHVHwUTHGOWC9Jyzcu8yh1kw3fhDQbydO/BJDDGa3bQxipvIHtJ7QhIT9h
         A9HAS8Zy7rWUoM2kWUCnotL/ZPJ9GfbsiN/n/pDxkosyEblzU7/75EAXVtJ5VsUxdk6x
         R3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qhlBxQsJumAbdMqajgsRu6nV2F8DYJkze4mLtiVz9A=;
        b=Rfai7KcZSF/3Y82fDJqx76tdhTb5Xg9fwzGfl6pd8rWPp8KIhW3YXBSM7Hd6ESIK7j
         UucsVFmJj16DZQqHNfFUf/VQ/r8vgvp6q8D5x8ZF1XzNhzPYlucJu8CMqCKNOq6gjRGy
         T0Vafe++9qmc9TU8A3pOiOBRN+8YgLuKSTiPhaDvdYtc/p/hr18lMWRK72Ntp9xT4fZr
         RwfrqQAFpkG9WHdDJt/lYVGIqgnclmhANiANxSUSYWgWsff4H44IgGWgnNB5SWtIXIuR
         GCR54FoDlNk53pBsl5SJgFwngEb9tXWHVhyT5n5ASAPx6aQIdmqo7j0VhJcq0v2yFNxN
         V0Yg==
X-Gm-Message-State: ANoB5plRoXUKZwb6VEwlzXzTYHFNdTTI3M5KioFP8FK8Hf49/r+I6ccD
        BxRwrt/YSIEQXY2z6BajH80=
X-Google-Smtp-Source: AA0mqf53OJFZLRwwlQ3k73iNaRtOP7Sqv7IJX5d1BEBmrm1oocSo7ZgkVuwmq9EURzfNkDCv1JHUCQ==
X-Received: by 2002:aa7:d4c7:0:b0:458:7489:34ea with SMTP id t7-20020aa7d4c7000000b00458748934eamr14651345edr.264.1668499716800;
        Tue, 15 Nov 2022 00:08:36 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b0078135401b9csm5176074ejc.130.2022.11.15.00.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 00:08:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ouqzj-003Ppv-2t;
        Tue, 15 Nov 2022 09:08:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Ronan Pigott <ronan@rjp.ie>
Subject: rp/maintenance-qol with 'make DEVELOPER=1' (was: What's cooking in
 git.git (Nov 2022, #03; Mon, 14))
Date:   Tue, 15 Nov 2022 09:06:16 +0100
References: <Y3Mag8qG2D3qjlmg@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3Mag8qG2D3qjlmg@nand.local>
Message-ID: <221115.86zgcsk5bw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Taylor Blau wrote:

> * rp/maintenance-qol (2022-11-14) 2 commits
>   (merged to 'next' on 2022-11-14 at 17db40bf26)
>  + maintenance: add option to register in a specific config
>  + for-each-repo: interpolate repo path arguments
>
>  'git maintenance register' is taught to write configuration to an
>  arbitrary path, and 'git for-each-repo' is taught to expand tilde
>  characters in paths.
>
>  Will cook in 'next'.
>  source: <20221109190708.22725-1-ronan@rjp.ie>

$subject is broken in 'next', here's a hot-fix on top:
https://lore.kernel.org/git/patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com/
