Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF283C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A182233FC
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgLSPDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 10:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLSPDi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 10:03:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A1C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 07:02:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so3031620plp.2
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQv84/FXL61rqUOABmRdPdEECSPUGw9DYKDOPD+qm+o=;
        b=JJxrljwMW26MShX096156zZjHAtu7aAZ7BaPVsqhAFYzWJLZH/TvsB1RmDnZGltleA
         oZXucehTd0AwCiIpcK9FFKLcYf0D+BD0JNF7jpztv4CRsLCy+KHMj5BUcxJleliIzx5Q
         gbRCXeQQlVXGkQfHC4OoSIOzd1xsP5c3zNyk7uc9v1397MDKZQa6FaL/jAlSZclaPpmt
         YNCg2naAsqGRFZyNQP7lmASrfMDHrgE03hSLGc0TmP0quWxu59HiAlip5cBYu4+ydIY5
         nxEAxQOcvDCgZqBfjOdIBkmqES0JSL+XypabW8fhs3UoyI4Uzj9ULlaGLwEBlpwmWHiK
         w7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQv84/FXL61rqUOABmRdPdEECSPUGw9DYKDOPD+qm+o=;
        b=luSNJGVTSdrEAJ0fhcO4rXCJ4vCgngSgaV0EkTPh25AA51dDeryBRjNW53hO7hYXoF
         eN5c8THEUxDPVA1rMzUjNEcGD8rGtuSkgFlDFb00S/BKn4BuVYRzN5ichs3iu2suhSYD
         ryn9B6tJcseOJLyyYironSV7Z3dKzLpjqNhY6/ud3XrPV5b7hT4xqv64pNiIkW9aytnM
         KH1UZ0pkCSetdD6XLzFkxBpYFPZ4fPFaI7VCf3iW+yWKLD2zX/8jCdi44Rt9aC2XM3pn
         sSJFVPSTaB61iq96sYVevHTu+SmKafj2pHEquC0xAuq7qRMkjXaiXOweCRj6lGPQwyxI
         lPYA==
X-Gm-Message-State: AOAM533ghFCBzxpjrhRmwc8o4eKnI6UMnjDY4TENvBjUwzfrC4u8cqmp
        tSR7uqxYo3XZkncnnrCtYpA=
X-Google-Smtp-Source: ABdhPJz8aXCfQR5SGk0HTUDRvy0zYsmFKkNSCtMcsFiaKmaFWvkG49Jt+EaD4QzybXEvKXKXlZr/Ww==
X-Received: by 2002:a17:902:c20c:b029:da:b4d4:4f42 with SMTP id 12-20020a170902c20cb02900dab4d44f42mr9081276pll.85.1608390177664;
        Sat, 19 Dec 2020 07:02:57 -0800 (PST)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id x18sm11821291pfr.158.2020.12.19.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 07:02:56 -0800 (PST)
Date:   Sat, 19 Dec 2020 07:02:54 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout -p: handle tree arguments correctly again
Message-ID: <X94WHmY3Cd30wqan@generichostname>
References: <pull.819.git.1608389760050.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.819.git.1608389760050.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Dec 19, 2020 at 02:55:59PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This fixes a segmentation fault.
> 
> The bug is caused by dereferencing `new_branch_info->commit` when it is
> `NULL`, which is the case when the tree-ish argument is actually a tree,
> not a commit-ish. This was introduced in 5602b500c3c (builtin/checkout:
> fix `git checkout -p HEAD...` bug, 2020-10-07), where we tried to ensure
> that the special tree-ish `HEAD...` is handled correctly.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Argh, thanks for catching this. The patch looks obviously good.

Since I'm the one who introduced the bug in the first place:

	Acked-by: Denton Liu <liu.denton@gmail.com>
