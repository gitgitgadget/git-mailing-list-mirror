Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE66C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhKWRem (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhKWRel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:34:41 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E8C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:31:33 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id ay21so45267540uab.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDVMYE9jjUqW/eH6yBMhE4d9XTc5MLyM/gRumFWvgG4=;
        b=XK+W5w/AxlHzai1Ac7CGCBApiZq+cTLf8BRBFZJUzc2NUqJjrGh7DdWcJG1wkQb8Hg
         nxeUwHWJXziloe2OrLTUADIZf2fOzb8YV6wUIIQgbNs7PpWNuMejp17dUGW1iY/f2RJM
         l6zEuv+1IgzO74ocVVqurQsoXukcJN/FWnkgo5oIjZdx3ZIr9rSGCOka+GU4dRMBIXH4
         D3Sx48Ij5EECdSzic9gGjT3VTClN7hfue00DNxQXis3mpiH5eX08XBLTEH1NbAnk2T+q
         C8+vh8+mtfjFWJ6uM0R8cO57eEfDzbciDb3XD+20bijMEZP69XCU/XpiRhscdBVArYWf
         mMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDVMYE9jjUqW/eH6yBMhE4d9XTc5MLyM/gRumFWvgG4=;
        b=M4sFv7efmGvCEUeLr7MQN8emShSIqhVLOnthxDjBlC+sivg5NrdSMBSeaiCK0kjB87
         Iacl9zPrZsKhA5/Tgmez1aZNkKRBUobp3Ar+4XSk7AazLw+N4tXwB5bJYgSuShj56o7X
         loykFTANi+/8WzeB4E57pINv0POKbeDfp2UC3l4B/udhbbjqIqovEcyErCWsqvicxiI+
         N7Phz7PJjJGTZ1ixuKMjwhcDcCT6Vm+kQOwHZxms0qqhbjbbjwUa3Ae2M5bMqFFIL6dR
         UMNBOmCxJ7/YDC8B/a4qWJga9xdHa2Qke2oGZraFwymIRJq8dh+0dQhVZkzIrpyoN3W3
         hYAA==
X-Gm-Message-State: AOAM530UC9wHmC4DjutBNgwYz8Xz3dDgADCQqEX8/dX/mWlEI9bu+eWz
        cLSo+MO9aXYcGdKhm9sS74ZNnpc0BK22ZmobfqROhUZvrj8=
X-Google-Smtp-Source: ABdhPJwgatoEcFG6SqBTQJuADAMacCGVdYt4yc1rnTciGtqEqSatje3ioZdrBlf5bFrmAXscFE5Vq9UaXcFYlin/c50=
X-Received: by 2002:a67:c181:: with SMTP id h1mr12133503vsj.3.1637688691718;
 Tue, 23 Nov 2021 09:31:31 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
In-Reply-To: <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Nov 2021 09:31:20 -0800
Message-ID: <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 3:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> I think a combination of isatty() and tcgetpgrp() is probably the best solution.

Definitely agree the long term fix needs to include tcgetpgrp() as
shown by this initial draft[1] (which I apologize, just noticed is
missing your "Helped-by")

That of course introduces a regression on the other direction though;
before this change, git compiled to use our getpass() replacement
(HAVE_DEV_TTY=1) function, the following will be normally stopped by a
SIGTTOU just like getpass() if running in the background (need to also
not have GIT_ASKPASS or SSH_ASKPASS defined in the environment)  :

  $ echo "https://user@example.com/" | git credential fill

I suspect that is probably fine though, as when that happens our
getpass() function still misbehaves if put back in the foreground
(unlike getpass()) and this "feature" might be undesired anyway as the
equivalent C code also runs sometimes in daemon-like processes, and
could even explain some of the workarounds put in place to disable
password prompts (ex: GIT_TERMINAL_PROMPT=0), but luckily we have all
the 2.35 dev cycle to figure out.

Restricting this feature further, maybe through a configuration
property or even special casing the EDITOR is also IMHO a good idea.

Carlo

[1] https://github.com/carenas/git/commit/64d15b2a74206f31e04cf0200f7be83a54a00517
