Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF251C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC56610A2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhI0Um5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhI0Um4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:42:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F524C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 13:41:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t189so27268268oie.7
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixkCDNCn5EGoztUWmqdv1FCs+oC4uIVkjNm9gB/0iTU=;
        b=DieFgfU5XmgSDH/zlLixgp1omriXprnmylzIyyexJEJ52QsCX23xIWxu69BvJGnM/E
         Oq7zq63kHHuF5OpzhcbyOC+YUa6EbzuPgTVHqsuWZJnWl0cIOLmfq6W/1GHCf2Chd8/T
         RCWYnPisyoAfhhh5bdpWMITYHqVQwAjzl7ejIgcmh1xGlfr05fIE0U47QykkwA4lhmat
         +uCddqvRBET9sxnud3QYY3yduAKAnM2zLX9OsOm5mbCl5W17RilQ7zd2xIVWnxgeUjkh
         Jg3UZ0KzsfblMOk+2/nTxPhw6rqr9DKM2Gks+lALN04otQaxeeVGcq/ez56OfchYW/qJ
         CBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixkCDNCn5EGoztUWmqdv1FCs+oC4uIVkjNm9gB/0iTU=;
        b=ihdMV3TP14YR2AIpTYL7KLIQRlOaFwTDIZ1PE7V2N7+UbZnbEAttamn/OhcpQ3cyoC
         xeJWXc9eqchRqouJbZFI0v6PGtPGmR1Q0tW4Co/EutA29HhGWhbVqY0JNCdCfGHfNCck
         W9xjyaLgMjzWNWYdOqzXz+hhuwjV9EFHe/oTE+N37onAo1x1s6KuYsRojO6zcDMOew0K
         7qjA9Ruq8nbu0AfKToFSCYpO+cJ5gwi+InfOr27P2oLgiMr87G/nSVlcbiIs/L1P2l6L
         8oN6h9+5WQXc0IOYWpAs/hwPGKL3xt9fNIi4kjlKxbV0GuBrOPGnLosakcDX4LcSpTeZ
         +cpA==
X-Gm-Message-State: AOAM530J0G1R+9LKPWl/eYewGfDNxVsiapIJpVLTOUwVExwwYLYaIU43
        Wgvh3CUGNEBHTPXu9nPwo08HAOp48EIIWitcVoY=
X-Google-Smtp-Source: ABdhPJxjd0aRLwGuC+4iIDjcP2IMiSuavyO1Ojp8I9cwShuiP6hrmXKpOrXDhM5QRraC58ENCwjjH1Ee3vVtNB4QYbg=
X-Received: by 2002:a05:6808:20a:: with SMTP id l10mr826635oie.31.1632775277796;
 Mon, 27 Sep 2021 13:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <xmqq7df1pxgh.fsf@gitster.g>
In-Reply-To: <xmqq7df1pxgh.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 13:41:06 -0700
Message-ID: <CABPp-BESmz+9vcd0r+5MT8vr7HodecUpLKNL=Hyx4qxLJv0ZCA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Fix various issues around removal of untracked files/directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v2 (all due to Junio's request to consolidate
> > unpack_trees_options.dir handling):
>
> Heh, don't blame me.  I even explicitly said it was merely an
> observation for longer term, not a suggestion to include the first
> step for such a move in this series.

Well...the repetitive code for setting up and clearing out
unpack_trees_options.dir that already existed (and which my series was
copying to more places) bugged me too, but I was worried that it was a
bit messy to clean up (and the fact that it took five patches suggests
it was).  But then you also brought it up as an issue when reviewing,
so I figured I might as well dive in...
