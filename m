Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E45CC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5166105A
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhKIPZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKIPZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 10:25:23 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1365FC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 07:22:37 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 132so911068qkj.11
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOEjQdeDFmweSaBOlw/aMji9SYE5Coe6pe+1zIu+xyg=;
        b=UxzNNg2iBaKk4+9aeLo9CB1YmjqKMcz2G07eOlFDX69VWM7EDyZW8BiqlO5L1qjmLM
         1HkniDJivLA4l9szImO+X1tqGAL640y9Qyg0ItOgxN026c7KpjWiiNpR1y0MzS7bcZhC
         GeaglAHO5VS+gMhRjRmtXsnlyVJqEF3ZVCDTe5xYat1wrS5VhmSiGzr53hTSqphzU8bC
         xR2J+WV+9lkS7rBPXTpkEeY6zqZWbNeCoJofosO68wa5TEpxv/EMumqMZEa3aPdDZzT9
         45ZnAL5RBSYQKfRmqSmkaQE080iGztfo+SMMGllRUA1rS7quAxprDz4nzr3dnXUZYJs2
         cE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOEjQdeDFmweSaBOlw/aMji9SYE5Coe6pe+1zIu+xyg=;
        b=lO+WpWO8H3OZhlPv2vKNNi++svCQOMhsj5oT040vR5aQqx8OtcV+Uy60QMaOVRxyV3
         R1mfOyeOqLeTQQZcdZL1K9x39Xyl/zXZBwrz56qHJI+guTb9CMZQne/1OsEUS/ED6Lkk
         h3cjDzZszX8L+QJKa1VW++uGbDikejAWFxQNehV3rlan/zcYQ/ifAEsyAEw/qVmT7WdF
         +KnXfQehC9Trxle1Ku1IbkfYx1wFPXX1MpySK/DGS13kTyQfASnoGmQxl95zdYx8hAgc
         KKVKYSRAR7xn6YbUHkgW3iuNS1D70gEXOIqtXxELUW5Tgy8DVVAI3EVfSkw5XOBblVbO
         YnjA==
X-Gm-Message-State: AOAM5327/039Mdj+XoCUVuvQ7o9kcmZBSFblcsEqcDGNMatIrB9b1TYJ
        0X1yaOv1i1zTsMRbWbdq9ko3x52WzLn08n4t
X-Google-Smtp-Source: ABdhPJz4ohXqPIMLJkmH/gweBUbH4UggYQU8BMteeOZMdJZv1OmbJWtl1m7gq1R3zq12wJKO2N5KiQ==
X-Received: by 2002:a05:620a:25ca:: with SMTP id y10mr6636849qko.162.1636471356197;
        Tue, 09 Nov 2021 07:22:36 -0800 (PST)
Received: from samxps.. (modemcable158.252-203-24.mc.videotron.ca. [24.203.252.158])
        by smtp.gmail.com with ESMTPSA id q13sm11621660qkl.7.2021.11.09.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:22:35 -0800 (PST)
From:   Samuel Yvon <samuelyvon9@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, samuelyvon9@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue,  9 Nov 2021 10:22:19 -0500
Message-Id: <20211109152219.11037-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <211109.868rxxvgdi.gmgdl@evledraar.gmail.com>
References: <211109.868rxxvgdi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> *nod*, the implicit suggestion here being: Let's put more of that
> summary into the commit message. It helps when looking up/discovering
> older behavior.

Sorry! I will prepare an amended patch later. Exploring the linked commits
has raised more questions on my end.

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> The comment was first added in 2888605c649 (builtin-commit: fix
>         partial-commit support, 2007-11-18), and quite suspicuous in timing is
> f5bbc3225c4 (Port git commit to C., 2007-11-08) where we moved from
> git-commit.sh.

Exploring these commits, I fear I might have been confused; the editor was
always launched after the reset (still today). The problem, as noted earlier,
is the fact that the run_status is ran before the cache reset, which
creates the outdated diff. I can't speculate to the intent of the
author, but exploring the code makes this comment:

> +    /*
> +     * Re-read the index as pre-commit hook could have updated it,
> +     * and write it out as a tree.  We must do this before we invoke
> +     * the editor and after we invoke run_status above.
> +     */

more confusing, because there is no point of invoking the editor after the reset
if the status is written before, since the editor won't show anything different.

On one hand, flushing then showing the editor seems to indicate that we want the
editor to be up-to-date, but because the status is prepared before the flushing,
maybe not?

While it seems the current behaviour has been the behaviour since the start,
I am inclined to continue pushing for this change. Unless I am missing something,
the comment is contradictory and we should be coherent with the idea of
accepting changes made within the pre-commit hook, as noted in 
https://lore.kernel.org/git/xmqqk0yripca.fsf@gitster.c.googlers.com/t/#u:

>> Junio C Hamano <gitster@pobox.com> writes:
>> Even before ec84bd00 (git-commit: Refactor creation of log message.,
>> 2008-02-05), the code anticipated that pre-commit may touch the index
>> and tried to cope with it.
