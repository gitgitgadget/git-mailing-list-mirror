Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B04C6FD1C
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjCJRkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCJRjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:39:54 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6FE10FB94
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:39:11 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id fa28so4107780pfb.12
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678469943;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn5cWlByGw+9IlBPX5LdEMu27cbGLs2EXpGVqHqYpvM=;
        b=ebCy3lEb43Ynu2mvfxWZA5lewqvoR2KAvySy4sZ3qpYRhs/UH4TUVY4cof9Ul+BtXP
         RGA/OLn72gr+T0j1JFnH7c6rG6HbVlozDwWJdhcoAeIDh1cxbQPVju/HWnT7mntTYq9z
         vs98ofa5GyXB5++7gdeR2Pc3EK8jX2bVywlr88gEtGDD5EIJ0lWvdT5GFZxdbOy8uszl
         YJL8w84b/WG7amPp/KKkNo/XxXmZ5g37lu6Z0YTcJhF1543aWwNYfPCh45f3/fTPQrsl
         kJpBvyf0BEhnAED18CbQWZHjJs6EweYU9NomvUqnMHhv9kwQzw04mSjEod3ptbruPJoK
         AtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678469943;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bn5cWlByGw+9IlBPX5LdEMu27cbGLs2EXpGVqHqYpvM=;
        b=VWVx/nnVm/72xQMJ04ocSHd/o0JEM+o1o+q/UZtche7ID5RdOkOKR0N3bFxexMMXhu
         0RN1kA+EHLiG1LQdLGtcf1CouqiNPwrx86wHSracvJUZl9jNvMcQaW8thYkQSM6YBNM0
         PBE4lGuMUfnJuRUW1mBQjxI1PYD4fcCnqUYW/7xxCl7wl57mGXyP91Hc2ykTTr+EkWc6
         V7+PH/txXEtFZCLEJwgFPocvQaVDhZRoa47wLPz7S+5+3sQacYVaZpmfiFLPmDyvXmW6
         AlRAWqTcse70rlmsXTWYdvLcZKx5nfjmir8Rht2gOBKjzSEqDlflAysZp+MtlYXGtmRh
         oRow==
X-Gm-Message-State: AO0yUKXkTKis1EnvrkTxTz70Jpw6tqBQpzM2qSN5ZkV4gVFsZphLFoqL
        KdfPRWrPIeZ8VfaP62+kj0Kr3ZRFYEk=
X-Google-Smtp-Source: AK7set8xPZXcjQ9dAzoiY+cyvU6BkS47T9IVfMI4gUAu1mqBSL2D0y8K1KqAVHW6+HJL3UaXezZzCw==
X-Received: by 2002:a62:25c5:0:b0:5a8:bd6e:90fb with SMTP id l188-20020a6225c5000000b005a8bd6e90fbmr21616731pfl.19.1678469941228;
        Fri, 10 Mar 2023 09:39:01 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78e0a000000b005a91d570972sm110212pfr.41.2023.03.10.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:39:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] ls-files: fix "--format" output of relative paths
References: <pull.1465.git.git.1678453473484.gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 09:39:00 -0800
In-Reply-To: <pull.1465.git.git.1678453473484.gitgitgadget@gmail.com> (Adam
        Johnson via GitGitGadget's message of "Fri, 10 Mar 2023 13:04:33
        +0000")
Message-ID: <xmqq8rg47bgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> Fix a bug introduced with the "--format" option in
> ce74de931d, where relative paths were computed
> using the output buffer, which could lead to
> random data in the output.

Good find.  Both the explanation and the patch text are crystal
clear.  Nicely done.

I'll replace "ce74de9313" above with "ce74de93 (ls-files: introduce
"--format" option, 2022-07-23)" while queuing, though.

