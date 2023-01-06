Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7753C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAFMk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjAFMkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 07:40:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CD69B24
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 04:40:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d3so1529352plr.10
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEfE4MgleJf+nLbwPNY2QKSFwwq5AbUQj6VAQEwX/mQ=;
        b=GOWfJoZyp4FqOpHfNA7Y8uMJpSf3J/9TBo9F4JsyrF7xUCKEjjQO14ytgld6RJdcTO
         QM7Ue8FmH61ziRbN18pOv0iLKuXTJa0FJnprnYcSlWREjmeMjvOkuuWDiAdd0owuim4e
         vwtPK9SI+xRvZ+fO1hq2MD7eIiZulm5U/wAxobMEXSbMpa99ZwCqFMxs2TV39bpz5dQq
         33GMPqu1I7BHsK8kU2bSSfzu7FUSkXyGWy+fM0WKqUzxxwdCGGMe4BZtP3fbupgl5yoS
         dp7Ru28cCzBXL8WHPeiO3n0OIgbZRMHzD8TuHjWUC0LtGiDqeJLfLusbVN7GHJu7QV1q
         o7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEfE4MgleJf+nLbwPNY2QKSFwwq5AbUQj6VAQEwX/mQ=;
        b=QBtdWhnYnj5/hiPX0BvCDY6PQAvCo7zji0XWbVd8J+1hIWpUL3tgif3sGxeMsr7zyN
         rBKYzutiHW8Pr7auZUgH+mbEKIgutD6tUI7M6bnlMzWMmLUbnzp4N8ypDX+3OYpsm3tZ
         F8lhL7/ljgLTsqEXEPypVvBrfwQx3KjvfQMK61msHxX5QFD83v+zgFykn3bO5llvaspk
         Qb0CAfstSVr0VSQ2/kfOHvwXziP4tVgYSMubaSvzhCsQA1ojGVng648y7lazv6Cq/2uI
         +fPuiL9/80+UpESY6UJW8+yvYeNN1fLSd/ivab4ophRQzpNmXrRofK4XEtZzam+OvgM4
         qYIQ==
X-Gm-Message-State: AFqh2koY8San1pFt76+l/wtOksA3Kk6VqIoQccOtDWQCe8ns/SP02T84
        vDvEmEWwprLY76D1BbfMbNk=
X-Google-Smtp-Source: AMrXdXvcdE057g7Ft3JcLdugPW6btIEdAzEWdsgWKb3PCKS6HPWjKAHUEBZq+g9qpwVbb4OgiGHxug==
X-Received: by 2002:a17:903:2289:b0:192:b415:d7de with SMTP id b9-20020a170903228900b00192b415d7demr29372100plh.20.1673008822672;
        Fri, 06 Jan 2023 04:40:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b001769206a766sm782897plx.307.2023.01.06.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:40:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Hlynskyi <ahlincq@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] `git gc` or `git pack-refs` wipes all notes for `git
 notes` command
References: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
        <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
        <CAAYtLE+PWK_v0cc8uqaiKnTHKghrkxuCCgfWyo9bhD23+vxK1g@mail.gmail.com>
        <Y7fikyZV1ky2modr@coredump.intra.peff.net>
Date:   Fri, 06 Jan 2023 21:40:22 +0900
In-Reply-To: <Y7fikyZV1ky2modr@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 6 Jan 2023 03:57:55 -0500")
Message-ID: <xmqqilhjsuo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 05, 2023 at 06:59:36PM +0200, Andrew Hlynskyi wrote:
>
>> > Can you share the .git directory of a repository that exhibits this
>> > behavior? It's possible there's a bug or something in the packed-refs
>> > code, though I find it pretty unlikely, as it's fairly well exercised in
>> > normal use.
>> 
>> The above excerpts completely describe the issue and there is no more
>> special in the repo.
>
> Thanks for digging. Your explanation makes sense.
> ...
> I don't think we have any fsck checks that the packed-refs file is in
> sorted order. It might be reasonable to have them. Likewise, when
> pack-refs rewrites the file, it should be able to cheaply double-check
> that the input is sorted by comparing each entry against its previous.

True.  I would not mind a patch to make us do so in the code path
where we rewrite the file and add "sorted" trait to the file.
refs/packed-backend.c::sort_snapshot() seems to be already equipped
to do this?

>> I understand that the `.git/packed-refs` file is for machines and not
>> for humans but sometimes
>> it's the fastest way to make several simple corrections in it manually.
>
> Yes, I have certainly done this myself. There are is a header line at
> the top of the file, though, which tells what is guaranteed:
>
>   $ head -1 .git/packed-refs
>   # pack-refs with: peeled fully-peeled sorted
>
> if you are going to muck with the file, deleting that line should be
> sufficient; the reading code will fall back to the older routines which
> don't assume it's sorted.

Thanks, both.

So we can conclude that this discussion thread has an
incorrect Subject: and the symptom was caused by human error?

