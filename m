Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079CC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563F461AF7
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356026AbhJAWtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:49:19 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45815 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356165AbhJAWtD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:49:03 -0400
Received: by mail-ed1-f42.google.com with SMTP id r18so39763999edv.12
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 15:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNZZnBmp90WjhCPsl4WOpMKNqFlxWsNlVUH+EQ52ucA=;
        b=iqqt6sIhbgQYDNFMFZn/vI6YDXa9kG9Qg/1LIQmlz6+omeFgrw7WT8QMQCPD51+fS9
         /NjTydf6Lt4V811+TexoVFWbEMxdJacm6jnlIrwBsYM+QZWp/yxUI/1thGYVopcNbrPM
         G0f3hIw1JEnD5L4y3wk3QtMXBwG+8MK8a9ioU56Qb3fNCre6GAn39ZqnOaiRCyDdXZh9
         TFNq2O4QkNQInWYkfWwG8yRTF9IJkqSGFyPuodbd4pBcG4nnnGzboqeaUf+/9N3D22PW
         SCKhQHfaUUfLMqQY8RXcxoXlnLC3V+G1/wpwkbHBvxGrj7LawL+BA5I75XPp3lhe+eZp
         6yPg==
X-Gm-Message-State: AOAM533tFLH6T0VjD6eSbA5xCXOx7UQz447T/rxBTK8Y3Kf/0nPD90Kl
        CEe229XkQkcMGqze29aK2NrpHvx8NSe6SuEfigU=
X-Google-Smtp-Source: ABdhPJye6Xffdhob+pKhQ80LQDAKWXRA9PJEtozp96/TZbXnYJXAS/ivXF9o3sH8z0/XT6LzVB/G8oMA76+7+dnyOVE=
X-Received: by 2002:a17:906:b19:: with SMTP id u25mr632152ejg.36.1633128437713;
 Fri, 01 Oct 2021 15:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com> <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Oct 2021 18:47:06 -0400
Message-ID: <CAPig+cTVODZX1tS1FJe16OH0pTgW4dagau3eAHrwDmnBpYNZ7Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] reset_head(): fix checkout
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 6:06 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The reset bit should only be set if flags contains RESET_HEAD_HARD.
> The test for `!deatch_head` dates back to the original implementation

s/deatch_head/detach_head/

> of reset_head() in ac7f467fef ("builtin/rebase: support running "git
> rebase <upstream>"", 2018-08-07) and was correct until e65123a71d
> ("builtin rebase: support `git rebase <upstream> <switch-to>`",
> 2018-09-04) started using reset_head() to checkout <switch-to> when
> fast-forwarding.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
