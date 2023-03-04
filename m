Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF55C678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 23:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCDXZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 18:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCDXZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 18:25:19 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33FD33C
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 15:25:17 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1755e639b65so7420683fac.3
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aolKucQG6D6f3H6IaRzmF51GjbUqXmhvTDDyvvqljIA=;
        b=TUHHiiI29Kel/MGtClcR5rTd6Yr+u8VSBNXtr/hq3dy3q682DBj8fjjFvsa4Oij58Y
         d1g8jLHYlsi46WvMqMxqfKfFDNSdCnwlnsufdHIHKNJvlblVLBWTjCG8bRzMRs9ipkgW
         XwrXJ/XpAlFKisPZI8bauX5EOPzci8VHisyPUdG0vme4fIkDZLnmlgg9uy2UfOmJnK0Q
         zX/n1uQfAQL/st2lwaWWOz63L3XSqGKBzFB3sGMqiCPM/7RiXqaSmOMJckHz4zRLjXld
         k3RRHhk4kF9SQnOStzGBgWBgcYr/GFz9llMbdDsIVfEzbjX1qaa3pptphubIFWtaH8Ao
         BZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aolKucQG6D6f3H6IaRzmF51GjbUqXmhvTDDyvvqljIA=;
        b=4+XFiZ7y0XoDWJHgSYe7k8Bx61VFQbbMH5hn1p79NUHw58A3mybWPiRqtYxctbuyQ4
         xofo57fIoN6u0GlbMWTTOiUW5YJqLbfKXqr2lvgTYCIUej8ttP3Z6irVLYIit6tbXpMZ
         JOYtOhVr4TL8c3mg/oFunlKRZhH5j4kqR5tAD4Bl3C49ItR1DIvwfmM3dTxDJ+eQGqIG
         JpFEDah1CGWsiHpq9lX2BTpequO9bHseK3kchxqPKURX5qahIAK0+54Z5PwP51dwPLZf
         QF2PAHQR/NI1+uFLZkkAMVguYwGLyzkENqF8cM2ELdSde0ZLe7CGAetC62R1paBYc2b6
         61ug==
X-Gm-Message-State: AO0yUKXYSntq9UFfi8bUQlA2hE0N9kN+AiZHIlu3GNYtYElLk7kmmVIb
        gnSWFa7zW1dYIxyMeW+GKWmTPl2H9seEsnCAp+o=
X-Google-Smtp-Source: AK7set9tAPvLdygT3WBc/8lIOcRWLA5t1pL7qHCKylrFhN6fZn0FMBFI276AI6toip4NfUQxogF7iyGqnOrw5/ay7B8=
X-Received: by 2002:a05:6871:783:b0:169:ce1c:d7c2 with SMTP id
 o3-20020a056871078300b00169ce1cd7c2mr5037510oap.5.1677972316900; Sat, 04 Mar
 2023 15:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20230225180325.796624-4-alexhenrie24@gmail.com> <20230302180226.2699247-1-calvinwan@google.com>
In-Reply-To: <20230302180226.2699247-1-calvinwan@google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 4 Mar 2023 16:24:40 -0700
Message-ID: <CAMMLpeTiphSA=1aM89n4CQ5-L90qwZyXenx-JYox7=6NWj3TrA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2023 at 11:02=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:

> > +rebase.merges::
> > +     Whether and how to set the `--rebase-merges` option by default. C=
an
> > +     be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting t=
o
> > +     true is equivalent to `--rebase-merges` without an argument, sett=
ing to
> > +     `rebase-cousins` or `no-rebase-cousins` is equivalent to
> > +     `--rebase-merges` with that value as its argument, and setting to=
 false
> > +     is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` =
on the
> > +     command line without an argument overrides a `rebase.merges=3Dfal=
se`
> > +     configuration but does not override other values of `rebase.merge=
`.
>
> I originally believed that having the boolean values as an option here
> created unnecessary complexity but I was convinced during Review Club
> that the tradeoff for a user who just wants to turn this on is fine. I'm
> just wondering whether this option will possibly have additional values
> in the future. If so, what would a user expect from setting this config
> to true?

"true" will always mean "rebase merges in the default way, I don't
care what it is". During a time period when the default is
transitioning, "true" means that the user will get a warning, but
there's nothing wrong with continuing to use "true" if they really
don't care.

-Alex
