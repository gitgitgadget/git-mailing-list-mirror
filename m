Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A20C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE20E60F55
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 08:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhKLIyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 03:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhKLIyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 03:54:02 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEDC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 00:51:11 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id q74so21814270ybq.11
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUgSKu8ammsPEH0/OWi+5BF4kR4Dot5y46zLzQYFuTg=;
        b=uzOev6JksnUMF4MnchI1CPHdcbm+JKNmkfZA4hHK00sg9Vlr85fZLSIMDBzWfVCQvF
         CPmJwjRvjBWoTs6oj7nz/cRFu8KnrfVn/HJwq5CH1dPJ2f5SAKInUU9nfanR1YasCiUe
         eaRG/Abgt2SDrmjRHvJ4k7aAgMknfm8UVRaWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUgSKu8ammsPEH0/OWi+5BF4kR4Dot5y46zLzQYFuTg=;
        b=HOcbHsrNx5OjPb6gSFH6ByL2wTp4eAjApwLnzDOA0oqejrxO8uA+mymehtkDu5mOsC
         Q9WBD+5w1Ahq6FXh0wRS9sHKtzB3BhfzHFkC651+2eQ+Zs+E3kprYf58oU52oma3vCPB
         SZM71/0mNAYEnOZsyiYbAPS/Q6oC5cusYufoMZ4CDSQKPZeQyi0+TWt4XB79y8YmZY3z
         GqIC0z5fPHmsZWHGLAiTHjNEEHkBxfJtC/96vUNKiukPjbIy8uq9NsZpUfCSelO6B9OT
         aKkYyggg+DlhPY7Wwuwo6ah4Q9fOmgE06k92dfNUzNZ/RjMAg13T33dp+jNneucUOdC1
         koNw==
X-Gm-Message-State: AOAM530ZCuiqhDM+V6hRVywKg4y4HN/UO1blPkgdpYF3ckRVm4LahiwK
        NQwFWJ6d0nvOInnHdBS5tRyhZ3KdbM8b/U8soxkDhQ==
X-Google-Smtp-Source: ABdhPJzYwXtyx+U2MpPQqOg01BxqNq0exZhikcoj5DZZv+JrYmcXwCb7w5/1mUZuoEFx3jFKCd3iAoXULlI9MM2UvzA=
X-Received: by 2002:a25:ac23:: with SMTP id w35mr13539657ybi.341.1636707070792;
 Fri, 12 Nov 2021 00:51:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1074.git.1636542550889.gitgitgadget@gmail.com> <xmqqtugkx7e2.fsf@gitster.g>
In-Reply-To: <xmqqtugkx7e2.fsf@gitster.g>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 12 Nov 2021 08:50:33 +0000
Message-ID: <CA+kUOanaVM183qtubr+=eLebm2G3+tQwMF2PAHT_xfeeNNHr+w@mail.gmail.com>
Subject: Re: [PATCH] simple-ipc: work around issues with Cygwin's Unix socket emulation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Nov 2021 at 17:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Cygwin emulates Unix sockets by writing files with custom contents and
> > then marking them as system files.
> >
> > The tricky problem is that while the file is written and its `system`
> > bit is set, it is still identified as a file. This caused test failures
> > when Git is too fast looking for the Unix sockets and then complains
> > that there is a plain file in the way.
> >
> > Let's work around this by adding a delayed retry loop, specifically for
> > Cygwin.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> OK, I was about to ask for an Ack from Cygwin folks but I see the
> original that got Ack is more-or-less the same except for placement
> of the comments (and this version of course is more polished than
> the "this should work---please try it" version), so let me pretend
> that this got tested-by from those who were happy with the original
> in the old thread.

Late to the party =E2=80=93 other bits of life got in the way =E2=80=93 but=
 I've just
confirmed this appears to resolve the issue for me too.

Adam
