Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C5AC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhKZSbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbhKZS3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 13:29:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE257C061799
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:04:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x6so41931005edr.5
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6njhNQImd2sdA9fZq/YFvBkly5ThnXMToBX1Gx18r3I=;
        b=Zrlwmm0eGq+m7ivsCMqaKRVLvFdHxXfnbIKtUo/gWuDMJGEKGUPoIVzOPf9pwU7HLI
         UPxp+Ffgtx7qZTr3+r2bCaHbGI+gtzEpyo/Dsw2tNRLbBe5fme31E4n9yJ3Ed/CLYPWa
         n5YpOk+uEte4fokgOQIiziWIc+AVxcWb03FQF4uXNiw7YrQZtDxC3/7Bm+TlVPYMvCPP
         gNl2KKRIJcnSy/N3zgSjVh3hygtlN7z4MmSqTyQQZsMfrEDiLJ5jAmmPox+yXXc8IP2M
         5t/Y3ek/r8D4gTa7hKQg/bnbOMtbLKrbbRuxsZeNqbrNgEjjF663zIBHHxzgkuJnAVLf
         OFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6njhNQImd2sdA9fZq/YFvBkly5ThnXMToBX1Gx18r3I=;
        b=dT1DAjfjkg4s3dBXjSi9JTAohMXgZ1gC6h7y0f1cE5Efzhgp/NfzbLj0KWFbiCCw8+
         eZsF5VwEFZgq46TzS2TNorondANlXcG8M+6PFUpJk3QkOnI/bbktsGBjbtBIeKl8KF7K
         icAzmAQDvpnAzKiDHjSs1P4P3L++aN5e4Ng4ur0crqNVjv6i8/5Ve5wLOxBStuHYsPmw
         V2nidDW+uPn49omdyXH3tH/WIylIi/sGYFcSh/y7W7BQfpxmBP7jTmarz1iGT8f/NJOv
         iXI1FjAdlteimt/SrVhR5B0Zl4oi9VOExWAQlvxxLy9qdhV2zTwdSu7F9LRVw4fS6m5R
         LCEQ==
X-Gm-Message-State: AOAM530uB6vM+JEe/U4jzzPrtgkuPcA8nYPbvdfbcgfz3DqiJZ41Vu5d
        D5jnmITpbnUthuX2JYo8XodDGBBDtKZvYCTv0WM=
X-Google-Smtp-Source: ABdhPJxZ7gKri6rrtCnkbXieaidPF7gR9EZvcVyTT0xyrNcxb4IdvbTsOKkfGU1c5o0glnPJAWcR5qH2VYkxf/JXCKQ=
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr50052364edv.242.1637949890446;
 Fri, 26 Nov 2021 10:04:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <edec0894ca2a01c7afbc70590efd5ee8a0d1abde.1637829556.git.gitgitgadget@gmail.com>
 <211125.8635nkjyby.gmgdl@evledraar.gmail.com>
In-Reply-To: <211125.8635nkjyby.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 10:04:39 -0800
Message-ID: <CABPp-BEMY63=SF17UsY=VePADNoa186UNq0LHXrxRwV8Q_CYWQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] stash: do not attempt to remove startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 2:58 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/stash.c      | 6 +++++-
> >  t/t2501-cwd-empty.sh | 2 +-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index a0ccc8654df..50b4875980c 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -1485,8 +1485,12 @@ static int do_push_stash(const struct pathspec *=
ps, const char *stash_msg, int q
> >                       struct child_process cp =3D CHILD_PROCESS_INIT;
> >
> >                       cp.git_cmd =3D 1;
> > +                     if (startup_info->original_cwd &&
> > +                         *startup_info->original_cwd &&
> > +                         !is_absolute_path(startup_info->original_cwd)=
)
> > +                             cp.dir =3D startup_info->original_cwd;
> >                       strvec_pushl(&cp.args, "clean", "--force",
> > -                                  "--quiet", "-d", NULL);
> > +                                  "--quiet", "-d", ":/", NULL);
>
> I saw you used :/ earlier in 01, and I commented that maybe we can use
> ".".

I tweaked that other one to avoid :/ a different way.

> Right now I can't remember the difference. I think for tired reviewer
> eyes it would really help to amend the commit message to call out what
> desired behavior change we're getting to by adding this pathspec.

Yeah, I want the ':/' to be explicit that it should clean from the
toplevel of the repository despite starting in a subdirectory; I'll
amend the commit message.
