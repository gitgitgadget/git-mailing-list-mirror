Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF3C1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKEST1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 13:19:27 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:41836 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeKEST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 13:19:27 -0500
Received: by mail-qk1-f172.google.com with SMTP id 189so13323853qkj.8
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 01:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pfy4UmgqGk5dOIaUCbzHx0dqXiPlMM8gBUP1RJVcwg=;
        b=Cb124KghNOVu6UN//n4TfLrvOcO6I+6BgJI0Nv6yEBfvXi4MEcT0G7ODw5RZ/KDLh/
         wLpFc8rRi0cUZIymmTlMR43uB315MXIBmA0UFGQcTpbCcODBqzAOp9ouq8OEkMUUn8i0
         lXlClj126Ntvik3x/KnLpKdaH8PqI3txp8VjtLfjXjPD1dCPRMU43JLdhM2sMEuJ2/Kn
         Xdl/8R26RVo3hQUGjynfl5vpQmMoD/htMFCr5SyFK7ZosC1CxBZwX7BArbrVbC4Aio0n
         EkO3is2CQtUOTl1G6y6jIMQXrQQ86K7J7p+dTYsrF+kmpHzOvVtlN+PjCOhZOS+dFnTj
         2Acw==
X-Gm-Message-State: AGRZ1gI6y17AwUm/d0CwTW7+DxFMAdqriTZDZdx+dBM5rquNniLJAYyj
        vziELpEineynMLPF05OvDTZSjOaS1X7E+tXifyg=
X-Google-Smtp-Source: AJdET5e/QNFDMeUdUu5SSzrzaISwTBHv1WxqQTQRFlvMLgX+A9E2YliHFpHVVVsmnRlkGPQBDaETyqzxLs3C92PnCNo=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr20043924qvg.6.1541408446672;
 Mon, 05 Nov 2018 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu>
 <20181104152232.20671-3-anders@0x63.nu> <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
 <875zxckk1g.fsf@0x63.nu>
In-Reply-To: <875zxckk1g.fsf@0x63.nu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Nov 2018 04:00:34 -0500
Message-ID: <CAPig+cTdAA-uPgi_viHhR8b17MgdM5RQ_7v-dWH-tr7BZa1Adw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
To:     anders@0x63.nu
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 3:26 AM Anders Waldenborg <anders@0x63.nu> wrote:
> Eric Sunshine writes:
> > Should the code tolerate a trailing colon? (Genuine question; it's
> > easy to do and would be more user-friendly.)
>
> I would make sense to allow the trailing colon, it is easy enough to
> just strip that away when reading the argument.
>
> However I'm not sure how that would fit together with the possibility to
> later lifting it to a regexp, hard to strip a trailing colon from a
> regexp in a generic way.

Which is a good reason to think about these issues now, before being
set in stone.

> > What happens if 'key=...' is specified multiple times?
>
> My first thought was to simply disallow that. But that seemed hard to
> fit into current model where errors just means don't expand.
>
> I would guess that most useful and intuitive to user would be to handle
> multiple key arguments by showing any of those keys.

Agreed.

> > Thinking further on the last two points, should <val> be a regular expression?
>
> It probably would make sense. I can see how the regexp '^.*-by$' would
> be useful (but glob style matching would suffice in that case).
>
> Also handling multi-matching with an alternation group would be elegant
> %(trailers:key="(A|B)"). Except for the fact that the parser would need to
> understand some kind of quoting, which seems like an major undertaking.

Maybe, maybe not. As long as we're careful not to paint ourselves into
a corner, it might very well be okay to start with the current
implementation of matching the full key as a literal string and
(perhaps much) later introduce regex as an alternate way to specify
the key. For instance, 'key=literal' and 'key=/regex/' can co-exist,
and the extraction of the regex inside /.../ should not be especially
difficult.

> I guess having it as a regular exception would also mean that it needs
> to get some way to cache the re so it is compiled once, and not for each expansion.

Yes, that's something I brought up a few years ago during a GSoC
project; not regex specifically, but that this parsing of the format
is happening repeatedly rather than just once. I had suggested to the
GSoC student that the parsing could be done early, compiling the
format expression into a "machine" which could be applied repeatedly.
It's a larger job, of course, not necessarily something worth tackling
for your current needs.

> > If I understand correctly, this is making a copy of <val> so that it
> > will be NUL-terminated since the code added to trailer.c uses a simple
> > strcasecmp() to match it. Would it make sense to avoid the copy by
> > adding fields 'opts.filter_key' and 'opts.filter_key_len' and using
> > strncasecmp() instead? (Genuine question; not necessarily a request
> > for change.)
>
> I'm also not very happy about that copy.
> Just using strncasecmp would cause it to be prefix match, no?

Well, you could retain full key match by checking for NUL explicitly
with something like this:

    !strncasecmp(tok.buf, opts->filter_key, opts->filter_key_len) &&
        !tok.buf[opts->filter_key_len]
