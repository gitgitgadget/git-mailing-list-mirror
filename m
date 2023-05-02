Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F4C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjEBQUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjEBQUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:20:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203840C7
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:20:01 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5e7482961so1534761a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683044401; x=1685636401;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGZEiw0GHOZMr/sRa/ZZ/kUobKkj7U2tRI16HrBb8SQ=;
        b=czVCn2is5AdhxWbGuYlPlb7QkaY3hG4rdo5Ik+zQdDnOc/los+mWexyjONQ5SHOFYG
         N95LagXsBo24eqeETWiteP8B/ugzusnl1xgWDijAVc8EMzyZbMudihuaoc7L/qJCyjZE
         JSMWHQodhVmpZHhLddTHQSOcVtyHNvHna4ujH+SGAgd+UM/8G/DPqBIDkBg/s7+AVBe/
         aYDOCka+flON0DihUi4XyCFrN53XGOr1t6NXE8d8KF+t5mzWvfeFjpJoTl/aNHkRGoPm
         PVjUv7hUCNwdTviKuvlzxbZ4vQVDjFwEyZCAoVi2w8/8x/xTJYy2zWHl/AFdQjqpWXWB
         pAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044401; x=1685636401;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xGZEiw0GHOZMr/sRa/ZZ/kUobKkj7U2tRI16HrBb8SQ=;
        b=KFsbFU8Y8hnh+pA20549+6Hndg7Ksw7zKuCCmc3fbLhf1eoqhoh3iXCwPOYMhsyXmO
         BjLnk+0psBk5Kry3+pWVgypLLGgAYBsq6QLO45axWYcgHsIJ+utwaFldvKXV5FKyc4Lr
         Lp68wvJoffOBcJkh2MMHX19YfYKT6mCN49rAA5VAu0QbhoO/llh3caT77B7yd53jkQBM
         M4cdmyowDPRceuJdnmrKSKiD9uhi/1mXQDA6CUburK8S0jrFg90paEQ9p/AprZGr0stE
         7pAe7pZOeBxPBmyjRxepaAPqpIIejj78z6Tmz0DtGMu0zaKpzhgMGnUEYw5ZWnqTMylX
         2C7A==
X-Gm-Message-State: AC+VfDwQB01cEXCjnh9bEgo3bsNjJgQFeneL37VOwENXEReAJOt0Peu0
        Lm2QS1PplhainpBwekUfdX0=
X-Google-Smtp-Source: ACHHUZ7SWofFw7xYgFaLYs0CaqneDIflqowN8Eo6AD2SDLCyHo8OlusZsqcL1eRLZSnVHmpYg06Byg==
X-Received: by 2002:a9d:6f01:0:b0:6a3:3641:8d7c with SMTP id n1-20020a9d6f01000000b006a336418d7cmr9251232otq.18.1683044400937;
        Tue, 02 May 2023 09:20:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f12-20020a9d6c0c000000b006a44338c8efsm11811476otq.44.2023.05.02.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:20:00 -0700 (PDT)
Date:   Tue, 02 May 2023 10:19:59 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Message-ID: <6451382f7aacf_1ba2d29490@chronos.notmuch>
In-Reply-To: <20230425064758.GD4061254@coredump.intra.peff.net>
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
 <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
 <20230425064758.GD4061254@coredump.intra.peff.net>
Subject: Re: [PATCH v2] credential: new attribute oauth_refresh_token
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Apr 21, 2023 at 09:47:59AM +0000, M Hickford via GitGitGadget wrote:
> 
> > Git authentication with OAuth access token is supported by every popular
> > Git host including GitHub, GitLab and BitBucket [1][2][3]. Credential
> > helpers Git Credential Manager (GCM) and git-credential-oauth generate
> > OAuth credentials [4][5]. Following RFC 6749, the application prints a
> > link for the user to authorize access in browser. A loopback redirect
> > communicates the response including access token to the application.
> > 
> > For security, RFC 6749 recommends that OAuth response also includes
> > expiry date and refresh token [6]. After expiry, applications can use
> > the refresh token to generate a new access token without user
> > reauthorization in browser. GitLab and BitBucket set the expiry at two
> > hours [2][3]. (GitHub doesn't populate expiry or refresh token.)
> > 
> > However the Git credential protocol has no attribute to store the OAuth
> > refresh token (unrecognised attributes are silently discarded). This
> > means that the user has to regularly reauthorize the helper in browser.
> > On a browserless system, this is particularly intrusive, requiring a
> > second device.
> > 
> > Introduce a new attribute oauth_refresh_token. This is especially
> > useful when a storage helper and a read-only OAuth helper are configured
> > together. Recall that `credential fill` calls each helper until it has a
> > non-expired password.
> > 
> > ```
> > [credential]
> > 	helper = storage  # eg. cache or osxkeychain
> > 	helper = oauth
> > ```
> 
> OK. I don't have much knowledge of OAuth, but taking the notion of "this
> is a useful thing for oauth clients to store" as a given, the
> implementation seems reasonable.

I don't think this is specific to OAuth, I've seen different authorization
methods use something like that.

In general you just need two variables: the refresh token, and the expiration
time of the refresh token. The logic is very simple: if the refresh token has
expired, you ask for a new one. This way you don't have to go through the
authorization process again.

-- 
Felipe Contreras
