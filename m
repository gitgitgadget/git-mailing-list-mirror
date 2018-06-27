Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3571F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeF0SYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:24:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40822 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964840AbeF0SYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:24:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so1039049ywg.7
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYUh7hOr9KxwculOI09ZJck1vkyNb2MtWLpjmaEmGDU=;
        b=SnLVRlTwlKkHtEmAecbNxGh8cJS8ciQjycedUNHdnfwQgsYmj9UYBNIwBIgURWmrED
         KWkSbsqwKBWVMcXSNljKZ9QooNYaAkBqnH9LCvi+GXQrXbScm+ZQ6aELc/ExRhM56hrz
         PMmw4Ms48loxILneyqrubXlL59dMIEwa+pTX6yHUO+4z5HcK5HAngXyHOYYbcWFX8f7E
         XKQybfhnz+qn6JCtejMRKVC3zNAJbcdiHB3E6KNS/vPILrRwjbDg3jFOZQEtCbE7bIPS
         A/tLYuKSp4c+oyjMkLV5peFsanG5O4I5l2+MeXrXATlanz/ZP7s5xUPviyPxhGeJbyJO
         49IA==
X-Gm-Message-State: APt69E15AioXRzPfuY7qNe+rOcFeoSAm0ElLrkY6wm35kUb0Y2qVOiLt
        xUb2eHYVS7PhtsNFigLe4ZpVJ8f1S/nEBxq8XjQ=
X-Google-Smtp-Source: AAOMgpfVauegPJjL3MtqC+iI6nbOExxDD3Cv1v/B/HocjjkkrfuA3lgzpXHJbdL61QVVmKF7k2jWaVkpjczAepp2vFQ=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr2973811ywr.16.1530123880763;
 Wed, 27 Jun 2018 11:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180607050845.19779-1-newren@gmail.com> <20180627073623.31725-1-newren@gmail.com>
 <20180627073623.31725-2-newren@gmail.com> <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
 <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
 <xmqqh8logofg.fsf@gitster-ct.c.googlers.com> <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
 <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
In-Reply-To: <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Jun 2018 14:24:29 -0400
Message-ID: <CAPig+cRckrRSp6Wg7vWXuOWUTW8rChFpVM9Px06u+Kb_p1-8-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 2:17 PM Johannes Sixt <j6t@kdbg.org> wrote:
> Pitfalls ahead!
>
>         PATH=... git rebase ...
>
> is OK, but
>
>         PATH=... test_must_fail git rebase ...
>
> is not; the latter requires the subshell, otherwise the modified PATH
> variable survives the command because test_must_fail is a shell
> function. Yes, it's silly, but that's how it is.

As an alternative to the subshell, some test use 'env':

    test_must_fail env PATH=... git rebase ...
