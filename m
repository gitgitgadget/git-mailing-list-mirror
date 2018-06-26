Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1E21F516
	for <e@80x24.org>; Tue, 26 Jun 2018 09:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeFZJVc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 05:21:32 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42589 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933189AbeFZJVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 05:21:30 -0400
Received: by mail-yw0-f194.google.com with SMTP id i143-v6so4350299ywc.9
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 02:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxLgarfGT5fIvM2naIFkehb5cT5o82FURbKU3H1v8TM=;
        b=N8xGTWdVn97E5aEJ0dnjyi80xJ/6z1v9hH3XKs9RD4J63tZ3WlldlI/25EpjHXYuv/
         ciMtpt0wSMYmDevJlnuE0SZ1GZD5OutK1bPyNDNrTlHHW9QOrwDuFstl/Tjj/oi8pSp2
         QQNxEwkk8P5fJn3OQK1sW6+tsg/F+i8Eiea/FtuhNsxOWEKZtH7P0DG1G6xcmhe3s4uh
         tuwkcX5TDt8v6gnYdDy0/SuPVlzj+07roPBd6/zCuaBivLk0iVae38sZsiKY1q94hT5D
         RzzslCMKoe0E3rrlQGG4nxe1tZrH5HYzi/v3OcuesW3URrDdrglUCGHwFrr/HpFOPEa0
         ECnQ==
X-Gm-Message-State: APt69E1MVRANc4a1IbIqenuB29G46rxJXcHq86ulf4UCy2qfd0B0SSdk
        e3IR4XSrpg9UF4IgHb1ZAMId/EfydSPl/TpWnrs=
X-Google-Smtp-Source: AAOMgpeX7Y12NA6q/mXKH52YPomc3bY1C6Wn/3QlCXqXTFzTFv8ziV8u7wvxq2tR2uD6DkH/qlfmvtxxE089q0C6j4s=
X-Received: by 2002:a81:451a:: with SMTP id s26-v6mr296277ywa.74.1530004890301;
 Tue, 26 Jun 2018 02:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-18-sunshine@sunshineco.com> <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
In-Reply-To: <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 05:21:17 -0400
Message-ID: <CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com>
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 4:58 AM Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > [...] Therefore,
> > replace the manual exit code management with test_must_fail() and a
> > normal &&-chain.
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> > diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
> > @@ -25,8 +25,7 @@ test_expect_success 'non forced push should die not segfault' '> > -               git push .. master:master
> > -               test $? = 1
> > +               test_must_fail git push .. master:master
>
> test_must_fail or test_expect_code 1?

A legitimate question, and the answer is that it's a judgment call
based upon the spirit of the test.

Although test_expect_code() would make for a faithful literal
conversion, I don't think it agrees with the spirit of this test,
which wants to verify that the command correctly exits with an error
(in the general sense), as opposed to outright crashing (which it did
at one time). test_must_fail() is tailor-made for this use case.

Contrast this with patch 09/29 "t7810: use test_expect_code() instead
of hand-rolled comparison". Different exit codes from git-grep have
genuine different meanings, and that test is checking for a very
specific exit code, for which test_expect_code() is tailor-made.

> > diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> > @@ -12,20 +12,8 @@ test_expect_success 'start p4d' '
> >  test_expect_success 'p4 help unknown returns 1' '
> >         (
> >                 cd "$cli" &&
> > -               (
> > -                       p4 help client >errs 2>&1
> > -                       echo $? >retval
> > -               )
> > -               echo 0 >expected &&
> > -               test_cmp expected retval &&
> > -               rm retval &&
> > -               (
> > -                       p4 help nosuchcommand >errs 2>&1
> > -                       echo $? >retval
> > -               )
> > -               echo 1 >expected &&
> > -               test_cmp expected retval &&
> > -               rm retval
> > +               p4 help client &&
> > +               test_must_fail p4 help nosuchcommand
>
> same question?

Same answer. Not shown in this patch, but just above the context lines
you will find this comment in the file:

    # We rely on this behavior to detect for p4 move availability.

which means that the test is really interested in being able to
reliably detect if a sub-command is or is not available. So, despite
the (somewhat) misleading test title, this test doesn't care about the
exact error code but rather cares only that "p4 help nosuchcommand"
errors out, period. Hence, test_must_fail() again agrees with the
spirit of the test.
