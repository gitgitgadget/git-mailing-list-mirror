Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A39C5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiAZANm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiAZANg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:13:36 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9370C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:13:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s13so34593144ejy.3
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrgf3px95ovp1UhTx2NoBV5vmX8tkFnkk3d2FegrAB4=;
        b=OTwsxxIQs3/WHTx8GMSqbU+Lwsn6yn38NBxMX77SyZ6HA6sECGHmbOCvldOC8tMAcr
         NPpEFrDJIW84Lt1S9KImAHH904Wjiwh5AnpSTqOzIAmIEaCRyl5OfRoPo2d2qKnwLZXl
         E5ff825tuWlCRWA9zhOPVqajWhu7xW1TRTMKY/1APjDg0FBKieumBRnMhPe7nI2fpo+a
         wLNtqqv5T7ch0OpBlcZqgE2Egl4tfDYUnU+s4t0ZRXfso/T+TAcz+vnUU+mLkWYYogWV
         6FFnRCay5D+gPdsvTJcVqlQUI9tVupfAZNT7hI9ezEY7tHy+HSy2ZF6luCbZnYUIRSzS
         rtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrgf3px95ovp1UhTx2NoBV5vmX8tkFnkk3d2FegrAB4=;
        b=sTYSSopgpt8OMdr4ZYKnEUSZWQrE5MhFolKcJZnMm+A2ecMbKlq9MUfUtO4oXRu+KA
         lzPna9uBVROv45iP+SvYVkIm6yHQ9dZqhBJeQK1Y5KAIsjlCB7vaBuL/FFuTbLhEu1vF
         WPR40+mMfEXxH4qcdXdEmJajsHFTOPzTynM8pHuVBeV98VIJ83d2QZT8/s1bIJStNIGE
         ZJu25XdkpQ1di6DGWfmuTFPM3ZkLNnlb999WavpDvJfSU6WV7zs4z/OEfaXIPDsssiXY
         /5omBucVqdGCMhcffuYZWQNSQm5ogM1Kke7AfHRMNZoPqnqKyAenTwqD6l5dTYEm6U7m
         gtJg==
X-Gm-Message-State: AOAM530r0Q/5+Ilj67wkDNGZWfywuU15nDHtM3RB25e7XLOMMoTuu48H
        MAcVA/a36y4NKyZH3KKuybIK2BaTbC8aALmqE9mILh4L
X-Google-Smtp-Source: ABdhPJwpfyZdnR6dx9TBopTb0v+KTi/DHKgZgy9x35Gs3HIJAiOvnuo9wCqhQcMCWhEu4aik6sXZNIlz5ALypRICHTU=
X-Received: by 2002:a17:906:175b:: with SMTP id d27mr18148374eje.476.1643156013370;
 Tue, 25 Jan 2022 16:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20220125233612.46831-1-chooglen@google.com> <kl6lfspb1j23.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lfspb1j23.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 16:13:22 -0800
Message-ID: <CABPp-BEaAu0=EEjDrTqghGdaNOG=nKv+L_b8kP-7mY=KspJZ4Q@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: set GIT_WORK_TREE in run_git_checkout
To:     Glen Choo <chooglen@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 3:39 PM Glen Choo <chooglen@google.com> wrote:
>
...
> I forgot to add this to the previous email:
>
> cc-ing Junio because this bug is in master.

...and is a new regression in 2.35.  :-(

Sorry about that.
