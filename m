Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B48C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C240C61107
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhIUQd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIUQdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:33:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FEFC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:32:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 134so4361584iou.12
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E5XZKFUdOrIQlyPIVFUMMSSP5I3eiV14Q8Wv0x4VDY4=;
        b=hYhA9lAOt60/jzAvSeIZBaxcqw6GaoWOm+KVNpGUKzlPkCkP+iBj0OVEbaatjJB2NH
         lS2d+QD74ZhM7ndV80WL1zucJP9Hu+ywfGOBRdQhvjFDQhM/JCVprqT+uB6ktm/iZ35q
         8NS4hjFVEQC4zLSu5SBo+tNuak3+DUFZKA5vN01A5NeOLVIVc7/hI4FP3/+iZvJO85ug
         aHbq96u93BW+R74RWyIsGQbyrFyxWtu6f+OROdutAL1k079yTJAvwsYKHpRB4JGXY/oA
         gBJc1zzOTwk998Is+wqoqnyi0X8qZfYhJe/i8zfjaC0VN9jcBR49dgrMq2ga4EPoTV7R
         PVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E5XZKFUdOrIQlyPIVFUMMSSP5I3eiV14Q8Wv0x4VDY4=;
        b=7M0AyAqZeqN+C5EU2HZKJ5FXZ54mS8ijW+rwXyQdrIV4QlavDSSKjSjMZeoDOVD91r
         WTgx/C7rEc0V150erssTbPOc7ghXFshTsgBSl1XZJlTe0+luuQ+yRpARNIKBbHlVwSWE
         pBe15h36IATovH+sVCYAT2eQBhNsSmHzMsfK9rdPCDkp2gcDc1+2Wk+RZhwJO2lFyNmz
         ZDJmHh5sCpkVCGz6ssqiE+/fcaia3DqdBVGbc0JfKtKdbRoniAceoBdmWB1t14i6cflA
         RHJoqZ56nLMDtoeeF6+PK+pn/Qa4qprAasRzJTXLg3BJDAIlHPOEidJ06oMG1ATQKPaa
         vT2A==
X-Gm-Message-State: AOAM5311eUolSH3x8oxW4OeZSbhgx34WMv41bQ1tQFt2lRTME6hnHwKs
        uA515LSMuAwVAHMtx9UvZjED+ao6AioQZg==
X-Google-Smtp-Source: ABdhPJwM7Ip8AHRjp3V0PUt6hmf5TO0OurEIR/J2yYLDtyR5jN4uLEg+4BnAshMVXBAXOOd0VO1URw==
X-Received: by 2002:a5e:d513:: with SMTP id e19mr723030iom.82.1632241946630;
        Tue, 21 Sep 2021 09:32:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a11sm11026952ilm.36.2021.09.21.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:32:26 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:32:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUoJGV0wj0ba7n8X@nand.local>
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
 <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 08:55:01AM -0400, Derrick Stolee wrote:
> On 9/20/2021 5:20 PM, Taylor Blau wrote:
> > On Mon, Sep 20, 2021 at 04:56:47PM -0400, Derrick Stolee wrote:
> >>>> I double-checked this to see how to fix this, and the 'list' subcommand
> >>>> already notices that the patterns are not in cone mode and reverts its
> >>>> behavior to writing all of the sparse-checkout file to stdout. It also
> >>>> writes warnings over stderr before that.
> >>>>
> >>>> There might not be anything pressing to do here.
> >>>
> >>> Hmm. I think we'd probably want the same behavior for init and any other
> >>> commands which could potentially overwrite the contents of the
> >>> sparse-checkout file.
> >>
> >> Could you elaborate on what you mean by "the same behavior"?
> >>
> >> Do you mean that "git sparse-checkout add X" should act as if cone mode
> >> is not enabled if the existing patterns are not cone-mode patterns?
> >>
> >> What exactly do you mean about "init" changing behavior here?
> >
> > No, I was referring to your suggestion from [1] to add a warning from
> > "git sparse-checkout init --cone" when there are existing patterns which
> > are not in cone-mode.
>
> This warning is part of the sparse-checkout pattern parsing logic, so
> it happens whenever the patterns are loaded, including the "list"
> subcommand (among other commands, not just the sparse-checkout builtin).

I might be misunderstanding what you're saying. But what I'm wondering
is: if we detect when existing patterns aren't in cone-mode, why didn't
we catch that case originally when the memory leak was discovered?

I thought that it might have been related to your third patch to change
how bad patterns are detected. But I ran the following script after
applying each of your three patches individually:

    rm -fr repo
    git init repo
    cd repo

    git sparse-checkout init
    git sparse-checkout add foo
    git sparse-checkout init --cone
    git sparse-checkout add foo

and the only difference is that we started silently dropping the bad
"foo" pattern after re-adding foo in cone-mode starting with the second
patch.

I guess my question is: it seems like there may be a friendlier way to
tell the user that we're about to drop their sparse-checkout definition
instead of just doing it silently. And it seems like you're saying that
we already have something that detects that and is used everywhere. But
I wonder why it wasn't kicking in in the original report.

Thanks,
Taylor
