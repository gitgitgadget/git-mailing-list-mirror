Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B171F453
	for <e@80x24.org>; Sun, 30 Sep 2018 04:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeI3LL4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 07:11:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35625 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeI3LL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:11:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id z14-v6so10818027qtn.2
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 21:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WRLY2jlMa8+Xr0uztMbjxF5s6Py/IfEWTRhoBoBiXE=;
        b=TrewJtJqiPD71HvjBcC49bLx94S5NEfWXVgh3aQuZ3jOq9wiuGxHB948OFQbF5NSNy
         1d5mTYBXUaCj+Ni7L+d0Dj5i/BHUP3Kj/CZ+CecdL99X3TwwuiNRKG4lqRBcy0IFN2lH
         G0RMjRXS5F0wpottnt+1ned2S2/M/M5zN+dbdf/UnuELoDbx2niQGXgmEBl+w6/E0p7y
         /P4/6LBXaULAt+jUZ9qq33MGD4Tve4EvSnAl3N+ds8fYM9U+w6R2FucK16xUjZ2UkRfF
         IohDxX+knwOKbivA9WiN37lKLT+ZPwMtafLvFEwkqaiTedETas6n+ZWXCABqHJd8uKoO
         ynKQ==
X-Gm-Message-State: ABuFfog0JVvfZ8XsnYK+6+XdzTZO5IfDmpnoCbKi8FpnHgoj5LHVuGUK
        ne7AqR4YGMHyGgHlxj9owdvoSZpblOGdEdmKzUw=
X-Google-Smtp-Source: ACcGV61Yq0fxyiv5AhiRG1ixBwfudSEaIQI91VtbQvsXJnV/jshT+8pquvZ4tlfPnudKkLicjywu1qJyMSRLKffBywM=
X-Received: by 2002:aed:2171:: with SMTP id 104-v6mr4128306qtc.220.1538282431728;
 Sat, 29 Sep 2018 21:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com> <20180928044936.2919-1-ischis2@cox.net>
 <20180928044936.2919-2-ischis2@cox.net> <20180928135549.GA23652@syl>
In-Reply-To: <20180928135549.GA23652@syl>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 00:40:20 -0400
Message-ID: <CAPig+cSW1D9hEc8CX-QmqSA8jJw+2E1hSYXk7osZJVQ9_JNThQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] roll wt_status_state into wt_status and populate in
 the collect phase
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Stephen & Linda Smith" <ischis2@cox.net>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 9:55 AM Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Sep 27, 2018 at 09:49:36PM -0700, Stephen P. Smith wrote:
> > When updating the collect and print functions, it was found that
> > status variables were initialized in the collect phase and some
> > variables were later freed in the print functions.
>
> Nit: I think that in the past Eric Sunshine has recommended that I use
> active voice in patches, but "it was found" is passive.
>
> I tried to find the message that I was thinking of, but couldn't, so
> perhaps I'm inventing it myself ;-).
>
> I'm CC-ing Eric to check my judgement.

You're probably thinking of "imperative mood" (and perhaps [1]), which
this commit message already uses when it says "Move the..." and
"Create a new function..." (in the couple paragraphs following the
part you quoted).

> > Move the status state structure variables into the status state
> > structure and populate them in the collect functions.
> >
> > Create a new funciton to free the buffers that were being freed in the

s/funciton/function/

> > print function.  Call this new function in commit.c where both the
> > collect and print functions were being called.

[1]: https://public-inbox.org/git/CAPig+cTozduqSAxh+w4H85m7en72Yo09asdx+1KSTswqbnBr4w@mail.gmail.com/
