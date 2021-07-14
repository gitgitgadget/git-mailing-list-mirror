Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF1C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB596613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbhGNPRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhGNPRn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:17:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3269C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:14:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso2790520otu.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BMAT+QOonJoSg//1hG5uvzntlb3B30ACRxyjJM1sVhE=;
        b=uGkVcAJsNlCV7+9740tGAGkoGhBl2SIQQC0ZfynEKbaA/wHA8J44J6IAOxMQKb4/rC
         FvCqL+QJGZg1kdaca7bRnH4D2OOyFMug5Om811e1dG8KJUuWTHwY4xSwoIdDj6jmOBR8
         iloj5bTmeWC1unrBIQVFzAUCCGHrc6lTQATS4OHZFkrbTfLxV9x7hJBWL0ybUkVYY6AV
         MHdkevfzRgtc3tlsk5xwWmR6xjOTUITDcSL428hSfK7IZryO+E2Bii6UopqEr4cKev9V
         xvK4QZ0QFBPJBpoBevReUGB6qtKFPSbx861cebo4grv8hOw2a4FL0liVf29W6Q/kvEXy
         JomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BMAT+QOonJoSg//1hG5uvzntlb3B30ACRxyjJM1sVhE=;
        b=JxwAHBgKON6NYLSCi5BNAV+aHPV8CBj5Rs5Iiaq+CLZAAY8I6aI6NooGBYGtc3Phq3
         eB6vN8/Lqujn6FPuOjsqPa/BHAn6/FHycum5ACOZMuRDcSSKWuuCxj0XymW2ojEatJUp
         bto0WPjKGhhLrnRGjnPYjvmxjt9QlAEx81kB4BPqHOwT3bAfYu4VeXBeLO3nEwDfVs+T
         /+mgi/boijmufvyQfhqfw5A+6hyha3d6TEZOM+zI+sGjVw6yG/FrNvVXIYsPFXAa/2tl
         T8EGfiZRhdFuxPt/8Rdr1NJ/+yZyoxzwWTcHAQAJuE65bYVayfgM2HRKhnM34Nj67drT
         2JGQ==
X-Gm-Message-State: AOAM531jLSdGfslxY7WNi2wiNqbWPD35/DIOOu5+ydtsQwilcY4oAIgi
        rw/6t1YthE9Z8vinceqHDMw=
X-Google-Smtp-Source: ABdhPJy85JBBI+SdFmfJ3un/m6YM6lOifheoFE7HrO0iN+mojf538r7vqJDE8C6lU+qIJDeMvqUqSg==
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr1069262otq.29.1626275691224;
        Wed, 14 Jul 2021 08:14:51 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id l2sm523762otl.27.2021.07.14.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:14:50 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:14:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Son Luong Ngoc <sluongng@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        felipe.contreras@gmail.com, Elijah Newren <newren@gmail.com>
Message-ID: <60eeff69293fb_10e52087a@natae.notmuch>
In-Reply-To: <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Son Luong Ngoc wrote:
> I am out of the loop in this thread but I have been seeing strange behaviors
> with pull.rebase=true in the 'next' branch and also in the 'master'
> branch in recent days.
> 
>   > git version
>   git version 2.32.0.432.gabb21c7263
>   > git config -l | grep pull
>   pull.rebase=true
>   pull.ff=false
> 
> But a git pull would still run fast-forward.
> Some of our users (including myself) rely on disabling fast-forward to emit the
> per-file change log summary after each git-pull
> 
>   Updating 245f278cb729..5e8d960db7b3
>   Fast-forward
>    some/file/dir.ext         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>    another/file/dir.ext     |  6 +++---
>   2 files changed, 47 insertions(+), 3 deletions(-)
> 
> In a big, fast moving monorepo, this summary is a lot of noise and
> switching to pull.rebase=true
> used to be the way to turn it off.

This is probably due to 340062243a (pull: cleanup autostash check,
2021-06-17).

I bet you have `rebase.autostash=true` configured as well.

It seems to me you were relying on a bug.

> If the change is intended for next
> version release, is there a
> workaround for this?

git pull -n ?

-- 
Felipe Contreras
