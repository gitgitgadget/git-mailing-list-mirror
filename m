Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6025C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCVQXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCVQW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:22:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EBC3A86C
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:22:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso23969435pjb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679502165;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YtpwqQG45EmHV14xFG8KSyzHxyhivyw5joGAwWeH4E=;
        b=W7/MmZGJ6g6J92g51LT9+4UxIt5QwNhN8lZlR7pwLW78IKDOeMfZ9IornEeaFrWY71
         kkA6PxB8wGr/Htt0mXIJTiJaDTxnDaet+Do2lHZlokrEm8ckGsBFCzwBml7bJ2LARb7H
         Y+r3XjBpJalTtSXHSwrlA1Oifs+RsMCmlROBz382LqeGeIIKyjFftaT9CQK8GcW29E75
         h7ZQWBhi6TnAVNe6jRY2PZMbzUxPC1H0mo3x4hJu34Mxc+pauTjq6/J65FI34P8Em4T1
         N+J1adFll1qNjBZgZRekvFFeFLpRQM4/32r8PMM2oGsCQT8ETaajU9lWC8bBlU31b2Zq
         fxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502165;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7YtpwqQG45EmHV14xFG8KSyzHxyhivyw5joGAwWeH4E=;
        b=ie/kHtf82dMK+Jjos+Zkyz7HNWNxES31f+ZO7ZnF4rHlJvoMwr1myJgXFX8pvRpm5m
         ZOmeNj+VJ6OpwhGp+vAWqkFdfyPsH1qjTWBCW98Z9m36YlWp1f4lzZc5NeWqz7ype8MX
         rYkaepQo+d2mM0sMhwr5VjLBUXZe4H28SEqXd39lmR+zFiISnLTT0iH5luFp/BsPvSuj
         88h+tazYmW0TLAMrnFBQ8tR5h0JXR8+1FnuH5Sih06s2Pf88ge9G0ZDZmQVMHp0+3vz5
         TU7Nf0oYwZSOkF6jDN/Su+MquOPUX5ZAtJtZL7VXM8v/86KC4nvUEN7xX0N2hDF0aJof
         YdJQ==
X-Gm-Message-State: AO0yUKXQPDu6NLE2VkeRBWsHff7Ses0WMDy2l8pOUl4vfr4sNVZVO7Wn
        z3XjWu176avxMe7/xS2qwNw=
X-Google-Smtp-Source: AK7set/pkRfTzwFQLGwie8T9mPqzQtm5DoOKNTwVeXOGzz5Dg1vAj2VBbhF4NCMvaW3Tnw4gmBGPrg==
X-Received: by 2002:a05:6a20:8b99:b0:d8:b2a8:f383 with SMTP id m25-20020a056a208b9900b000d8b2a8f383mr106391pzh.53.1679502165319;
        Wed, 22 Mar 2023 09:22:45 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z5-20020a6552c5000000b0050301521335sm9822816pgp.11.2023.03.22.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:22:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Fix a few split-index bugs
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:22:43 -0700
In-Reply-To: <pull.1497.git.1679500859.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 22 Mar 2023 16:00:55
        +0000")
Message-ID: <xmqqfs9wg3ho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note: While the Git maintainer has stated a strong preference to introduce
> regression tests in the same patch that fixes the corresponding regression,
> this patch series starts with a stand-alone patch that demonstrates a
> problematic scenario via a new test_expect_failure test case.

It is fine, especially to show existing/old bugs that need extensive
explanation.

> This patch series is based on maint-2.37, the oldest maintenance branch it
> applies without merge conflicts. When merging with next, there are only
> trivial conflicts in unpack-trees.c due to en/dir-api-cleanup where
> o->result is now o->internal.result.

Thanks for digging into old and important case.  Maintenance of the
index data structure is a crucial part of the health of the system.
