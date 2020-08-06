Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02655C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D78B2311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=3v1n0.net header.i=@3v1n0.net header.b="JO0zZwyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgHFRYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgHFREo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F02C03460A
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 05:36:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so36287834ejr.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=3v1n0.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pp9TemfPYSIWuYUILUrYYBEcu2MsGQER8NRbaT5UOFQ=;
        b=JO0zZwyLGkH0kqsxWoHlneSOkLadUZFtJL0jQ356+5PowkEbdlkXShQ4u12V/7IpJY
         aQoznGEop9VLEQlFIYT/Bxr1sH12JsXt6ObOJTFBPHqBsEIu5kXoe2UJTjLCdnCE2cf1
         jIT+a/8SlKvpaSM8JSlBn/U8j+4K4WNg9d4bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pp9TemfPYSIWuYUILUrYYBEcu2MsGQER8NRbaT5UOFQ=;
        b=SeuyxZsLAWrm22fiB8MojPdUIyvOcIoLHndEe7Q5tkSaUOoTNA3tMvdsZRot76x55i
         2+Oiq3mpt3mPEz0ikdM+ZE+CFKNs/11g0bO4nfn1CJSmRSUbNpsGsgqYF/OQQzq0Jetn
         EVOWApdi6WeZS1ZISgmvcHorPyG9BW+ptTMbfmdSCNSNOoqpzynoVzuctmcX8fSPhIjS
         LWktRgQlGYuOtu/1pq98d1rRdEmQmCIrs/zK6+wVxCwITNWY5Kdlq6y6s8db//i1wmUi
         QlH5v4dueaI/g3YZ9eUvSqcZWnb/VzK2dl8YMmpEj/+jaaCwZTfeukD66v/r4G4Ykarl
         ntGA==
X-Gm-Message-State: AOAM533EQb1BJ1LhG0Pomfmmbv4TiYUPFhTunMFVOz3wt5S2sUGNfGhN
        RfD1tDwVMIkbOkVDdcMl8+Y0zme2WJo=
X-Google-Smtp-Source: ABdhPJxIUolVqD/h19sahVSqA8+r3bV3u048EvNZt/kmPQ/FldmddY8bmXC4/goOz+SD7m1nhfGDPw==
X-Received: by 2002:a17:906:6406:: with SMTP id d6mr4024439ejm.30.1596717416497;
        Thu, 06 Aug 2020 05:36:56 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id gl20sm3695740ejb.86.2020.08.06.05.36.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:36:55 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id kq25so37164204ejb.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:36:55 -0700 (PDT)
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr4123557ejx.212.1596717414992;
 Thu, 06 Aug 2020 05:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <37090d232221415b227c165bd44f6711d21f376b.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cSn7pGzr+PYBMAgbp9V0z+OVUGgW=SDWV33HbqjMiiKhA@mail.gmail.com>
In-Reply-To: <CAPig+cSn7pGzr+PYBMAgbp9V0z+OVUGgW=SDWV33HbqjMiiKhA@mail.gmail.com>
From:   =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Date:   Thu, 6 Aug 2020 14:36:28 +0200
X-Gmail-Original-Message-ID: <CAALaSc=U65aqgK95zWG2=qSNguHLYkve4Hu=30WxyVOFYPUX+w@mail.gmail.com>
Message-ID: <CAALaSc=U65aqgK95zWG2=qSNguHLYkve4Hu=30WxyVOFYPUX+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mergetool-lib: give kdiff3 prioirty in KDE environments
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mer 5 ago 2020 alle ore 23:16 Eric Sunshine
<sunshine@sunshineco.com> ha scritto:
>
> On Wed, Aug 5, 2020 at 4:02 PM Marco Trevisan (Trevi=C3=B1o) via
> GitGitGadget <gitgitgadget@gmail.com> wrote:
> > mergetool-lib: give kdiff3 prioirty in KDE environments
>
> s/prioirty/priority/
>
> > Signed-off-by: Marco Trevisan (Trevi=C3=B1o) <mail@3v1n0.net>
> > ---
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > @@ -288,12 +288,15 @@ list_merge_tool_candidates () {
> > -               cross_desktop_tools=3D"opendiff kdiff3 tkdiff xxdiff"
> > +               cross_desktop_tools=3D"opendiff tkdiff xxdiff"
> >                 if is_desktop "GNOME"
> >                 then
> > -                       tools=3D"meld $cross_desktop_tools $tools"
> > +                       tools=3D"meld $cross_desktop_tools kdiff3 $tool=
s"
> > +               elif is_desktop "KDE"
> > +               then
> > +                       tools=3D"kdiff3 $cross_desktop_tools meld $tool=
s"
> >                 else
> > -                       tools=3D"$cross_desktop_tools meld $tools"
> > +                       tools=3D"$cross_desktop_tools kdiff3 meld $tool=
s"
> >                 fi
>
> Wouldn't this change the behavior for people running old KDE which
> doesn't have XDG_CURRENT_DESKTOP, giving "kdiff3" much lower priority
> than it had before?

Yeah, true.. So to avoid this we can just also check for
KDE_FULL_SESSION, that has been introduced by KDE 3.2, and this should
be enough I think.

> This change also illustrates why I wasn't convinced that patch 2/3 was
> necessarily a good idea. When you touch 'cross_desktop_tools' here,
> you end up having to touch all the other 'tools=3D' lines anyhow, so the
> introduction of 'cross_desktop_tools' didn't buy much in terms of
> reduced maintenance cost.

Yeah, I had the same feeling, TBH.

--=20
Trevi=C3=B1o's World - Life and Linux
http://www.3v1n0.net
