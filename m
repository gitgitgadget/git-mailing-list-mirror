Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EFC2D0C6
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A908214D8
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbfLKQC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:02:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39605 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbfLKQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 11:02:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id d5so6003030wmb.4
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 08:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOyzHQoirO7PSMbJkGONyGAIZBe3KHAhPizMpDuO3gk=;
        b=GgZBaT2wopgpZEvTo7rfeRYsZ5Q8R91gBOXppMPyAE69CCHmzXMRDjbusM1+ABcEBi
         gFnxFAp0q7rQdrCaF9Cb+7cemgLaY0ypiPwwAB94CgNnFTJr0AatgCiKd8drxw2D2Eqn
         kz4B73iDaUPS4Q0ERhJVkbsIYmHprpajVagRBUaYCA4WQf5z1il+iDgQicaeHLrfLRs6
         o08cH4PqMHP/Rs6fTMl+vTQVBWTd+V1TgXSrZAoiE98XNZsp6Mj255vpctwCGMhj1HQ+
         PQ1oih/jbKH9k/ZUakMXhVfFKpzN/xoUMlEMnX1nqEY1D5Y/MFTn+ePfELeEy8GTR0gg
         09ag==
X-Gm-Message-State: APjAAAVEW19+32twVL5GH2RMecIIo2z5058tz2v0fXTdLSNCZVamGpw1
        761wZMMW+KVMBHfOW5cVwRAjaEHTcVpIDMNo2qU=
X-Google-Smtp-Source: APXvYqwGW4D9MUFnTIFBxPnP3WRNtwATm5MVUZtUCUBoQMZesdIgNBjI2xYlMdaWfdh4koxM7sqKvueuLcAxZykb8HQ=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr539262wmj.75.1576080172986;
 Wed, 11 Dec 2019 08:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20191205235704.31385-1-alext9@gmail.com> <20191209145312.3251-1-alext9@gmail.com>
 <20191209145312.3251-2-alext9@gmail.com> <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
 <20191211122136.GA46399@generichostname>
In-Reply-To: <20191211122136.GA46399@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Dec 2019 11:02:41 -0500
Message-ID: <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rebase: fix --fork-point with short refname
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Alex Torok <alext9@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 7:20 AM Denton Liu <liu.denton@gmail.com> wrote:
> > +test_expect_success "git rebase --fork-point with ambigous refname" "
> > +     git checkout master &&
> > +     git checkout -b one &&
> > +     git checkout side &&
> > +     git tag one &&
> > +     test_must_fail git rebase --fork-point --onto D one
> > +"
>
> nit: use double-quotes instead of single-quotes to surround both the
> test case name and the actual code itself.

Denton meant to say that you should single-quote the test title and
test body (not double-quote). In this particular test, the distinction
doesn't matter presently, though it could matter if the test is later
changed. In particular, if the test does any sort of variable
interpolation (such as $foo), then the single quotes ensure that the
interpolation will occur when the test is actually run (which is
almost always what is desired) rather than at the time the test is
defined (which is almost never wanted).
