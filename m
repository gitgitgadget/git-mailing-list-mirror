Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D99C64EC7
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjBJVwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjBJVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 16:51:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E42108
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:51:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so4364695pjb.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEOhTZJziz0FCVz4d1i/X7X6qJg7mEH+qEW/JK27Uxg=;
        b=B4Un4NEa1Jgf5gbX7lw8vSGLHOmGeWtfYGteOVUrXKXnoXaNNvcKH1YoQjCMajnSuU
         GzhIuSi0Bo1cLFGDeVSXx1qfLxzotsl1wL1wZRHD2RkAeSK2LiQ8+qXKyTlKAr1oacQA
         vQFFbtplgXYsrvuWWZ+HCGtAr08aSu4UnrP1jXbud1ikzQkyBvF7SuMeynePPJonSP8O
         e0Yux16ZmjTiMTQPsk0Bs4AeXHJF3Wnw44U/G0sS0Wwfnc4X2RPMFB3viUotgQtuXodf
         aTGDWDuT9+JzckBzqFP8LOkaaz4pT3Yl8h3r682CnNcUR0/6tSNb3ZrxiMRiP7qVjBYq
         SGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEOhTZJziz0FCVz4d1i/X7X6qJg7mEH+qEW/JK27Uxg=;
        b=WRKBF8MEz4A1ecnscoYcYDWcO8sW7KKACeHwz4n3X7lG7E7uWOdIQIdRhU9cA++SEi
         VHzLB/I5gV4YI3Nu1X6ckYgT6wzoVjJFRt8C9zXTn/KKnoohSNKD/C8pdR4WH035ev5z
         uveaHLiunhs5sFq5zLEqbiGTua1LmdeDBVYbDtJftS9M/yJYYXuOvqAZ1C0xCRNsbggp
         Ow7dngd0I0YCC1OnRv17o4qkFLOvianZSYdAI+OY4MrtH5OsfN/IpBAUO8STtoraf5NO
         bSX/0Ss6tk7sctCGpB9OMXIfEayZ3F94h9qdDWWWOFXc8JPPuFDSsK+xEvJRjHeqjPTl
         PoLQ==
X-Gm-Message-State: AO0yUKVILW0inRw8LBmD9SlGW99hntmicuA0ve9nE6SWtQs/3Mn2iQ/n
        F8QGzj1dzx17JFP2LXJtegGZ5EnLzrA=
X-Google-Smtp-Source: AK7set8uXlM/WbolFxMh/ShS8D3Lu1cSEFshj8YiQpoqRJSIG31SAU1lRcxXMZIf9zr2JkTvIOsvdg==
X-Received: by 2002:a05:6a20:4290:b0:bf:4296:80f4 with SMTP id o16-20020a056a20429000b000bf429680f4mr20195575pzj.24.1676065911628;
        Fri, 10 Feb 2023 13:51:51 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t18-20020a63a612000000b0048988ed9e4bsm3370930pge.19.2023.02.10.13.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 13:51:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir: remove unneeded local variables from match_pathname()
References: <20230210045119.25190-1-masahiroy@kernel.org>
Date:   Fri, 10 Feb 2023 13:51:50 -0800
In-Reply-To: <20230210045119.25190-1-masahiroy@kernel.org> (Masahiro Yamada's
        message of "Fri, 10 Feb 2023 13:51:19 +0900")
Message-ID: <xmqqfsbdgpe1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> The local variables are unneeded - you can simply advance the 'pathname'
> pointer.

It probably is somewhat subjective if it makes the resulting code
easier or harder to read with these extra variables, even though
"are unneeded" may technically be correct and the compilers may
produce identical binaries with or without the patch.

In the context of the original, this used to be in a loop where
elements of an array was matched against a constant pathname
variable, and it was necessary to use <name, namelen>, separate
variables, to point to the "remainder" of "pathname".  It would not
have made any sense not to use separate variables in that loop.

When the body of the loop was split into this helper function in
b5592632 (exclude: split pathname matching code into a separate
function, 2012-10-15), we could have removed these variables and
instead clobbered <pathname, pathlen>, but apparently we did not.  I
suspect that the original author found it easier to reason about the
behaviour of the function to keep the incoming parameter anchored at
the constant location, and use separate variables to point at the
tail part of the string that are to be worked on, which I tend to
disagree, but I do not have a strong preference.

Having said all that, I consider this to fall into "once the code is
written one way, it is not worth the patch noise to go and change it
to a different way." category.

Thanks.
