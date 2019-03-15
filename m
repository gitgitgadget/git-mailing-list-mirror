Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEFA20248
	for <e@80x24.org>; Fri, 15 Mar 2019 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCOITV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Mar 2019 04:19:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfCOITV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 04:19:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so8074335wre.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 01:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z2O6vVne1XhVQlfUx8e0lucvkAf4+ezPfx4aebokD+8=;
        b=bfz2qtO/m5nj3It80UVsnvQ36rkDbQivXGa5B4KSf5oYC6newrU1Y226F9MgjjRbAP
         TtGl8zL3lLpLkp3kOyIBsFVbyVpSzPxCaMnXiaqOkoqtdK7VPua/JhqiQHt3uyusToCD
         mDPAO9Xq3MYMQOfxFvzz1ZkB/N/WPc8B1m215xhW6dmXmwx2HvnNOsFFw7CM6sGAP6Av
         dUP2C9fTNvcpoQ7HEEKYxr1vc6dN0SgO/UsGcpZyVrgo6LQtcbBy5jMPE0cw1VqXCiYk
         VcuzpxB/nPOJynqoQu3m5EKqqmhVxlS5eqRj0hqgg1fxozCxLzcTuFe8O6aTBrESr45F
         IJ/w==
X-Gm-Message-State: APjAAAXEXG1NBQKI+6+piVlv9wX8mUsmoj76+7qd8uTY7DLeOsqP3zjD
        IsDxM8ILvdo1oMLTR/+f/SGdSfr6AU795g4fwS4=
X-Google-Smtp-Source: APXvYqzSMcVBBEIzPixNyAGa5kDl3OQY9/0aHNoZRxgrf1ASvOcmqjM+wpUP8Y19ZadCx6TBc24nLxm7KjJh3CgS3iI=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr1488797wrg.88.1552637959231;
 Fri, 15 Mar 2019 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-18-pclouds@gmail.com> <20190313183604.GA27503@esm>
In-Reply-To: <20190313183604.GA27503@esm>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Mar 2019 04:19:07 -0400
Message-ID: <CAPig+cQPMZhd-JSxD4Z6pL19qB1bFNu+EvPDh0vADpcaJ0tbqw@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 2:36 PM Eckhard Maaß
<eckhard.s.maass@googlemail.com> wrote:
> On Fri, Mar 08, 2019 at 04:57:48PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > Similar to automatic detach, this behavior could be confusing because
> > it can sometimes create a new branch without a user asking it to,
> > especially when the user is still not aware about this feature.
> >
> > In the future, perhaps we could have a config key to disable these
> > safety nets and let 'switch' do automatic detach or dwim
> > again. But that will be opt-in after the user knows what is what. For
> > now give a short option if you want to use it often.
>
> As I am late to the patch series (sorry!), has there been already any
> discussion on that? In my experience, people get confused with detached
> HEAD state quite often, whereas the automatic creation of a local branch
> is no problem.

This statement does a good job of articulating my (unspoken) response
to this patch. Whereas a detached HEAD might be scary and confusing to
newcomers, and difficult for them to recover from, automatic creation
of a DWIM'd local branch doesn't seem so problematic (if at all).

With git-checkout, it's very easy to accidentally get into a detached
HEAD state, so it makes some sense to protect newcomers, by default,
from that accident in git-switch. However, auto-creation of a new
local branch is not, for a couple reasons, nearly so weighty a matter.
First, in many cases it may be less likely to happen since it requires
presence of a corresponding remote tracking branch. Second, it's
intuitively easy to recover from it: when git-switch reports that it
created a new branch, though perhaps surprising, the user would
naturally know to look for a command to "delete a branch".

And, unlike a detached HEAD, which newcomers may mistakenly believe
lead to irretrievable loss of work, an unexpected branch creation
carries no such penalty, perceived or real.

> So if it is deemed to be too confusing to dwim in this
> case, could we add a hint suggesting the command? Something like:
> "No suitable branch <foo> found, however there is a remote tracking
> branch <origin/foo> that you can siwtch and create with `git switch
> --guess foo`" (or maybe the one without guess)?

That could be helpful if git-switch continues to make --no-guess the
default, but making --guess the default (as it is in git-checkout)
would likely be even better (for the reasons enumerated above).
