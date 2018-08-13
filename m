Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94DB1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeHMW4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:56:52 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42776 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMW4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:56:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so18838896qto.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0I+0j1rLxux5aUUpq8/PbDbjpsG/r2tg4oziDaxqQ9A=;
        b=tKhrZXuon4ZJoUftjyN4ESlSzH5xqD6+dXRUi4my2k+BEWbIgYlUR0VuuCMRdVg66I
         1G8WD4XGwE8WGAjJuijd3FJBoa81wuu0mcoLDWwB4+n8tRLY0R5WwDjhzt+pBwYnqcEw
         IZtvP2FkKAN1ObZa/BeclVBYGsWpR9+rqa2d/g4lESfe4LnIMhntw3DTcs41PVXvjYsv
         U5FMvtOVRkFuPflXS2JWZZ0TOKHfCmo1bQS1xn0AsnMzVWEnexZ2zpCf/lL5g9QZrG0P
         8c7ydZ/nML24cTcJWsZeVr5FMLD8UiMulalYn8LoV/4wTNxtKJTjcWQZPdKOrEmzVFWn
         GMrw==
X-Gm-Message-State: AOUpUlHFDO0EKWL8eiic9AI3YRGUeav5SaZnitrd5UolKxljDdnFNuFz
        fXyhuVHASxrtBdrYw6+qGncW2bUypfCP2WIDckA=
X-Google-Smtp-Source: AA+uWPzixluU/QxaiCuw2xYtd9kNkZL6FTQMZNY3OEPlM0VGaDMW6vxoZnKmdEPfP7HwCPV5aftoOZuTwNp8SkOEgNc=
X-Received: by 2002:ac8:1019:: with SMTP id z25-v6mr18528671qti.25.1534191187270;
 Mon, 13 Aug 2018 13:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180813084739.16134-1-sunshine@sunshineco.com> <20180813084739.16134-3-sunshine@sunshineco.com>
 <xmqqwosu3w4k.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwosu3w4k.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Aug 2018 16:12:56 -0400
Message-ID: <CAPig+cQNXiZ8MhapGGikB0bwO2Cm-YHFRbZice22opWTAEhwgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] chainlint: match 'quoted' here-doc tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 3:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > A here-doc tag can be quoted ('EOF') or escaped (\EOF) to suppress
> > interpolation within the body. Although, chainlint recognizes escaped
> > tags, it does not know about quoted tags. For completeness, teach it to
> > recognize quoted tags, as well.
>
> Is this step merely completeness and future-proofing, or do we have
> existing instances that the linter would be confused without this
> patch?

We do have quite a few instances of single-quoted 'EOF' in the tests
already, though none of them confuse the linter, so this change is for
completeness and future-proofing.

> I am primarily wondering what the reason is that <<"EOF" is
> not looked for while we are at it (the answer could be that we
> have tests that use <<'EOF' but not <<"EOF").

It's an oversight on my part. I've gotten so used to \EOF (and before
working on Git, 'EOF'), that "EOF" just slipped my mind[1].

I do think it's worth a re-roll. Thanks for noticing.

[1]: What did not slip my mind is that quoting _any_ part of the tag
suppresses interpolation, so 'E'OF, E'O'F, and even E''OF are all
valid, however, that's so ugly that I really didn't want to support
it.
