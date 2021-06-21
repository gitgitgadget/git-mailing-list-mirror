Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA9C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C076124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFUSx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFUSx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:53:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:51:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so18701166oth.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ajKpq2VQRpRdcWKjrT1qnYtU7TD4dIgOBWi2UNx3Fm0=;
        b=EPSYORVho04ENHChBSlrpoeTrcATt+T47zc8qz4HV7MvWfP9v6728BIvdMDGUE1Zws
         fHpb8ujNC023BC7TFbbkamDmEQPLyg3jz5ztKTiczPKdA+iZKYwhUBBFQSuOqL9/8PAE
         v8QHz8vjlpU0IwgpvUAwGkAYbzxYDfweVIrPAq5Jb3svFSZEQ6KSYud1xkIwmHTxfwfo
         JvR4mWzV7hNBURk9MeJBNxBOvMpR9eW67BIj2U4Su//bufNduC1hr+5htchr9HM9hBBh
         e/6JVxS1D5VNrNucXeqdZVAV8JZ0pr/caAWYxqTHVEum4zPUv0vYKH2U7FVg5XwwGZD2
         OlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ajKpq2VQRpRdcWKjrT1qnYtU7TD4dIgOBWi2UNx3Fm0=;
        b=BITleeZZ2fj1v0TjKguwcT4jK1ABc0cRiHA0SCJOD+iSoM+HQEUsRT7eqELgB/QfIO
         tmYivnG4zohQkUZ+DlUqcdGQSNapMSmHdeFnza4FFPu+LNhPBdM/f/q+M8m4HsY0+0pP
         0eLYzCXkFMKVPHg5bOKrtumysRXr0N6pbgmRF+nlCRi0MvPHT/+pM3EvtlHaQs4R/HkW
         9DhPP5I4emNRBM4/tIo7VdOgbVElkgsfeM3X1YrtgXRL5fAbQBavO4ULPiDBtsCoGmMt
         rGwJYcXNW9b6mQLkH35awDyQeesl4TswkorEO9aviaunXbFxrWzUJQMPKMD9isE5CtkT
         Q08A==
X-Gm-Message-State: AOAM531LFYCweEDdyaNUYDKuTRrjkLKYs4/4lpM9nyBlaadwPwX/NuZq
        Qc6a2TKpLLUCCOuZBL7JbIk=
X-Google-Smtp-Source: ABdhPJwMo/0BcU+mmGk/5wC+e/fI5gF3FJ2Ssxl0Yp2EqCjgxJhjYIbpLyFphIjwTBNPdyMt6svANA==
X-Received: by 2002:a9d:674b:: with SMTP id w11mr14670310otm.260.1624301472491;
        Mon, 21 Jun 2021 11:51:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o20sm2901701ook.40.2021.06.21.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:51:12 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:51:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d0df99d91e1_108e902085e@natae.notmuch>
In-Reply-To: <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Mon, Jun 21, 2021 at 11:52 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > +                "If unsure, run \"git pull --no-rebase\".\n"
> 
> I don't think the message should recommend merging over rebasing;

This is the default strategy.

Doing `git pull` is the same as doing `git pull --no-rebase`, except
with the warning.

> The eventual goal is to get rid of the default here and make the user
> make an educated choice, which does imply some work on the user's
> part, but it avoids the massive headaches created by users merging
> without understanding what they're doing.

Indeed, but any minute change in git's UI is a gargantuan task that
takes several years--or even decades--to accomplish, if it ever happens.
I started this patch in 2013, and here we are.

This patch series is not attempting to do the impossible.

Cheers.

-- 
Felipe Contreras
