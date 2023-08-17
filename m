Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB73C3DA65
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbjHQRHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 13:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353836AbjHQRHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0C2D7D
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 10:07:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so29421fa.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUZNoN8nAwVvZ+8RFKITSvLRMf/ekchuVWQZetgH/FY=;
        b=TZZB5OSA99fBNGXgcHrBdD2TlB2fGdiQeNAQHhqhQxJoU9awls4L/gp4zOMxeH6swW
         clrJkW2aS/aMhy4nCrY5BJGU50afozHoug/cyNK/+mxgpiQm1D9jiFDUOMbzCsISw7Jl
         +KunDGyz6Ba6KDdQXhcL4Pr5gbWtE8pEA+5fQBFfdWsX95/74LShIrDhcLwIfiqNMFv1
         qY/JJk20hzu+9RHXgR63k/iMg7/5Qn/xiLw2uS5V3OHKKGEEJjzP5i4ACP/CvnoW/leL
         WHFB7lYBnsd32zy0aDwe6NEM3enSUxNavNRbTPiGR+VfgYDdaYXlslpVteZiRlSmjtx1
         rLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUZNoN8nAwVvZ+8RFKITSvLRMf/ekchuVWQZetgH/FY=;
        b=RItRkNz96goftfYVNAShxHhoVYsH/ESz2QfiR+740kZ6zLGSOXVUHdTsnxLHae6sdb
         2aw1/GMH+kU+o1VPlZbqmoMDgMvmcZI+Ci64JEQ6S9zODNRVVF2yxIuLoYROU8vMzGJC
         gPBmN1lX6PzDhKbcrK2V3znQ2BA7FlatLZPKMsL0deB5rp6ehYS5ni8UcZ0rjqBNAnHY
         2HGC4Q1Rw3fxhQ2gqgQsgeAjcSEAFrMWh6ghoEsrSL1Hknmq4GcgnITo5/X58uCupY4q
         ll3c4tnL8PelhDef4OCToyJcw43RsS6KUitelhtH3eG9Z3NP6w3bd+Zu/0/PvW06dPxV
         tLeA==
X-Gm-Message-State: AOJu0Yw1UCeGpW3eeV+BMU0nK+tgqsjOUUXBppKia0Q0QQCfzldcLrN1
        NRTT2KcVbH6UAMeF1O+9MskMpbZ6vvmaQzvCEtYBRQVfEVFnTQ==
X-Google-Smtp-Source: AGHT+IHvBFJnNjWxzMqx7zKmM7Gz/pqy/6vspUPLG4pwGhX08kL90Ryyxl7pgv09u36DdGXhqLjDpXZiyBHJQegKvj0=
X-Received: by 2002:a2e:9ac6:0:b0:2b6:a6e7:5afa with SMTP id
 p6-20020a2e9ac6000000b002b6a6e75afamr4965005ljj.12.1692292045197; Thu, 17 Aug
 2023 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
 <20230816025715.GB2248431@coredump.intra.peff.net> <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
 <20230817054405.GD3006160@coredump.intra.peff.net>
In-Reply-To: <20230817054405.GD3006160@coredump.intra.peff.net>
From:   Patrick <patrickf3139@gmail.com>
Date:   Thu, 17 Aug 2023 10:06:58 -0700
Message-ID: <CAMRL+qbSn058AsMW7+d1nRbt4Ao6R+BZ6HYHxDrVQhURgWoy7Q@mail.gmail.com>
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, I think I finally get it now. Thank you for so patiently
explaining this to me in different ways. I'm sorry I was slow to
understand heh.
Just to be really clear, the filter in `interactive.diffFilter` is
meant as a filter for transforming (think a photo filter), as opposed
to a filter that removes elements, correct? I think that's what I got
tripped up on when you explained the first two times.

On Wed, Aug 16, 2023 at 10:44=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 16, 2023 at 09:30:38AM -0700, Patrick wrote:
>
> > Jeff, would you be so kind as to elaborate more on the
> > interactive.diffFilter approach? My understanding is that
> > interactive.diffFilter is only used for git add -p or git reset -p.
> > However, the limitation for my use case is I need to use the pager
> > for git log and git show so that won't work. So then, you are
> > suggesting that I ask my users to opt in by setting an arbitrary git
> > config like fzf.pager and then read out the pager from that git var?
>
> Yes, they'd have to set a new config variable. Though if you are really
> just filtering diffs and the semantics would be the same as
> interactive.diffFilter, I would probably just use that. You could also
> introduce a new foo.diffFilter option, and if unset have it default to
> the value of interactive.diffFilter. That provides flexibility without
> forcing users to repeat themselves.
>
> That said, I would not be surprised if many users who set pager.log do
> not even know about interactive.diffFilter. It's a bit more obscure, and
> came later.
>
> If you do want to follow that approach, the simplest example is probably
> just to see how it was added to the perl code in 01143847db
> (add--interactive: allow custom diff highlighting programs, 2016-02-27):
>
>   https://github.com/git/git/commit/01143847dbf4fbf27268650f3ace16eac03b3=
130
>
> In shell it might look something like:
>
>   filter=3D$(git config --get interactive.difffilter)
>   if test -n "$filter"; then
>     git show ... | eval "$filter"
>   else
>     git show ...
>   fi
>
> -Peff
