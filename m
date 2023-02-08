Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E4C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 23:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBHXMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBHXMd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 18:12:33 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855135AE
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 15:12:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o187so338642ybg.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jyhamTmPMkeWz88y073od9kK9Ei/eHrIhCE5do+kCkI=;
        b=P0tEC6sggCSQuCkQ2cXg3DeNoxNj5a5u424Vfu3KXtF9dJlg7rBANHKisG0Y82RoNk
         35PAhe8o2Q2hfwq14fb69P4RB3Gnqznw5rlpEzAAxy3aNRvR0aONtzhDVRaEynV5OGn2
         2DTpD/PwhOgkguJ/2W7/XdZvat7hpE/pio32HUrZoFH4CG2uYrTV4Bmygmzxyq8H9maa
         ghs+/UxNEr0dFWN6ZjZKOMceiXNpkWYF73pxrlplbPI23Xm0IyfENq6pBWPH06BSn3Vq
         dWE/4ErYgHw1veH0+0u1daIVy7uiveTU/AEh4bjLTtJ0tUEhkncyzt/kO+DxcInRWKEk
         JehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyhamTmPMkeWz88y073od9kK9Ei/eHrIhCE5do+kCkI=;
        b=CWa5KZtbaIQj2jr1HS/GUfLEV/llsYyCAQry1I1OtS/F/dlxugLIuugtYm7BaQeLcU
         DQ+D8ZtYiNX6fnuajw39S+F/Ol7Dk+aWwEULB83ARetg3azSdzhRDOedU+4ylTJoZkrr
         uTUbGAmXopz7qbQiStkvjQR//Rpw530ZQH/3ImiyJwOg1ra+p5OAWBiSLRvRyftI/1oX
         PsZ4TjfLI4pe0toZL5WazE4ebFuZOIqvhSTXnai45vdjCoJqVfasfqp8WxotNYmVenYC
         O13d0hBXl/0dt84JD1OWXXthrOMKa/7Epsu8NnnYA5/lhQiUicET9pP0Ib7YZm6ldu8N
         SY8Q==
X-Gm-Message-State: AO0yUKWg1ywCg9SfGInG+sZ2LTLQzUIcvz6LBmcFMvtSkRlIaqtB0nDg
        9N8FfQTlAMC+uj89F9IuTnTiPmSiRvGmYQjtYFv62g==
X-Google-Smtp-Source: AK7set9fA+9m4//0Z56wZnUfmkoCbKKPXQub9ybTVDWXr4xQqeeTWQkt7q7DdqNUn2ozrFM85SOYV/sPoUus7SblKxo=
X-Received: by 2002:a25:9f11:0:b0:898:5cc0:66c with SMTP id
 n17-20020a259f11000000b008985cc0066cmr1116425ybq.640.1675897951915; Wed, 08
 Feb 2023 15:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com> <20230207181706.363453-6-calvinwan@google.com>
 <4ae106ed-bfa8-2824-c0c7-6cde32dbe369@dunelm.org.uk>
In-Reply-To: <4ae106ed-bfa8-2824-c0c7-6cde32dbe369@dunelm.org.uk>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Feb 2023 15:12:20 -0800
Message-ID: <CAFySSZC31aT4zu=-y1vBBd_Z=KWWYn3-7yziLfVbeK9Foc9c3w@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] diff-lib: refactor out diff_change logic
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I worry that having three integer parameters next to each other makes it
> very easy to mix them up with out getting any errors from the compiler
> because the types are all compatible. Could the last two be combined
> into a flags argument? A similar issues occurs in
> match_stat_with_submodule() in patch 7

I'm not sure how much more I want to engineer a static helper function
that is only being called in one other place. I also don't understand what
you mean by combining the last two into paramters a flags argument.
