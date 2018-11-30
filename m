Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A525211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 09:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeK3VHC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 30 Nov 2018 16:07:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45179 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 16:07:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so2792184qka.12
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 01:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90N9d4O1g8hQnkGaNs1fBzEsjpXsRa59bVYvFO/xzqs=;
        b=WJQZh8V6rHOvA/HMMCR++UcPywU0hKXpuvgsfooBcddtVSdq4OeaQWhYCabfr6xdV1
         ec/MrwClafaEmZsfhpSVSYyFTzUhPEDpSruYgB9Kh0AIWWhiABPtssj/6oBLoIedHT6h
         ikdFoE1tk5w05RzVtCjjr1laV7sjcsJbxoDHdhM66pKFprCKtmepIp1n7HTT5n7j3oZF
         fMHWXMWySVTp1rrwlHqFDtDgz8k/nR9MjRNNhD+p/dVfuaiOvNwGBC0xJ2Ff7I3WSY0T
         CzTzBvtdWB0RQi+Phe5ZhWjuCthFce4ObQarA67cFgaTKzF28mn2FW78/aoLArt1W2kS
         EQKQ==
X-Gm-Message-State: AA+aEWaIj68EhW5VoGG2+18ngoIupwWjr5t402BVezjIuhUVmgXimBDK
        mUsA3T789TNcBrLO3JeyLpCedzbMY3HKpElBYBY=
X-Google-Smtp-Source: AFSGD/UfuQPqCKWI2g8MsQpQuCBnOCVLa/i5QkLGSddP9EdBvoKFXisOWEGR5T9+u382tNH2ukoREX3bhA86E4Wd6MM=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr4440331qkb.220.1543571896139;
 Fri, 30 Nov 2018 01:58:16 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com>
 <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet> <871s74yms3.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com>
In-Reply-To: <87tvjzyiph.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Nov 2018 04:58:05 -0500
Message-ID: <CAPig+cQYbuySiWNbDevjRs7rvwy-HBXvfj2fkCWnV+JGkVD6pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 11:03 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> I mean not just nasty in terms of implementation, yeah we could do it,
> but also a nasty UX for things like --word-diff-regex. I.e. instead of:
>
>     --range-diff-word-diff-regex='[0-9"]'
>
> You need:
>
>     --range-diff-opts="--word-diff-regex='[0-9\"]'"
>
> Now admittedly that in itself isn't very painful *in this case*, but in
> terms of precedent I really dislike that option, i.e. git having some
> mode where I need to work to escape input to pass to another command.
>
> Not saying that this --range-diff-* thing is what we should go for, but
> surely we can find some way to do deal with this that doesn't involve
> the user needing to escape stuff like this.

I should mention that it was never the intention that
git-format-patch's --range-diff option would allow passing _all_
possible options to git-range-diff, but only those most likely to be
tweaked by the user (such as --creation-factor). It was understood
from the start (and stated by me either in the cover letter to that
series or in discussion) that the user always has the escape hatch of
running git-range-diff manually and copy/pasting its output into the
cover letter.

So, I'm not convinced that we need this sort of flexibility in
git-format-patch's --range-diff option, but we certainly can add
convenience options (such as I did with --creation-factor) as people
complain that their favorite option is missing. For a UI, I think we
already have sufficient precedent for
"--range-diff-opts=nopatch,creation-factor:60" as a possibility.
