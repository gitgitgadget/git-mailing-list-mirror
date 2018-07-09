Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8431F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeGIIoP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 9 Jul 2018 04:44:15 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45767 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbeGIIoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:44:12 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so6877300ybg.12
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 01:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+ctsyoF8RDraXPi8J3+KG9PZG19G+cQFJNVR7QQaFE=;
        b=pPYgJY+ZD6CDfx7SGTpCvYHvkvFZ3vc7cnHLJwIiK2dzZTtVCHv+hgcb3mPm4QYWiA
         x4YcarlI7ZCOifJfQ+eN7fxFJ88gafmQIJu5Qs3DWVLk/eylI+W3QkXRpItEq3VKk0nM
         fF0MP9jxC012vTLzRr2gIBA6mAe51Z+H04juI5rE+4FtKCZK5re8neIswiDGvGVpGKmf
         Y3x/vwGbxSC3VkwKCq4jdUXZY7F0ZTzJLepNmlNHR7ShITvhIEgYT1gsVIbiKO9V5Bpk
         LvtX7td4b8nw+/Ktu36nFRBhzl23CGTD3jTVf406jH065Z/uxU72ZrG5uK4HRjOL2nhf
         ILDA==
X-Gm-Message-State: APt69E185Ot6En+0QOdhI3xAd/8zWOiRhKqFDRpZ2a34AL4mCrZagtj3
        JEeXe3fKrDNS1JZNh5f59y8HoFk4k+DlKlvq6cA=
X-Google-Smtp-Source: AAOMgpcnvSouC0Ig+5+kK0CtBkQ6IX06WXQFQBUpx6ufG3u2kZ5IowZDYH6pBJy9h8XHrHmnpWOV4gT5GdA2EyXLDPU=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr9684763ybp.76.1531125852056;
 Mon, 09 Jul 2018 01:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530616446.git.henning.schild@siemens.com>
 <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
 <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
 <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com> <20180709102139.274f0560@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180709102139.274f0560@md1pvb1c.ad001.siemens.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jul 2018 04:44:01 -0400
Message-ID: <CAPig+cQyXC2o4fUARL_kqPn5+6adBpr+WUfAWWgu2QLjDn1eoQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple
 gpg formats
To:     henning.schild@siemens.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 4:22 AM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Fri, 6 Jul 2018 10:24:58 -0700
> schrieb Junio C Hamano <gitster@pobox.com>:
> > Martin Ågren <martin.agren@gmail.com> writes:
> > >> +struct gpg_format_data gpg_formats[] = {
> > >> +       { .format = "PGP", .program = "gpg",
> > >> +         .extra_args_verify = { "--keyid-format=long", },
> > >> +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
> > >> +       },
> > >> +};
> > >
> > > I think those trailing commas are ok now, but I'm not sure...
> >
> > What we've been avoiding was the comma after the last element in the
> > enum (in other words, if PGP_FMT had ',' after it in the above
> > quoted addition, that would have been violation of that rule), as
> > having such a trailing comma used to be ANSI C violation as well.
>
> I guess that means the style is acceptable and does not require
> changes, please correct me if i am wrong.

The trailing comma in the 'sigs' initializer is bothersome because
'sigs' is declared as a 2-element array, and this initializer already
has two elements. Therefore, the comma is misleading to anyone reading
the code, making it appears as if additional items can be added. For
that reason, alone, it would be nice to see the unnecessary comma
removed.

Ditto with regard to the trailing comma in the 'extra_args_verify'
initializer since 'extra_args_verify' is declared as a 1-element
array.
