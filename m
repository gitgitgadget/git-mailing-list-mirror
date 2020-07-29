Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7AC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E772075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3P6MvVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgG2SJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2SJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:09:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F5C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:09:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l84so8964020oig.10
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL8Tup0NVU46/j60DcWAhdjKeD1yEnpimNiqYplJVMY=;
        b=H3P6MvVQopeOIQcpDekt63r85VgRFTjcYv8G2LWm0Dp5w6lnQSv4S/f+5pds7KdfzH
         VPw9/DhxOIuTnE67KGdhOG+ANJU6ExmK/4cPP5pt2LMMYxUWLOilQ+37kbC1HW2F5GY6
         RwkACp/K0XTj1YIzVd05fbnZ2qmtk8U9mgvDIbkXG+A8mrRNXiADpaBQEfUqa3ZeC71I
         o223Ow8YdKzbxxNmKxibyT4kMNowAdaYWVQzmVuZSqE9/Oij96pfmnbqZuGX7ZvhrcSx
         SV7bYTSQdkFnLOkgfsRn8J5K8TXqGPi6fqwUV4k2cQhf5+M9HigqKP9jXN9Zmr1Zfd1C
         a7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL8Tup0NVU46/j60DcWAhdjKeD1yEnpimNiqYplJVMY=;
        b=LqEf+k+W/xRqOmhTIUozKVSU3NGB93uT9vB3f18kx7pxfTKqRAc7H90x1+EzKDHagf
         rbBQXfMw3xTgyUID6v+KzRQCg4bOzYankBgup7BU9wO82/Iuz1SsDH8FGlb6IjFQ6gjt
         DyR5iqdZu0ImXKbeb9ICZovqCs6Q2QPy6F8xKq2nHpTIUwpf0hg+/MJy+kTbDZSJx3YZ
         kw7la8GduIU/OE07Aq686bMRhagpdAwgVO9blcMqDsuwp5YWQS3DeDKbfwZmy7P4LmVR
         xW8rA/9epKkGYMclrhC21wy4Gjgk16BpkxMoEfnEnNv9hKLXhk787ezt2w5tVb1hhkam
         lREw==
X-Gm-Message-State: AOAM5304psyRgxGmKZS12tP2KyDO72XcI0T/GINkq+g56P3FafOmk3bv
        BI4fbJUTa38DIjJbKvD/IX6CjPyorDijXx70ERM=
X-Google-Smtp-Source: ABdhPJwVGVtupOt8P6mNBHg1M7S65q0ZTs0i3XuLHtAoL9D2RS9yZPAJWOuYRnoiOroyE4sio69XB8/CLW9IEpmA700=
X-Received: by 2002:aca:ea08:: with SMTP id i8mr9156100oih.167.1596046181629;
 Wed, 29 Jul 2020 11:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <186376813.20200729195318@yandex.ru>
In-Reply-To: <186376813.20200729195318@yandex.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jul 2020 11:09:29 -0700
Message-ID: <CABPp-BF4C1ixfYn=Bavg+kbnB0M=KJv=yuh_nxymwX-woGhh5A@mail.gmail.com>
Subject: Re: Cherry-pick picks more commits (and miss some) than provided
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 10:00 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>
> Hello Git,
>
> $ git --version
> git version 2.28.0
>
>
> If I do
> git cherry-pick 90a075bf f2c161b7^..ae27237e fb7e608e f34c9562 76f2568a fb141148
>
> then more commits are copied and some commits are ignored

This says to pick all the commits in the history of 90a075bf or
ae27237e or fb7e608e or f34c9562 or 76f2568a or fb141148 that are not
in the history of f2c161b7^.  In other words, it'll cherry-pick all
the commits that show up in the output of either
  git rev-list 90a075bf f2c161b7^..ae27237e fb7e608e f34c9562 76f2568a fb141148
or, equivalently, the output of
  git rev-list 90a075bf ae27237e fb7e608e f34c9562 76f2568a fb141148
--not f2c161b7^

> But when I do step by step then every thing is OK
>
> git cherry-pick 90a075bf
> git cherry-pick f2c161b7^..ae27237e
> git cherry-pick fb7e608e f34c9562 76f2568a fb141148

This is very different.  This says to pick all the commits in the
history of ae27237e that are not in the history of f2c161b7^, plus
grab commits 90a075bf, fb7e608e, f34c9562, 76f2568a, and fb141148.

The only cases when the two would mean the same thing are when all of
90a075bf, fb7e608e, f34c9562, 76f2568a, and fb141148 have f2c161b7^ as
their parent.

This comes from this part of the manual:
       <commit>...
           Commits to cherry-pick. For a more complete list of ways to
spell commits, see gitrevisions(7). Sets of
           commits can be passed but no traversal is done by default,
as if the --no-walk option was specified, see
           git-rev-list(1). Note that specifying a range will feed all
<commit>... arguments to a single revision
           walk (see a later example that uses maint master..next).

The fact that you specified a range (f2c161b7^..ae27237e) among your
arguments, meant that the implicit --no-walk was omitted and now all
arguments became ranges.
