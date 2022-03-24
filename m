Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D18C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 02:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbiCXCGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 22:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348083AbiCXCGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 22:06:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B12616F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 19:04:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w7so5681324lfd.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 19:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pZQQwjaol8XU3y2NuTfeGtrkA4xiJak10+pA7t20AXo=;
        b=D4IwWHoCIARY0EsVhJU8Gh/3hhv4BQvrJZDm8InP98YXqY4bHo+cI1flmhXTmbLPFq
         6fuEBhDPmnEJ6X+zdYcFzYcX2DsIjwjt3gjzu5sORkwHClUn2fJE/SSefwHek3g5aU7w
         eZR3H6eRq+yfwqY+al5DZN4ckJMPg2cyCu+2u2PDjzoJnNIxJL9ouppurM/4OyMsi3pR
         NbA1yzxp2SSxbye9YcIJqYVisHyeYC0GyvQbVPAEBLJo1eOO1XgK2NW46bfDQ+OIe87v
         yqrZcsHhRERZ5jKqRWrtM3w9RAfsCFC5GZ6E4pCErdon09J+Ps7XC2BtOllLi1T9lEEW
         OxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pZQQwjaol8XU3y2NuTfeGtrkA4xiJak10+pA7t20AXo=;
        b=0MZxVGyJlpLUhWzmLYa5zbXrTl25tO+PpEw0sl4AGFvmlEwKx0aPBN0lnAg+pVkP3C
         VJ3DOy14lb6OCZ0wQu+BW8tbAsf/QzdJG4GzwgNI2FSKqkf83bk2s+jbISXnocQOyyTZ
         4gMiGcJagJLU260UZMLummcBRmpVxgrNXlD/FpDVoLTMlvXkm/g0PXAkOcKsNStTzy23
         zt+MGdYt9zdjyw2D/HsNY1TbUvX2L0esYX3zQAusRXQpkW+Pg4OD78qdgCnpWFzzLDnX
         TZYCNu4oIWAfMyCZkM1eICC/3WJxd0DjOWtmxdSGrU8c1dDCd5umgM+ENna6pIexfQwR
         8H/Q==
X-Gm-Message-State: AOAM53255s+xzvnI7CAPbkcYBIco6Lgbj1WzWyk0874J1SWUqJoWqb5F
        S48Dewa0aUZdIoDQj3DQE6V1Mskuz/FAM67uflQ=
X-Google-Smtp-Source: ABdhPJwDJHKFNeus988k8878RLwUVbX/0Z+gs2cZ5skl0nhlxJusRJDH42+iP6gSKy7NeQiWDrmfff1dmlmp6PYXzPk=
X-Received: by 2002:ac2:5dfa:0:b0:44a:15d4:9e60 with SMTP id
 z26-20020ac25dfa000000b0044a15d49e60mr2119948lfq.241.1648087472282; Wed, 23
 Mar 2022 19:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220323.86k0ckol2v.gmgdl@evledraar.gmail.com>
In-Reply-To: <220323.86k0ckol2v.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 23 Mar 2022 19:04:21 -0700
Message-ID: <CANQDOdekfyPEZTfzrJ3Una=9Xt-kCcGDtqPskKr=29cicxO-=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 6:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> > [..
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> > index 889522956e4..a3798dfc334 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -628,6 +628,13 @@ core.fsyncMethod::
> >  * `writeout-only` issues pagecache writeback requests, but depending o=
n the
> >    filesystem and storage hardware, data added to the repository may no=
t be
> >    durable in the event of a system crash. This is the default mode on =
macOS.
> > +* `batch` enables a mode that uses writeout-only flushes to stage mult=
iple
> > +  updates in the disk writeback cache and then does a single full fsyn=
c of
> > +  a dummy file to trigger the disk cache flush at the end of the opera=
tion.
>
> I think adding a \n\n here would help make this more readable & break
> the flow a bit. I.e. just add a "+" on its own line, followed by
> "Currently...
>
> > +  Currently `batch` mode only applies to loose-object files. Other rep=
ository
> > +  data is made durable as if `fsync` was specified. This mode is expec=
ted to
> > +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS file=
systems
> > +  and on Windows for repos stored on NTFS or ReFS filesystems.

Thanks, will fix.
