Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940C31F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeG3Uzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:55:38 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42600 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbeG3Uzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:55:38 -0400
Received: by mail-yb0-f193.google.com with SMTP id c10-v6so5193451ybf.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=go0mtvSpSQkrfoO2ccR0Zagcn05QSx0ZLzW5s7I24NE=;
        b=LOgTXYjtUFzwe6OAx4Nl0ensvR4zH9mO4mVLJk9d0hfNjQKm9POVubFQFw9Hu/w56Q
         okYDhes8QPWjxrdBiRJ73F/vgxj3qvJi0t6SlSk/TQQXhtzq4qM/AH3UmEoU8OvmFK5X
         1+gvd0iedAGkwm4ipCh0Q3XNUtCzfBKWjq1qW5vsXUJlZi/edpkkLaumUxWXQ0V5D2fo
         M6u2L1MgFnBEsPJ4k58o/57CZLNyJfmk8ZfIEJ7vcsuUaT5UnsmUO7hohYJ4uIV7RRTX
         gHlQ3lXcVmHNOyEWStP9HTAWvpKKxDKTRNfkCViF/eDsAlRcJiIrKhnKuV/KmYzCsvr6
         RhZQ==
X-Gm-Message-State: AOUpUlF4cD0v2b4Kw+MJp1dnmTVv9paBHVFJnl9ih+NLfPr1wxDVl521
        njqOCviwzkKsXCjFUoHw7ig5jrTV20NHbqpgUiw=
X-Google-Smtp-Source: AAOMgpfKNAbSL+i3EO4wqVMFGSyDxPbxZAse8nNUM1lWJMNQyNVVai+wmZDaLV/V3G2Fi8gdJaO2dJMdDErxrWZTYXc=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr513676ybd.497.1532978352503;
 Mon, 30 Jul 2018 12:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180730092929.71114-1-sunshine@sunshineco.com>
 <CAPig+cSYPEqapdQ=7zjW-RsM6XxCw2vPzZzV32uh_SgO4cQSog@mail.gmail.com> <nycvar.QRO.7.76.6.1807301746190.10478@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807301746190.10478@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 15:19:01 -0400
Message-ID: <CAPig+cT78x-2er4mMMwPAjGYpf=MSzYNUti_T6XGoO9Ue4EMog@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 11:47 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 30 Jul 2018, Eric Sunshine wrote:
> > Unfortunately, after sending this series, I see that there is
> > additional corruption that needs to be addressed. In particular, the
> > "author" header time is incorrectly prefixed with "@", so this series
> > is going to need a re-roll to fix that, as well.
>
> AFAIR the `@` was not an oversight, but required so that we could pass in
> the Unix epoch.

I don't think it was an oversight either, but it is nevertheless
incorrect to use the "@" in the commit object's "author" header.

As I understand it, you do "need" the "@" to distinguish a Unix epoch
value assigned to GIT_AUTHOR_DATE, but the commit object format is
very exacting in the datestamp format it accepts, and it does not
allow "@". So, the date from GIT_AUTHOR_DATE needs to be converted to
a format acceptable to the commit object, otherwise the commit is
considered corrupt.
