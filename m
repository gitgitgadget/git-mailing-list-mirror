Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29366C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20172311A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbhAGHZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:25:31 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:44305 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAGHZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 02:25:30 -0500
Received: by mail-ej1-f45.google.com with SMTP id w1so8277997ejf.11
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 23:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wVmVdWnDtm3kbDJ0PolPeCCciyIaQJdM3ForuMrfog=;
        b=VEmU0P/z291Hf0dt4hyQ6ok9Os1UW66ELMYhZUObZlGaEV8c+IszcWQC6sv1ma+Nzw
         NRpsyPcPR0d4NM32WODvGbFBMe6XyKqhkZwwQsK1dYKQpBtUUVp+F8Xx0D//hV6aJuL+
         hc3TkLfA47gtutUhRC2gaJVigYM7oWrLjz07NteXInF/5sC8rjSV4NsrBpZy2qZr2yY9
         U5z9G9PgeN2H6aiqY+X3VJcvW6qKNZ7RBY88q43AwV8KJyIXPaRMZL7wcauKRPEQ9FHL
         WydJFECzNoyy/ZgnrDwDQNnosIubqkSonJ1RarrYQGZ1rp21Iy4Nw6fXQkmTMHcpQ4WS
         PypA==
X-Gm-Message-State: AOAM53380HE5QooREYt+WjfUnKG1Z4PEO/wP9ndqUU69hs2BfL/eSAqE
        iDQd3b5auD5nLKXIM1yzcBCMxQgKlkcYpsgxqpKKtajKcik=
X-Google-Smtp-Source: ABdhPJwd09XHF1ioBvgs/M7hoSonQr1zeRjzWmC2Nn/ut+8a+Pfbnbe/KK4PvwY23ZTLhV7//lJJTv7enBxn7BRt+1s=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr5616793ejb.138.1610004288746;
 Wed, 06 Jan 2021 23:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-2-rafaeloliveira.cs@gmail.com> <CAPig+cT0hkrDBptLXNjgdzA+QMx-uGcqOLezJJ5ASGnjGTZtng@mail.gmail.com>
In-Reply-To: <CAPig+cT0hkrDBptLXNjgdzA+QMx-uGcqOLezJJ5ASGnjGTZtng@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 02:24:37 -0500
Message-ID: <CAPig+cT3e8zUaq8WhibjcBEK0BjxE_7_OhG5zanmfrck-YqLzg@mail.gmail.com>
Subject: Re: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 1:55 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
> > +/*
> > + * Return true if worktree entry should be pruned, along with the reason for
> > + * pruning. Otherwise, return false and the worktree's path, or NULL if it
> > + * cannot be determined. Caller is responsible for freeing returned path.
> > + */
>
> It would be good to update the documentation to explain what `expire`
> is since it's not necessarily obvious. The documentation could also be
> tweaked to say that the worktree's path is returned in `wtpath` rather
> than saying only that it is returned. If you choose to make these
> changes, they should be probably done in a separate patch from the
> patch which moves the code. This is a very minor issue, not
> necessarily worth a re-roll.

On second thought, adding a patch just to make a minor update to the
function comment is probably overkill. It should be okay to do it in
this patch. Mention the change in the commit to alert reviewers.
