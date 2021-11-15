Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABAC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7916323F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbhKOUfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347589AbhKOTkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:40:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85AC061570
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:37:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z10so50291735edc.11
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tQrOWzVVYYGoHU/GfCX7zOhmty6BQBbjZZndx7WBFXI=;
        b=VKt6lyqtya4Ux0vyYRNHWcUpPXDkkc7F2HzFVaxOHJDSMYtU7XBwIq2KGDu4MmwcMl
         eXl/mB4n+RsZ2/rYvrfGVnR2zpPp6SqWDMWf+8b05UkPC18B/9zs0On8L0x+qAEiv4vQ
         dmtf3PVGv4KMzux4FeLENdXHBmee2n7ONgSDCBrROtmuexpRXfFOPUWs2+v8vNXiHVmR
         7JxdMHDshbfLGlq7bA3V4Z3qhtVTrF7ylozIZ7DknIF+R+7M2Z69FWOR/vXHBAkLyEac
         U/mkAPYAlKC9Ony4zfPzRXLjL5xUcGbWqWnG+EiIwonbeo/6kbMI6bTAMy2HzzMXMva6
         2uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tQrOWzVVYYGoHU/GfCX7zOhmty6BQBbjZZndx7WBFXI=;
        b=XTAz/Cn8lHxudXOxs4ZiHZxVzR/awFbiL1PObS2GJZ8XEDQGlc4OUYgPPfy/iBhS8j
         EYM3WKI4RJpUNtz2512Fz6lLTf3r5OmaGPwgR0OPZdLdn4cgDIHMbEJBYhSYFyGNheRM
         4Pr8BCbfBL4bJZVuSCCV3zZlf8oa3wdK3XTCLPfHlcAZyWOjrhFhaAav/+4f9Xt7wMSq
         FtxfpWG2l78rcTrcAL+Hl9Wr7jORUEXtCnNKdaFg1Bk8sEXL0FcDg08g1WCGV94hNtfQ
         B9m0zDtsoyyLLHl//8Sv3N/fCveroBSBDVkNF12p+xj3cKmRY55PUnfTi0Vkc2/EdxID
         V9gQ==
X-Gm-Message-State: AOAM5315Ifn1g/fEW9tVxXbjwgD4xSuzByDzCsdsFoZZPTPbr/GK9T/H
        kkkMmGPWPnUWzcBJ503sNgHtlzHvMyo=
X-Google-Smtp-Source: ABdhPJx/h5bpZ/4sfTX2iQ2GJMros95UUFD6Rlk4cpFqWI+lYseSWCJofmx046EQEOnJxOlpcvDHew==
X-Received: by 2002:a05:6402:1e90:: with SMTP id f16mr1668777edf.91.1637005057424;
        Mon, 15 Nov 2021 11:37:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cw20sm6931450ejc.32.2021.11.15.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:37:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmhnM-001CU2-8Q;
        Mon, 15 Nov 2021 20:37:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Nov 2021, #04; Sun, 14))
Date:   Mon, 15 Nov 2021 20:35:25 +0100
References: <xmqqv90tfhh2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqv90tfhh2.fsf@gitster.g>
Message-ID: <211115.86wnl9qkfz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-11-03) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.

It would be great to get this one marked for "next". I think all
outstanding feedback was addressed ([1] for the last CL), and for a
topic that's adding we haven't had any reports of the BUG() assertion it
adds firing (and I've done some very thorough testing to make sure it
won't, per the 8/8 commit message[2]).

1. https://lore.kernel.org/git/cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/
