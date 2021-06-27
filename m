Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68856C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB54613F3
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhF0EXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 00:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhF0EXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 00:23:37 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977FC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:21:14 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso2514238ooh.9
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ouLDFmJEkz9jnDYY6cDEyJUeGGXZrGtpGMe4+bc2fzw=;
        b=ZgmoUnOMRMT0xF6sgSwje3YkLBq6wh0J4W49mlhBd8ZVuX9c8y4DXU56l6B02ei1fW
         TUjzmV4hb39bcQ2Wm+B1MreVzMrstKCTyd1iIvVEuS8u55J17VbKFdmBiPNzMu4Fjnji
         aRas8aMfzIDMgk5V0g5SA7bxNrnfCrVwX7oarg4xrTAQy2ndfV1c1P0xL6gANVp5ErrB
         4D1L3bbI0sSh/t3oVu853TdkfK8e2iyTlWr55HGU40YTx48CIWZbV9g6POJO2Oz5Xr3D
         AJ454l/SbgCFndOwlsravSKM8XM6VvEmZsi8VbOgWSAfiUlnsh1x5J/i/VxX9bWu70KY
         +cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ouLDFmJEkz9jnDYY6cDEyJUeGGXZrGtpGMe4+bc2fzw=;
        b=aDGXPYL9vGKuOOzedobU7jZatt6rkKCyW+WMFUHNFVbYdWNLqIyhe7SsxFHZOGRstM
         6ejRd4Kxd3+4puI/pYadTzNV5oZ+Ej6hmbygEdN12tutmJpPr3TmUN2OyO7uauNd2wbR
         rBRveZrF8tziRP5EQTZe5DBA4ra2tO62+hIohI1Fmh99rRw8q/p01CJMGNfUCUO7lNmD
         i7pNA4B/a4UG2cC9f+GW9SP2ApIaE+L/8hqsAkVvACe9fKJCZ3lwQX3/KJQGjrt+THQL
         4CdotKN1NV4uUnQoDFkqKvFTN/S9ju0Hym3M6N2Y2N3P+s3fJNh79KoiSZvlv+d9/+oG
         Fqlg==
X-Gm-Message-State: AOAM532IyNYN2RyZaExT3EOexBH9LkcotHE0Xp9EdJ+WjZY/p/xWEadH
        nYiw1p+86uEZ35GN/nF4Neg=
X-Google-Smtp-Source: ABdhPJzB7mi+X9uUzFp66zBbCxp/+iJGgh2eo6pJn3CmRFMuLcZhJj42QaNNvhHVsmhmQcaqjEkibQ==
X-Received: by 2002:a4a:b5c4:: with SMTP id u4mr14894312ooo.18.1624767673546;
        Sat, 26 Jun 2021 21:21:13 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w5sm2276621oiv.7.2021.06.26.21.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 21:21:12 -0700 (PDT)
Date:   Sat, 26 Jun 2021 23:21:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d7fcb7d229e_b8dfe2089f@natae.notmuch>
In-Reply-To: <CAMMLpeSa=Shw3Y5=D9VZhRFJb922ZJD5L=X=eqGZFRkrDJG7dw@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <60d289c84fadf_312208dc@natae.notmuch>
 <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
 <60d37b3b77aeb_378720834@natae.notmuch>
 <CAMMLpeTQjw0W8ZTegPru_9muRBGj7RDfk3WgEEN34vm-PG9Jfg@mail.gmail.com>
 <60d41e6464a6c_3d32208a7@natae.notmuch>
 <CAMMLpeSa=Shw3Y5=D9VZhRFJb922ZJD5L=X=eqGZFRkrDJG7dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Wed, Jun 23, 2021 at 11:55 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Alex Henrie wrote:
> > > On Wed, Jun 23, 2021 at 12:19 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > >
> > > > Similarly, until "git pull" does something sensible by default (which
> > > > isn't the case now), these debates will continue, and there's value in
> > > > them.
> > >
> > > At this point, I'm inclined to push for s/advise/die/ in pull.c in the
> > > next release, without a transitional period, just to end the argument
> > > over how to best explain the current awkward situation. (I'm sure
> > > there will be more arguments after that, but hopefully they won't be
> > > as tiresome.)
> >
> > Give it a try. You will inevitably stumble upon all the problems I
> > already fixed.
> 
> Patch sent.

I sent a bunch of comments to the approach you sent. I think that's not
all the issues, but it's been a while since the last time I took a good
look at this, I feel I'm still missing one issue.

> > In the meantime what's the problem with v2?
> 
> I think that setting pull.rebase on a per-repository basis (instead of
> globally or per-invocation) makes for the easiest workflow in the
> majority of cases, so I would prefer to continue to recommend that to
> users primarily, but I don't have a strong opinion.

OK. What happens if you don't have the configuration in the particular
repository you are using?

-- 
Felipe Contreras
