Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569BC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCFRfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCFRe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:34:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B869232
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:34:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i3so11234094plg.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85InkN064XQF/H1rT8dQ9qnx1pd7oA7w43n1ocZWNe4=;
        b=i6L8MjI98uILMJHk8/y05jB21I55ppiE1aUyS8G1U3DB1DrfrCg/K2NVEQ4FcZQYJ2
         3Um2H/GgrwVE/uAZiKOUoKUZqiWrN9F30cBYyQ3H4KXDWIMJQ7H7yyWz8Ct6fLNtOsG3
         q4D+iZzOkvIX7SP5dF7Rz0IW9Cf2tCOVnYJMp3kriQw3sHDgWKCF2tPNO1vt/P4qSegL
         T4hLmJ5YL+yhsZLozZ9jFVUqmu66KBmhtUmUoFyman5CZw9NoqE/b2Wnv8sFAgE555QV
         a/N9ugkQppzHNj9xzZo/PfgqO48DmBJ6Hz/+xokYTiivJfn0353PnN/Jqz0/7fiWa+Y1
         Zmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=85InkN064XQF/H1rT8dQ9qnx1pd7oA7w43n1ocZWNe4=;
        b=WhEgxoaJfNxYwtBUlSYy2VOZ+933RPNi3CI1ybnZJ+/71Gf5oNrOp/exbFfsmbUFHs
         uiymfj+NGW0iuammx0tiKXpt1yK47bVCbST87xSmMTqiXAgKBlNhly78jBQlhoAHMY9m
         rOLliePt4/Wd1jdTkOAMfqTZlZSpl/h+hRZdMbfsamwzqvQohPadQHIihQ+5/MLxejm4
         KIyFUmWIls9Yt102eiY/hm4vuZaDDXmEStG14pwhBOYrodXnHozLZIN5/bxgaK1VDOnw
         wj/G58KYOol2cfglSS0663BxoKQFyqStGRcA1z22/uGYYQ/2/hg1VFK2F7fCVone3Qy2
         B16Q==
X-Gm-Message-State: AO0yUKX6yWVaadVXafvBYg1UKn7OJft3tydOY/lq4VOIBdB1HEu9/qee
        x5P4D5sF3clBc1KlL+ao782EmSXgK2k=
X-Google-Smtp-Source: AK7set9yCZCqGvANWhZpFA3cYq8FLLx7b0ntsH5DrLbwRPT+ZngKAcQu+VF78PbEZ4cXzvqN9AMfig==
X-Received: by 2002:a17:902:aa02:b0:19e:2eb5:712d with SMTP id be2-20020a170902aa0200b0019e2eb5712dmr10826615plb.25.1678123955173;
        Mon, 06 Mar 2023 09:32:35 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001994a0f3380sm6977186plh.265.2023.03.06.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:32:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
References: <20230303145311.513960-1-eantoranz@gmail.com>
        <CABPp-BGOtsjgfN5f=dSb0ZSEx8nzFs6SKrUm=2TtPPH5cKa4cA@mail.gmail.com>
Date:   Mon, 06 Mar 2023 09:32:34 -0800
In-Reply-To: <CABPp-BGOtsjgfN5f=dSb0ZSEx8nzFs6SKrUm=2TtPPH5cKa4cA@mail.gmail.com>
        (Elijah Newren's message of "Sat, 4 Mar 2023 12:31:50 -0800")
Message-ID: <xmqq8rg9bxal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Having read the rest of this thread, I notice you pointed out to Junio
> that you want to amend a commit in the history of the merge,
> suggesting you are just modifying the commit message (or maybe
> author/committer info).  More generally, I _think_ your usecase and
> justification for this patch could be worded something like:
>
> """
> We often rebase with `--rebase-merges`, `--interactive`, and
> `--keep-base` (or equivalent command line flags) and only modify
> commit metadata during the rebase.  Since we do not modify any files,
> we would like the rebase to proceed without conflicts.

It makes very much sense to focus on this narrow but useful use
case, and I view it a very natural extension to already existing "if
we just pick without any user interaction a commit on top of its
current base, the we do not do anything, fast-forward and just
pretend we picked it".  IOW, shouldn't it something the sequencer
machinery should be able to do natively without forcing the user to
specify a new merge strategy?

