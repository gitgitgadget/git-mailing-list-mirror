Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34458C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiKWRtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiKWRtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 12:49:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47BAEA6A
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 09:49:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-391bd92f931so166589727b3.22
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BowAZMzuoFvqYOxUTeYHReVuVFmCSn++4F+Bx7kzz4=;
        b=ZR68kazlWzlkTvMUFNxomYhBubHwVVDRrjB5QeWjgmxmU2jszW58dABbCshQM+lxS7
         vnsh+DWwL6GXCu/AfPILlqqTW4H4G/yV2t2LOJp/uSkCxxhcBB2fUR6sd4p6GPPgJcwf
         7e4iNQLlAdpgAyzlusytRcLpn+3JU0khIeO6D7902aObko/kyz28yGWkmvdI11HAui20
         Ap8mE38Sj5rXYLOUlmG65cBBf1bklDFhI+uUCT8IBIAnLBtN4iXqQJ1hTVB1+RVcCgn2
         6qnts8vCj6lrXF519Kmr+DlaneYz6HOVfmpL4Hj5mKDYG8hWPjswxW5zCdMXb1GsfUZP
         T3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BowAZMzuoFvqYOxUTeYHReVuVFmCSn++4F+Bx7kzz4=;
        b=ctR7YnqcVTtQQEivrIiv/LXX/Kw3XqY3JXTjQP76gLYwB663IE6UWP45I8qdlunfIn
         BPy4kXSy2+jCUWVrjPohOj+tGoLrsSskyhIPRXMi8cgsy5luFs83J5zRZirL9CUFzcQH
         xk/FrjTE1/4nvLuqIT0bBiC83GYjYq9PBtzc1YEpY/qws1mjaJnsFwG2UFIcKHImuB9F
         Y6uq4vzDCB8c7Kr1d5vgc6jCx8TPF+YKe9qSWStdluGLmMQs6axBI3pV/eZK4NQ1klbQ
         Wj9XJHwev/mAL70ccpEs4/xh9MBQ49sCSjn+u+fGuVBUxoY6mofcNOP4qYRmawJiLEVT
         bzAA==
X-Gm-Message-State: ANoB5pns3Y3d3ULQVEchYWOtwPaMBJa64AJFUINh1Z0GbSisIgCfh2qz
        Q5WdQnbAEixqv0ue8sHPBI27Qzsj/gLQyQ==
X-Google-Smtp-Source: AA0mqf5iG2F6f1SLst244vNHt+T+HXQyfQMbda0LLJI3gM44MbngszEmmvagH/tGVqIEAKE/WIryKCALMbSmRA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:114a:b0:6eb:9b94:6a4e with SMTP
 id p10-20020a056902114a00b006eb9b946a4emr1ybu.182.1669225752582; Wed, 23 Nov
 2022 09:49:12 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:49:11 -0800
In-Reply-To: <20221108184200.2813458-1-calvinwan@google.com>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-1-calvinwan@google.com>
Message-ID: <kl6l35a9ef3c.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 0/5] submodule: parallelize diff
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
>
> Changes since v3
>
> Renamed pipe_output_fn to duplicate_output_fn and now passes an
> additional "strbuf* out" parameter. Output is directly duplicated
> to that function rather than held in a separate variable.
> Slightly rewrote the tests to more accurately capture the expected
> output of duplicate_output_fn.
>
> Removed a patch that added an option to hide child process output.
> Child process output is now reset in status_duplicate_output.
>
> More style changes as suggested by Avar

For ease of navigation, here are the previous versions:

v3: https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/
v2: https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
v1: https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/
