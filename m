Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBAEC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD3260EB4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJ0VxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhJ0VxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:53:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669AC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:50:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x1-20020a25acc1000000b005c1df16c5e9so2101225ybd.9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9IJyrw/J+YXfitW6k2fiRTl4Hd1fr9oGuKNBESb44ZI=;
        b=VAX07mYoKO9o+/ehuAxcjbr8Oxn0liJQEJ1wX+1DWeqU3Y0nmiWp9WsI/yeW4hqqbn
         LNCI6C41sR3ygoppGzchk+p1rc6acw9GjKj8SMJXsHDgEW2Nut2IGHWc/LAiuzrChSam
         nPAKGqjkRSK3msk/a555bf9T1ZmUgmp96BXOWlV7TE5tv/yumcNEM5ntgz73GHdxSZzV
         AQuO3Pp50Eniccv1EkIH9ZfojkmzxkM/XIidZ0MAnj5MhRJTnpwbrbuO9xZjVS4N4HQQ
         bnAwyA08WaVPP6pXWWIeDNVIu+eaeffEr/hoLShyWI1GvfSW7flhdVFHaEfjeSFmcKNr
         v6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9IJyrw/J+YXfitW6k2fiRTl4Hd1fr9oGuKNBESb44ZI=;
        b=qXdToGCmlzRRygxnqSSDO/9IUr0LQs2ywLC2lnrfiaS6tsNWqHMBGj0vUZArMm54Rf
         WmIinx+xK4yyAr08A4+IipJnu9rOFJuHCStqaCC/0FxiZSUhMH9cowZP0mxyOgWFUWoi
         gIv/fG8itaYTqX+kmda7lOhu2cmUZ+3EWzPOdLRPrxc1gzLRysLhSQ6BJUtGrrT45cX7
         a0teZK8Qwym2s/xVeZY9xd7MJhMhrtBeumDKLxMTaubL+rkwqPBT9xpWaGEXLXYWTlvV
         +CBB6jmpcVgC319X98FHopVq0iz2hmSvMw8u7Xzr/L75OmdYAMlsg5o48yksEHxvcXUs
         +ALg==
X-Gm-Message-State: AOAM532txVImE48pgHHbbx4YOX/zn/dkZgtNQOmWk47uhAlbxrPS60/J
        OvxVBAhFr++IuoRVt07VmXofatjYaaqohpGWhY7x
X-Google-Smtp-Source: ABdhPJyvOwJqsLq8Y3aPPor3x60CxX5Df7PGU0ERVq2MLtb/1cdY3uezZw2Llsjymf9Tt0f5sSGmdskCHhXJfNnRaU4F
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:707:: with SMTP id
 k7mr268848ybt.545.1635371456368; Wed, 27 Oct 2021 14:50:56 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:50:53 -0700
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
Message-Id: <20211027215053.2257548-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: Re: [PATCH v3 0/6] usage.c: add die_message() & plug memory leaks in
 refs.c & config.c
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        andrzej@ahunt.org, martin.agren@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What started as a set of small memory leak fixes is now adding and
> usinge a die_message() function. This non-fatal-die() is useful to
> various callers that want to print "fatal: " before exiting, but don't
> want to call die() for whatever reason.
> 
> I wasn't planning to submit that now, but these were incomplete
> patches I had lying around, and make the 5th and 6th patch much nicer,
> in response to comments on v1 and v2 to the effect that managing
> free()-ing around die() functions was rather nasty.
> 
> This doesn't conflict with anything in-flight, and the changes
> themselves are rather simple.

Is this mainly to make a CI work, or just so that a certain set of tools
work? (You mention an old version of GCC in patch 5.) If for CI, I think
that there might be a sufficient version to fix this, but if not, I
would think that something less intrusive would be better (e.g. a
comment that certain versions do not work).

As for patches 5 and 6, I think that any leak detection we use has to
consider any pointers still on the stack as "live" - if not we wouldn't
be able to die without returning back to the topmost function since any
intermediate function could have allocations (unless I'm mistaking
something). (Unless die() is somehow overwriting the stackframe through
some tail call optimization or something - in which case maybe what we
should do is to disable the tail call optimization when we are checking
for leaks.)
