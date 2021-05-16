Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580ABC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E4F61152
	for <git@archiver.kernel.org>; Sun, 16 May 2021 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhEPSwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhEPSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 14:52:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D7C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 11:51:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so3777908otg.2
        for <git@vger.kernel.org>; Sun, 16 May 2021 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Hq3dFBT3ptrN9alsYzDH9lu5+yu/CfKILUiCXvRfc3o=;
        b=bfPOZ5Zxodi0AyMOch3gcb38+iCR5WaguhgpasaAvJGfyKFRxC8dR7IMIP9JmapDGu
         r7+cHCoif1JgZ/tMLMDAYS5+fdplaEVtPdsSLTCHpsFGNoj4a3nSgVJ5fb4wH9hp9s12
         X3lJXBRBXJj2f70xGKJBN5mRtW3vc18CqS2QRzfXF9SCI2xxlJDriwKub5E0E2+8UxZ5
         cEqx9M5z4vpN1ObZ/3tuDlygnlAb8mXBP7mhwxd1ggCVMlI0/XeyxQjrsjv7ERxcPOZr
         8MaaduK5dRCTK50RyqXPZmRgjgWtNxpTzd28zMcVdO738BUjKFje/GI3Nax8ron4v5tR
         qCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Hq3dFBT3ptrN9alsYzDH9lu5+yu/CfKILUiCXvRfc3o=;
        b=HzwlV+fhDwUASqcHnJuqdWqNuSe1phoi1SRhpd2oHDLGkVTyjV6B29EB75Jwa7KWcy
         AX7TLt16rvFsIbY3WxyjlgROcPlXzLPNPUN1RG0rAZ1XHaTVnl3jqKKlFYJLdxo3SIb1
         hBWQQZYfsgyOFy4tZ6VMSQsl09Yq7mIcyBFb8hnTyPxhNgyNrw6oc11q5CrCw35twwpP
         lRaP934BjdxsJFxGr6HrDDBMBtrcHhKEbnVZik1oDGxYF/t7sZomSvv4Xtoh9bKk49Qb
         Px8YaBatwTLW8GIkIhqDl9l9T2RyKhJEAsqIFi/m971XpMtGxslJ90Wt/7X3FC4uGWvX
         E4TA==
X-Gm-Message-State: AOAM530hBm0WreT8NSj9twiW6RhT92Qrdow1iiTNqjPqIZdEQ4c2pkdt
        goFIDbu0z5Y/aWgyPPmeqvc=
X-Google-Smtp-Source: ABdhPJwNl4quAkFgAfLCHCTEcU++ASOTrLs5MA7OKrSs6NcKALSuvwe701+djVsOq9oOjnhXygWYxQ==
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr49199134otc.206.1621191072535;
        Sun, 16 May 2021 11:51:12 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o20sm2617383oos.19.2021.05.16.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 11:51:12 -0700 (PDT)
Date:   Sun, 16 May 2021 13:51:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?QW5kZXJzIEjDtmNrZXJzdGVuIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?QW5kZXJzIEjDtmNrZXJzdGVu?= <anders@hockersten.se>
Message-ID: <60a1699eedcd4_109fc7208e1@natae.notmuch>
In-Reply-To: <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 16/05/21 14.32, Anders H=C3=B6ckersten via GitGitGadget wrote:
> > @@ -139,8 +140,11 @@ at the end.
> >   =

> >   The number of additional commits is the number
> >   of commits which would be displayed by "git log v1.0.4..parent".
> > -The hash suffix is "-g" + unambiguous abbreviation for the tip commi=
t
> > -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
> > +The hash suffix is "-g" + an unambigous abbreviation for the tip com=
mit
> > +of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). Th=
e
> > +length of the abbreviation scales as the repository grows, using the=

> > +approximate number of objects in the repository and a bit of math
> > +around the birthday paradox, and defaults to a minimum of 7.
> =

> What is the birthday paradox then?

It's a probability fact that goes against common sense. In a romm with 23=

people you are 50% likely to find two people with the same birthday.

https://en.wikipedia.org/wiki/Birthday_problem

-- =

Felipe Contreras=
