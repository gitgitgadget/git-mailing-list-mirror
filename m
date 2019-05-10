Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795451F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfEJUkN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 10 May 2019 16:40:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:40:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so9184991wro.10
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tLPqJnrTjNPCVz8p7UezKVS5WaCJTEKDtAhQ5XijUmM=;
        b=B3oyfkXJXMiDYt05ivmuhLmVZF0fjIjk/Jm0+EhIhp3Emo6cMKv+YygZmdb6nJy/gt
         D+tcGB+wpBtKQgVB9mTpX2p/BaEz27P1Y2iFoR1aueJPjHyePZsjSO3Uy8pqhD+yJF2D
         Cxzl+bfOcopTlZbhbGouvdHHQY4K6ktGHzh7mr3KhWQAfggtS0PWK5GIz9qSzzXC9hzX
         4GX24JN8slK/N+vpjlVtZszRCDNGsn7HqVazg4Ior4vAYEAProWdisbrWKDQyXdRjrtd
         VqNPpDeBfLCN4WndhAPkbT/CR3B4j3/vi0u2SnWOrtL5n/JgdKUrYvcB4AFn0swzKcSU
         m8mw==
X-Gm-Message-State: APjAAAWpoGnBgNxynM+XuhaCjUGR5qd2i/AOb8Ha9x5BXULqIpXZ1DKP
        HyTHwLBJ2yTyv01Gjp11J/UIpW88WCT22HteSL9uLiGk
X-Google-Smtp-Source: APXvYqzQWGik33oqDpD1phD+D845emrx3yeHLnqPrPC3aUVgfdLDbH1dKchRdmW8o9MffSsPoIoRSnbGsZz53+FwBSs=
X-Received: by 2002:a5d:4206:: with SMTP id n6mr1330388wrq.58.1557520811683;
 Fri, 10 May 2019 13:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
 <20190509102037.27044-1-sunshine@sunshineco.com> <87ftpnhknn.fsf@evledraar.gmail.com>
In-Reply-To: <87ftpnhknn.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 May 2019 16:39:58 -0400
Message-ID: <CAPig+cR30dnurYq=G_Ki2Nf7vFCkebcR+egvhbGE5w8XSBKQBA@mail.gmail.com>
Subject: Re: [PATCH] check-non-portable-shell: support Perl versions older
 than 5.10
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 9, 2019 at 8:33 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, May 09 2019, Eric Sunshine wrote:
> > Although this implementation is well supported in reasonably modern Perl
> > versions (5.10 and later), it fails in a couple ways with older versions
> > (such as Perl 5.8 shipped with ancient Mac OS 10.5).
> > [...]
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
> This fix is fine, but just for the record: There's no problem with
> assigning to $_, it just throws an error about $_ *because* of the
> readline() issue, i.e. it'll fail, clobber $_ to a read-only value, and
> off we go.
> So just assigning to $_ is fine, and you don't need to localize it.

Thanks for the clarification. I'll drop the misleading discussion of
$_ from the commit message and eliminate $_ localization from the
patch proper.

> Anyway, I tested this on 5.8, it works, then looked at the output and
> wondered if I could improve it, came up with this:
> [...large WIP patch snipped...]
> I figured it was better than the current output just squashing such a
> long line together [...]

That could be done, though it is outside the scope of this
portability-fix patch.

Also, the existing output with its sufficiently clear problem
explanations is probably "good enough" to clue in the developer of new
test code as to what needs fixing, so I'm also not sure that it's
worth that much effort to prettify what should be a relatively rare
warning message from code which has not yet made it into the project.
I wouldn't be opposed to someone working on it, but I don't plan on
tackling it myself.
