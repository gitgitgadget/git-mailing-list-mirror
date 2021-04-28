Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED8DC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38025613F3
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhD1Qd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:33:29 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34381 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhD1Qd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 12:33:29 -0400
Received: by mail-ed1-f42.google.com with SMTP id i3so49327135edt.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m1+teueQO550s8alPSAs5SZhbuqvXdge4kR3UZKN2Y=;
        b=AvaF9hvcJEwXyqmNC+Zw5RVnZesExsBzdcY7HK6LnY+mGGHO5b1OFMTRQQN+g+RbaJ
         vHiCi5NptpDFziruFdjr/Jshy6SodqlcWMdphTu2aiACRc+rx52J5F77hPMv+MjiWS9J
         97Pc9GiH6FbNdQvkvDJhzMH+uanQN2nLiKGyh/nKEdAlNt3AfLLQyKbBoB+MiHS7NGCb
         Urjs1tOpJ7EcV5iSP2HsObnhsYio3b2ie/n2oC9DdftJDNxKWh0jvuxCRI2lH3fBCjl+
         LY6zOOMXwx+sKEIDOs/W06zBv2ja+y9ssd4toUd9gj+DaTuijp+2FKKxnl6Vlr9Ja411
         sV7Q==
X-Gm-Message-State: AOAM533XW0Jm+8tTHRsH0QBUSRO2tn//QpC4HwtLJbWRs2jZO6bBJWOR
        qFdwP9sTHTg0dWTLWarrrEZ7NUPGh37MdnVdJhw=
X-Google-Smtp-Source: ABdhPJw7MDGKQraf0ep3NfqOK1sQTDduClUF3ER71f2jN7k8fh1yL9nqYxaEioN63Oj59Rg5wYQh5uCfn7Z7es6w3hY=
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr5767920edv.181.1619627561803;
 Wed, 28 Apr 2021 09:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080508.154159-1-bagasdotme@gmail.com> <CAP8UFD0k9fwwW94BKtMPLmA=Qx1ce3Qh3UfF0KiC5+AOj-=MiA@mail.gmail.com>
In-Reply-To: <CAP8UFD0k9fwwW94BKtMPLmA=Qx1ce3Qh3UfF0KiC5+AOj-=MiA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Apr 2021 12:32:30 -0400
Message-ID: <CAPig+cS0yA3TP9PBi2ZtQx5UeKRbFgwXqeqB1sC6QPB7q+Lu2Q@mail.gmail.com>
Subject: Re: [PATCH v2] t6030: add test for git bisect skip started with
 --term* arguments
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 4:12 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Apr 25, 2021 at 10:06 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > +       git bisect reset &&
> > +       git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
> > +       HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
> > +       git bisect skip &&
> > +       HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
> > +       test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
>
> It might be a bit safer and more consistent with the rest of this test
> script to use double quotes around $HASH_SKIPPED_FROM and
> $HASH_SKIPPED_TO, like:
>
>        test "$HASH_SKIPPED_FROM" != "$HASH_SKIPPED_TO"

Also, is there a reason for upcasing these variable names
(HASH_SKIPPED_FROM and HASH_SKIPPED_TO), thus making them appear to be
globals even though they are used only in this test? More appropriate
and less misleading names might be `skipped_from` and `skipped_to`.
