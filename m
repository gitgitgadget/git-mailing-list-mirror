Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18731C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B752F64E4D
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhBWPcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhBWPcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 10:32:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1322C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 07:32:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w7so423347wmb.5
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hsf/uB62kykxAVpUlbBu03MF1NLLydXBWeZAk9pZSOQ=;
        b=lBSw5ufKo34ILJjm8cGsPZAPJRIMJ8ueW+Wq+DXjtNron4sy0u+gzYjfmGQBKLD8Rq
         JRsTB1zwkgLh53LSMv87g2U+v8t8ubXJ02fLXJv6USNAqrRnTggDB/94fElHEQGpGzxR
         ppympxIJtz+d9MDdTL6W9fJMQL3ywpiw8evAXboW0uzVNebUwjcozQz4HCQfm4ZC5y2j
         v9KOVvH2YPvBsS1aEzvQbNywg2N8xK+eiU1ttJ2j7jpniUK0dRvCMHzURhHE23LEBtGv
         NpaIbrBtoQ5hGb84IYil1gIX5UtMuaKfTYtPar10RhpYtNiU3qBP4KlU1HH3SbFo9Qp6
         XjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hsf/uB62kykxAVpUlbBu03MF1NLLydXBWeZAk9pZSOQ=;
        b=Qcj/+66fnDxgnM4Y83lHQQ0jcp5L8cjWv4N9GQVLg7S8d8MWH93D5rZLqUxsv6a1Hj
         UKq8bJTbC8QzO4fOM+ydlXUTphVADasfPT4YS9HbVoijbIE6ECS5/ERGvlhjknOrq7BM
         1JeeerW0eIiRkCdQPvdl4exo65pPgf377L3gnJhgxmhoNoc+kgZX/JSknxQDTBYAr/Mm
         u670pjp2djbOx1rYH5yqT9MKlqtgg+vLXdPY1aLQZck3y1cmNFb5NbPLLiyL6kQKrftY
         qgvx8s41Qqf8B8yZMWdwpVeeXGb1tYCGSE8bINDXUWCrzUSkGXEtB3welsxXDV6KSW0C
         zuRQ==
X-Gm-Message-State: AOAM530hrIyD/M2hKm4GF3cx16VQ7HnNEi+rCYYclhEclZsNxos/VBrF
        UbVDSv3+C5sVgn4NwkMjB527oczNZxwUhsqa1Siw63tWJdwDuw==
X-Google-Smtp-Source: ABdhPJxKkUVhOfiQiWLlvlMT5A16fHAUrwMm16WfWigRHS2Ae5h3iChZqWuwBebL0sHbY+Sd9YyYvgmdGOa+SLnvmFQ=
X-Received: by 2002:a1c:ba05:: with SMTP id k5mr24519918wmf.111.1614094329360;
 Tue, 23 Feb 2021 07:32:09 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com>
 <CAPig+cSvYLMtML5ya4GR30-nfNNt19okLjchkkdhdzAEB19H4g@mail.gmail.com>
In-Reply-To: <CAPig+cSvYLMtML5ya4GR30-nfNNt19okLjchkkdhdzAEB19H4g@mail.gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Tue, 23 Feb 2021 07:31:58 -0800
Message-ID: <CABXAcUwdpJa1osz=9xarVgbP9wFK82rbx8J1vk-EZEA5x25ffQ@mail.gmail.com>
Subject: Re: 'git maintenance' won't work on bare repos
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 9:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > 1. 'git config --global --get maintenance.repo' returns '.'
> > 2. There are no Crontab entries inserted.
>
> I can confirm that problem 1 is a bug. However, I am unable to
> reproduce problem 2.
>
> Note that the crontab entry won't be created until you run `git
> maintenance start`. Is it possible that you are forgetting that step?
> (Be aware that `git maintenance start` will show a misleading "no
> crontab for <user>" message if you don't already have a crontab file,
> but the crontab entry will be created nevertheless, as evidenced by
> `crontab -l`.)
>

My bad. I misread the manpage, and didn't try to run 'git maintenance start'
on the bare repo, since the first step did not look right.

> I have a patch which fixes the problem with the bare repo path being
> incorrectly registered as ".", but I still need to create a regression
> test for it.

I saw the patch, thanks for the quick fix!
