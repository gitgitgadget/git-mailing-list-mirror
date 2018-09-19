Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE54A1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeISS2W (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 14:28:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42573 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISS2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 14:28:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id g13-v6so2897782qki.9
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 05:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zuf/lehyHt+JfhgxcoGZvAHAWLZlf9wa7Sz8V9yehE=;
        b=ccDmlT1GEK2Q1j7lo7EMUpCsrJcksPphzXKB+fZivPGFTV3rGFNFnRt5YQxDtNE4/U
         NTuBTJYsxsgYKhS68ZaF3iXPOCNLJuJPtKKyPTodOENf+N9RNTCRgTjStD9Gaykqs8ru
         /dLHFIJ+QDwsyCMOpG1lzCT8TgBnEJ9Aug0wTZHGncWpO1/+sgRuDb1ZG8jGNOqpr3xa
         ZeGInuxtqZ9lV6j208fA4CSYMPSU6yNTxCNuHoGaijA/7LBJpQXn63XBUUTT1FmhScaI
         PpiE0ThArcTCB9rYHqRV4JjsXzRTPHnGpB8gb+F0F+AA4tQfXXtKvMEt8Z3ELdCnaODg
         hoAQ==
X-Gm-Message-State: APzg51AkoRju8Bd7ua7M0cSgaBGNYgLywXehfG2/5QzjCLltlpQjUvbi
        UECy6tAUMdw2HUNp/b6AdnUMUpmuNTJi5mwYDUc=
X-Google-Smtp-Source: ANB0VdYsZxwzDqAdXCAF3L9eO5Xlwma9wf+el6Mcpkt+RSnavV+qmBPs+PKtaOqjJ+8VKxVIZDe+P6ZCegiE0t5wJEk=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr22974599qka.314.1537361433055;
 Wed, 19 Sep 2018 05:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com>
 <CAPig+cT5BLu2onbuTBbZ_mMzNMkEuPk5-g2d5YKw4V6Z42Y3aQ@mail.gmail.com> <CAMfpvhJ3ye_7LWaQ1abXKtMB=O1sfOz6xYN=7acrVdLOksq9eA@mail.gmail.com>
In-Reply-To: <CAMfpvhJ3ye_7LWaQ1abXKtMB=O1sfOz6xYN=7acrVdLOksq9eA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Sep 2018 08:50:21 -0400
Message-ID: <CAPig+cQ3M+Wtyrm_GGRhL7kgM0eWPsXanK-AbLtJiQsORJ3A5A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] t9109-git-svn-props.sh: split up several pipes
To:     Matthew DeVore <matvore@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 10:56 PM Matthew DeVore <matvore@google.com> wrote:
> On Mon, Sep 17, 2018 at 6:57 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> > > +               cmp - $3
> >
> > This is just wrong. The "-" argument to 'cmp' says to read from
> > standard input, but there is nothing being passed to 'cmp' on standard
> > input anymore now that you're removed the pipe. I'm guessing that you
> > really meant to use "observed" here (and reverse the order of
> > arguments to be consistent with the expect-then-actual idiom).
> > Finally, since these (apparently) might be binary, you can use
> > test_cmp_bin() instead.
> Fixed, except for the test_cmp_bin part. My understanding is that git
> svn propget is supposed to be printing human-readable strings.

If so, then please use test_cmp() rather than raw 'cmp' since
test_cmp() will show the actual difference between the expected and
actual files, which can be helpful when diagnosing a failing test.

> > After this patch, the test is even more broken than appears at first
> > glance since the test body is inside double-quotes. This means that
> > the $1, $2, $3 inside the test_propget() function are getting expanded
> > _before_ the function itself is ever defined, to whatever bogus values
> > $1, $2, $3 hold at that point. I can't see how this could ever have
> > worked (except only appearing to work by pure accident).
> Fixed, and here is the new test:
>
> test_expect_success 'test propget' "
>         test_propget () {
>                 git svn propget \$1 \$2 >actual &&
>                 cmp \$3 actual
>         } &&

Rather than escaping "$" with backslash, a cleaner fix would be to
change the double quotes around the test body to single quotes. Those
double quotes weren't needed anyhow since there are no variable
interpolations in the body. Single quotes would make that obvious at a
glance in addition to avoiding unexpected behavior in the future (like
$1, $2, etc. being interpolated at the wrong time). Single quotes
would also make the test more idiomatic and consistent with the bulk
of other tests in the suite. If you do go the route of swapping
quotes, please be sure to mention the change in the commit message.

Thanks.
