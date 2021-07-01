Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D559FC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04B0613FB
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhGAXJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGAXJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:09:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCAC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:06:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gn32so13175844ejc.2
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZJ5JJU3BFeRaLYBeI5Vul40iCyGOkZuDTl3fLjxYNhQ=;
        b=mlaTp8Lxx7e0AKwS9mczRNBh5tbaJVwn1jq9dold4LxHOF0au4PZv7hdsEVTZglAei
         ZenYUqjJuYaf23fGqo5jCep13zvu+rbPgNPFug3jsUUiKgSHNzbLEhNj4f+kswjkTrEr
         JHUD0xwkZUkHqRJkUpbvBaeAS3pK37uUSrEynCsvYYk4lHENOYP0YLaKGOUyL05ubcpx
         zFbMIEp+0i4cPAvt+kUFnUW8St4AOKvOIWdTFlT+QPh9+Yqe2l7HBlNOYeGcJVMQc9dU
         iBBmOCFuMnQoWRGGiYHaNcWpp/NVe5PX8R0/JtRimLXxKVrzFJjt1+Jdxi2v12eJYNKZ
         s1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZJ5JJU3BFeRaLYBeI5Vul40iCyGOkZuDTl3fLjxYNhQ=;
        b=S0Jd25d2roBab5edXKqGLCiLjX6XWWZk3jLY17/Yf258Psrve/xT9TmPRyf7cCPYaP
         V+cGFjhQfmnfnvRyq2ku3hZ7lt2b+qaoMwAFlI7zp+J0avuyHEZWjg9ylIDeuPgObTwm
         fEOTzX5eB+o51yo53sato2XELrRLh/8b2mo37AZLMd9mCM9sN/ClzrPWlIkm5sKMOox+
         deB7x1SB9p4nLt0FcQefPDjNKCi07b3imoVvCw2MXNDiDdrI5UeZrW3hsTOaVjg6ZpWj
         8NenncIs/+kJ1WFhaRTh/6gvvKvCdOBNV6q0COHLic/GofXQU+dSis2baOExOqnPFaDa
         WLMA==
X-Gm-Message-State: AOAM5324DCD+ZZwT1UPiMWS0Qc5yCdhjBXxnzXywGTvCFNj/Kua0EKHs
        lJ2IVZr9ht+wZ57nLskhyig7XBHtrAnohg==
X-Google-Smtp-Source: ABdhPJy/gu7ijRqbdlc1R5Q708izaA5kmN8o5EFE1GCnUMCboaeRnLAJvrhlOWIQNlH38ea2Au8kZA==
X-Received: by 2002:a17:906:b201:: with SMTP id p1mr2346684ejz.30.1625180793716;
        Thu, 01 Jul 2021 16:06:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h5sm401067ejq.46.2021.07.01.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:06:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
Date:   Fri, 02 Jul 2021 01:02:34 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87k0m9bpmv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach the win32 backend to register a watch on the working tree
> root directory (recursively).  Also watch the <gitdir> if it is
> not inside the working tree.  And to collect path change notifications
> into batches and publish.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++

<bikeshed mode> Spying on the early history of this (looking for the
Linux backend) I saw that at some point we had just
compat/fsmonitor/linux.c, and presumably some of
compat/fsmonitor/{windows,win32,macos,darwin}.c.

At some point those filenames became much much longer.

I've noticed you tend to prefer really long file and function names,
e.g. your borrowed daemonize() became
spawn_background_fsmonitor_daemon(), I think aiming for shorter
filenames & function names helps, e.g. these long names widen diffstats,
and many people who hack on the code stick religiously to 80 character
width terminals.
