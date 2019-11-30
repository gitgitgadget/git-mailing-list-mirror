Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE2C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73FD20732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 11:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfK3LbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 06:31:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50510 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfK3LbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 06:31:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so16564069wmh.0
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 03:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVhFxjj28b6jMNglE8VnK/7cPmnAKlMrl7c+zC890EU=;
        b=or1kbtnYcOHAPAvnNXMHVOXDefzDUBjOaEZaSY/CuSWOtAa1nE3Ptj28DcyyRgvZqK
         vuYV+PT/6rEnpriUpZuXY1ksPU/Yk9K81tL1LiJTYKiPujVD0GwNtwiUdwJ2NQrKBnOH
         xDAFM1jE0lbucze3xioSKXA8oW+lAHTozDA+WhT7sRWraFTO4xZriVDMspPjMVTWbhh3
         LQP2YYLwYsLxQOwdtOUvjv/vPo4BYuLTaq76jZzsPwB1VUlFLDu3B3N4+ybqbWRylJmY
         K/fwsNiRbJznd2ZONdZ1qQyZfRVMJZH25AhJkPRA9028DtBv6zUk8uMdu3XBRPi/g74g
         DZhA==
X-Gm-Message-State: APjAAAWuqvYsF0WGlkstCZCDKpvOL3uGcB2vjiw5uorDVGuE7oXWUCoz
        mQ4sDAEehfmEdukPmRHEem/B+xUIAS1YYKLgr5g=
X-Google-Smtp-Source: APXvYqxowpS73Iy/ogHuojE646m+ezuloUWHwW0HXTH6YBeuoE4nkrNJyjofeY4Qe5FdZC9YiykGYtoAs0B3UBQvwt4=
X-Received: by 2002:a1c:7419:: with SMTP id p25mr8384369wmc.129.1575113476190;
 Sat, 30 Nov 2019 03:31:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574731022.git.liu.denton@gmail.com> <cover.1574884302.git.liu.denton@gmail.com>
 <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
 <20191130104812.GA18401@danh.dev>
In-Reply-To: <20191130104812.GA18401@danh.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 30 Nov 2019 06:31:04 -0500
Message-ID: <CAPig+cQ38J_0wHLw0CuhSdWBBEP-RuAchgG014GPHiSp6QOpsQ@mail.gmail.com>
Subject: Re: [PATCH v5 26/26] t7700: stop losing return codes of git commands
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 5:48 AM Danh Doan <congdanhqx@gmail.com> wrote:
> On 2019-11-27 11:54:04-0800, Denton Liu <liu.denton@gmail.com> wrote:
> > +   ! grep "^$coid " packlist &&
>
> I think we want to use test_must_fail instead of !

test_must_fail() is intended only for use with 'git' commands; "!"
should be used otherwise. Quoting from t/README:

    Don't use '! git cmd' when you want to make sure the git command
    exits with failure in a controlled way by calling "die()".  Instead,
    use 'test_must_fail git cmd'.  This will signal a failure if git
    dies in an unexpected way (e.g. segfault).

    On the other hand, don't use test_must_fail for running regular
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.

So, Denton's use of "!" here is correct.
