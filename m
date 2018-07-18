Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C55A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeGRUfQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:35:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36726 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeGRUfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:35:16 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so2190972ywg.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3XqXCMnurOk/2fAK0ZHR1VaLmYhEehc1nSwIQgHWns=;
        b=UVj6ELR6GElO/V1caoJT985JuydNn0UweqAqTe2W/tl1ns4m3SjSGnu9ehUnBC8ehy
         ZfCf15oapMnbiODrWeZYkfO4wUWPaCG9Z/LKd/uLVB7uMf92u4fFrYzVDppdJKHVk1GR
         LImyRIlCJ0nN6+FBXkXjQwk6ZxyGx9UZX4s9XUIYSeivNh/9W+MLf5cdRvudUDqHkdn7
         qWHzABeG//F1MiNPhpeX/FE8W8E9nWlNHoiVk/lAozlqXlwk1J6x39XWlpce3iY0BHQc
         qriKDT4WbIJ2tr9S7fC+L6Y0u+/QI/tgbw67Ngx5OpB91jGU38tW6UAt/fKrQSV5wSfE
         hMoQ==
X-Gm-Message-State: AOUpUlE2CZJUTdM3kSbawnwAoWGbVKsOQBGlsCZPR2+qVrDfA5hffZMG
        TkyDPpUPBgMUGOJRrtNS4tT+zsvpOGUcnnfSdQc=
X-Google-Smtp-Source: AAOMgpe6fFWBo9CCxVlYqfKuD5uyF1PKkji/gDgLQ7gXkg3Y5I+2AGFeJhciUdfHEJgM06Ha+N3vUSdSSrCNl+t95Ks=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr3798357ywc.70.1531943749940;
 Wed, 18 Jul 2018 12:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
 <CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=M0cNR3L5UJGGC6vHPDQ@mail.gmail.com> <CAGZ79kYCDR=m0C1Vmh5U2tsj5bTTpGUo1mKe0BMDKmO5riBLLw@mail.gmail.com>
In-Reply-To: <CAGZ79kYCDR=m0C1Vmh5U2tsj5bTTpGUo1mKe0BMDKmO5riBLLw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Jul 2018 15:55:38 -0400
Message-ID: <CAPig+cT9zCcNxn1+DPMQWqJ-hfxb7gE7rKyfbqHjTC+FDNY_mw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 3:34 PM Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 17, 2018 at 11:59 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > The "git-format-patch --range-diff" option implemented by that patch
> > series (and its upcoming re-roll) place the range-diff before the "--
> > " signature line, so this isn't a problem.
>
> Now that I grow more accustomed to range-diffs, I wonder
> if we want to have them even *before* the short stat in the
> cover letter. (I usually scroll over the short stat just to take it
> as a FYI on what to expect, whereas the range-diff can already
> be reviewed, hence seems more useful that the stats)

I did consider placing the range-diff before the diffstat, however,
what convinced me to position range-diff last was that the diffstat is
usually short and easy to skip over both visually and via scrolling,
whereas the range-diff often is long and noisy, thus more difficult to
skip for someone more interested in the diffstat.

So, the choice was deliberate. However, I also considered making it
configurable, but that's probably something that can be done later, if
needed, once we get more experience with the feature. It's also worth
taking Duy's wish[1] for customization into account, as well, before
designing such capability.

[1]: https://public-inbox.org/git/CACsJy8D=6fAEpO5m4cc7KZyggAW1AosSkUWaunQBFH0nr-YrdA@mail.gmail.com/
