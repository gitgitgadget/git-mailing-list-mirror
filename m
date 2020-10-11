Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6AC433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7571207D3
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA+XBtxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgJKMcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgJKMcy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 08:32:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99862C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 05:32:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so11402551pgl.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5N1sa1YX/ti+YUeZUtBpRmy7bc0I4krr5i3X82iaEo=;
        b=LA+XBtxb3/r5fQ+K/tvTBWDaj+0XMrZaqgRo+O7ralnpTmc7k/Kx2FFwCAcc+gzDMt
         flhlFhzuTi0gMt/bPLKU/PctDy41JYyizCpHWuxgSimyWnBwEHh23Zjp89cnZ2Chz/ZF
         Tx7f/YRwu4NZ3pfdocXW+kJQQ9/02d6pevgP8JD7YkTNK8Qc5A42iZQ05aUhTPthONmI
         JwtMTqn76FbDzs/Bn6LNtUVjzoE0X6gsH5GA3RE0po7bZicZx188WBdCuxlgSzufUv9J
         4R7MABSORGF7C6Uh+m/HU+kaF5NldzqXuh/0qf0JYFVk3w9IDzzH23Ahe/uTlylN9YY7
         eUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5N1sa1YX/ti+YUeZUtBpRmy7bc0I4krr5i3X82iaEo=;
        b=grKGMW8jr7hZzQzjWYV+5VEgfCgyCGvI8YuRIJUP4nAtVuR70RGGZkMbHIDSQulAk1
         4bhgb8ZBfgNV0iz0Whe+kUXNdMXz1xzIeaM2wXEBQ7f4LUzgB1DD9c3rIPZBI+2CLPLf
         4Ns7GF6EBjZLI9Pvq3Bba2PL4n7lxRy8ZE1aE9W0iGR2atWgG56WEJ6VvzccwtLbfAPw
         bRSaz5wCkz3/0zU8Vbw5kkgVbGiMWjfhqtClWDPhaaee7ZQLhUy6z5W07FMpTFcjs9/W
         hdIqPcEIbldaH4q/uwl2PQkZF89aK1qYOLyE5WulWzrnsjcbrT3aCF3K+qd7rL3bSs14
         +HKw==
X-Gm-Message-State: AOAM533UISsTBKyuszDiaFpQoeCKQ/XQg3Wg28AWkZri4QcuCpt/w4SU
        uDDi/eNdsv43QHRipz+CLO4=
X-Google-Smtp-Source: ABdhPJy6x/YyetdLaoXb5vGXRXFm7ghaxWy7sWP4ujrImlT9SQBwxRgVOqT8TBYoENHZG4u9n4kY2w==
X-Received: by 2002:aa7:8421:0:b029:155:3229:69cc with SMTP id q1-20020aa784210000b0290155322969ccmr16845646pfn.36.1602419574071;
        Sun, 11 Oct 2020 05:32:54 -0700 (PDT)
Received: from localhost ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id v22sm16432671pff.159.2020.10.11.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 05:32:53 -0700 (PDT)
Date:   Sun, 11 Oct 2020 19:32:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Tomek Mrugalski <tomasz.mrugalski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug report: gitk crashes on git commit with emoji (utf-8)
Message-ID: <20201011123251.GA26193@danh.dev>
References: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-05 13:33:02+0200, Tomek Mrugalski <tomasz.mrugalski@gmail.com> wrote:
> Hi there,
> 
> I'd like to report a bug in gitk. gitk crashes when trying to view a
> repository that has utf-8 chars in the commit comments.
> 
> System: Ubuntu 20.04
> Tested gitk versions:
> - 2.25 (the default in ubuntu 20.04),
> - 2.28 (installed from ppa:git-core/ppa),
> - latest (next branch, commit fdf196b9972337a0285dae59f904f62f989fbca8)
> 
> Steps to reproduce the issue:
> 
> I've isolated the commit in our repo that causes this problem and pushed
> it here: https://github.com/tomaszmrugalski/gitk-bug-emoji
> The repo is small (only 3 commits). The offending commit that seems to
> trigger this bug seems to be 3ad99781c449da3b1b42a098c4a820455050eb44.
> 
> git clone https://github.com/tomaszmrugalski/gitk-bug-emoji
> cd gitk-bug-emoji
> gitk
> 
> Actual behavior:
> 
> $ ~/devel-ssd/git/gitk-git/gitk
> X Error of failed request:  BadLength (poly request too large or
> internal Xlib length error)
>   Major opcode of failed request:  139 (RENDER)
>   Minor opcode of failed request:  20 (RenderAddGlyphs)
>   Serial number of failed request:  3065
>   Current serial number in output stream:  3148

This looks like a bug in libXft, multiple projects see this problem.
As far as I understand, gitk uses tk to render graphic, we couldn't do
anything with this problem.

Workaround: Don't install coloured-emoji font.

Thanks,
-- Danh

> 
> There is a window showing up for a split second (too fast to even
> notice its content), then it disappears and the aforementioned
> X Error is shown in the console.
> 
> I've tried removing ~/.config/git/gitk, but that didn't help.
> 
> Expected behavior:
> 
> gitk should not crash. The window should show the git history.
> 
> It's very much ok if gitk doesn't show the emoji, but it shouldn't
> crash. I've tried to look for existing bug reports, but couldn't find
> anything useful.
> 
> System info (as produced by git bugreport)
> git version:
> git version 2.28.0.1022.gfdf196b997
> cpu: x86_64
> built from commit: fdf196b9972337a0285dae59f904f62f989fbca8
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC
> 2020 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
> 
> The same error happens on earlier versions 2.25 and 2.28. Here's output
> from 2.28:
> 
> git version:
> git version 2.28.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC
> 2020 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
> 
> Is there a workaround I could try?
> 
> I'm willing to help with debugging the problem or testing patches.
> I'm not sure how long I'll be able to remain subscribed to this list
> due to the traffic volume.
> 
> Other than that, gitk has been rock solid stable for me and I've been
> using it for years. Thanks a lot for providing this great tool.
> 
> Tomek Mrugalski

-- 
Danh
