Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC01C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiCBICc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiCBICa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 03:02:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2EB6D08
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 00:01:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i11so1067804eda.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6+WM+hCa4RzR/etpkvK/Ic9HEpHc3Cp5hXFoCWneM0=;
        b=Ws0epXvN1sffcCiuA6wCOLtVZPQOL7OkfSC0zuUnVzZ4AfyunT9hxEYNTR7oLl31kO
         PPIj3T7K5GAJ+LQHvqT61RNJ/h9S3EP+Ahkrg2CVmwAYjJK04aQG5HPLtgjHK1HSofs/
         RM3WBeXRZDMfYnB7yrMUCrkIDUmL9C1t39CdNJ2J4XNQQ+CpzDNK+8RMOhY1VRJi8FMT
         bw2YhARzNg4FAN/wAHtd322RuVawxwMLkEKplXgpiAv3gQUnSH6EkrcxcNpgQp4IoACT
         ehaYCCyfy4fbQf3xAvircRq45lq6Z3156d86AB5ndME7KPAmk9Byvi6y1xR9eDavYM0x
         V8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6+WM+hCa4RzR/etpkvK/Ic9HEpHc3Cp5hXFoCWneM0=;
        b=zQ+V29UBHgEwDtPpraBMZf4JXG7y5smxM1BBCdlLX+VidZRCKEx+SPoQjW0ksH0bU+
         h66iniTgN8mwHE0SmzxWgXAnTYkF5R8BGAO+koYKusvyTcGtBD4RrcymxUrIcuNTx9Ll
         NSwEAW3E/7ksS3twduAVlr2xhljYmDdoaV13d7dByJCczaJ8wx+kE4MZna2CDAPBYOEU
         RvRmXWz0/FEjNbLSxMpWCoYtha+5kUpvAMqG952uvzXKm3a6JgT5FYJfd0A/kGLzuxIN
         6rQk192V1qUny4p9L4Tn5mjvmobJNzSsL9hr4W1EWJO4rG4dzDi0d7igD/ptLqD2nPcg
         ZxuA==
X-Gm-Message-State: AOAM533bHMF6yGtzbQXE3W5zt6fFeaxrqjS1Whlw8KI1LXN9fnuWjUjh
        +Zj2iAC4o1KH+gY574uvC8kOSrnILQDvRNKID/M=
X-Google-Smtp-Source: ABdhPJxheZjI16TwCWAUTf3dJCmcF3ZQqkNViF+cDzpsbdrpn28sCrfNi+M/yT95exPeKfDhJpIPteIiM8FWGiQp4bs=
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id
 h20-20020a05640250d400b004132a276b56mr28421053edb.228.1646208106279; Wed, 02
 Mar 2022 00:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20220226061222.797107-1-newren@gmail.com> <20220302043301.1620188-1-newren@gmail.com>
 <xmqq1qzkolet.fsf@gitster.g>
In-Reply-To: <xmqq1qzkolet.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Mar 2022 00:01:34 -0800
Message-ID: <CABPp-BFqJGHDMz744Q7FV22tW6dpGNoBwAW=P1HZE6PtZeHN6A@mail.gmail.com>
Subject: Re: [PATCH v5] repo_read_index: add config to expect files outside
 sparse patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Typically with sparse checkouts, we expect files outside the sparsity
> > patterns to be marked as SKIP_WORKTREE and be missing from the working
> > tree.  Sometimes this expectation would be violated however; including
> > in cases such as:
> >   * users grabbing files from elsewhere and writing them to the worktree
> >     (perhaps by editing a cached copy in an editor, copying/renaming, or
> >      even untarring)
> >   * various git commands having incomplete or no support for the
> >     SKIP_WORKTREE bit[1,2]
> >   * users attempting to "abort" a sparse-checkout operation with a
> >     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
> >     working tree is not atomic)[3].
> > When the SKIP_WORKTREE bit in the index did not reflect the presence of
> > the file in the working tree, it traditionally caused confusion and was
> > difficult to detect and recover from.  So, in a sparse checkout, since
> > af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files present
> > in worktree", 2022-01-06), Git automatically clears the SKIP_WORKTREE
>
> The reference is a bit off here.  Here is what I get locally:
>
>     af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
>     present in worktree, 2022-01-14)
>
> and that is in the version I have locally in 'next'.

Ugh, forgot to update the date when I updated the reference when you
pointed that out.

> > [1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
> > [2] The three long paragraphs in the middle of
> >     https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
> > [3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
> > [4] such as the vfsd described in
>
> Here is another difference from the version I have locally in
> 'next', which I didn't notice that this [4] was misspelt as [1]
> before applying.

Sorry, I hadn't noticed you merging to next, and I saw in the irc logs
the discussion about this 1 vs. 4 between you and jrnieder so I
thought I'd fix it.

> Everything else seems the same, so let's not bother reverting the
> old one out of 'next' and merging this version after fixing this
> version up.  What we have is good enough modulo [4] vs [1].

Sounds good.
