Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1CF1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHUXFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:05:22 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36404 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:05:22 -0400
Received: by mail-wr1-f52.google.com with SMTP id m27-v6so10584033wrf.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nOGnuKjYMWadSwiGCi6/sdH+SxQ7kYUkTqSFC92xbC8=;
        b=reJVCTG8wZm3AsZVeVocs370Q5tTDwsWSNTm2sZdIiq91VaunTwRqqT6NXMHhgzI5J
         vdMZue36HRrredsKSgbMpW0nEtHIFncJ4EakZU+UjO/OmGQWd71j/7zaKp05q0KrHKx0
         u/6aWJaSD/prFZCkbSr6MxCmnW3qFmRnVBINiCGrOrbmZngGu42IVjHgZQpHsDp/TaI9
         m6eUPxcTHtmPwJ+dogVb0qbaqsUHv0aHukbg8nOQO9jntF155iM6mJxclohaDv+cwUBh
         xFvR8t4QPRswQgRzONPtL6YxGUrUGOmBtzhpH8l4G9VFs6DIMpb0qY2GSlwtO3oWJlvu
         Rf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nOGnuKjYMWadSwiGCi6/sdH+SxQ7kYUkTqSFC92xbC8=;
        b=hHKKwF7zz7n2JNKyIrxqSTnCnUDpNZPQtGOpHJ56CYLRRgumHyy7ZYgzWJ0Lm9hKvS
         NQxiagLzSz5kpY++rv7ADLHjjPJ9EKdFSzDkio9P5tflJBz5mdGFmUgn0IxRrr2+BeYg
         NeqbsHXXtFgjWNJiDSlxEsNS5Il+fe9d2gXy5kNJjb3zm46B9KMaD7iD3XFORoLpwyRa
         07uxKxJrO+evvB9W5/5lAMvnixyH1Z7r7Ib2apiuXErlbnJfOXqttpkJIwm8tvtIQNmT
         YeGT5I1F3MCrem1fWZdfEnTnylWdZXvKxmhwk30Rp2Vx1yrW8BTN7A34Ap9kZybKnApg
         x7dA==
X-Gm-Message-State: AOUpUlHQcXSrJj0iItaMWvurGZ3copQRId7hy6UIYJTBzROVrTrn0aEu
        l1CNpD/7s/FeJzW8x/9L4Gw=
X-Google-Smtp-Source: AA+uWPwIXQvC/MOSBAVLDvmNZuHdsqMCpIUpbND/K6VFhSi1GEOevkfRAiu1eZKYxIsP/9vH6cJSkg==
X-Received: by 2002:adf:8004:: with SMTP id 4-v6mr34125038wrk.130.1534880630775;
        Tue, 21 Aug 2018 12:43:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o134-v6sm6187333wmd.9.2018.08.21.12.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:43:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190705.GF30764@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 12:43:49 -0700
In-Reply-To: <20180821190705.GF30764@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 21 Aug 2018 15:07:05 -0400")
Message-ID: <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we serve a fetch, we pass the "wants" and "haves" from
> ...
> This lets us limit the change primarily to the oe_delta()
> and oe_set_delta_ext() functions. And as a bonus, most of
> the rest of the code does not consider these dummy entries
> at all, saving both runtime CPU and code complexity.
>
> Signed-off-by: Jeff King <peff@peff.net>
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Sorry for commenting on something completely off-topic, but when
applied with "git am -s", I get a resulting commit with 3 S-o-b (the
above two, plus the one added by "-s"), with a blank line in between
them.  I can understand the first blank line (the one between your
two S-o-b), as the first S-o-b does not even appear to be part of
the trailer block, but cannot explain why I get an extra one before
the one added by "-s".  Puzzled...

> @@ -79,6 +81,7 @@ static unsigned long pack_size_limit;
>  static int depth = 50;
>  static int delta_search_threads;
>  static int pack_to_stdout;
> +static int thin;

It appears that this line is the only change since the previous
round.  The remainder of the patch looks cleanly done and readable.

Thanks.
