Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C14C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD5F6117A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhERLZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhERLZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 07:25:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26CBC061761
        for <git@vger.kernel.org>; Tue, 18 May 2021 04:23:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1361833pjb.5
        for <git@vger.kernel.org>; Tue, 18 May 2021 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=Lqtwm6EMx3EpCdl4XmNttWVaznDq8a+wO7vKcrRzvCE=;
        b=VDp8xTQeCbrEo7kje1pGq2nV1P1LzHMhB6y2D3XyAVZEs7qCf5R/csccc87sJiuHmm
         +2jDMnQIk5aL26oaS5h+cOBPHVtdMJRBJ9mvBbDf+7UPmDbzK9WxbMf6vnRdRw9/xb1C
         o0ms7zT2pGKweej26yGEP6qTyoctcldvyVg68bdcy4IQX/ZsvPtOWSshB1uXxjNR47yl
         Z3ZHkydWIqMAAfAJIQTr1gsPjJWYl1V4DaFC9oJvq/TqS1tLDj2HgNoBX8NR3xep6Bc5
         IUOtbLU8qV2U1ejaE+kII6DKHvOG7Z1BPQyi0Qk+pX9ktVz/OYsoKXMJkj93cldZVoxt
         cyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Lqtwm6EMx3EpCdl4XmNttWVaznDq8a+wO7vKcrRzvCE=;
        b=HydhYjrqhXTs/Z8kKx4oWCJxWYLY5vrlhzK6B4goxTfD1GDy8reIZF08EEQY9veHAt
         3GHQO8jB99Nt8FUfLbj77fropgZORhQ98JR/AIeOHEgLALy+CcZrkIoMvNoOFIJ0Ya4f
         0F87O66ofS9gDEjKjr7UR6mXpGSHZrR082crBtYs7Z/etPA29Q2RpcgX0skUq3Bv2aDC
         0TPSQJsj8px64RZfbeQYO3t+/cmKMtBxEucGesiDzukbUTrmxGT08I0+s5M1zbOmhxuD
         7It4lUnv65GaXIPUGyDWWTBrjUG7j6jVmsPo822EepCpvxKJuNuUBUaNFuU7d6KuAYmn
         /S+w==
X-Gm-Message-State: AOAM5336IeXC6mLKYOaWRfeRVHmzcKpG/hUCXTM64AS2PaA5g9UConEp
        R9indE6RB+D2/dG5pcjx4LIKuOC7CbEiEJml
X-Google-Smtp-Source: ABdhPJwTpp5PnSZJdaeu7UjSbyvVCZzJaNTW+HoIVGHcsNWw/8C5CLD+qsMaJ0iyuWP/1hZgqV9/lA==
X-Received: by 2002:a17:90a:c38c:: with SMTP id h12mr4621632pjt.145.1621337023751;
        Tue, 18 May 2021 04:23:43 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id c191sm4052241pfc.94.2021.05.18.04.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 04:23:43 -0700 (PDT)
Subject: Re: git repack on shallow clone of large repo (linux kernel) hangs at
 "Enumerating objects"
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
References: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
 <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <158a2f8c-95c0-075a-4cda-6328324c2261@gmail.com>
Date:   Tue, 18 May 2021 18:23:40 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
Content-Type: multipart/mixed;
 boundary="------------D5150BDB176CB9EE4D38C9DD"
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------D5150BDB176CB9EE4D38C9DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

> You could try using strace or gdb to see what it's doing.
> 
> But as a guess, one thing that sometimes causes a stall near the end of
> "enumerating objects" is loosening unreachable objects that are
> currently packed. You told repack to use "-A", which asks to loosen
> those objects so they aren't lost when the old packs are deleted (as
> opposed to "-a").
> 

I attached two strace logs, one for "git repack -A -d" and one for "git
repack -a -d".

For the former, I got following excerpt before I had to SIGINT the process:

> stat("/opt/git/libexec/git-core/git", {st_mode=S_IFREG|0755, st_size=22096480, ...}) = 0
> pipe([5, 7])                            = 0
> openat(AT_FDCWD, "/dev/null", O_RDWR|O_CLOEXEC) = 8
> fcntl(8, F_GETFD)                       = 0x1 (flags FD_CLOEXEC)
> fcntl(8, F_SETFD, FD_CLOEXEC)           = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7feb5ecbfa10) = 13691
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> close(7)                                = 0
> read(5, "", 8)                          = 0
> close(5)                                = 0
> close(8)                                = 0
> close(4)                                = 0
> fcntl(3, F_GETFL)                       = 0 (flags O_RDONLY)
> fstat(3, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
> read(3, 0x55a540de5250, 4096)           = ? ERESTARTSYS (To be restarted if SA_RESTART is set)

I thought that in the case of "git repack -A -d", it is stucked at the
last read() before I ctrl-c'ed to trigger SIGINT.

> You'd probably want to at least say "--unpack-unreachable=some.time" to
> avoid writing out ones which are not even recent (and which is what "git
> gc" will do under the hood).
>> But if you don't care about keeping them at all (e.g., because this is
> not an active repository where other simultaneous operations may be
> taking place, so you know it is safe to delete even recent ones), then
> just "git repack -a -d" is probably your best bet.
> 
> -Peff
> 
Using "-a" instead of "-A" on git repack works. Thanks.

-- 
An old man doll... just what I always wanted! - Clara

--------------D5150BDB176CB9EE4D38C9DD
Content-Type: application/x-xz;
 name="git-repack-ad.strace.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git-repack-ad.strace.xz"

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
--------------D5150BDB176CB9EE4D38C9DD
Content-Type: application/x-xz;
 name="git-repack-Ad.strace.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git-repack-Ad.strace.xz"

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
--------------D5150BDB176CB9EE4D38C9DD--
