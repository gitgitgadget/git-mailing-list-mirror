Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B14320248
	for <e@80x24.org>; Thu,  7 Mar 2019 23:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGXYv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 7 Mar 2019 18:24:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGXYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 18:24:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so19406846wrw.8
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 15:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9bw7cZ/NHSZsVHqO/UC6odIwhkzbAcakChG1WEztklQ=;
        b=Sdgr7ekHBJKaNNif78myB4wNtwXoNi4ps55IchPBNeszlztH8ja1C9rAPM/CIiWnsF
         UZh2Em+gZXOCW3MMpLIjz1G8poro/KkCWnNpjWMqgF6E6b4FNi7YWo4ydrHCE8h04kIX
         MmEGROrnAEznWaRzMIYD4Jg3MTYBmsOdpR1XFRf4VChCwxW9Ykz3FNEW5ECzG5gnmKZM
         RA/kgBy5XPzECDFoUP3FOzfcBSNHJguYZreRiS70BPqveTZgG+OuDxxHMp98fX3g2PcP
         x8a8GDUNurMRz7HmixQn2JATiP5/onXOjRLKoVtUrgTdu4dAlA8wOHXhIwH9buQ5JrDC
         faiw==
X-Gm-Message-State: APjAAAXd9vtyWjILPboEEddvwKEqeXHUdroZrT1vLd2Cpzu7uQM868qj
        eox4pzX0FtOeL6zOq1vjkdH0tKCJjnLl2lHJBBw=
X-Google-Smtp-Source: APXvYqwEieSXrLjYGwOcTepVsl4nnYLN4tP36CXO12CIMWC99X3Wfkmhwg504xDpwZzgXiJfoNgVHr+rgmpQRuLbnOI=
X-Received: by 2002:adf:f149:: with SMTP id y9mr8265271wro.282.1552001089125;
 Thu, 07 Mar 2019 15:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20190226105851.32273-1-pclouds@gmail.com> <20190305120834.7284-1-pclouds@gmail.com>
 <20190305120834.7284-2-pclouds@gmail.com> <20190306214912.GA32630@sigill.intra.peff.net>
In-Reply-To: <20190306214912.GA32630@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Mar 2019 18:24:37 -0500
Message-ID: <CAPig+cSra900Zz3zytZTCP=QJpRr0s19gFzng0kJ00T0T8pQ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] refs.c: refactor check_refname_component()
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Yagamy Light <hi-angel@yandex.ru>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 6, 2019 at 4:49 PM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 05, 2019 at 07:08:33PM +0700, Nguyễn Thái Ngọc Duy wrote:
> I had envisioned just sanitizing each character into an output buffer as
> we did the checks. It does introduce some complexities, though, because
> now the checking function is doing the replacement (so it has to know
> the right sanitizing rule for each case).
>
> The patch below is a rough cut at that, just for discussion.  You can
> ignore the check-ref-format bits; they were just to make poking at it
> easier, though perhaps we'd want something like that in the long run.

This is more along the lines of what I had envisioned, as well, after
looking over the implementation of check_refname_component(). It's a
bit noisy and loud but easy to follow, and doesn't give rise to
concerns about quadratic behavior, etc.
