Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC9C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJLQIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLQIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:08:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7386C74DDC
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:08:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f27so3119089qkh.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yYdGDJohwwWz5yiTfyMyX0T3gQSNGxRUMBlTPr1yrTQ=;
        b=DlFCP80b995BzZjyMIAE9F1L+JvkB3fJTeysY7j0KOmOaNKbMPaqJL86XWZ+n4NgM1
         u5WUhF2QzLyV5AH/mppLtBFQqwBsE1COHqHAPdpNDp7i2/k8JSULV0ERkAEleoIFAPOX
         wQx7qQavX0Rq4KodF+xgxaYLQqdsY282PcWO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYdGDJohwwWz5yiTfyMyX0T3gQSNGxRUMBlTPr1yrTQ=;
        b=loInX3LHO34PXXDiaYKDGnfPs9r6825qsXl9s2AkPc9y2gyztIyKMr282j4KZB7gsw
         OEE5bCaZFNkfBkDkN85GKzl8VOOHQzDbP+tjzh+R3Of53yM+x71urdTINICZfX2xdSht
         SFOb4Bue6PiyF0O3l7hI8E+C3EyO4T9nOl2q3T8xFp9aGTdbaITjrZgXRHv1Khwidyqr
         Zf/FK+Ie3UZVKmFDuTo2U0sUOmRStPHQc8JI2p0bX6uemTMms2F6y8IzLp5ITUek2Rb/
         V6fSp9GvpNRbs+Chnz0XBWcH8/mOMz0n+Yk/E0dgZGodIVfck6gl25zuY9rHQQ4ASi9j
         VHEw==
X-Gm-Message-State: ACrzQf3KX/fPS5QAuO1UPIr0rdPVJAdYilVkp8sk3VZj7IwzpRWbFqjo
        r8DyfkWw2Wdg6T69PzLh83RmRAvzg28e6VS8GWkXcxrAsoMPNg==
X-Google-Smtp-Source: AMsMyM7FoxnnwrRNaVNAKvJ44eDrgTg+aSsBM/FSKBhoMnkC/BULeY6I1iOO1UwVYITbyZMmyQ3G8penypmfxH4x3mI=
X-Received: by 2002:a05:620a:270e:b0:6df:7dba:f45a with SMTP id
 b14-20020a05620a270e00b006df7dbaf45amr20434359qkp.661.1665590896245; Wed, 12
 Oct 2022 09:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 12 Oct 2022 18:08:06 +0200
Message-ID: <CAPMMpoiQe+9YEQC4mHwTNt4QGBawKxYv5s0v4k+dkjqtKw6NKg@mail.gmail.com>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 5:59 PM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> When no merge.tool or diff.tool is configured or manually selected, the
> selection of a default tool is sensitive to the DISPLAY variable; in a
> GUI session a gui-specific tool will be proposed if found, and
> otherwise a terminal-based one. This "GUI-optimizing" behavior is
> important because a GUI can make a huge difference to a user's ability
> to understand and correctly complete a non-trivial conflicting merge.
>

Quick clarification - this was intended to be an RFC.

I forgot that with GitGitGadget at the moment (until we do something
to explicitly support RFCs) a single-commit patch needs the *commit*
to have the RFC prefix, instead of the Merge Request, as the commit's
subject is used instead of the merge request's subject in a
single-commit patch.

I will make sure any later RFC versions have the prefix as appropriate.
