Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12CC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FEF6140D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGARu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhGARu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 13:50:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF49C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 10:47:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l24so11749021ejq.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=t+DJRSFf8P5NhE3n7vAB6QLiM8OF2PhClLKhusWhs5g=;
        b=Ec8bD7SC/DanvXqeWMcn5XsO8fA1NMUM6dRXH10JXJ53MSgNe+sSiDJ40A98/0t9EI
         B3R8v8pn28Genrw/DJ2JgB1meWreqri35WA08Z5PO3wuL/mGfyA+gFON3QEXOZIwenV8
         +5GzRcUff797LYarJG4BMQ+0om/Pjh5yy8rbci4v13x6HMqTNhlfzjcgxWIsvBRT0YPg
         kmL7aiHK3cG4Bsv8hE2S1nQ596rpEC1j9VhaSoWYLbJcOlqEnkmJiyC2SAkv6FbMixHq
         ISeXhxtwB3dRtY9YLxhFrHpf0ZGxvfKT2vrCT2nRU/+1HXcNW1EFZcl5UAkXbasCk05F
         fgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=t+DJRSFf8P5NhE3n7vAB6QLiM8OF2PhClLKhusWhs5g=;
        b=d6HERu5jCmjRLLCBp8kP6II6tNtPiwNriFLq2jUcNLY8F59rytt2EqmBzXgP35G0zv
         bs77Rcm+CdsYWTA4BhUlxlCaqLdIoKRE8QnNqDkzPqfaFEStgC5BSrnzQJgOtpYuPmiy
         qFV6Sj2O/zvlZxrdFFI5o2C2B+JRENQo6ATVtgQQJYvKexQB21qZY7IhzG7+Ap2jDQBI
         D6eR5KFOLxZeBl4IKJSQHeyaMt4LVsbgTueR0gp4vy2Hhqw5fhMWhk82BWGQpV7ST18V
         Hl8x5wSiVyfEVw40+JpPhpyVCt3z5Aw+LITEg5ULWFSt0EKKGUNygrtc6hZzu7FCgXW4
         u9GQ==
X-Gm-Message-State: AOAM532jX4nCAMqptk1vVDwxKQMTtRHPWY2Ol9dluQq+41KuVnQ/J6Vb
        ugAMroEW4DvytrwYQXbFYEu9OCEsekQPbw==
X-Google-Smtp-Source: ABdhPJwuz5F+9S8n29+43BFlZKokeSnaGRMcgziEmljx+a5Ov3h1HM/k1PZrrVwFpeKKKlVlMmoepQ==
X-Received: by 2002:a17:907:9c9:: with SMTP id bx9mr1196834ejc.72.1625161673671;
        Thu, 01 Jul 2021 10:47:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm173989eja.84.2021.07.01.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:47:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Date:   Thu, 01 Jul 2021 19:40:45 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
Message-ID: <87fswyc4dz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> Here is V3 of my patch series to add a builtin FSMonitor daemon to Git. I
> rebased this series onto v2.32.0.
>
> V3 addresses most of the previous review comments and things we've learned
> from our experimental testing of V2. (A version of V2 was shipped as an
> experimental feature in the v2.32.0-based releases of Git for Windows and
> VFS for Git.)
>
> There are still a few items that I need to address, but that list is getting
> very short.

...
>   fsmonitor-fs-listen-win32: stub in backend for Windows
>   fsmonitor-fs-listen-macos: stub in backend for MacOS

I left some light comments on the repo-settings.c part of this to follow
up from a previous round.

Any other testing of it is stalled by there being no linux backend for
it as part of this series. I see from spelunking repos that Johannes had
a WIP compat/fsmonitor/linux.c which looks like it could/should mostly
work, but the API names all changed since then, and after a short try I
gave up on trying to rebase it.

I'd really prefer for git not to have features that place free platforms
at a disadvantage against proprietary platforms if it can be avoided,
and in this case the lack of a Linux backend also means much less
widespread testing of the feature among the development community / CI.
