Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E4C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C45F6136D
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFJPWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhFJPWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:22:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA8C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 08:19:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so56413otl.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IS0iFP4EFD59OXdFcB4L9tShkjDt4UdkmbN5lWEsLuA=;
        b=CtfifcP/cL6pQkIOUwJwOTp7yDJCUU5Dn4wMDiLwSkjNHkPDSUXlf9DfiMAZ/g0fPP
         cS7B//gHBJa6QCf7jb05M6gKjy+HR+t6cjEjypNunNueWYQIyQMbn9kX2+OAbjcdgaMu
         rB5i7nSpiNkVcZ2ZRfAVubmaL5WK/kyIAqL+VhvXm6zGctMCn/NGAdN4Ospm9yaD95RH
         eF8bTL/aerd/E4DGEsv9/sQQvizYCnKZiU/U3P8Bh4mvNAZ8TVQfcw4dOv7Sal3LPpzF
         PI11szhtfWxJf5SnNZHcPY+71QZl1NnCVN82yAZc3KIq3HN/KoNeKoIbJvjWWPH8fOVo
         fMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IS0iFP4EFD59OXdFcB4L9tShkjDt4UdkmbN5lWEsLuA=;
        b=mdozuqFlehRvsICDhQIMZIQaSPCBcg96hQDnqVo/b0kYUFraxGdHgr2cyQOK3crhTo
         Lf7dQMg5afVAQ55vJjXQmJzvoQgw908+9PjA+xKtH7W1HUh8qzfuqJqUTbXIoDh3RpkT
         6wy3j6HyvaLAATZktUGa7kma0upsWJCp3Jl1AgNSidMJR1RHePf5EOvKrH2/XOOo68mQ
         kBJ/aWyL0IknEAaIwZyKfmu2jehF8HN5ulfc52U7bvFH33RxJlJwikqLuDc4LKRZkSx/
         1zZciuykrL/hvWbBVUlVsHU+i5bcz6qArI0IPJMm/KYYOAk29Hmm+fivHHVZwMZix53t
         ONTw==
X-Gm-Message-State: AOAM533B7nFhDedV+5YM4aOX1d/2jeBJsEs0GuvWFiCsjyiWOPP7Ol8e
        L9o8ADzEauO/3LDMFGbvnT1CkN3l9H8EwcjriU0=
X-Google-Smtp-Source: ABdhPJylj4FphaHawjdVLZvYDUf/DEa/+fgW76tXWhnDXEFL6eazw734173anYXBgUlhyKFFhro1rMLWUfQQ2r1332M=
X-Received: by 2002:a9d:426:: with SMTP id 35mr1841803otc.162.1623338398990;
 Thu, 10 Jun 2021 08:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
In-Reply-To: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 08:19:48 -0700
Message-ID: <CABPp-BGEJ7TX9G_kdZt3ZqhhFMe9-8KHdSJ8bJ+avtsXdnUUnw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix union merge with binary files
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 5:54 AM Jeff King <peff@peff.net> wrote:
>
> This started as an attempt to silence a "gcc -O3" warning. But I was
> curious if we could trigger the problem it complains about in practice
> (spoiler: we can), so I wrote a test. And it seems there was an even
> bigger bug lurking, where we'd generate bogus merge results. :)
>
> This fixes both bugs.

Nice catches, and fixes.  I had a minor comment on 2/2, but with or
without fixing up the 'path_unused' variable name both patches are:

Reviewed-by: Elijah Newren <newren@gmail.com>
