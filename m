Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0545C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96995613D2
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFKSMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFKSMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 14:12:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01048C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 11:10:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so3975820otr.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+gRWyMATk4yUDwYOeowYgA7ucsSyq6kSdaAgWbLKQgM=;
        b=Gj26ySDb93SkM38BFvMWeamgw50FlZAXUyphAB0NiFPWevG3NQm6Nm8c+Lp9aAV+Wi
         +gx+RBrrCupoziFWLsbX2vbsGZBhNlv65Hic9kBmsfBaoxpqYiSNnT09srefp2d9vXUt
         RfzOxkuB+lL7PJG4UucrGCb+CITXW4wGsflYg4s3pAg0K5RvmkOWNhEN6sFHAnAD50zK
         F0Ribuv108g2kYr7q1p6EDhbT7bTGAeCwO0WKrlLrLQNlOTrKV4hlScUtcrWk2dWkyPt
         wmYVMCYKbEhlIqnXV371HQ5GZXxiZ6cBNzUmTQzJ35uPjlh4T8MphET8GuXSl2SnC5mf
         k/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+gRWyMATk4yUDwYOeowYgA7ucsSyq6kSdaAgWbLKQgM=;
        b=UfskElnVucwj8tKyHcF0NJcgjKO/iTrNC4bKYps3ZFiybvRk9wOhjBqe5lqDUvWpfz
         wngvDRtO5MbyAHuHy3ftkEq1P9zj065lvXit2Qc4V5JnVn+j23V2zGGPBSAWv15zu8JR
         Q6ke9g0kww1z6BczcHFyP5dRQCiNFXECLVFrgfrNMIAlMR3kCS8wlwSvULkj42CUlesp
         uvVUlJ5AwnvxEyKLmARA1oGOLamWzbtxOWQN4m/UcTf1mrSCaXMAL6IUBrW7F/718rQn
         PNxnLIamII5b9aZsdLr3BSimZ8/lgq+jokdFbsVyZ7wSpuVBSr3A/ZIyclfZCFRIkHr1
         SD7g==
X-Gm-Message-State: AOAM531jnz2qkzr3/MDbLOt9GJRSJKa6zj1EfOotYUnCy7pXykXuPZU4
        2mtV0RyMPsOP2bzO9Fyn6I4=
X-Google-Smtp-Source: ABdhPJzaF2BmQ2IimB6TmNlne+Hj7kADFvRhyIex6nXpp+ep6UDAIFsbR2XK3Ut8C4U5ammrDAp19w==
X-Received: by 2002:a9d:7cc4:: with SMTP id r4mr3935336otn.160.1623435015284;
        Fri, 11 Jun 2021 11:10:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z4sm1467403otq.48.2021.06.11.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:10:14 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:10:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c3a7058af24_8d0f20833@natae.notmuch>
In-Reply-To: <87bl8ce1ug.fsf@osv.gnss.ru>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
 <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
 <60c39bb3b5cc4_8d0f20817@natae.notmuch>
 <87bl8ce1ug.fsf@osv.gnss.ru>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Johannes Sixt wrote:
> >> then diff3 must display the conflict as
> >> 
> >>  12<ABC|34=AXC>56
> >> 
> >> to be technically correct. RCS style can coalesce A and C outside of the
> >> conflict and display it as
> >> 
> >>  12A<B=X>C34
> >> 
> >> and *that* is the helpful part of this simpler style.
> >
> > I have trouble translating the above to what I'm familiar with in my
> > mind, so...
> >
> > diff2:
> >
> >   1
> >   2
> >   A
> >   <<<<<<< l
> >   B
> >   =======
> >   X
> >   >>>>>>> r
> >   C
> >   5
> >   6
> >
> > diff3:
> >
> >   1
> >   2
> >   <<<<<<< l
> >   A
> >   B
> >   C
> >   ||||||| b
> >   3
> >   4
> >   =======
> >   A
> >   X
> >   C
> >   >>>>>>> r
> >   5
> >   6
> >
> > I personally don't mind at all having a few extra lines in order to
> > visualize what actually happened.
> 
> Plus a good tool should have an option to quickly show a diff between any
> 2 of 3 parts, making analysis even simpler.

Indeed, it depends on the mergetool, but personally I use vimdiff3
(which I authored). All I need are diff3 conflict markers plus some
colors.

> > But of course there's zdiff3:
> >
> >   1
> >   2
> >   A
> >   <<<<<<< l
> >   B
> >   ||||||| b
> >   3
> >   4
> >   =======
> >   X
> >   >>>>>>> r
> >   C
> >   5
> >   6
> >
> > Which is the best of both worlds, even if not technically accurate.
> 
> Yeah, now I see, thank you both for explanations!
> 
> That said, to me it seems that for any of 3 formats one can find a case
> where it's better than the other 2. I'm sure I got a few occasions where
> leaving common part(s) out of conflicts resulted in a confusion and
> mis-merge.

Yes, and I found it curious that all this sprang up from my suggestion
to get out of our comfort zones.

Since I don't have my beloved `g mt` alias, I've been forced to do
`g mergetool --tool=gvimdiff3`, once there, I decided to use gvimdiff2 a
couple of times, and I even gave meld a try.

Now, I didn't dare to remove merge.conflictstyle from my config, but if
I did, I would I have immediately noticed that:

  git merge --<tab>

There's nothing to easily switch conflict styles.

Seems like there's many areas of opportunity.

Cheers.

-- 
Felipe Contreras
