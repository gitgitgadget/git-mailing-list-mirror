Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEEEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 18:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF2SqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjF2SqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 14:46:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB52693
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:45:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso16534851fa.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688064357; x=1690656357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giOyR0PNHrP245jO2SVWr7pHC0s8q3sAD0VPNjxLN1c=;
        b=L/s8BplG8bAJPOtWWDwz3xgmGfBRcp8N3Xa1BGBv2c42ACgSqTdN95hHYsqNLGcHBI
         h5c3RNXZZyJgfqztnALghAX773LdRY7Is6IWeXHQcbsP2JOtf0vbnHuGT2HvjuAJEU4j
         aaaSJ3T125rMA3/KxMp1VK1PGwi5JSzthuQYBhEdCxhQCYmwKKyXY4aFOFbmyusptlDH
         c1ex+8HHWFJthHhP4Xzn0b/QWdfzsxDngdprlAilm2EZajKa5q9gF3JW5rATsOwrm+4S
         Leu9CZpKAx18zIzm1SqH5yGH1mUbEF4T24+ZbKsrZyl9hdKWRxZ4k/+884Z9KR81lUda
         vhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064357; x=1690656357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giOyR0PNHrP245jO2SVWr7pHC0s8q3sAD0VPNjxLN1c=;
        b=X83UE0aqaYrGSHHBVT80WbDnKJQXeTTYDh4ZaNj6PHe7p178n8ZRRJ/do9VKJzpUMw
         DY/lH7iEINFwT/GImfwljQD9AcnynJdrPWl3Hp1+tTkJ1AErAPrFADvmouDoJmXSgM/A
         blMQi3jCfdnarWMSNiNnTJqDweXpM7yPihEs8xekZlqrwjyK9UEZvnwd3gHy8IcBc1xx
         guN3heuO12oWMAFapm1s6vTS5kPxBwPpX/8R4Q7MVp/7izHSWg6Bi4ovkP1JufZpgd/T
         14tuG8bjo4b6dpjBVZW8aF2wKC7WN4fK4kJ/fhVzD9yj+4t4Lz96+DW6yaIvuRaUpC4D
         b3tA==
X-Gm-Message-State: ABy/qLaWy94Eyb7EtZLOHp0NP4WJGS8Ne4gxIzwvbWfNUGWSGwVMN2sy
        lX0J+/YI3ynsrt8Im0Ms0vKLLEMuLJd85zeZVvxFx2qY
X-Google-Smtp-Source: APBJJlEo+j4ojQc211zh3NcP/v+mqpwTn4reHlInhG2wCX/WAaPF9fteRx2TNQ9Kz1jOgFESh8MwUt1P2vAeEFYygh8=
X-Received: by 2002:a2e:80d0:0:b0:2b6:9f4a:fce2 with SMTP id
 r16-20020a2e80d0000000b002b69f4afce2mr443096ljg.7.1688064356555; Thu, 29 Jun
 2023 11:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com> <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com>
In-Reply-To: <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 30 Jun 2023 00:15:45 +0530
Message-ID: <CADE8Naonm+bW_jVvJKmnfZWQyX=0-QVSHxpSaHs1qo+5DsCiPQ@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Jun 29, 2023 at 9:33=E2=80=AFAM Emily Shaffer <nasamuffin@google.=
com> wrote:

Hi, thanks for replying!

> > Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
> > very recently a patch to clean up some headers which probably were
> > implicitly including trace.h when I wrote this walkthrough. Patches
> > totally welcome - and if you were working from the reference code in
> > https://github.com/nasamuffin/git/tree/myfirstrevwalk
>
> bah, wrong link, the tutorial points to branch `revwalk` instead of
> `myfirstrevwalk`, but the offer stands :)
>
> > and it's on your
> > way to rebase and fix that too, I'm happy to update my branch
> > accordingly too. (If you weren't, don't worry about doing the extra
> > work, though.)

Sure will! But do you mean open a PR on your fork? I have the patch ready,
and would be very happy to do so, if it is accepted!

Thanks a lot!
Vinayak
