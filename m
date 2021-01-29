Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E23C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6586064DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhA2BKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:10:24 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46693 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhA2BJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:09:56 -0500
Received: by mail-ej1-f51.google.com with SMTP id rv9so10544119ejb.13
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbWLeo4/6gtX2LwJ8EyedmxTRdQdmwkkq0CpF9Aguos=;
        b=NtO1sfQBZwiX4L5MInBfPTYBCkX/Cf/iBD5+zQmMLDKl85V9h/T+3v0o7bR6x7LgT9
         a8pWScAaQYj6qkG8lg3yltriX8YmKVqFvkA6p/GvcOWzk/LebTbQZvTLpTYkCfc+T5t0
         sF/CGlEMeEnLqfqrTDjwD1NT54tXWLAkUfYbdAGtNYMrHdVML7RWy4AyDiwWUWCSTVmK
         fj/zja9l7MBT6i5JlTTAP81LmvhkcaOGgbtkneoqqRN8CEGWsrpdh7ufyu59sFtJ+Eq2
         17Nk/5LgwiJXltweDI1oUdzrh7fBl0aXfomOAPgh0I4gjOmIi7aBuRq0FXBcVrnvkXHX
         nHDw==
X-Gm-Message-State: AOAM531pOFvif2aiaSrlAo9HZJOWdTsi9y0mbIdKiAVjf/hgxxajygCC
        B8q7tstXLx+vVHMmVPu6+7gnR99CjND9NHu4S0Q=
X-Google-Smtp-Source: ABdhPJzrs+M8hZTZxtG7qTtb9+jyCvs+MnFoayDZ6msFaMGonNyBqU6k7F8NN0dXJ6cibL9L9lJg5/scs/owGdLDid4=
X-Received: by 2002:a17:906:3514:: with SMTP id r20mr2189367eja.202.1611882554760;
 Thu, 28 Jan 2021 17:09:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610129989.git.me@ttaylorr.com> <cover.1611617819.git.me@ttaylorr.com>
 <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com> <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
In-Reply-To: <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Jan 2021 20:09:03 -0500
Message-ID: <CAPig+cQZkzFiAyCj6W7-7WC+Dx7aojcj4a+Xvmqvo10RLCoSZw@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 7:49 PM Jeff King <peff@peff.net> wrote:
> On Mon, Jan 25, 2021 at 06:37:38PM -0500, Taylor Blau wrote:
> > +sane_unset GIT_TEST_WRITE_REV_INDEX
>
> I think we had a discussion a while ago about sane_unset outside of an
> &&-chain, where it does nothing that regular "unset" would not. But I
> don't know if we reached any kind of conclusion. I actually argued that
> it was fine in:
>   https://lore.kernel.org/git/20200630185536.GA1888406@coredump.intra.peff.net/
> So I guess I should probably stand by that. ;)

I recall that discussion. The fact that sane_unset() outside of a test
caused a hiccup in your reading of the patch which led you to dig
through the mail archive and spend time writing about it in your
review could be interpreted as yet another argument against its use
outside of tests (specifically, it wastes reviewer time). Of course,
it's such a minor thing, though, not at all worth a re-roll.
