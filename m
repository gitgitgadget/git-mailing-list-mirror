Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDDC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5FC6128B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhGJHOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:14:53 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:33431 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhGJHOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:14:52 -0400
Received: by mail-ej1-f52.google.com with SMTP id bu12so20837456ejb.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWZu/r09lR7pLvaSsPIdSVmvSG3H/lVjsV/rne+1dIo=;
        b=JyTEyhkrQIxNhHzDy8DbeKUTUoulmG43i0Xx0+k+v3x0StHjqZT77rAQWGyj3xezYj
         Bj5JmYAL4g3C9RM+0aE+K0bUsAJRU8DeV2RrM1CQoZUiW6vTPpXCDW/pXFxHtttD069Y
         ne9d1nntl5qb/Uzroi3FeKuWWm4TOgTxc7T0frFPEJuhG1DJpbDL0W9iDpwKgXBm9vcu
         eEkfx9OzJl73+ydVRDVQ0CjmxvDDVoiWBOyYdAnOo/X75wWpj310SSYEXV6jV4C0lDyK
         kLY13lHhzR1nMTZbZ8Eu/T+GHiWUorXGDK+6lFbg0/XfPslv/QfQMlWChlAeaSRJ8D00
         UFhQ==
X-Gm-Message-State: AOAM533sRoMD8OFO3g8FfQ/pyFSKyerG5r6XYroFwk902tdwabi2Wy+n
        735l773dB0uxx8Bj1qf5KNk/5zz6cMcf4WNmJW0=
X-Google-Smtp-Source: ABdhPJznFdah1LvTgaZPRXr2bQiYORev1OcxUFyqf3yXUd2J/ZVGxf/pK2bT4vroae7LIKN4j1fHgeHQpS8DQDYeKHs=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr303377eju.371.1625901125123;
 Sat, 10 Jul 2021 00:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
 <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com>
 <xmqq7di3jkki.fsf@gitster.g> <CAPig+cQbBPGN+Dcvmy+ZAZeKLpffRrN4-2PNjRHzDHj56axcJg@mail.gmail.com>
 <xmqqczrr8qax.fsf@gitster.g>
In-Reply-To: <xmqqczrr8qax.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Jul 2021 03:11:54 -0400
Message-ID: <CAPig+cQEn0k8YEYWPep0yxn5N6xdtTE9hc1Po-DGCHu09UFzHA@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach `add` to accept --reason <string> with --lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 9, 2021 at 11:23 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > "reasons". That possibility suggests that this particular
> > reason-giving option of `git worktree add` ought to be named
> > `--lock-reason`, but `git worktree add --lock --lock-reason=<reason>`
> > feels clunky and redundant, which is why I was wondering if `git
> > worktree --lock[=<reason>]` would be a better (and more convenient)
> > UI.
>
> Sure, but
>
>     $ git worktree add --lock --reason=why-do-i-want-to-lock \
>                 --frotz --reason=why-do-i-want-to-frotz
>
> would work just fine, no?

Yes, taking the stance that option order is significant would be workable.
