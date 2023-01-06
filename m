Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A1C4708D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 12:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjAFM2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAFM2D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 07:28:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929126D7
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 04:28:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n12so1369238pjp.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 04:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAI1MJozBj5l0eSEfFKNlCsguW7mXrtx8pzydpVTEqM=;
        b=YZNRDDzVcg+U3DIyz2l4wHHrcj1tFtRtsx04GqC2//+CvDFd7AZ/T1B92eYQ44U9F+
         OO25hKbnKnw80eS/O36vjDI/4yC4paY32JveEu07KdNFRm21LbIjtyZR20E60lPTPg94
         UvVdSdmZNK7iwEwfZfnkGPbT3udA1UOar6nKMjeaDkdpHp8j8zCznIjdftdLyDvLKqlH
         r8roeapziJNfMMHt1AFifg/idQZR7i7uiHfZrdYIMvfUj2zxPe0FQgB2Nql+7NcWMdd9
         QRNKpjzOuxTPLO+vda8XPQk6Q8Gw73quInxf+XGLssdVYizoaXOFuSRyOr+l5QQ0H7gn
         pnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAI1MJozBj5l0eSEfFKNlCsguW7mXrtx8pzydpVTEqM=;
        b=hVb7sgAvxzgOwN7jJfNJq1iQSySZCE33iPr8FE6eLN8D4PtEK3ykDlYGISZ4ruVY0c
         fSVVQgFLUj7teusxcKV9f6tBBjuvlUIumjvBK0cWlfN3q8f72UNw+8Wo6l3NdCKn1I/U
         OwZtj+JKRzro20KrJeF+4rTYt3yVlrRD9C8iU0IwNO/2y1ssxFU/BOT8cJQlaeprEBGZ
         AMzrUZUVrjN7umivGsjasv1FOAICvXVt8utaX4zBMOhnCGGXkXbYyWk2JTdfIP4hKTwi
         8/OdsnTtPxGpRDgfuVqZJVT3woI4meTIMXYdM6yS4dCqnVF89AQ7flFCGd/yggiDHVRW
         CQKg==
X-Gm-Message-State: AFqh2kqEGpslcvv8gHEgytRsH5EoeJlj2iHHGlW+dCWGPq92+ZzQZRfK
        YGtxbE/+uqB12OtXgvy3wuI=
X-Google-Smtp-Source: AMrXdXu4BQb2qwlcvq8C7BxaABdlnZ1UO9RMRbggS4hdZ5He4kRa7ieDXCFsHIlHKexz+/S6iCnuHw==
X-Received: by 2002:a17:902:da86:b0:187:3921:2b1c with SMTP id j6-20020a170902da8600b0018739212b1cmr80949535plx.55.1673008081608;
        Fri, 06 Jan 2023 04:28:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b00189db296776sm909374plg.17.2023.01.06.04.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:28:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v14 0/2] win32: close handles of threads that have been
 joined
References: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
        <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 21:28:00 +0900
In-Reply-To: <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Thu, 05 Jan 2023 15:44:32 +0000")
Message-ID: <xmqqzgavsv8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> After joining threads, the handle to the original thread should be closed as
> it no longer needs to be open.
>
> Signed-off-by: Seija Kijin doremylover123@gmail.com
>
> Seija Kijin (2):
>   win32: prepare pthread.c for change by formatting
>   win32: close handles of threads that have been joined
>
>  compat/win32/pthread.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
>
> base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v14
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v14
> Pull-Request: https://github.com/git/git/pull/1406
>
> Range-diff vs v13:
>
>  1:  6f89b120641 = 1:  a20eafb9541 win32: prepare pthread.c for change by formatting
>  2:  f126d6416d5 = 2:  aa0319bc08e win32: close handles of threads that have been joined


In general, the cover letter of a reroll should explain why
reviewers are asked to look at the updated version instead of the
older one, i.e. what changed since the previous iteration and why.
For those who followed and/or participated in the review of previous
iterations, the range-diff might be sufficient to guess why these
changes were made in order to improve what, but for those who are
coming late to the party, it would be helpful if you explain what
you changed, how and why.

This is true especially if (1) you are rerolling even though the
previous round got little reviews or (2) you are resending without
any change.

Thanks.

