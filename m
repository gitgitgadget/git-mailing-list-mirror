Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A411F404
	for <e@80x24.org>; Wed,  5 Sep 2018 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIENnm (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 09:43:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46559 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIENnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 09:43:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id j7-v6so4346768qkd.13
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 02:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzDehU89nvQmfSrz9z6ohIpU9OXvVpllMRVyCKtglPA=;
        b=GR0UnMRJEMNGmRiUDVngsI7qzm8OApiI2pyE+e9QqzjlgAIJFoYcz9kOG02KueG7z4
         f8AdxPnssli4g06U76WO5a4fukCbr0m8aAzh5iSO0e76rHKaDJhfY1VqROYJjn9JXy7z
         1EcSZy9PHBOZrDoEqlbVUPy5uHsJcC8+h/Z+2QFrQrFodMZAxMjkbJiyK37+Uv7gwWy4
         iv/lsf/vx6+KgZ06j7hjM93iDkCSX0TxPcoqZHPdcVKq68yARUJsoomiStyoLJcrUsdJ
         GQeWobbbiKHlaTz+qJK1NkioWYaYPnIK7V/3aSww4e5LpbH0jT1RkAmRsucFxt1pRMXl
         yYmA==
X-Gm-Message-State: APzg51DUhuPCczvCsD+nTwMehBeBj2SdLT4z4NqdpdzzoccuIrV4wNSd
        S9b9dsTQ9EknjahPp2axLGTShbZxgWqHRHv4/Lo=
X-Google-Smtp-Source: ANB0VdYhZJtgdteuri5tI+ic1QHTgnWEEbCAqVIn1kol4Jl1JCPUeAfh3WZ7jcVQVdie2ZWS6vbPqemI533/Vnvo/cs=
X-Received: by 2002:a37:1be4:: with SMTP id m97-v6mr31918220qkh.12.1536138864719;
 Wed, 05 Sep 2018 02:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 05:14:13 -0400
Message-ID: <CAPig+cTQLED6P2AWrxU=pvNc6WzO-5YVsPNh3fg28LdZqU15AA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-forced-ops-fix (2018-08-30) 9 commits
>  - worktree: delete .git/worktrees if empty after 'remove'
>  - worktree: teach 'remove' to override lock when --force given twice
>  - worktree: teach 'move' to override lock when --force given twice
>  - worktree: teach 'add' to respect --force for registered but missing path
>  - worktree: disallow adding same path multiple times
>  - worktree: prepare for more checks of whether path can become worktree
>  - worktree: generalize delete_git_dir() to reduce code duplication
>  - worktree: move delete_git_dir() earlier in file for upcoming new callers
>  - worktree: don't die() in library function find_worktree()
>
>  Various subcommands of "git worktree" take '--force' but did not
>  behave sensibly, which has been corrected.

This description mischaracterizes what these changes are about. The
primary intent of this series is to fix a bug in which the same path
can be registered under multiple worktree entries.

As for --force, it worked perfectly fine for the couple git-worktree
subcommands which accepted it. The patches in this series dealing
with --force are merely extending it to other subcommands or to other
use-cases.

So, perhaps rewrite this description like this:

    Fix a bug in which the same path could be registered under
    multiple worktree entries if the patch was missing (for instance,
    was removed manually).

    Also, as a convenience, expand the number of cases in which
    --force is applicable.
