Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC0C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8202D64E02
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhBDQQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:16:17 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44670 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhBDQO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 11:14:56 -0500
Received: by mail-ed1-f43.google.com with SMTP id q2so1723308eds.11
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 08:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0oWINXk/qSQf0ODuYkRl4iIekQ3x/lpryM71aFqOAk=;
        b=lpkLgU4eYs8wBL4rSRte60YyDDF6+XxY5iTBOfZOo7XQApsR6a7MJHfx9TOhPG37zr
         VWnVRQUMMk1S722fIxzyeh1OVsBuZSuH2CPDeNUiiRqjpMtUxnN6IEkbCtCmbKRTR84x
         /wWMMDfvOhE/u/QgYuzg4S3pHv3xiuzTNJlNj8Le6QywHL0jKtD70xwGM7jHyleD01Ve
         nyLiX1ugiX7/Jrv7Sn2IyEAlDr5mHJWXY1Jn8THSIypGshwIy4VXrhwh4wztRyiZSWdf
         7/KXEN/ZKvyvsYkYvhp/Zvae4guDm4lTayS4GSeYsq6A4jiXmhM9w0xLxiNVcLDpeEq3
         Mjyg==
X-Gm-Message-State: AOAM5334f0fujjeVM4yBW/f5jm20YhobJvxqe5uXx5usKLbPm9C0mEgu
        6lYQVXmeVGuZ0vkqGrpEAbMYOX/VvkM6XnvMKGE=
X-Google-Smtp-Source: ABdhPJzzICCcBMHIMkcVUKyAo5YFhD/QiP2E3hweRe4lK1Vryjq0HSO3TJ1rV5m7wYArCMxnWojT4+xWOpp/sgpp5DQ=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr8572146edz.89.1612455253958;
 Thu, 04 Feb 2021 08:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
 <54d1ef0f-6a50-b2cb-3ac6-c313cf9dd2f3@gmail.com>
In-Reply-To: <54d1ef0f-6a50-b2cb-3ac6-c313cf9dd2f3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Feb 2021 11:14:02 -0500
Message-ID: <CAPig+cRt3+CfGVKMTroCsLMLM+LxhM7ioLV=2-AAMU9MGzquaA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 4, 2021 at 5:47 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 02/02/2021 02:01, Eric Sunshine wrote:
> > Are the timestamps of these commits meaningful in this context?
>
> I think we want to ensure that the timestamp of the commits created with
> the different author are different from the previous commits. We ought
> to be checking that the author date of the rebased commit matches the
> author date of the original commit and not the author date of the fixup
> commit created with the different author.

Such date-checking would indeed make sense and would remove any
potential confusion a reader might have concerning the manual
test_tick() calls. (It's not super important, but I still lean toward
dropping the test_tick() calls until they are actually needed simply
to avoid confusing readers. I asked about it in my review since their
purpose was unclear and I was genuinely wondering if I was overlooking
the reason for their presence. Future readers of the code may
experience the same puzzlement without necessarily having ready access
to the original author of the code from whom to receive an answer.)
