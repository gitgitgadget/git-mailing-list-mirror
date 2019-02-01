Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACDA1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 06:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfBAGLp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Feb 2019 01:11:45 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:32861 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBAGLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 01:11:45 -0500
Received: by mail-qt1-f181.google.com with SMTP id l11so6324253qtp.0
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 22:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rx3/Qo1X7SEm5mJxCyJvrMbyxxe6SKYSFi2sL13NRc8=;
        b=BDiU+PuV8MiCHamJz0kduV/QUVQcgprR5BKp0X+5GmfXbRX9kJMYsgdBfEfmuADlpJ
         HR35xjT1DX4HOUZ0iOsulwOkHaWfvjHYh6wMHBufBOlcFE7x7O7FIXk2UUdfhGoYOqgu
         uPg37DO3zrzw+jTilaSd/sbuFTUJPfUshXoUxWf29RNNtBBoYNiHlakJ4sVOX4t7fWjZ
         C8kEx8R5E4yk9YhbdtHDl0O6GSlX4bbJ+e1Yru5RzVPlbBjOmF8gTPTCr0JFwvWwbjI4
         EM2wQLPGvvNT/14+0u/CH1QoPTYIKwtnIRkqaLvo2c9B2XCw4ZU44NGolvxf1iKtxtQO
         +PEw==
X-Gm-Message-State: AJcUuke6ZAi470fPz7yTxw2aCiysAP8GvzXNcbnn5Odz1tkhlXCP6h7B
        P8aP2IBkrdOGyd5csteTKZyBZYSYh2czxbFlxf8=
X-Google-Smtp-Source: ALg8bN4tmDgarm+KZ93Tg22S2/qitR9MDOCG1Dmstj36yWZt+EbOPGaWPB8oA1VMH0LRK71Tu4HIc2a5GgRDAaJZaJ8=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr37628139qta.110.1549001503903;
 Thu, 31 Jan 2019 22:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-2-worldhello.net@gmail.com> <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
 <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com>
In-Reply-To: <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 01:11:32 -0500
Message-ID: <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 12:44 AM Jiang Xin <worldhello.net@gmail.com> wrote:
>> Junio C Hamano <gitster@pobox.com> 于2019年2月1日周五 上午5:44写道：
> > Move this outside loop, not for efficiency but for clarity. This
> > helper function creates a single empty tree and bunch of commits
> > that hold the same empty tree, arranged as a single strand of
> > pearls.
>
> Will rewrite as:
>
>     create_commits () {
>             parent=
>             T=$(git write-tree) &&
>             for name in A B C D E F G H I J K L M N O P Q R

Don't forget the && at the end of the 'parent=' line to protect
against someone later adding code above that line. So:

    create_commits () {
        parent= &&
        T=$(git write-tree) &&
        ...

> Nice chart, will edit test_description as follows:
>
>     test_description='git pack-redundant test
>
>     In order to test git-pack-redundant, we will create a number of
> redundant
>     packs in the repository `master.git`. The relationship between
> packs (P1-P8)
>     and objects (T,A-R) is show in the following chart:
>
>            | T A B C D E F G H I J K L M N O P Q R
>         ---+--------------------------------------
>         P1 | x x x x x x x                       x
>         P2 |     x x x x   x x x
>         P3 |             x     x x x x x
>         P4 |                     x x x x     x
>         P5 |               x x           x x
>         P6 |                             x x   x
>         P7 |                                 x x
>         P8 |   x

test_description should be a meaningful one-liner; it should not
contain this other information, but this information should appear as
comments in the test script.

>     Another repoisitory `shared.git` has unique objects (X-Z), while
> share others

s/repoisitory/repository/

> > > +test_expect_success 'setup master.git' '
> > > +     git init --bare master.git &&
> > > +     cd master.git &&
> > > +     create_commits
> > > +'
> >
> > Everything below will be done inside master.git?  Avoid cd'ing
> > around in random places in the test script, as a failure in any of
> > the steps that does cd would start later tests in an unexpected
> > place, if you can.
>
> The first 10 test cases will run inside master.git, and others will
> run inside shared.git.  Only run cd inside the two `setup` test cases.

That's not what Junio meant. It's okay for tests to 'cd', but each
test which does so _must_ ensure that the 'cd' is undone at the end of
the test, even if the test fails. The correct way to do this within
each test is by using 'cd' in a subhsell, like this:

    test_expect_success 'setup master.git' '
        git init --bare master.git &&
        (
            cd master.git &&
            create_commits
        )
    '

Then, each test which needs to use "master.git" would 'cd' itself, like this:

    test_expect_success 'some test' '
        (
            cd master.git &&
            ...
        )
    '

> > > +test_expect_success 'setup shared.git' '
> > > +     cd "$TRASH_DIRECTORY" &&
> > > +     git clone -q --mirror master.git shared.git &&
> >
> > Why "-q"?
>
> To make verbose output cleaner.

What Junio really meant by asking that question was that you should
not do this. When something goes wrong with a test, we want as much
output as possible to help diagnose the problem, so suppressing output
is undesirable. To summarize, don't use -q, --no-progress, or any
other such option and don't redirect to /dev/null.
