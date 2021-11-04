Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9B4C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568E3610D0
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKDJsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhKDJsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:48:52 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DBC06127A
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 02:46:14 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id b3so9737304uam.1
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apALBqSDRhJzesOSP0WzYhjXoEoxN/JpZ7M/DIKLTOI=;
        b=GAb3q+NlQn0FIUzkPHWl4KiGBfb4x/I6so4DOYzzm/aDir/9b+NFMiUOeFWexokPaE
         yPC/pMkiy3zEtsfVfWh6ibRdedW82H2S+lPEHFdwHAfzMd3JwMkv3IicwQk7NQ34T489
         uQY3CYCAhOMcM/D/UgboZGfGDxlneryYiKcoMv51HP/AJiMWdJi/y2tZY7B2vHmITkEP
         AxTqdQSN+PwXKtNsBReGyvd0y5uGp0HNlCT4Jrw14ZcSFxhzF1soy5KmzrJciNJplKWy
         uotKOLMEGq63OWtxVt5czsJ7CoAAss7JdrnaO/9+splUyxPDs1P/hUlthDIiyhKwXyXz
         FS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apALBqSDRhJzesOSP0WzYhjXoEoxN/JpZ7M/DIKLTOI=;
        b=nZBqckYB5Qldmydw2MAe78V4Kc/F8NUGg8exBoEdfsTN8u7+cf89eTNZ5gfa9X6zj3
         8Cu8vHiEVDucEyBZDtluFlzjAbpdMQp6t6IOcA80bAKPlUS3mzDR/BsQyGdEAiPP3fZm
         AJQYsDQCvyHjWs0rD8cdFQZKKQhHu20gdLBlx36OJWESxwiTXfokoq7bYsn2+XekEfHY
         724np7taBHAP6z8TT22+3oMl9tLGeQL4YUe1tNwjmQflE/pt/j3yTYJL9CDSqqoX472h
         XDdIi9lqz5OSBlx53yjga3c8FLx0RSom/SGbMbwJujmg/VPPD/mDFQJ0LMkQlkZX2vVc
         7/ag==
X-Gm-Message-State: AOAM530+MWNODcWhhzrwTZMukeHiOQdtiFBmeNUehtPnOzL/vAZLPPo5
        y7fHEaQTv0S/x/gA3at57A429I6lsM9IhpWWrf0=
X-Google-Smtp-Source: ABdhPJxRl68U48caNrF5Ej3MArle8LgpaiZbNOY/VDQRPgrJlG2VAo5VZrYS6EU+OjNW3Ehjz34QV8J1U8HM3Yte6zo=
X-Received: by 2002:ab0:2411:: with SMTP id f17mr2629327uan.2.1636019173446;
 Thu, 04 Nov 2021 02:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2111040823270.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111040823270.56@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 4 Nov 2021 02:46:02 -0700
Message-ID: <CAPUEspiJW8ee_1zoMg6JzJ0ow-2tmPh8iUZK41kfvt6etzEfjQ@mail.gmail.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue on Fedora
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 4, 2021 at 1:43 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> My best guess is that my GCC (which is v11.2.0) and Fedora's GCC (which is
> v11.2.1 plus the usual Fedora customization) behave slightly differently
> with respect to that optional `size-index` argument:
> `pthread_setspecific()` is essentially declared without a `size-index`, so
> I guess GCC v11.2.1 probably defaults to `size-index = 1`.

Got to read the whole explanation that Victoria put together.

for the warning to trigger on that gcc, you got also to have the
attribute in the header as shown by the link[1] she provided, and
which I am sure could be a nice thing to send toward those helpful
folks of the MSYS2 project so it can be added to their WinPthread
headers, as was done in glibc.

Carlo

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
