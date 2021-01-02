Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D5C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B68620798
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhABW1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbhABW1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 17:27:09 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50262C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 14:26:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l207so27799402oib.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8sm1TM1JMfj7cAvqqw8Bl1+ZRMqNlVcGBckJfay2r3s=;
        b=OAHB8QGAZ2//2I/on09e8YElxSEK8b2q4g67DP48yQuG1Zfg6YZRCvmUHUmXQuhFdG
         wR1DVZWxDAk0hkXxeE+Txde5HhihszD5Pk0o/wvPDIRZMq27N2usviJLGjnqW4r/yr/x
         exWYhOFEdavL/zdcPPlPvGJFv97uWwvWz4jkNvJsy6q6QNvgWHW45c5/14RBPwzqGA83
         Znry309NT/tq9P2HlR3ZRM06bvSb8z4+7mXK3QY3tPLc991Lxk2NSg+ld4H3++2KFs18
         30RFDncWHf6IgvvCkmjqiijPJy8nG3Q6dSsS9djqolmRuyb04vK5hNhZZooQnoH4QHw0
         cibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8sm1TM1JMfj7cAvqqw8Bl1+ZRMqNlVcGBckJfay2r3s=;
        b=fJaoFBiERYru2DldjOA1P64+zsCgrDVmobKTzoRiE+dCTCCrnzqHN2Wpg7FK5KBn5o
         kk3y7py1LrJfaZe9YXDW4zADtP1mo5NWS5mEOEL2X+a8bUKvHqn5hRpGFOvws4CXcGhx
         DG9GqS+lCJCUtzYqEOPt1Psmh++AD8g40t6x1cmcWx+GLUxXajCuGM6glIa2Dof0zBWt
         B+geP4RYC8wD+aN4NgXTnc9+3jHeyxNmHi3Fz+eBpD4yPBIWh6M0SeDBVy4Wad4J+fct
         8fcklV18NmndgulN4DQY2pM4FeTeTfAU5/HF+7T2+5o1bewoTN9DZ5WckEFqLzmZBkiD
         5Ktg==
X-Gm-Message-State: AOAM531BKyVMIj8x9kkEOnUh43DRqy7Fwh55BLRjpzweFMAtOmhKiSK9
        tF5I4qVklbyoQIgkl6ju7BU=
X-Google-Smtp-Source: ABdhPJxyHiXzHI6ZqOcHcxjyPmj8vVjVCcRzrNBQD18jUv33XXYMx+OqaIFbopa880GlV8AgxZvxIw==
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr14146974oij.132.1609626388759;
        Sat, 02 Jan 2021 14:26:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l21sm13396289otd.0.2021.01.02.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 14:26:28 -0800 (PST)
Date:   Sat, 02 Jan 2021 16:26:27 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Message-ID: <5ff0f31315732_a76d20833@natae.notmuch>
In-Reply-To: <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com>
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
 <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix some typos
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Sat, 2 Jan 2021 at 18:43, Thomas Ackermann via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> =

> [Snip several typo fixes in Documentation/, all of which I agree with.]=

> =

> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsyste=
ms/CMakeLists.txt
> > index c151dd7257f..8f77baa678f 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> =

> Hmm... This does not match the "doc:" prefix of the patch.
> =

> > @@ -442,7 +442,7 @@ endif()
> >  check_c_source_compiles("
> >  #include <regex.h>
> >  #ifndef REG_STARTEND
> > -#error oops we dont have it
> > +#error oops we don't have it
> >  #endif
> =

> I don't think this is correct. This omission of the single quote someho=
w
> looks like it's done on purpose. I don't build using this system, but I=

> tried making some silly code like this in another file, which I actuall=
y
> do use:
> =

> #if 0
> #error might or mightn't work
> #endif

But this works:

#error "might or mightn't work"

-- =

Felipe Contreras=
