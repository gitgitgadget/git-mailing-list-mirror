Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A95C4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhLIRFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbhLIREz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCDEC061353
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 09:01:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so21107183eda.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfOtJwN4amQ62j5//J5XmLl8juJfsznONC62mlXKLOc=;
        b=mPUI1F4CFbFXmEihhST7QPmXuvqTeqmR6SEBivMOPZDgJyP6jXnY76M8cs0/Qn8gGM
         SkXZGRzIUfLUoi029kFAWidHGOpTRU2ueWtmZraRInQn2lZ86+yxgADjYtTSj49CPJj5
         ryRtF8EFiW+SezUnlaQw2rz/y+m3bH5Fe2slhSlDuAIMr+m5UHmfBhm5lgMzOpniE0kk
         fM5s3Dm/VZgB2x5NeTfEWKxiY7kmRrWyKvMDSU4I+hfCZGYyUUDgmUAMk5L59w3WanBH
         BqfyopJ008uwq/4shbKhiorvSZh6Pxnm9E+f+trP6o2BE6c+LBOTaYPs5rN+ohgfEI4T
         m9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfOtJwN4amQ62j5//J5XmLl8juJfsznONC62mlXKLOc=;
        b=hFCkKt/H9G/NhPYdXqCzKQcZuFk9SuJuVxQ2YWB5Uj0I7Z1mdcMf/+FNi4ijn+Ka78
         uDqC/AxFclF1EVvKiZmvgAat7xJTXCixObex8bt9msliL4CP4CTlc3jbhZiRda6gs0V5
         xBxZZUxt3np2oyLNpbcdEWxYrmTV/eNG0zOVu1Jg5Av4LTHrzM8E07hWFYXAjSRYmHo6
         iLEwdY30gsi5gFvksal1Rje3D4i6OAvPcSrTeAN+apTzeObkdlqQi0ZFaRsGpK5LrbSS
         HUqnWEkiUur8DwRdN8bs5ifn4rrWIp7TkhBOxXcQtvTEXM0w8/MG5+6yHhS8eVtaKOTt
         RuOg==
X-Gm-Message-State: AOAM531a3buvohXrOYSWOj4OeREb+xZtzW8uT7ookSucviQpEf1HLla4
        DaXcXLnNsr1gkZRV8Lw6ussVTT2AtVpIZYTv9Y22j58I
X-Google-Smtp-Source: ABdhPJz6Chzwr9YPTftV27xyVYkixqHFnY4BGbKGCjgI7OaueOSey05Xe7sjHtsxeCBJoqCdUyCnmCUPwzoLPHeA+CI=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr16729022ejh.172.1639069091109;
 Thu, 09 Dec 2021 08:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-12-sunshine@sunshineco.com> <CABPp-BGBhxbvh_Ob=bR8U9f-3muiBzWmFruKLXd=K7420i8COw@mail.gmail.com>
 <CAPig+cQzTnQiwT4Nmpp8qYJOaRpy2pK7DDOu42Wk-1TfmbUxSg@mail.gmail.com>
In-Reply-To: <CAPig+cQzTnQiwT4Nmpp8qYJOaRpy2pK7DDOu42Wk-1TfmbUxSg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Dec 2021 08:57:59 -0800
Message-ID: <CABPp-BGkMNTAzPqGQ0S8sKenhX8L0CBep23TrdODqEU1BJeTdA@mail.gmail.com>
Subject: Re: [PATCH 11/19] tests: fix broken &&-chains in `$(...)` command substitutions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 8:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Dec 9, 2021 at 11:44 AM Elijah Newren <newren@gmail.com> wrote:
> > On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > >  test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
> > > -       OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
> > > +       OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
> >
> > Shouldn't the second ';' be replaced with '&&' as well?
>
> Thanks for reading so carefully. In this case, the answer is "no", the
> semicolon is correct. This code legitimately wants to capture in the
> OUT variable the numeric exit status of the command preceding `echo
> $?`. If the semicolon is replaced with `&&`, then the echo won't be
> executed if the exit status is non-zero, but we want `echo` to be
> executed regardless of the exit status. So, the code is correct with
> the semicolon, and would be incorrect with `&&`. (I hope I'm
> explaining this well enough to make sense.)
>
> It's this sort of special case which accounts for why the new linter
> (as mentioned in the cover letter) has special understanding that a
> broken &&-chain can be legitimate in certain circumstances, such as
> explicit handling of `$?`.

Ah, right, you had mentioned this in the cover letter.  Short term
memory on my part, I guess.  Thanks for explaining...again.  :-)

> > > -       OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
> > > +       OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
> >
> > Same here; shouldn't the second ';' be replaced with '&&' as well?
>
> Same answer as above.
