Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D33C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B0B60E08
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhIOUpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:45:05 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37701 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhIOUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:45:04 -0400
Received: by mail-ed1-f43.google.com with SMTP id g21so8321626edw.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEc6t8CADatkGooCXSARUnmgjdibO20qzS+tadrq/ik=;
        b=p9fm+Hc8gh/qMFcs4I7Ez9twAwCjUtxUukC5APSI8UNd1moGyRBcsmOlcXb1LW1LEU
         uHEdL4Qmco5AJC8F251CeRiJQE+MNQKceTwem2bttTg4xKZ+/kZu/FexZ0wqJGITNdgZ
         DQhyMGp/XN+3ZlnWPS+m2cfTY7raEmW4L6tYGrqQ5iEezQcicxg15KpWV6dJNzN1h1rl
         ZllJ8qFAkVbde94fmzeJli2QVTtokAoJlIHyGR8mvGGGFaXnOj3ED6/N41+5AWSSc27R
         wI9w77bY/gKbHY1tY9w2pDJDC2Vd6kDqoxFzAUPENSos11WagZKV7qiSgjfZ7hsCD886
         sRCA==
X-Gm-Message-State: AOAM530ScxxsjebezftUn0RCI2+Z9h1elURvifLTCHhlB2/NEGDIxRcZ
        IXQH4apgp4eh32asIjrf43CugX79XNDguuasRLXM2ztjp4I=
X-Google-Smtp-Source: ABdhPJzKuirqcl5qE372LAoUpWkJ1VG0x3xCBwNIoP6R+ND/MXlqk8fJO6IKgiEJUs4mCqSBMqdX4bPyRcyUAJIZMCk=
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr2085606ejc.392.1631738624535;
 Wed, 15 Sep 2021 13:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <7182419f6dfa49d4d8415736943c72a575ab6753.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <7182419f6dfa49d4d8415736943c72a575ab6753.1631738177.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Sep 2021 16:43:33 -0400
Message-ID: <CAPig+cQ0qbyBrCDcJgg7=DezWGfZhyAR=YuC=vbxd38B4WA=Xw@mail.gmail.com>
Subject: Re: [PATCH 2/7] simple-ipc: preparations for supporting binary messages.
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 4:36 PM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add `command_len` argument to the Simple IPC API.
>
> In my original Simple IPC API, I assumed that the request
> would always be a null-terminated string of text characters.
> The command arg was just a `const char *`.
>
> I found a caller that would like to pass a binary command
> to the daemon, so I want to ammend the Simple IPC API to

s/ammend/amend/

> take `const char *command, size_t command_len` and pass
> that to the daemon.  (Really, the first arg should just be
> a `void *` or `const unsigned byte *` to make that clearer.)

The reader is left wondering why you didn't also change it to `const
void *` (or one of the other choices) while at it.

> Note, the response side has always been a `struct strbuf`
> which includes the buffer and length, so we already support
> returning a binary answer.  (Yes, it feels a little weird
> returning a binary buffer in a `strbuf`, but it works.)
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
