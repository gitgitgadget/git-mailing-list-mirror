Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA36B1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeKIEth (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 23:49:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33934 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeKIEth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 23:49:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so28564737qkg.1
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 11:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hbUm3djDTWFpNL28xR7QwCoNgccSP3vVJEnwBiUydE=;
        b=p8IIhMfaQPlw9xKk1xz4fdIik0bTm5GzNsoDrO0othhuu/wGfQC/sHtgO7nfZIpQ6U
         GdFAvPynsJw3Xe5befcqkQRv0mKPVTI/rJSAZnOMDWyT6WsWPPCn1X/EE+gh3vxdK+S+
         EA5S7rdRkAKS1hOT5hytsv2xmKMY55+9mLuHNWzW9RXd/jzQkDItADZ8pdFVfg9bhHH3
         dwgc6/EJdRi1JBByvR9s9agEpR+s3x4hkwuEIGZUcYCMF1xDnuq+EAo++dN8eQkYiV8b
         hgK9Ue4JY+gAYLEfbin0l+gqM7hPTKUvovhCHUriFg93zO6C9/ft3Iafz7ABhYzxc6hF
         kzQg==
X-Gm-Message-State: AGRZ1gKI5/rbEWbIKlYxmdVgQ8FSDw1F/iEROrFhI1yeZNSImGTxQeI0
        1OMMOSvKmqDFg/lZsyRQ13RomgbGfDNsXaX9meg=
X-Google-Smtp-Source: AJdET5dqf+5FH2HA/iD/2xshTxPkAAImzbP6AKxquoiKJlMJiwYsMKnXgGM+A9qZcIerZKGp8f7ph86MBjNjoOAOO0w=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr5760921qve.203.1541704365459;
 Thu, 08 Nov 2018 11:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20181024114725.3927-1-avarab@gmail.com> <20181101193115.32681-1-avarab@gmail.com>
 <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Nov 2018 14:12:34 -0500
Message-ID: <CAPig+cQR++wfWLrODNOioTu=FuLBKWX=P74kaS8X92Nrp6h_pA@mail.gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 7, 2018 at 10:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> Makefile: ease dynamic-gettext-poison transition
>
> Earlier we made the entire build to fail when GETTEXT_POISON=Yes is
> given to make, to notify those who did not notice that text poisoning
> is now a runtime behaviour.
>
> It turns out that this too irritating for those who need to build

s/too/is &/

> and test different versions of Git that cross the boundary between
> history with and without this topic to switch between two
> environment variables.  Demote the error to a warning, so that you
> can say something like
>
>         make GETTEXT_POISON=Yes GIT_TEST_GETTEXT_POISON test
>
> during the transition period, without having to worry about whether
> exact version you are testing has or does not have this topic.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
