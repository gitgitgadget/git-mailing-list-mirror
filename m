Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424FC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 06:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhLYGot (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 01:44:49 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43985 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLYGos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 01:44:48 -0500
Received: by mail-pf1-f177.google.com with SMTP id 196so9242027pfw.10
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 22:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gn4ivLe7AlH/V7i60JreKwbTywPrT875j9LP4dhhg34=;
        b=bth7Hs3uDFapolsmgrtXtNXczNmQQ/jk/9fgPjK19wHdR+tgclG8lOlEC/WA751O2N
         Sg/9aZ+8cEsuWgQPRVJ9B7aWm31+DzZyS9yJJYX6K5xupWzMr/6ABUFiz4jMrsB3MKKe
         8pZlT/wWZJAfsGdbQgnLtk1fO8D5Hcw6IwtzkU1nrKtVKiKjDO5pyBRz28AwR93kTlOK
         lPz/9G0J2Ads+UdgBdiWzcOpbnqwbz5NgGUUqr1aEXozp8sikrJbj411FWPCLcOAuPDt
         6QjakLuka7knGpsNOhZ3O5vLAVs6N3LJYrZa41NFWC/LSTPN3NquVlYnU5YJqQB2sEBv
         z73g==
X-Gm-Message-State: AOAM531msqq+dKtDEAZN1wLieY4h5gCi3rklOw5s2bpo1nVApq+PFAUo
        WZvFrrb7m/Ng5/z0AGxFUwnLUh8x1iAan5q4aJLNrmQ3tTF/vg==
X-Google-Smtp-Source: ABdhPJyoH4qNXZuSmTx1aMAFW+b2W3CYWwMbvbp/GKJB25SAxXgVlOL+hHIJZCNsg4zNG7t9XR9NaReAhLmZMv/VsS8=
X-Received: by 2002:a63:395:: with SMTP id 143mr8542903pgd.181.1640414688068;
 Fri, 24 Dec 2021 22:44:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqqsfui6g7q.fsf@gitster.g> <xmqqsfuh5tz4.fsf@gitster.g>
In-Reply-To: <xmqqsfuh5tz4.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Dec 2021 01:44:37 -0500
Message-ID: <CAPig+cSiMzjBTdXCnckXhvUPxYuGW8GO+7jNUnrkW7TLwC6LXw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #05; Thu, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 9:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
> >
> >  "git sparse-checkout" wants to work with per-worktree configration,
> >  but did not work well in a worktree attached to a bare repository.
> >
> FWIW, this topic by itself passes its self test, but when queued
> near the tip of 'seen', it seems to break t1091.
>
> For an example run that fails on win+VS test (8), see
> https://github.com/git/git/runs/4629824103

That's breaking because t1091.10 is incorrectly using:

    git config core.sparseCheckoutCone true &&

rather than:

    git config --worktree core.sparseCheckoutCone true &&

All the other instances in that script which set
`core.sparseCheckoutCone` correctly use `--worktree`.
