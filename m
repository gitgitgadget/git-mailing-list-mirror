Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB26C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4EE20672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgDETS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:18:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgDETS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 15:18:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so14902950wrm.4
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 12:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJwmsG14at4UIY2ZZuZ+Ny4VA0PtLCewgKOMCkce5Ug=;
        b=byAntbmsWAhhJp3jnuXak4xvxtIf0aI9GbLKJrQN9PrnFAgOUUpcedzURMydbk6J6e
         UMqcHePXrw2QSxb0J+AZgfXbqPy/r2km89YUBqtuDpCRb4ENAZjdk1rduQ7ekFbDZizE
         zVyr8dt09Ai+KV+F++DXVAr5UdKCtmt2bJ6qcT8psgDsmXwMYOuTBiBoHKj0GdrFX4y5
         pbZp4eZwBj8rJsNqlGv/slGqtQmyvngef/g2H1SLi6++3CZLAERiLuvgFFe5IXl8KHES
         KTrNpxFSPzPJYH4DQSk+QZuyJfCBiwX8rKl8zt/iNWQRWvff34Wq0NyW+eZlkFDzMcrN
         U1jQ==
X-Gm-Message-State: AGi0PuZf6D0on4hJUZP/oivJ9r/a4Fa5MT3Fp+BjCwcwSlGX+mu/SmrV
        MzuUFAT7wJKEHmOlbVSb3tS9PGf+VuNucp4N+Zo=
X-Google-Smtp-Source: APiQypJz4jUf7VOh85KGNPnBVG6xQIr/sStTpIbTKriSnclRFfDRmhvJXRSSAZ99mDH0+bmx7cWDVaMsHX1IjEIXkqQ=
X-Received: by 2002:a5d:670f:: with SMTP id o15mr14229751wru.120.1586114304876;
 Sun, 05 Apr 2020 12:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200326080540.GA2200522@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet> <20200404145829.GB679473@coredump.intra.peff.net>
 <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com> <20200405184441.GA1309425@coredump.intra.peff.net>
In-Reply-To: <20200405184441.GA1309425@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Apr 2020 15:18:13 -0400
Message-ID: <CAPig+cSgQQHTX1fyZ7ZMftg4aygXOPnWV1vA5H=GTSKDCb_czg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 5, 2020 at 2:44 PM Jeff King <peff@peff.net> wrote:
> On Sat, Apr 04, 2020 at 09:33:51PM -0400, Eric Sunshine wrote:
> > On Sat, Apr 4, 2020 at 10:58 AM Jeff King <peff@peff.net> wrote:
> > > This is our first use of eval in the Makefile, but that goes back to GNU
> > > make v3.80, which is from 2002. I think that should be OK.
> >
> > Upon reading this, I was worried that it might trip up Mac OS which
> > has (often very) old versions of tools, but it's alright in this case,
> > as Apple ships GNU 'make' 3.81 from 2006.
>
> They're certainly good at keeping old versions of things around. :) I
> wonder if it's due to a switch from GPLv2 to v3. My understanding is
> that's why they'll keep bash 3 around forever, and the GPLv3 was
> published in 2007, between GNU make 3.81 and 3.82.

That is my understanding, as well.

> Anyway, I think we're good, but thanks for double-checking.

History repeats itself[1].

[1]: https://lore.kernel.org/git/20180802212930.GB32538@sigill.intra.peff.net/
