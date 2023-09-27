Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23435E80A93
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 06:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjI0GO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjI0GOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 02:14:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2579C
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:14:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50433d8385cso15934835e87.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695795291; x=1696400091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR2hwIajzkPsFApwXfeNP69CGcZon48bFWfPU+oi4RQ=;
        b=LrBanE3KoTGV8HkHw81dbg05Jg9NZkvMTb9t23s8Qia8k8XBx+ShpYd5n21/kvweAi
         QIoFyywKFuQxr8AFYtClhsAweuiwZWvYYFLtRP03M24Dqqq4wOh1JfNXqTFDBGE5fQPe
         C6BivQqtTRp6Z41jkfkv8Mz8fK8y5IFHTZyINPxyEvtlwJq6XRQFeUPSJdNhHRXH2P7E
         v++2wz8pWBJEKr2veCR9pOPAu+ppbC4FVgaJd7Ay0Hhggg5l5ZbcenUZTk0TB+ZZ3F5l
         7P/TrGExelfKY9sHeEBFJIDrPC7CQl9NGLt+l+Upk4th2kHoJ4SvaxV8iKsL3OUHW7Ux
         dkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795291; x=1696400091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR2hwIajzkPsFApwXfeNP69CGcZon48bFWfPU+oi4RQ=;
        b=cyHZKQCu7OQ7QQtBcKA1+/SgA0WPPSXlHNhO24rK0WcZAfkJUcHAYB+4us2+Ohx/7U
         ixd5A4ECc7FNbFnkXIBbeUUlTvKpO0O27zFKql187Up1yRnu1Cr8kKmsCv1fNXn9zQSH
         sXGfUKQ2OYuqLQyLdOEqKemn8SgSRS3V1txs/L5VpRK8U7sKjZwTgGIzxg7hqxwb8NbW
         FYzfuHSfds8gckd1oTMyH+t9nXsGQdS4IWTxX1f3PlU0gg/fB50Chk6ZRIQ2KJGqRMRW
         dLNEyz32QyxI1qt+HE5WS71Giq9ndfsJYajGi7spSmQOiqHT6GtzyEW29v+Nyi58Th5y
         z8jA==
X-Gm-Message-State: AOJu0Yy4oHJjF1tqTVpb0gmQ1MvLSMK9bxFbn9Gv2PnORoAuI4IkKhg4
        LJQ6za6aYtEmXslbYojifQXtpYDUcSHUaxsk3lI=
X-Google-Smtp-Source: AGHT+IGffnzigFzp3+O1VrANvPAtqwPIXS0mLwHDGcksNzzXoX7ZgfHdo3Ql3xpYvmOWWDymk39rgkp90d8wX6uNKV8=
X-Received: by 2002:a19:650c:0:b0:502:adbb:f9db with SMTP id
 z12-20020a19650c000000b00502adbbf9dbmr832399lfb.65.1695795290794; Tue, 26 Sep
 2023 23:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
 <CAJoAoZmC-Ku80aSp5xkxfirJitoi_ai6ryK3cJ7Jkx_2fUjENw@mail.gmail.com>
In-Reply-To: <CAJoAoZmC-Ku80aSp5xkxfirJitoi_ai6ryK3cJ7Jkx_2fUjENw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 08:14:39 +0200
Message-ID: <CAP8UFD1gdLG2VMH2fkPQAajw17qz-FuVatiKrguh70e2VYEWAQ@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, Sep 27, 2023 at 12:23=E2=80=AFAM Emily Shaffer <nasamuffin@google.c=
om> wrote:
>
> On Tue, Sep 26, 2023 at 7:48=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi everyone, especially Shuqi and Kousik,
> >
> > September 29 is the deadline for proposing Outreachy projects. As we
> > have at least one mentor for now (me), we should propose at least one
> > project though.
> >
> > All ideas for projects are welcome, don't hesitate to suggest one!
>
> It is probably premature for this cycle. But once we have unit testing
> framework[1] in, I expect that moving tests from t/helper/test-foo.c +
> a sh test to invoke test-foo over to using the unit testing framework
> could be a tidy project for GSOC/Outreachy. Especially if we can have
> an example migration to refer to, which Siddharth from Google is
> working on in his 20% time just now :)
>
> 1: https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/

Thanks for the great idea! I am going to propose this as the coding
part of Outreachy should start only in December and I think there are
good chances that the unit test framework will be merged by then. In
case everything is not ready when Outreachy starts, I think we will
probably find other unit tests or libification related work that the
intern can do.

For example, I recently thought about converting commands that store
config info in global variables and use old config functions like
git_config_(int|bool|string|...) to instead use the git_config_get_*()
functions and no more global variables. I wanted to ask about it
today, but I think your suggestion would be better.

Thanks,
Christian.
