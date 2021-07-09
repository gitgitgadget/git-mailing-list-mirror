Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0EC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001C861380
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhGIOw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:52:28 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:35333 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhGIOw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 10:52:28 -0400
Received: by mail-qk1-f170.google.com with SMTP id q190so9543458qkd.2
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhgQiEbCR7wSzpzUyYDgpbVsRwQfajUNnEPcZR0uk7s=;
        b=mGgnlqVpsITJE/qUJO4V09innnRBgT0ZwX0k9P+Cb3CEWorIajC8MOBMMOfGjGejpa
         ywToWpqkKv+V2EieySVLJzOfmbbysCPfd/7NHxXri4t1KL5m0cGPl6AwsxhEM/QcZQtA
         9v4RXx21liiEiVqRKHm7cXTZFqbz50wiqwXyQjbXaVrO8HJHw/zxHzrayLXBzZAisX5a
         rjkn4RsAOT6J+IyTZGGr/M7vde0Ni1hYktZZJ4CtpYvJRtphxyXHeR7/a9qWes2JKdqC
         7XPaS5iieAGhnUIx5rfuAY6TNWQACTE39M/vfmiD+GG1uQ7h84KeDh1npUrZmRZOgIXq
         jilA==
X-Gm-Message-State: AOAM5332NWYTmjYkP0LzTOqkq1/Y3qZ24bBUeLQ50I83T5B2JhkkX/Es
        SGkWuFQLrQqCgmBomLH55T8nopji3QvGUw==
X-Google-Smtp-Source: ABdhPJyZb+UwVlj/+GvFf0pMhb09MpLa2Cy43tEsC0NYbgvxjVLVAJmXY/D6McDMliAYVqMoYvMctg==
X-Received: by 2002:a05:620a:4dd:: with SMTP id 29mr33286979qks.250.1625842184145;
        Fri, 09 Jul 2021 07:49:44 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id j3sm2290264qth.63.2021.07.09.07.49.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:49:43 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id t19so9512592qkg.7
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 07:49:43 -0700 (PDT)
X-Received: by 2002:a37:8581:: with SMTP id h123mr38080531qkd.316.1625842183559;
 Fri, 09 Jul 2021 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210317.706313-1-me@avishay.dev> <20210706210317.706313-3-me@avishay.dev>
 <xmqqbl7fgkvu.fsf@gitster.g>
In-Reply-To: <xmqqbl7fgkvu.fsf@gitster.g>
From:   Avishay Matayev <me@avishay.dev>
Date:   Fri, 9 Jul 2021 17:49:32 +0300
X-Gmail-Original-Message-ID: <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
Message-ID: <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, code@tpope.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Jul 2021 at 01:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> Avishay Matayev <me@avishay.dev> writes:
>
> > There are several behaviors where git will not attempt to do an action if a
> > tty is not present, for example - `git_pager` (pager.c) will instruct git
> > to not use the GIT_PAGER environment variable if stdout is not a pty.
>
> In general, I am negative on this approach, even though I agree that
> the issue you are trying to solve is worth solving.  "Force pretend
> that we are talking to a TTY" exposes too much of the internal
> logic in the implementation to the end users.
>
> Often we use isatty() as an approximation for "are we being
> interactive?", and I wouldn't have as much problem as I have with
> the "FORCE_TTY" to an approach to give users a knob to tell us "do
> not use your logic to guess---I am telling you that we are
> interactive, so behave as such".
I'm not sure that I understand your view on this patch.
`git_isatty()` does exactly that, it gives the users that knob, doesn't it?

If you don't find the approach in this patch good enough, what exactly
do you suggest?
