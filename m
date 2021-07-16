Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB61C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD6E613F1
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGPQ6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPQ6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:58:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932CBC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:55:57 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10475019otu.10
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pcixN7/UQ/+xdY3w/iv/zi3h8Yy/ERgaaiy5SviRO8E=;
        b=EBfAR2AIULAiYJ7f8lpfIIdKSUlBxibVu7NF+CHSDbhRVq8IXZxgK8cqvMfg8PG9tc
         /oI7zZqMAtxS9mQTl3ht3SzQ1GbSn73vYhYxcicPe3KE21ZGXHcod7TVAPmOG4LYDbYA
         vY0DCI0w3xHjrSJ7N3UA+1uowDx7JVJon+VMvp1X3S5Jf5JZDcGTo32Yw0wSd1VD2PnV
         FbcQn7sPFEi9ckTi1axOwEVTZyVg6MzfBVlP4ZvEoiA1YCGShRfE7kIQ+5hmM8hiqg8V
         ONqyNDIW4A+XUgSdZYj/7RajuIfAO9Ado3bfSyY4/hVIWQW3QVZdsG+kOZ3iBZ3mOqfT
         Gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pcixN7/UQ/+xdY3w/iv/zi3h8Yy/ERgaaiy5SviRO8E=;
        b=QYOzVEiaZPwabccEWct9HwxJw8nQyNRuWDPRcE+lBerOGBoolelemyRH59yL7xTahL
         NDmPvBlnQxh589Sy/ABeNyN2DvZQiYm3pf+rlasbcVDJWBtlGewucAQ6AO0y3q9jnImd
         DUpjQt6iFzLc50xf2uQitpS6ypyXRN8NdNM6LQ8rTvOvt08AneDQsoB3efmZ2BQz+2CO
         oStTAGELelS+kIHC0fl/MV5VEvhPKN4Y9aFdfElUu6wH698thHvkor08i8q5GylNDGfa
         Wa4XVjlqJHKja9/yDPPxlTa0AbPW17wUvmgz/t6wLjM9zOnYvxT36iP848viF1ehHCL6
         95pw==
X-Gm-Message-State: AOAM531tuWRauTZxaePYaZsmDkKDMA3nicyWDSO5b+7/MkMFSaxY/h/m
        BsjAXp3oMepoHtkCt8bD9JY=
X-Google-Smtp-Source: ABdhPJyNXBBfyRUI4zm7NFx+KV22PqEhy+0TTOX4/Kq574KVnThaDmFvwayeRmo2U2RNYy+cr2bA1g==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr8862301ots.358.1626454557023;
        Fri, 16 Jul 2021 09:55:57 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id p9sm1955687otl.64.2021.07.16.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:55:56 -0700 (PDT)
Date:   Fri, 16 Jul 2021 11:55:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60f1ba1b2deb2_ade92085e@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <87k0m9bpmv.fsf@evledraar.gmail.com>
 <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
 <87mtqq2i3r.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Tue, 13 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Tue, Jul 13 2021, Jeff Hostetler wrote:

> > > I prefer self-documenting code.
> >
> > Sure, I'm not saying daemonize() is an ideal name, just suggesting th=
at
> > you can both get uniqueness & self-documentation and not need to spli=
t
> > to multiple lines in some common cases to stay within the "We try to
> > keep to at most 80 characters per line" in CodingGuidelines in this
> > series.
> =

> While you are entitled to have your taste, I have to point out that Jef=
f
> is just as entitled to their taste, and I don't think that you can clai=
m
> that yours is better.
> =

> So I wonder what the intended outcome of this review is? To make the pa=
tch
> better? Or to pit taste against taste?

Unless you read minds you can't possibly know what the taste of other
people will be.

So you put forward what *you* think is better, and then find out if
others agree with your taste or not. If it turns out you are the only
one that thinks it's better, so be it.

For what it's worth, I agree with =C3=86var that daemonize() is better an=
d I
find your statement "I prefer self-documenting code" a) not an argument,
b) not a valid argument if we fill in the dots, and c) passively
aggressive.

Each one of us can only do one thing: express our opinion. What else can
we do?

Reviewers should not be chastised for expressing their opinion.

-- =

Felipe Contreras=
