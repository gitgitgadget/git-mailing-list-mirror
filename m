Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0F01F404
	for <e@80x24.org>; Fri,  7 Sep 2018 09:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeIGNz1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 09:55:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39959 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGNz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 09:55:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so15519172qtj.7
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 02:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pyqhNrtlrJ7ixTfWltinatQCBRBjyQf1/135a6LJqo=;
        b=F4p0ebg7abFwqksTnju4B1ZZ5EgGKOBPWtydWf3j6sSZsFaujFTgPolv84/NrBY7ao
         lsQGqY7Bqtj+BMv1RSMUhyB9uQJZ9fw+DfGewY1VvFCSh2gMIOzj/5Ej98gGqaQaDndQ
         d+2uBxQa4Cil3bA5WVtDwMGRhSLyCrwvRrfj39i8WqJ+89Xm9FUXf8JRa/8g6KlLXYbJ
         0ARGGZhP1Nd5gtNVqJ/h9FCVJvPFFchQqBNMWJ3ogQI+6Lp6K/LuR9JvjltbgF/20vzE
         llgn+9JaBzmxwRwqGYXeH7Wres+2TI49oK+Onx3b9Rl5JkuUq0g4Zoi3vMxFXgofQ9u2
         4UJA==
X-Gm-Message-State: APzg51C3RHTi8PIqge99Gwzidekm8/RRRmd15IXaMp4DWtFmo4ER4wBE
        MprYdj44bWBbNCVBpwgaqQ7noHnsH6XI/FVMO20=
X-Google-Smtp-Source: ANB0VdaQrwCJm1tzhGjqWqbk8/LttZqPFMNbTs18UkkzeYeKeZouA8geUDn1gJlfKv3D5JFZioy5yxRVjTBGuQw9gGo=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr5317984qtd.101.1536311725696;
 Fri, 07 Sep 2018 02:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-12-sunshine@sunshineco.com> <xmqqva93t4u7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva93t4u7.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Sep 2018 05:15:13 -0400
Message-ID: <CAPig+cRfcJYux2Rfaq-2NhW-d9vD1J-Mg_NmjGMbrW2S0RWB4Q@mail.gmail.com>
Subject: Re: [PATCH 11/14] format-patch: extend --range-diff to accept
 revision range
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 4:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > When submitting a revised a patch series, the --range-diff option embeds
> > a range-diff in the cover letter showing changes since the previous
> > version of the patch series. The argument to --range-diff is a simple
> > revision naming the tip of the previous series [...]
> >
> > However, it fails if the revision ranges of the old and new versions of
> > the series are disjoint. To address this shortcoming, extend
> > --range-diff to also accept an explicit revision range for the previous
> > series. [...]
>
> >  static void infer_range_diff_ranges(struct strbuf *r1,
> >  {
> > -     strbuf_addf(r1, "%s..%s", head_oid, prev);
> > -     strbuf_addf(r2, "%s..%s", prev, head_oid);
>
> I thought "git range-diff" also took the three-dot notation as a
> short-hand but there is no point using that in this application,
> which wants the RHS and the LHS range in separate output variables.

Correct.

> I actually would feel better to see the second range for the normal
> case to be computed exactly the same way, i.e.
>
>         int prev_is_range = strstr(prev, "..");
>
>         if (prev_is_range)
>                 strbuf_addstr(r1, prev);
>         else
>                 strbuf_addf(r1, "%s..%s", head_oid, prev);
>
>         if (origin)
>                 strbuf_addf(r2, "%s..%s", oid_to_hex(&origin->object.oid, head_oid);
>         else if (prev_is_range)
>                 die("cannot figure out the origin of new series");
>         else {
>                 warning("falling back to use '%s' as the origin of new series", prev);
>                 strbuf_addf(r2, "%s..%s", prev, head_oid);
>         }
>
> because origin..HEAD is always the set of the "new" series, no
> matter what "prev" the user chooses to compare that series against,
> when there is a single "origin".

I plan to submit a short series as incremental changes atop
es/format-patch-{interdiff,rangediff} to address the few review
comments[1] (including my own[2]), so I can make this change, as well.

[1]: https://public-inbox.org/git/CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com/T/#rfaf5a563e81b862bd8ed69232040056ab9a86dd8
[2]: https://public-inbox.org/git/CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com/
