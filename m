Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DCC4332D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C264F2D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578477AbhCBPYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:20 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40785 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577115AbhCBFoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 00:44:03 -0500
Received: by mail-ej1-f53.google.com with SMTP id ci14so13903930ejc.7
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 21:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0f4gLSH4oaDWEnFiLc2nGLW10Lg33GrM5f75NtGEDeY=;
        b=rEsoB53VDuyuSFJPKJyp7/ilMQusRujXdc6/EHvA2hwXbk0Jq9kK6YAbOVnQ3wcctV
         rSSzBo1vAe6TE2TGQnuxEaA141QmvJfnRSiUykZrYSEh9mjYeVtri2P3lIdErIJXXFLA
         KGmH6Df1aiMO7AwUDZiu3dsAzjBoaN7l3c8ylU8ZWuKsB47GAAO6Mf+HGTBlUBlhqI/J
         dU7nM2jt+CpQnk5pR90o03zTTk9f/Qh5WuRaIHBFmIibsWG83uSsVKjAbzxTsiQoQWZP
         Dyv0VnVdpBv0yeLGlAlGfJPcxWv5g6+icvbw8Oh3CQfo0cgs8a+Eya83jrQZH+qM4S4W
         gTXA==
X-Gm-Message-State: AOAM532mh8ImE9Kp/g6pEg7eeLiSlyaRbsCLJSnN2ZIQBBOFn5jXPiTN
        PZo1hXau1skdc3EjC1yw9lMYO+zqwsYiJBEZX7c=
X-Google-Smtp-Source: ABdhPJzBuHnWQ0ymnVyFAbs80yqqxMvUz3N7nwaoJ3lG815xcjXDxYpVBi5TXJyhi3ZfgsDBLgIpa5MEOBWT4eV/CT8=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr3173984ejr.371.1614663801809;
 Mon, 01 Mar 2021 21:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-5-charvi077@gmail.com>
In-Reply-To: <20210301084512.27170-5-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Mar 2021 00:43:10 -0500
Message-ID: <CAPig+cTVrcWm8pJvnkP4gnWE6B8SKHENjvbAR7Do0ury-ArnaA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] t7500: add tests for --fixup=[amend|reword] options
To:     20210217072904.16257-1-charvi077@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> t7500: add tests for --fixup=[amend|reword] options

It's usually preferable for tests and documentation updates to be
bundled along with the patch which makes a particular change[1] rather
than waiting until the very end of the series and adding tests and
documentation covering all the changes made by patches earlier in the
series. As a reviewer, it is much harder to tell if the late-added
tests and documentation updates are comprehensive since it's difficult
to keep in mind all the changes made by earlier patches.

When reading earlier patches in this series, I questioned whether or
not certain features of each patch were going to be covered by tests
or documentation updates, but I couldn't tell because those updates
weren't made at the same time as the change about which I was reading.
For instance, when reading the implementation of `--fixup:reword`, I
was wondering if the documentation was going to be updated to mention
that it would ignore changes staged in the index and leave the index
untouched, and I wondered if and hoped that tests would be added to
verify that the index was indeed left untouched. Over the course of
many patches, it can be difficult to keep track of all the accumulated
questions, which makes it onerous to review the final patches adding
the tests and documentation updates enmasse.

I'm not necessarily suggesting that you re-roll merely to incorporate
the tests and documentation updates into the patches to which they
belong, but it's something to keep in mind for future submissions.

FOOTNOTES

[1]: Once in a while a patch introducing a change is so large on its
own that it may make sense to split tests and documentation updates
out to their own patches which immediately follow the patch to which
they apply, but that's different from delaying _all_ tests and
documentation updates and plopping them at the end of the series all
crammed together.
