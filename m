Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C4C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 12:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiL0Mwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiL0Mwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 07:52:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C81173
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 04:52:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso3550572pjc.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BbQHZvPdkHYxnQaG8fA5Lz14/ViNQ/nS9goqyYx7gcg=;
        b=Jr3XFVRWY0RQLUOVlTEv7EnPHIXGplyDRAJjGkmh11ZWX0rzF0gqtt1Hlr5XyAsoAU
         gISSsIRn3CpFF4m+7wNXuXGLLfsX+GYgBPUvThmOZZEuDv8DscQPerkHN8LKLNvUl7Od
         G+2UF7BJVWuUGLkmndlGhzGGp83tQZnJnOKP9m2ebiwCIyweCrjLBf8LIEZI7Re6jzZb
         wKsDUrklImkmyEOJYYBXxqVMcolCwtvwcCFRl0PtQS+bzmlt84obeUT3VgD1lnNp99OI
         0tyh8bpKo2awCrLi37o6OCyqV1Xe8Kz6L3Z1J9p+5H5FDIuOk7vu/KPi1ju+l+SQ7nTw
         VUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbQHZvPdkHYxnQaG8fA5Lz14/ViNQ/nS9goqyYx7gcg=;
        b=vtPsPze+5tHJ0bRFH9Z7bm0XEqrA4wZY0ijGTOCEFNbAGuIwEG7GovBC9tDAAPTK1O
         YiRzK8q3EUS0MYF5B7oeUYa9VOm2klg3HSQEkWNV9TXTY1NlNn2NKTh/sYkPhs5KzjEW
         ufPtRPIueSDZ4FEWRHYfRH+aZOVfrutIZoZBxKis8NVpe9Q/LliIyOfJ1BZhJuJRhYuQ
         gX6H/yuMtsc9ZfNKADsT+oT8DbfkqgrLLiM4kmc9m9zxQ/FGui49BWGwdhbxsladiKQb
         ZoQ8H6rSOqO9CXw/0bZGoVAKt93Llkrc4pTzpMgelA+xDW+uXdKQy53hpVeLUDLg/SMi
         kP4A==
X-Gm-Message-State: AFqh2koBotkSLkHGztF04K92l9K088/b2YGTmrOxY45wfoI0amLbrCTk
        BG4BVLx/359UxpeHjdEx1s0=
X-Google-Smtp-Source: AMrXdXs3EKY0cQbS1+/tto4uE9q+muenfqjp8M/ItXjQF1JPBO9HYWafcYCgd+3dvgI8WVzvkRfIkg==
X-Received: by 2002:a17:902:eb8f:b0:186:f57d:8573 with SMTP id q15-20020a170902eb8f00b00186f57d8573mr23796287plg.2.1672145569403;
        Tue, 27 Dec 2022 04:52:49 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189651e5c26sm9010273pla.236.2022.12.27.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 04:52:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Hockin <thockin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: git fetch --dry-run changes the local repo and transfers data
References: <CAO_RewZeUBVvqT+UgXL5V5EeTOt14zZ-5vJYA4YvNr-jNyupXg@mail.gmail.com>
Date:   Tue, 27 Dec 2022 21:52:48 +0900
Message-ID: <xmqqcz85t3dr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Hockin <thockin@google.com> writes:

> I'm trying to test if a remote repo has a given SHA. `ls-remote` does
> not work for this unless it is a tag or a HEAD (which is not
> guaranteed for this case).
>
> `git fetch --dry-run $remote $rev` SEEMS to fit the bill, except it
> changes local state. For example:

Well, without changing the "local state", you cannot see if that
report repository has or does not have the commit.

> FETCH_HEAD was not updated (good)

None of your refs are updated, either.

There are things that are not reachable from your refs (or other
anchoring points like the index and the reflog).  As far as Git is
concerned, they don't exist [*], and that is why Git will happily
remove them with "git gc", for example.  They are crufts and it is
easier to think of them as not a part of "local data".

So I suspect that ...

> but the rev in question is now
> present locally (bad),

... this complaint is a bit misguided.  After all, the procdure you
gave above is exactly how you would ask the "I'm trying to test if a
remote repo has a given SHA" question about commit f80f1b23b4ca.  If
the operation did not transfer data, you would not be able to get
the answer to that question.

> Am I using --dry-run wrong (or misunderstanding its purpose)?

Maybe (mis)understanding on Git's data model (see above [*]) is the
root cause of this confusion.
