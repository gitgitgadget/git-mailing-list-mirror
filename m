Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5957C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjEGWBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEGWBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 18:01:45 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907559ECD
        for <git@vger.kernel.org>; Sun,  7 May 2023 15:01:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38dec65ab50so2185511b6e.2
        for <git@vger.kernel.org>; Sun, 07 May 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683496900; x=1686088900;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkxC7CdYBvBbvDi670c0UjPU09guPlXcTreQkU7AsOI=;
        b=dJRx2O1Zgad11q9NzoaPHcwFAe318ATHGXWWF8iIsCHWgMcBKKts86MzfwP9vkcv7e
         gfl1lGSNrc7UJPCFTWPXuXhHn57Z5YXJE6p5EzCpHu7rCNUUlw77qOt8p/BXPBfdRuDJ
         0CGYLwBrZuIOD3UC3mrDNAPlpRzGnIJ0cj3ajht3H4Vgxhq5vWMmxaeU1zmqfTRgChdn
         e1+lh1EQLcoYsUrtOvYW2Cgd3qG3OPlS48nQV/d71UPihfmNgkLXwokptTI8fx/TVNS9
         wD2tXFiaF0dSldNW8+Slyj6DRCSDMveosoevKl6CSiQjdlTwIq+K8wghUnspBGDVo3uB
         vPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683496900; x=1686088900;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkxC7CdYBvBbvDi670c0UjPU09guPlXcTreQkU7AsOI=;
        b=Qr78ExGeSD393zKj4WQprq/kpxQhUODv958TB8ifYMpMP6L64rF1UBsD+6V4HVoYFU
         n2d4+K1fxZEBXLHOxK8L7BOE+AnLCw9iduEoFoVCjHbHhYyhvdyvGgfgJSI/RSeAXZYc
         2kQJ2e32PAh+Tow4MUjt1fREPhrrYpbZo7BtS9zE3zfZhqhtioZvXCYm67TnGFJp9DVK
         sIepI82rlt+W+PBgl4oan4zKHynfs4hKyy+NXfrjxQT3YkbniIBuWhGeyA0z1tY+4uFe
         zi9JpSvdlOUOi3ZnRSL7eCsbLW+pd9G6xdjEfIDo+FOeZSnq77SfcL80aszinEOuIu65
         dA4w==
X-Gm-Message-State: AC+VfDy/1KNciB6nYFjSYITXMeDmGieugEY0s7K/6NmJp0EdJ6pe+IeH
        7Evs4sc73fiwXa8Wy23Pu7kbIiGtEWk=
X-Google-Smtp-Source: ACHHUZ5ZcNSvSzR0WdQCX2opWTh31ZfXtg1s8+E5+YamgtroVZBsKH6e2fT6993dHWl8HMvtRqC7iw==
X-Received: by 2002:a05:6808:645:b0:38e:2155:bb7c with SMTP id z5-20020a056808064500b0038e2155bb7cmr4282827oih.43.1683496900719;
        Sun, 07 May 2023 15:01:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m205-20020acabcd6000000b0038de993f3a6sm5266155oif.53.2023.05.07.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:01:40 -0700 (PDT)
Date:   Sun, 07 May 2023 16:01:39 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>, Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Message-ID: <64581fc358ede_4e6129442@chronos.notmuch>
In-Reply-To: <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz> wro=
te:

> > If we are comfortable changing the behavior of branch checkout to be
> > safe-and-limiting like switch, then that should be almost as simple a=
s
> > removing that condition.
> =

> I've never heard a dissenting vote against this

Here is my dissenting vote: I'm against this change.

If I want to use a high-level command meant for novices, I use `git switc=
h`. If
instead I simply want to switch to a different commit and I want git to s=
hut up
about it, then I use `git checkout`.

You want to strip away the options for experts, in search for what?

If there was a way of doing:

  git -c core.iknowwhatimdoing=3Dtrue checkout $whatever

Then I wouldn't oppose such change.

But this is not the proposal. The proposal is to break backwards compatib=
ility
for expert users with no way to retain the existing behavior.

Generally, breaking backwards compatibility for no reason is frowned upon=
.

-- =

Felipe Contreras=
