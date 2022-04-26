Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B5C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbiDZUaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354796AbiDZUaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:30:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8F5E75F
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:26:59 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a127so18579025vsa.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoVZsv50A10Tgt9QRLVyZcAyORU+tSEpxG2LCRR489k=;
        b=IyPdFwtWenf0lQzAC7BnqFlBDRZbc34GisOHOHJiA1F2Df4oF6+A57xqf8DupwERu6
         jmMwm7tBM67bkAVEehIPWF6sn/5cL2IyDOceaPR6fRtEQIl0bq40m9ghSVVEqGqJB8rJ
         P086bJPwaDWjbA2btg3JNa6/qOG178mRP52fTpIFgLpwgb9ek5n5/kdQ4ZOvqWH4PGAN
         Mw4MK3fDy3YWXJcjPRNbBmhtLn04FG2Y2hO5Rf82gw5pHZd2cKOHUnl7DOo7omgpatap
         Uj7/eZ7AbW9cGMwP55yWFAE6YPtUyLO1+JUJcC7PUmDVfuAq6+Zr5CEXmdTjbxcaGkkB
         1Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoVZsv50A10Tgt9QRLVyZcAyORU+tSEpxG2LCRR489k=;
        b=Z7AmwndYTqTOr0aAKrr6ojUllc6AR9PhKm7SkerLtZycvvQ9OsXftyL8KmUAVqhPM6
         L4bhqxdOQbmwkxQz5xSGCV3DClDMS+VU6tt+n2hv/C3jzO3mRROd42Vp4+qqw6iG1ZUD
         +ALYXjlt4Nf0QWRaag2zJ/c+yeM/NcEOcVJbEVZv9QHJ7KApbFLRfZXN3sySp0iNLPGL
         uGFOTw1V703yH9b91N47NBYPi/zFUf4k21QpGrLeoFQrrCyQP1V2WGTKcOU4Ezv/gqU6
         5CM6SO7WDHHa+VbINstMUQVBe7KeaqQB3s8iZg+oYjvbR+82GoRVMy2XqbNM8A3lcWXw
         2l8Q==
X-Gm-Message-State: AOAM532CgX5XJkZso5i7ZbMTcdptgQmSLQ7h3MhUZvQPtZ4X+Jh3+EXG
        cqZ0Fs5oYUE1iVDlsz2Gzv46Wh3b87jKq5SDf30=
X-Google-Smtp-Source: ABdhPJxC18lxsyO5Ea8XlTmkZViIbXnGT+UCYC1GMetrGqa4T6djKc+dKfgA1zrkx9yLTpbsy3Xcd7lh156NlppFtkg=
X-Received: by 2002:a05:6102:ed4:b0:32c:ea17:c6b5 with SMTP id
 m20-20020a0561020ed400b0032cea17c6b5mr1212309vst.52.1651004818896; Tue, 26
 Apr 2022 13:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
In-Reply-To: <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 13:26:48 -0700
Message-ID: <CAPUEspitAQrEjMpUyw8e2pyT1MT+h_dO5wSU0wWDWTqSye5TwA@mail.gmail.com>
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 12:48 PM Derrick Stolee
<derrickstolee@github.com> wrote:

> These points make sense. It would be worth taking our time and
> doing some refactoring in advance of this functional change.

Problem with taking our time or making it a bigger change is that
it is currently broken in the last maint versions so it would be ideal
to backport quickly there as a "regression".

> I wonder how we could test a multi-user scenario. The tests I
> added in e47363e5a (t0033: add tests for safe.directory, 2022-04-13)
> purposefully avoid the user-id functionality.

It would need to be a CI only test (where passwordless sudo is allowed)

> I imagine that something else could be added here to help Windows
> users who have elevated to administrator privileges. It will use a
> completely different mechanism, though, if needed at all. We can
> delay that for now.

Note this function is *NIX only, there is another one for Windows where
a similar fix (if needed) could be implemented

Carlo
