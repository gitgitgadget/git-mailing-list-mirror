Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C56C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbhLAAIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345878AbhLAAHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:07:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641CC0613FB
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:03:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so93553264edr.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3jTLyEaNaUJKWIBQAP0a3UPfbXrZ6DQCU1GtWNGA2g=;
        b=T+CvTvcDvKleIxIIUbaGfn79Z3ra4ZPx+6l7rwg0kbt/Og4B1d/5m/bXcMobwYf2Wy
         GCTs6eKX7bXIjUtFxc3WZ1u2/I/TWfHMt0Ok/71RAxIhaEhFXBFJe6TfktEpSSgojkxp
         b4rUuJ33WlTPRMYjPOAgTyhzSI8ikLEBjsqdpr1HWqdITYozfmudyZi6TIULf2bIpXxb
         9/SrGo89v9QbIUGtvmquTpShPSOSwaROuNUMSAYQnB4UFykREYZiqWqTnc48Ov2feKYo
         fI/x+MyCrLnx6afa5E4L62T0punu8a+8eJ9ZX2gquV7yysZ+hBxZl5RcuU6Qzvm2G+eW
         hGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3jTLyEaNaUJKWIBQAP0a3UPfbXrZ6DQCU1GtWNGA2g=;
        b=vFU9EOb0Xa0Dt559zXEWWgyTd5dIPbm3pYmlUXXOzVlNUBOFQfHQuAqjQA4NTKXFcC
         BflOHzREQL5o0m03isQI0uWt8JuVK/mXw1v/GguVeFj3smCwSyPfboK06th6awhpLsEz
         kLnwHanEdiCI7sjqNcAfIZMrJkIHcDxOiia6mjuCRrAW8+LxfSMTFP1BBA+Dw/nMtROO
         G37fyYnIO2/iekRX5wVwOrZzABkYql9uXaO2QHKdCr+5zG0BVVYGpXakGB3TOVkPf24p
         PQHqF/TRpp9+WedJJBj8NiruQMlRUEMoul/sLFD9fHiDkmqObrU0rhjiJNdSAlX35OJ4
         ssyw==
X-Gm-Message-State: AOAM531787igC+RR9+jmKity31b5geo+soxmCFc7kbw7sZJYFr6O3JzV
        /NBFdAcpx4RPaUVfeAtuHj4zs8RI9ghRp8PR+0c=
X-Google-Smtp-Source: ABdhPJz1EvwC7RT5bxUZ05B126oBUROZzrPqblDF5a7TSp1K2pZFC7X8/EPe/WV6XdO+zMH+ey0bO5IZAknoFqLvCaE=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr2884990ejc.74.1638317029362;
 Tue, 30 Nov 2021 16:03:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <8e8b95d7-a4b4-6839-c572-8a43bbae8e0c@gmail.com>
In-Reply-To: <8e8b95d7-a4b4-6839-c572-8a43bbae8e0c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 16:03:38 -0800
Message-ID: <CABPp-BHpdhfw7SQZfVKcQoPvwwjiN+3aaM_XNJS0bWottr73jg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Avoid removing the current working directory,
 even if it becomes empty
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Nov 30, 2021 at 3:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 26/11/2021 22:40, Elijah Newren via GitGitGadget wrote:
> > Traditionally, if folks run git commands such as checkout or rebase from a
> > subdirectory, that git command could remove their current working directory
> > and result in subsequent git and non-git commands either getting confused or
> > printing messages that confuse the user (e.g. "fatal: Unable to read current
> > working directory: No such file or directory"). Many commands either
> > silently avoid removing directories that are not empty (i.e. those that have
> > untracked or modified files in them)[1], or show an error and abort,
> > depending on which is more appropriate for the command in question. With
> > this series, we augment the reasons to avoid removing directories to include
> > not just has-untracked-or-modified-files, but also to avoid removing the
> > original_cwd as well.
> >
> > Peff and Junio provided some good pros/cons, if it helps:
> >
> >   * Pros: Peff (original suggester of the idea)[2], and Junio[3]
> >   * Cons: Peff [2, again -- see the "P.S."], and Junio[4]
> >
> > [1] well, with a few exceptions; see
> > https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
> > [2] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
> > [3] https://lore.kernel.org/git/xmqqo86elyht.fsf@gitster.g/ [4]
> > https://lore.kernel.org/git/xmqqo8691gr8.fsf@gitster.g/
>
>
> Thanks for working on this, I'm sorry I haven't had time to take a
> proper look at it but I think it is a good idea. I did notice that
> you're using ":/" in patch 8 and wondered what happens if some runs 'git
> --literal-pathspecs stash' but I haven't looked properly.

Interesting point.  The --literal-pathspecs passed to stash is not
passed along to the git clean subprocess, and we only use the ":/"
pathspec with this subprocess.  This means whereas before we'd always
run
    git clean --force --quiet -d [-x]
from the toplevel, now we run
    git clean --force --quiet -d :/ [-x]
from the relevant subdirectory.  So, I don't think I've introduced any bug here.

(Now, the fact that we use a git clean subprocess instead of just
calling the appropriate library functions is IMO a
design/implementation bug, but a longstanding one.)
