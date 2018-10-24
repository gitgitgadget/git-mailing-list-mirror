Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5486A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJXQis (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:38:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42908 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJXQis (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:38:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id j46-v6so4708463qtc.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 01:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7Z9DHpohjVw58s75xFt5b3ekmc5C5a9TMpbImgYgpg=;
        b=hhhcYo38RE/xrp+nH2lt/H3YnM/Bx6b207EZbdI88U4t9kLVy+BnJ8u5SFaFzdt5mW
         GRy3Zlnx46dw6PLLy/+kKQgpcUt7B/nQ4mKJmpW5Ue4IbNKjWjvDoomLgSbRnpFk7MZu
         hZ3N2v+AFVA5Y1hffP4FmCUhXCtqd8fqTFkbK2eyuyxU8iPsP2DxOwd5AMRmwovNEr8/
         bUV5piBNFVpDe8YGu4cxmXoFOBnXLFBzxlux6TvlF482+XaXctcxZGETc1Y09UPryTx2
         AMEjs4+UCb3PujrHjNb8PK64+kAbibBuu3/8wkk4HxD1L1wVV5zJOQc9bCDODsSNV1lf
         Vyiw==
X-Gm-Message-State: AGRZ1gK35kJ34irUFQoNNMtdv25A15D2G0BVQud0MKvzJS5lrdLeYfVF
        KIbLt69NGAURqxp6NQ0yzgo2LOfcE6nYUZSmPCk=
X-Google-Smtp-Source: AJdET5dSGH+Rs4zFt3jy/FDp9L27VTDRFPoJRMcN+nEhFbQVSL8Yr0bFkkUYEqNQoBza/8Zf+P5TJ9yQzsPelvnC59Y=
X-Received: by 2002:a0c:a2e6:: with SMTP id g93mr1463556qva.62.1540368703930;
 Wed, 24 Oct 2018 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181024063904.36096-1-nbelakovski@gmail.com>
In-Reply-To: <20181024063904.36096-1-nbelakovski@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Oct 2018 04:11:31 -0400
Message-ID: <CAPig+cRN_0VVe6dzhnmU73pgo-8ncPzmOx4bRrTBVvReLW6RfQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: populate lock_reason in get_worktrees and light
 refactor/cleanup in worktree files
To:     nbelakovski@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Mike Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 2:39 AM <nbelakovski@gmail.com> wrote:
> lock_reason is now populated during the execution of get_worktrees
>
> is_worktree_locked has been simplified, renamed, and changed to internal
> linkage. It is simplified to only return the lock reason (or NULL in case
> there is no lock reason) and to not have any side effects on the inputs.
> As such it made sense to rename it since it only returns the reason.
>
> Since this function was now being used to populate the worktree struct's
> lock_reason field, it made sense to move the function to internal
> linkage and have callers refer to the lock_reason field. The
> lock_reason_valid field was removed since a NULL/non-NULL value of
> lock_reason accomplishes the same effect.
>
> Some unused variables within worktree source code were removed.

Thanks for the submission.

One thing which isn't clear from this commit message is _why_ this
change is desirable at this time, aside from the obvious
simplification of the code and client interaction (or perhaps those
are the _why_?).

Although I had envisioned populating the "reason" field greedily in
the way this patch does, not everyone agrees that doing so is
desirable. In particular, Junio argued[1,2] for populating it lazily,
which accounts for the current implementation. That's why I ask about
the _why_ of this change since it will likely need to be justified in
a such a way to convince Junio to change his mind.

Thanks.

[1]: https://public-inbox.org/git/xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com/
[2]: https://public-inbox.org/git/xmqq4m9d0w6v.fsf@gitster.mtv.corp.google.com/
