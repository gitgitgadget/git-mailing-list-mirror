Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0487C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiB0WNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 17:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiB0WNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 17:13:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C301A838
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:12:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s1so14965850edd.13
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoSlqYLpACOazVikej9PA9KBaaVeIavxwfrH+QrysWo=;
        b=UYTr6stG78bgjyR6jMaY9F+gMvZ/56zuXY6M9f8qihIN6PIYPIGSAtHLJJ765mNNIz
         AhLDp2S09gfNGMtqJLAA8+g9ml8zezh0yeaKhTQt5414rvUi+I/kiTT0cgkDer/FzAOP
         jZIsTklXB1rp+AHMgBruWtZa3YX0plXvDyleGrqY+uOXGsNDhhF/X6wNpgiqvmGrfheA
         /+puJRotOKX+Pug5RukFSjBZBWUxR77sYSTYELKm0GhZIVvgirKqC+i5cdWb6cyKmuSO
         0SSP0B/k9/yxFaLNsJwt04xqsIaG0uBOL+JXh/uihb7bHiKYcXXCxtEk4tf1pHSTO+V/
         E02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoSlqYLpACOazVikej9PA9KBaaVeIavxwfrH+QrysWo=;
        b=ICkCbeHIp+De9BOR7WDiHMVwJvlvhhyB7QDLFqV5aK8KKu37tpmsIjUctKiUh3fQGE
         pOdLgez29Dk0IDX4CY6489LOv/w72A608tUkaOmJGGfspO6yMMKFeB+K1u3CXjjAo2yx
         iE9WEIMzbG+75C+Wo5Bcj4S+1DgaytrVDD6gT4X5k6cA6nhClgK6XPVhOuev+QWhpEn0
         t7vyUjfj0wUIUTdgZyQ6dq88bO2ylFDJc8fReS0+cgKVQqyy62EnbzrNsGPEovV4yS+M
         XzDCd0ttVGDjWSSfEuM/GjXOM0H/C8z7EIIguzuONihrwFYJ0zarjrUS6Xtpv/6y3Amw
         VmIQ==
X-Gm-Message-State: AOAM531c2j/Bwn1s/yMaHUgos9brkvXRfpaglnz5HmUvWN7vnQrIy1Me
        5PRQG1Xgosybepk+nyUwMC0qgBojXutIgPyQjpGEWu5I3Yp4Sg==
X-Google-Smtp-Source: ABdhPJwtdqxkhGIsZ+/uJc6THoSFatKo+GTu5rfBYwRam7dyhfWdSh6Ovcyuxy/jE1zyfJsMqx/MSyeChYtgvII+iGk=
X-Received: by 2002:a05:6402:5cd:b0:412:d3fe:843d with SMTP id
 n13-20020a05640205cd00b00412d3fe843dmr17345389edx.97.1645999965300; Sun, 27
 Feb 2022 14:12:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
 <pull.986.v2.git.1645809015.gitgitgadget@gmail.com> <9421b71540d1f1764db6931d0781576d8a710866.1645809015.git.gitgitgadget@gmail.com>
 <xmqqr17qbw8l.fsf@gitster.g>
In-Reply-To: <xmqqr17qbw8l.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 27 Feb 2022 23:12:33 +0100
Message-ID: <CAPMMpoi4oQ4nORc-Jq00pFQq7eFYe0mZhwdU7fvTabvCdL1Okw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t7519: avoid file to index mtime race for
 untracked cache
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 8:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > In t7519 there is a test that writes files to disk, and immediately
> > writes the untracked index. Because of mtime-comparison logic that
>
> "untracked cache", I think.
>

Yep, fixed, thx.

> > uses a 1-second resolution, this means the cached entries are not
> > trusted/used under some circumstances
> > (see read-cache.c#is_racy_stat()).
> >
> > Untracked cache tests in t7063 use a 1-second delay to avoid this
> > issue, but we don't want to introduce arbitrary slowdowns, so instead
> > use test-tool chmtime to backdate the files slightly.
>
> Good approach.  Perhaps fixing 7063 can be marked as #leftoverbit?
>

Sure. Updated the commit msg.

I also started another thread with what that looks like - it's not very pretty
in the end because of Windows compatibility issues, and still incomplete
because (as far as I can tell) the sleep is used for a couple of different
purposes, and only one of them lends itself to chmtime manipulation.
