Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A85C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA3464F67
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhBDAPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:15:44 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:46582 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBDAPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:15:43 -0500
Received: by mail-ej1-f48.google.com with SMTP id w2so2002419ejk.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeN1uOoPWjzMffre32pHWyzX6Gdvx226KNRUeh8WOJI=;
        b=s+hD22wvr9PO/5gJNQmGhuBrtxL3Or9TtGkT9b0w784LdpXDZqCYV0ztDuhfYLdzGN
         U8Mb2aiVBjEUfyvzkpNDKGGVPc0sF8GyLGjAUw8oqpyOPEPiYt0ToDvFwZlOcmN5O5Nt
         6V4pW7VS5thSlx3JZahcz2HAscs0SnKAxjsODaSYgCGJZHNpIniUmQR1GAlEpz+g418x
         6aUKFEkxgmRloXgwme0xWwqFq5ToIVaBOy/wC/jNDylkj5spjiqUN6t5KgsNvOn1Oed5
         2zAKIacb6pJgtpv/5OuoNkYJzNwZV90c8ZVqLiGY14FhyL3lKFXiScDAQKtJL9jxdpsH
         OV/g==
X-Gm-Message-State: AOAM533jBOlhtbBuzRXTpCEZsvIs7YueXPn5GGKhotUSC0Tv7aCsutpQ
        6o4s0qMbyOKzYB9XiHMN1BTOYBE01z3C96+S1VI=
X-Google-Smtp-Source: ABdhPJyxEiFK12NySPgKBdwXcLmo2nOVcxhwyKCWf5ZbjaEIg/V6Qo1M1iNPF6bA0OkBTptTN/GEBJlQNFHdNXSkCu4=
X-Received: by 2002:a17:906:6d94:: with SMTP id h20mr5810295ejt.231.1612397701400;
 Wed, 03 Feb 2021 16:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-7-charvi077@gmail.com> <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
 <CAPSFM5fZHZDnmRD2GzwPVKwBjogKD=GJbC7e=6aQSbu_iXBdNw@mail.gmail.com>
 <CAPig+cRxmFr_Sbwdf4OFMr8Vp1q6O6J7AbgYAD5cgdD--hgDuw@mail.gmail.com> <CAPSFM5fLi-U3zVcXFip_kgchHSXiEUF9nngO2nSf31kAEBkq1w@mail.gmail.com>
In-Reply-To: <CAPSFM5fLi-U3zVcXFip_kgchHSXiEUF9nngO2nSf31kAEBkq1w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 19:14:50 -0500
Message-ID: <CAPig+cROYr0H80ZosNUQe_mxVaRtwgqirtNxFPr2a8tnenvwwQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rebase -i: add fixup [-C | -c] command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 7:01 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > > I admit it resulted in a bit of confusion. Here, its true that flag is always
> > > going to be specific enum item( as command can be merge -c, fixup -c, or
> > > fixup -C ) and I combined the bag of bits to denote
> > > the specific enum item. So, maybe we can go with the first method?
> >
> > Sounds fine. It would clarify the intent.
>
> (Apology for confusion) After, looking again at the source code, as we are using
> the flag element of  the structure todo_item of in sequencer.h. So, I
> think right
> way is to let it be in binary only and change type from 'enum todo_item_flag' to
> 'unsigned' , as you suggested below (better than first method) :

That would be fine, as well. Thanks.
