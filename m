Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12339C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D253C2072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEENu0uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgC3QEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:04:20 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:45950 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC3QET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:04:19 -0400
Received: by mail-ua1-f73.google.com with SMTP id h10so7718806uab.12
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=siZnDi3GDp1pz//paASpHCTtEwsRWBNa6sCGP4eqUIo=;
        b=eEENu0uH72B2RMx5tIdBbrr+T4BvTsxDBgpwZ3N2beI7JCWrdsBSOorg/kMRSVhzcU
         7tWe+K5E0ToOIqlI4aooa78kf3/1/YhOtQiUrYgRKBj8VsnnygU6g0iIIIDpcrURLk9m
         3UB6qKNjljMk7kvGNBTgMZKB8EqX95Uy+jhtqK7TFOohvrJ9jIHLq/4Wzaf1wKtkSM9Q
         Pb30mKD8RKiGgKR23KeYhxY6rO/uMFp+vlFILZZEjGka2ePHLgYtZcVOcVxnN5J82oke
         QgneTqEaXQ8DQAS3kpcP6QBBB7voIJa6FnsaDI2n1revkqI1n6/fNqTrMZGHDfnPLhGp
         s2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=siZnDi3GDp1pz//paASpHCTtEwsRWBNa6sCGP4eqUIo=;
        b=OlRVemCLNEUQ7Kw1VyzjzWW8Yc4UtyrbekCWmNfGOM7siEsMRngcFxjUSi2B0hScUW
         GqRQB6shkF8CUaxg6No0BowQeS+9acdWVwSAKGDOz3YD9lVEmHGkJbQUffCVVvgkqDDO
         fiHGgqqSyeEcd56d/N5EjjOCh9zwSRvx65d1OdT5KYo8k5MdN7MdniP7Z3uYz+eZuXEX
         WxvwdAo3H0ohAVdSmMVaZSbSGNuvP9jOURt7Y+OZp8HvKqKSEkIfdFe+gJeqg0mPazuY
         W6nPZsQo5JWxu4soiwVz4Kb40uA+87HDdvwTvxLDZOyZtP+vRxiqJpacBK1fIzYniwvt
         yq3A==
X-Gm-Message-State: AGi0PuZc5zg/Yao8+GffmnCyqc8g4wPZnLwqDiCFV92Z/c+rdtJd/S2f
        YCg6nJ6Ex6B6h/DC0LK+A7maS2Hav46dECs4ZYXG
X-Google-Smtp-Source: APiQypJKkwMZNmVwRRIyd5BAgk5R7Uvr2afuFwgF9zsdbwftnce9dofJdvZ5LqN9RPkgYMebtcwdKcOd01IjzKen4cEx
X-Received: by 2002:a05:6102:2087:: with SMTP id h7mr9433825vsr.226.1585584256955;
 Mon, 30 Mar 2020 09:04:16 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:04:12 -0700
In-Reply-To: <xmqqd08ua0jo.fsf@gitster.c.googlers.com>
Message-Id: <20200330160412.120614-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqd08ua0jo.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: Re: [PATCH] connected: always use partial clone optimization
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, emilyshaffer@google.com,
        steadmon@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> Sounds good.  Jonathan?  I've squashed Josh'es Reviewed-by, but I
> >> will refrain from merging it to 'next' just yet to see if you too
> >> like the proposed code structure.
> >
> > I think that this is a local enough concern that going either way won't
> > paint us into a corner, so if what's in
> > jt/connectivity-check-optim-in-partial-clone is OK, I prefer using that
> > to reduce churn.
> 
> If you do not think their improvement is not much of improvement,
> then please say so.

Yes, I don't think that their improvement is much of an improvement. If
we were to split up the logic into functions, one of the functions would
need to be documented as "Return true if all objects returned by 'fn'
exist in promisor packs. If one of them does not, return false; the ID
of the failing object is then stored in 'oid', and 'fn' can be used to
obtain all untested objects." Peff said something similar in [1].

So I think it's better to inline the logic, even if we have to use
"goto", so that we can see all of this in one place.

[1] https://lore.kernel.org/git/20200330133714.GA2410648@coredump.intra.peff.net/

> On the other hand, if you also believe that the
> resulting code is better, adopting the improvement (in other words,
> help from other people) and get a better version of the code queued
> before it hits 'next' is not a "churn".  Leaving a chance to make
> the code into a shape that you think better is a waste and risking
> the chance to forget improving it with a follow-up patch.

I agree.
