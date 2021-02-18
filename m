Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF17DC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 05:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9E264E4B
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 05:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBRFVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 00:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBRFVl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 00:21:41 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86656C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 21:21:01 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 6so721188ois.9
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 21:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NUgDyh1eaHu65v+fRXnAMTRV5NhXDl07tRAq+zIJpw=;
        b=oLtzUV4iVr7QPFEfqor4ml/s25PjrmwD8XelTaa8cCGBGhvPEWcDAZYeRd4NJ2wymo
         HV22405apW+h3v4N+BIdCM6tGT+0ARhc0ftwMtNMDZDxW12/H27JghuoK8Gt58IndB/0
         6n1Jp2q8mGwdv8d7AYDiU5PasJ95nzmvk4rhkpu/KFEkc+u953d3rMm6QVVnexL/axtT
         2mfOZ1ymrSkEbSZghFIxa1rWp/dw8M+N//bTM3m3UnDaKdtHmH1sAg+bxuqNeFSw86NL
         Q+Nb0QKjCesRS/fFFkBy+GV74rSoUrwMJDnt9XgS1B3+EvKXP/yPu+f+ZFRkkewGXBCx
         VcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NUgDyh1eaHu65v+fRXnAMTRV5NhXDl07tRAq+zIJpw=;
        b=sFTrDKHF5XEF/7DqfGcYwmVAmmuTmeqOwi68MutZOA1xfXiMxqTm5CMbfKZWQIoQo9
         thFlgi4GBvqbycmvOFlk5OwTwy3cZxDblGEgWj1TeAn+Xv4TwVKVfbkvm2Nr/ZDbc7BH
         SH4eSKra99GuyOh+5Ew46vXB7auZdHp6p7iURgaG/klKRLcsN2cyNv4XH9ewpAo20VR9
         leB4na94/uU36hQ8W35/qOkqY5UYMhodVu662Olq0jWOauTjH0XKA8iJQbGv+8cDf2yx
         GMxG267UqndlZAWYwNFgo+UIWV5qz0CCqnA8Up7HWkF5s02PNcHA4rOp9vQtInnYcJ03
         SSFg==
X-Gm-Message-State: AOAM533z7ZXTmpgWq1PRaD6Eb9cP678H3upNKwgUObALGVe9CS34FcBv
        NYaXD6aLeMsBHzCmhN4ZHn1PugRTzRlDuojaR2c=
X-Google-Smtp-Source: ABdhPJwcZuqM49D99kR2Wjc/2DQMmT+Rkz+3rXSwGCReu7ATxdBHMv8YLLrLrHUzafOqHcFKm8YHgT1K+tG1JVNrnTM=
X-Received: by 2002:a05:6808:914:: with SMTP id w20mr436527oih.120.1613625660832;
 Wed, 17 Feb 2021 21:21:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
 <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
 <YCz6oDZCAODPS8sY@generichostname> <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
 <xmqqo8gile02.fsf@gitster.g>
In-Reply-To: <xmqqo8gile02.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 Feb 2021 13:20:48 +0800
Message-ID: <CAOLTT8SkVQV+KFCAqipWmA35wcieM+Y1u45ONmc1ASchf8ub5w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, thank you for your patient explanation.
Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8818=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:56=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi ZheNing,
> >>
> >> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
> >> > Oh, I am sorry.
> >> > Then I only need to squash the two commit, right?
> >>
> >> I've never used GGG before but I suspect that in your GitHub PR, you
> >> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.
> >>
> >> CCing the creator of GGG, please correct me if I'm wrong.
> >>
> >> -Denton
>
> > Hi Denton Liu,
> > You mean I should cherry-pick Junio's patch to my topic branch, right?
>
> Thanks, Denton, for helping.
>
> ZheNing, the end result we want to see on the list is just a single
> patch, your 2/2 alone, that says "this patch depends on the
> diffcore-rotate topic" _under_ its "---" three-dash lines (where
> "meta" comments on the patch to explain how it fits the rest of the
> world, etc.).  As a single patch "topic", there won't be even 1/1
> marking, i.e. something like:
>
>     Subject: [PATCH v6] difftool.c: learn a new way start at specified fi=
le
>     From: ZheNing Hu <adlternative@gmail.com>
>
>     `git difftool` only allow us to ...
>     ...
>     Teach the command an option '--skip-to=3D<path>' to allow the
>     user to say that diffs for earlier paths are not interesting
>     (because they were already seen in an earlier session) and
>     start this session with the named path.
>
I noticed that "skip-to" is more suitable for users, right?
(I always thought "rotate-to" would be better)
>     Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>     ---
>
>      * An earlier round tried to implement the skipping all in the
>        GIT_EXTERNAL_DIFF, but this round takes advantage of the new
>        "diff --skip-to=3D<path>" feature implemented by gitster
>        (therefore, the patch depends on that topic).
>
>      Documentation/git-difftool.txt | 10 ++++++++++
>      t/t7800-difftool.sh            | 30 ++++++++++++++++++++++++++++++
>      2 files changed, 40 insertions(+)
>
>     ... patch here ...
>
>
> I do not know how to achieve that end result with GGG and I do not
> know if GGG allows its users to do so easily, though.
I understand what you mean. I think I want GGG to work normally.
 I will try to resubmit your last patch and my new patch cherry-pick to the
 new topic branch. If there are still problems with this, please point out.
>
> Thanks.
