Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C2C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiLAXLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiLAXLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:11:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589DC936C
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:10:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so3574614pjg.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPq+ONvLukWF0tWLNTX1gm6qjZKN1KNc3ilv0v4Jozs=;
        b=NQoXJOrmKw4CFYc8rX5nBRzQMepqARPbj8d/lrtFMotzZkKIQrn62eSRgW8zDg0nET
         G3d/O5d955Md//9mWYcsT/2J10ylkYum5P63+YL7ba+/MlnWqbtGMqb7rIlWUYYFFsSR
         JJ3xKFDO9wfJu49VpUmFyKf+11FPyJrz6NS2eeImCpzmQTGBPU2vRS5qHVwDXUNA4d0g
         yY7y8qTNj1a3ilS5fR0bmNx7nBw6n5ZgE4i/DCeR6FRfu88AjsPX31oli/QbctcxPKRE
         OEmwMDP+qKo83gcFRueOiYl3ueexIx+3CmHePLJILoJYs647KeOT43wu6WAaMNKl2kHx
         wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bPq+ONvLukWF0tWLNTX1gm6qjZKN1KNc3ilv0v4Jozs=;
        b=VlCBOA2pQe3edOMZg/dvn5KxLf3lruXdyLRv74yw0Z8EIIA/KQx47ifmv4nwGn08kt
         t7Uncw9qpeMn6MyR2surGCJPnB6ACevs41qEdwovjc8cqMqtmXcra6HtEoq+lkPT2xyf
         PjEGp0gfutSDcAKR/dtYlcFumCyrM89hT8TNiJ0swP0puHZ7LoNIIgpFn/JLGpF05zYO
         dPAWSh7cXH5LvuRa5ZJIZUf5GYBMFuFQkwvNhj/DpJzIrJtR6pkAWbV04l8YQgEc6jLW
         VGBBloI4ibE59IDwevWjuia75P/8qiFjrYJw887yzElQy7juVvo1eiYOYxFkg4SrrI9M
         qLfw==
X-Gm-Message-State: ANoB5pnL0TWNgB+0vX+S0fndIe9jBVMnwzTYJrgZn2GSg5wd88PTuSkR
        AlP/pzN6walFN+Y/7z87X5Q=
X-Google-Smtp-Source: AA0mqf7hnl9CrjoTe8P/DTL1MllHZ3O9/KI9gYgivcsZR+E/LVkDUOllxE9hbGPIblJFnu9kKSBFmQ==
X-Received: by 2002:a17:903:289:b0:189:25fb:8e83 with SMTP id j9-20020a170903028900b0018925fb8e83mr52176554plr.20.1669936199524;
        Thu, 01 Dec 2022 15:09:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t197-20020a635fce000000b00476e84c3530sm2966132pgb.60.2022.12.01.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:09:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1669922792.git.jonathantanmy@google.com>
        <Y4kGiEXdTOpn5Eyi@coredump.intra.peff.net>
Date:   Fri, 02 Dec 2022 08:09:58 +0900
In-Reply-To: <Y4kGiEXdTOpn5Eyi@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 1 Dec 2022 14:54:48 -0500")
Message-ID: <xmqqv8mura9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 01, 2022 at 11:27:29AM -0800, Jonathan Tan wrote:
>
>> Thanks everyone for your reviews. Here is a reroll with the requested change
>> (just one small one).
>
> Thanks, this looks OK to me. However Junio noted in "What's cooking"
> that it seems to break CI on windows. The problem is in t5318.93:
> ...
> In particular I wonder if obj_read_unlock() might be the culprit here,
> and something like this might help:

Thanks for following-up.
