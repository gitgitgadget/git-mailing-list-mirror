Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5378EEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjFTMWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjFTMWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:22:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD151709
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:22:45 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56d304e5f83so51933847b3.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687263765; x=1689855765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9ZuYuqSKMKxS+rI0Bs53wG5NlfdmkyTttzMED1gpSw=;
        b=qE7kFfZOYClUorkygCdYHGXqCAfU8a/jzsMmbnC89NW1exoDFj23D3uJ9uZDDRr4fC
         GrswuzLI19Qfba1sm1OfvoJ58UxnAas7tVKlftwCUAM5nXnQDrY5rOVe0El+p/0/Zj0X
         7Qbxv6Mn9PpEsGaVgbm8DDTPCdUjfbtVywG+9rdI8pR9uQ3Lg9oROaOcYBk2yLMLSj1b
         g8oIbGShIYBk7hCFfyx99KXygGFhFn/vR2g+70thUbp3IX/I4jto3pjAVvxIj/Pdlc3i
         t7ueaVlhNEK/3WCOpxN5X7C2OdLsP9QEH3ELuUpTYz/tJTCAbzGkCahm4tQq4D//LGCq
         UU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263765; x=1689855765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9ZuYuqSKMKxS+rI0Bs53wG5NlfdmkyTttzMED1gpSw=;
        b=djSKQpuKF9uM+sldca3yySwXtNQ/nAGnOS6qy82hII+zYwEmKzf06h+f14EmyiDOm0
         HYYJ4RMOP80E8pIiGUFe6oi9i/jtxF/TeC6TCCA22ZccxqKHsqe4kFZfo8+1EY5KQo1x
         GDul0WHBhq6NzAKdQ+1gWXVX/z0lAISZvhWjCruoDvlnUd8OOc2U3NN7r6qZ43IP+jGF
         oHW40PIUzGXD5F8YLlzxjAkOIiyK71b9IYHA7artsAM+2B+uQzMS6HbNbtak5ceI2TAH
         gtIhXg0wWLBHNpMd/2LXwdMZVHsY2rCoMG9AHiW0S/sT8btkW2XTCwT2h7FrgWYrfuaS
         Q6kw==
X-Gm-Message-State: AC+VfDwtsaSvroyYiR3aSb0aH5wph6RqWtTMbrpK/w/+uIqtD80zcauH
        ZzxmQTgbXwU6ZXRlzZ0NyFHn3Q==
X-Google-Smtp-Source: ACHHUZ7BvUn+OCAuHKw3/AFiAHMVypN1/JxHsr+v+wMCKhgXhPcwmnLbwXU1idxcwVDhYNH6FtyqvA==
X-Received: by 2002:a0d:dc01:0:b0:55a:18e2:cdf9 with SMTP id f1-20020a0ddc01000000b0055a18e2cdf9mr13547095ywe.49.1687263764767;
        Tue, 20 Jun 2023 05:22:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h201-20020a816cd2000000b0056d2e140f11sm474522ywc.4.2023.06.20.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:22:44 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:22:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] refs: implement jump lists for packed backend
Message-ID: <ZJGaESy7zuCqks6D@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <ZH7ZtmUrlyJ8H0aP@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH7ZtmUrlyJ8H0aP@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2023 at 09:01:10AM +0200, Patrick Steinhardt wrote:
> On Mon, May 15, 2023 at 03:23:07PM -0400, Taylor Blau wrote:
> > Here is a reroll of my series to implement jump (née skip) lists for the
> > packed refs backend.
> >
> > Not a ton has changed since last time, but some notable things that have
> > changed include:
> >
> >   - Renaming "skip lists" to "jump lists" to clarify that this
> >     implementation does not use the skip list data structure.
> >   - Patch reorganization, splitting out `find_reference_location_end()`
> >     more sensibly, rewording patch messages, etc.
> >   - Addresses feedback from Junio and Patrick Steinhardt's helpful
> >     reviews.
> >
> > As usual, a range-diff is included below for convenience.
> >
> > Given that we are expecting -rc0 today, we should aim to not let review
> > of this topic direct our attention away from testing the release
> > candidates. We can get more serious about it on the other side of 2.41.
> >
> > Thanks in advance for another look.
>
> I didn't have many comments in this round. Personally though I'd split
> up this patch series into two in order to land the individual parts
> faster, where the first part introduces `git for-each-ref --exclude` and
> the second part introduces the jump list for the packed-refs backend.

Thanks for reviewing, and for the good suggestion. I think that
splitting this series in two could be worthwhile, but I'm not sure I
want to make this change for v4.

You could imagine splitting the series there, where the first half would
implement the naive version of `for-each-ref --exclude`, and the second
half would implement jump lists, and make upload- and receive-pack take
advantage of it.

But I think that makes the first half trivial and leaves all of the
complexity in this series to the latter half. I suppose that makes it
easier to graduate the first six or so patches earlier, but they aren't
really all that useful without the remaining patches.

Another split might be:

  - the naive implementation of `for-each-ref --exclude`
  - jump lists, and using them within `for-each-ref`
  - teaching upload- and receive-pack to use the jump list

But juggling this series as three sub-topics feels like it would be
burdensome to the maintainer ;-). So I think I'd rather leave it as-is,
unless you feel strongly.

Thanks,
Taylor
