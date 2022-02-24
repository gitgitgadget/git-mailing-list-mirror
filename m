Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92EFC43217
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiBXJLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBXJLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:11:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9721A129E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:10:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h15so1861142edv.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nGCscv30vX2OqJ933OXKJfDNZQVQ2PrG8hzDQYdnT4k=;
        b=TH2o/OJxq0MNihIqOgSmM234c0CD99TGUVc+g24tzhcXCOCObsWo+5DalnjEgtaEte
         ddd5Z8RnUjU6JgU69oADT3OJI5INFb9iCKjPEiC5Z6TVIqWbKMIvTOEetRS0k+5Pj4j4
         GtI+epSkRg5lgDXktq24K4vqBjCFPV2SWMxPlpgZzxrTAvW6thLAGn0XrlrHOwOakHC8
         YJ6+/iRrgxco9ChiMDsiG/aZFLxwxCjYhiomQW5WdDqAQoh15pyOOOR6YUCnjjKDLr9G
         st9ssxH9u1r5sGzKyhL2/jBuTghnVB0KIJH/1d82itv9DOV6AC89BqdiXLmEpHTIqSeG
         aLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nGCscv30vX2OqJ933OXKJfDNZQVQ2PrG8hzDQYdnT4k=;
        b=jn+SEEVWUnLCD2mnQpCQXd1IXeVadpKeahf2jZEFuhPEzF0gCzKKr+0Hpy4hSi8/gt
         1JYsH0RV6+xQgarIoSYqCD9faXf8nrU3CiD6bzw71Wpo5sXWC/JLQpYzakNN1lEvRBW/
         XUkXjYp/FzTpKOFb5XkUUJSfTwUYSIFaqk1D4wVLKCa84WfCkdemRWAPq400/vTY4YO2
         m6uh0n2QtOps7WxVVieYz2iB4JLAddz6bUlZkcd6GYMSSo/at0+xtmowbfAb9Amg5Yqm
         t/w0ObfaLoQ4gOmjdNLQxD1CwlFmn/zT690sX8n0s6zS2qNQedowrj/sECIVWUF7MOrP
         UdxA==
X-Gm-Message-State: AOAM5319P3iXFrw06dpCAt0MPIr9nvMl4WYUqnFObKML9r5GW+HbWMLo
        F4qYsMkmKMhaui05M88ayvM=
X-Google-Smtp-Source: ABdhPJxGZ5FT3VoDa775X1LOst/LOL19OAtKnDHEw3bHxJjxNg3K3egsuOC/4kwIRpF8J/WPRDyMTg==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr1357297edb.265.1645693841161;
        Thu, 24 Feb 2022 01:10:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nc33sm1014305ejc.169.2022.02.24.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:10:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNA92-000D2n-AA;
        Thu, 24 Feb 2022 10:10:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/commit-plug-leaks + ab/diff-free-more (was: What's cooking in
 git.git (Feb 2022, #06; Wed, 23))
Date:   Thu, 24 Feb 2022 10:08:59 +0100
References: <xmqq1qztortk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qztortk.fsf@gitster.g>
Message-ID: <220224.86k0dkaaun.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

> * ab/commit-plug-leaks (2022-02-16) 2 commits
>  - commit: use strbuf_release() instead of UNLEAK()
>  - commit: fix "author_ident" leak
>
>  Leakfixes in the top-level called-once function.
>
>  Expecting a reroll.
>  I think UNLEAK->strbuf_release() is a regression.
>  source: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>

After you noted that in [1] I followed-up in [2] giving reasons for
wanting to keep that UNLEAK->strbuf_release() change. What do you think
about that?

> * ab/diff-free-more (2022-02-16) 2 commits
>   (merged to 'next' on 2022-02-17 at be8ae78a2d)
>  + diff.[ch]: have diff_free() free options->parseopts
>  + diff.[ch]: have diff_free() call clear_pathspec(opts.pathspec)
>
>  Leakfixes.
>
>  Will merge to 'master'.
>  source: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>

Thanks! It will be great to have this merged down!

1. https://lore.kernel.org/git/xmqqwnhs11he.fsf@gitster.g/
2. https://lore.kernel.org/git/220218.86fsoggdou.gmgdl@evledraar.gmail.com
