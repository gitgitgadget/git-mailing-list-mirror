Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53DC38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjA0Ug6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA0Ug4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 15:36:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE37B78F
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:36:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k18so6169058pll.5
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7b20O5xSpjhnJcuV90vr12WadJYgycHtlSkDYuGKwM=;
        b=liO3BfBUK0SF+u1HCm2JGaDiPlsDnjU97bOalOlLcwh6mUFpARK1/XMC6d3tAqnvKO
         Tz6hnl3Cf4uLFFH9RoDS8oUCKJJPNFajVO9DEZbMI5g8ev8AXx96wbTBmx7wdgAoQU0E
         U1+9LReFMWd1Tcf23JIPo5qHWnuNNtRaPea49bHOIPcp7p91hfPlJZ71oxCM8rKQSaFS
         eHhZ9jgQS4ViiZGXh17EEwb9tTAEUDCFYqtKR3Ezy6pkz4VOGTx+acqYl0ZTxPsSot1h
         scJAk0P9FWBrN5+TDzUXU0WDneS+0GKTqL12Mn1//2Q+mrWIqCmjSuRJJaDEKvW32m+f
         /L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n7b20O5xSpjhnJcuV90vr12WadJYgycHtlSkDYuGKwM=;
        b=5OSnRQgfaIXVsgeYq5iKcdiJobUBHg1YhcvV3ISR0WjSrPB/PznJ1Pxy2qtf8jovqx
         i6b0bU2DbhQFMXFWu3JwKAEsH4GMMdITsggXPFoK47oLFxdm2v8JJJCRf4p9cxEythKk
         sqxwuBEqMppCa8AQbkZyozt5Mcz2xP/eC+YhKzgA7gINe7ZIvKA3km9QmrWMjkaRk8j2
         XdAPcRNyd9B/S4gd31+jERD2CFKCVFf0OR4e/LQtFfBO3K/TQJteLaND7g/qNhkADk75
         0fNO48gTIgt/xX+WfeU0gNBKK8f0NKp7j0ms/hIQCtHMwyS5ppUr3Z2nik5icGiQYUBH
         41Ng==
X-Gm-Message-State: AFqh2ko0HhtVyMGxFgqpn2hlgejK/sKftPoyEYoQiXvtRgH6DU+rwzKw
        4j4D9st7fBqbmNqpAgvXbtw=
X-Google-Smtp-Source: AMrXdXuWfoMN4cfAni2DspQC50VaMPAOCjui3mV5hiNmVx9rgmz6A6/thxgJuYc2RDhoaE73ia661w==
X-Received: by 2002:a05:6a20:4408:b0:b8:66d3:30b8 with SMTP id ce8-20020a056a20440800b000b866d330b8mr58840888pzb.20.1674851814383;
        Fri, 27 Jan 2023 12:36:54 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id i9-20020a628709000000b005893f281d43sm2786467pfe.27.2023.01.27.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:36:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
        <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Jan 2023 12:36:53 -0800
In-Reply-To: <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 27 Jan 2023
        20:06:03 +0000")
Message-ID: <xmqqleln90ka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> A user reported issues with 'scalar clone' and 'scalar register' when
> working in an environment that had locked down the ability to run
> 'crontab' or 'systemctl' in that those commands registered as _failures_
> instead of opportunistically reporting a success with just a warning
> about background maintenance.
>
> As a workaround, they can use GIT_TEST_MAINT_SCHEDULER to fake a
> successful background maintenance, but this is not a viable strategy for
> long-term.
>
> Update 'scalar register' and 'scalar clone' to no longer fail by
> modifying register_dir() to only warn when toggle_maintenance(1) fails.
>
> Since background maintenance is a "nice to have" and not a requirement
> for a working repository, it is best to move this from hard error to
> gentle warning.

Wasn't the main selling point of scalar that users do not have to
worry about various minute details of configuration settings to
maintain their clone of projects on the larger side?  The "maintain
their clone" certainly should include running periodic maintenance
tasks without them having to worry about it.  It feels like this is
calling for an explicit "disable periodic maintenance tasks in this
repository" option to help these esoteric environments that disable
cron-like system services, while keeping the default safer,
i.e. fail loudly when the periodic maintenance tasks that the users
expect to happen cannot be enabled, or something.

Perhaps I am not the primary audience, but hmph, I have a feeling
that this is not exactly going into a healthy direction.

Other two steps that led to this step looked quite sensible, though.

Thanks.
