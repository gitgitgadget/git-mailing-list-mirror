Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FB9C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKAWDd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Nov 2022 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiKAWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:31 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5895558A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:03:28 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id o13so8551464ilc.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T/ciDLGtT2pDkQbjUPNckbRg2y/hkcTEA4cEf0Rn80=;
        b=1/BDMrFpT0qsYBvCjF9DSrhwnbEiTKr17WqQI/giLBErLu4C5z+i/Mfbo6L0zxLuLx
         zd+GJzexKIiMfe0z5P6EbKr9jJWd51SpWTl0hcPoLcB2K75qVXdFtbx9lLvowMx8BqP5
         wZ0ic/f+xsPEQWRyNdkVWXpDXKBKZompK4GeFVuRqjzo0tdzQWB7BL3LBgzEAiM/xZC+
         ycPYGzsV6PfWFwnOpFurVQXzyoLgoChbwx6ZEcdg8/Cu6gtEYexW0+U09fZO3pjCLF1m
         n/Ih6WskuzrziGN9c8N9OOPjwA4t1gjRHfzzKKCWl+UyORQvpqbRWzR352PETgMA8gOS
         fSEg==
X-Gm-Message-State: ACrzQf3+5wPzJDrb0GgexOuK28BALGaax4mR1ed6IUcv5yKLX6Z5MWNH
        OaLtFZsEaFiazDJ9LuCTrpvzRRJuMBLGCeqzbe7bKDDEdR4=
X-Google-Smtp-Source: AMsMyM6uaj5p8NAKEQE0sEMGEZrcxWwDYvtVsXYnLyvgky/QInnc142aK8fd+24LaK4n7YvMjAq4emEJDbOGaj9YS0w=
X-Received: by 2002:a05:6e02:1905:b0:2ff:a163:8497 with SMTP id
 w5-20020a056e02190500b002ffa1638497mr13534058ilu.147.1667340208105; Tue, 01
 Nov 2022 15:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
 <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com> <CAN0heSoc+jKxseyyR-=8+ATc8rdY5UyFWZPepaQsGn9m+Hpfmg@mail.gmail.com>
In-Reply-To: <CAN0heSoc+jKxseyyR-=8+ATc8rdY5UyFWZPepaQsGn9m+Hpfmg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Nov 2022 18:03:16 -0400
Message-ID: <CAPig+cS184iKk6icG6ML=X+6Ng=fJyfic8izFyp1hT40cChm4g@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        git@vger.kernel.org, andreas.stieger@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2022 at 3:41 PM Martin Ågren <martin.agren@gmail.com> wrote:
> On Tue, 1 Nov 2022 at 20:05, Martin Ågren <martin.agren@gmail.com> wrote:
> > > There is no real test error output, but we can identify, that it is
> > > happening in the test part with check-chainlint.
> >
> > > [  387s] make[1]: *** [Makefile:83: check-chainlint] Error 1
>
> On further reading, it appears this error happens in the
> "check-chainlint" target without even checking this environment variable
> (that happens elsewhere). I doubt my original suggestion will be a
> complete workaround.
>
> One approach might be to patch the "check-chainlint" target into a
> no-op, possibly combined with turning off the chainlinting as I
> mentioned above. My makefile-foo is unfortunately not sufficiently
> advanced to immediately spot what might be going on here.
>
> At any rate, all of the above is just about working around the issue. As
> for a proper fix, let's hope someone like Eric can chime in.

Makefile-foo or not, there isn't much to go on here since the `make`
output doesn't show the actual problem. Squinting at the
`check-chainlint` target in "t/Makefile", I wonder if the problem is
with the line-splicing and missing command termination; that is, it
could just be a shell syntax error which is picked up by more strict
shells such as `dash`. In particular, in this hunk of code:

    { \
        echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
        for i in $(CHAINLINTTESTS); do \
            echo "# chainlint: $$i" && \
            sed -e '/^[   ]*$$/d' chainlint/$$i.expect; \
        done \
    } >'$(CHAINLINTTMP_SQ)'/expect && \

if you add a semicolon after `done` like this:

    done; \

does that fix the problem?

If not, then you may want to remove the "@" from the "@mkdir -p ..."
in the body of the `check-chainlint` rule in t/Makefile so that `make`
will print out the actual command(s) it is running, and then invoke
the target manually with `make -C t check-chainlint`. With the actual
commands visible, copy/paste in the terminal to run each command
individually and check the exit status $? after each command
invocation to find which, if any, is failing.
