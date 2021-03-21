Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE29C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAA56192B
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 05:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCUFyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 01:54:55 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41537 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCUFy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 01:54:27 -0400
Received: by mail-ej1-f52.google.com with SMTP id u5so16013051ejn.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 22:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOg5WJd+uQBSnNjYXjhftg7+0fnn+yIJU5OLrQHYen0=;
        b=AMmKW26fxb+JNRHMPOOPQariMGjfrWU87ESieKCDF1AmGXC02cDAG78IwyaOExHvWz
         1AU6axUq+Cf5I2VGLxOLBlLTC9yLf2UzaG6QAWLbmnWH7QPGp5VmD8zCnRFHntK32Kpp
         HS6gUCvWMzrIkd+xfp6qavq28h/VPuAN4GQeFNA8PYdp/VhtytLRClVLyXbImLUKrss2
         m0pwSJNQskj1WbLsL/OJAvmF+pv0w9/ZzaNM2PrkGs/NZd5vKfUFFwiFkgGAOTG+I+Re
         wHBtND7b4+NzPgdzKZZM4iVQDPYG2P8ssueJ52HscjRmIsSG5+XrjRKNJ60tu4lmpKlO
         Kdrw==
X-Gm-Message-State: AOAM533la7s77zASI7vJl6aighXpxT9bhnwyFHZA6TVGWaQ1etusyggh
        DCrcsS+/yH9ypVS5J2GVbFnIEw7fc75i1fmgm5g=
X-Google-Smtp-Source: ABdhPJwbjLtqhtr7ZSmObautd2kfZ+TuTmDFIs3wGbdra5IPtIuLxB0PkJhs8vc4Wvv+tyK9cspgAZcHG1g0nDZAp2w=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr12429100ejb.311.1616306066411;
 Sat, 20 Mar 2021 22:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
 <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com> <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
 <xmqqpmztcb6r.fsf@gitster.g>
In-Reply-To: <xmqqpmztcb6r.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Mar 2021 01:54:15 -0400
Message-ID: <CAPig+cSzapSDP1OZuFBPooEEChd4kBZtBbEx5YpsX3p0xzTooQ@mail.gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 1:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > To protect against that problem, you may need to call
> > format_sanitized_subject() manually after formatting "v%s-". (I'm just
> > looking at this code for the first time, so I could be hopelessly
> > wrong. There may be a better way to fix it.)
>
> Yes, slash is of course very problematic, but what we've been doing
> to the patch filenames was to ensure that they will be free of $IFS
> whitespaces and shell glob special characters as well, and we should
> treat the "reroll count" just like the other end-user controlled
> input, i.e. the title of the patch, and sanitize it the same way.
>
> So I am pretty sure format_sanitized_subject() is the right way to
> go.

The pathname sanitization would also deserve a test.

Denton's seemingly simple feature request[1] has turned out to be
quite a little project.

[1]: https://github.com/gitgitgadget/git/issues/882
