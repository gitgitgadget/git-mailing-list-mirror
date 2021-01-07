Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EDBC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 04:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17F122EBF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 04:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhAGEag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 23:30:36 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39090 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAGEag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 23:30:36 -0500
Received: by mail-ed1-f43.google.com with SMTP id c7so6464096edv.6
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 20:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6cbbEvEuhLwtnMQEp8JVA9+VvHRUC1rpQ8LIgY79rk=;
        b=dc22BZaqI6DzqMEGA9ltkalFESauVK9/uUviU8T18oms2/kSjiJNjJpVNFFCiDn2mL
         XQsfiCzxOapfgN6adr5R/yDPFLdm1haKgEZkVoxqkXdDR/Cb6ngTVo+Xoit9qF2k0o3B
         b/7VTX0ULFJo48aT41uKVtNtwMowljRbCkqH/UDtFbtR85Wek2YnsUeoODboruxQTlep
         v78YTN+R0fiAGLvD58/vRrmuk9L0qXEjB3zpD9X0puczQqTfxGwOFdM17KKz/P1RLq19
         gnHALGFLzGQC4okqgg0Zzv4fdk7Marug9nQM7u0yXRzpHDk/JmX+mDjrIxLmjuDWrnx/
         dz8w==
X-Gm-Message-State: AOAM5319vK2l5TJqumywOoQTKE5dQbPg3SdfNjOP7Gk+bokmmYrLSwnc
        28C68ChLhgf1fTTHM+mJ/9o7RkY6F6MEuvAVZS8=
X-Google-Smtp-Source: ABdhPJyDH9lg1HIgKXh1+1t5a6DuqMP+vG5Ack9SsnY+B59E/F/tuUrXBxxf5vASUwITcXpjcFXetq8rMQA16Wl2eS8=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr249033edc.89.1609993794421;
 Wed, 06 Jan 2021 20:29:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
 <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com> <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
 <xmqqturtrdre.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqturtrdre.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 23:29:43 -0500
Message-ID: <CAPig+cQ5_J4MU9CkG9kyjOTrYPFikkX4vG6AFQhczUT857H7pg@mail.gmail.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 3:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Is the API of this command ideal? It feels odd to force the user to
> > specify required input via a command-line option rather than just as a
> > positional argument. In other words, since the config variable name is
> > mandatory, an alternative invocation format would be:
> >
> >     git for-each-repo <config-var> <cmd>
>
> Or not to use any configuration variable (or not to have the
> for-each-repo subcommand at all) and let the users write
> something along the lines of...
>
>         git config --get-all <config-var> |
>         while read repo
>         do
>                 ( cd "$repo" && <cmd> )
>         done
>
> which is not all that bad and much more flexible.

I had the same thought/question about why git-for-each-repo exists,
though I didn't verbalize it since I assumed the reason was covered
during the original discussion or patch submission, which I did not
follow. I can see this command possibly being useful for Windows users
who don't necessarily have a Unix-like shell or MS PowerShell with
which to open-code the loop you illustrated. This may be especially
important when this is used for some sort of scheduled maintenance on
Windows, as a guess.
