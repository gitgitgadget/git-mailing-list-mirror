Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A42EB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGTRmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTRmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 13:42:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F27CC
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 10:42:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704af0e64so9798537b3.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874935; x=1690479735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t92tCeu5IN4LzY/lOhlfz72ILwExyfDYKAM2+n4rET4=;
        b=l3VtuZNF5CrdAE/5DvP6lBeGN61LvL0aGWMcHg/sQXVeynY61G5IUUcX2f9S/uB79u
         P2OccllLkR/Afv/+9qgPtD70C+HqH4QIOTy/e8705Grg580gaRjqykvLKABLZjjSGewO
         JxN5bM/3bclk5mYgJiD7bJJx4WWh89HoiUpNzK+oyjPAo3xJNsUf6loUx9iXcrjgtXlz
         kex6AAwEZbqk6CECf5ylVpYVkAdPg970y5PGWynZWUSzYZpNJgxUo9VRmoPP1VyTFAmD
         z6jhPJAAJmbtoBftDXh3XWDIGTcqNgZ+LTaMcd0r9X7khWDbB6XyrH+1Jo255fixTgo9
         u4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874935; x=1690479735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t92tCeu5IN4LzY/lOhlfz72ILwExyfDYKAM2+n4rET4=;
        b=S1tOvk1kMBbdldN2Bvul+o6TJpvHTIwZzveL/lD8ZjXGbLL7JoC/qGUdyEsJMzzQEi
         14vbu2FtC/gHDaxKn840brJ52Bwvr2Kx9VY5r3ji6t03QhwwmUIGaoRfa7vgd3cle06U
         dGvGVN3nF0sqLTxIzVLlQbP7HX1toEntMV9U5WgVYE2KeBvOfzUhIS+wDBlHe/metZgz
         uS/26TFNvUKZOW1WEIAKOqg+rWcAROKgWzmuZaxpQE7BJyMdSYBo5DmvasORuG6zUQHj
         og+gFymlJtSBJvL22ZIV8Za52rZ4y7nGpon/BaE6mYWINNvLa6WVXWMJ06FK+qNA4SP6
         rWEg==
X-Gm-Message-State: ABy/qLYM4ZVqTBCU0/k7Ldms8iHhT0nKLgcSLzO54UKeVlc4xm8ExOcZ
        KescXsyI59aBWqclDnFvqDQRlDx7l1n+RQ==
X-Google-Smtp-Source: APBJJlFLEvsUV2micky1bmkilYGPJe59UthS9NUO4lIIB6Am9iDWpaIuHe31fSuFcuIETmfhvQPba7Nu3pwANg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:868b:0:b0:cc0:e198:e347 with SMTP id
 z11-20020a25868b000000b00cc0e198e347mr46890ybk.2.1689874934877; Thu, 20 Jul
 2023 10:42:14 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:42:12 -0700
In-Reply-To: <xmqqjzuv5vvg.fsf@gitster.g>
Mime-Version: 1.0
References: <20230714194249.66862-1-five231003@gmail.com> <20230719162424.70781-1-five231003@gmail.com>
 <20230719162424.70781-2-five231003@gmail.com> <xmqqjzuv5vvg.fsf@gitster.g>
Message-ID: <kl6lzg3qzdhn.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> New helper functions that do not have any caller and no
> documentation to explain how they are supposed to be called
> (i.e. the expectation on the callers---what values they need to feed
> as parameters when they call these helpers, and the expectation by
> the callers---what they expect to get out of the helpers once they
> return) makes it impossible to evaluate if they are any good [*].

Agreed.

> 	Side note.  Those of you who are keen to add unit tests to
> 	the system (Cc:ed) , do you think a patch line this one that
> 	adds a new helper function to the system, would benefit from
> 	being able to add a few unit tests for these otherwise
> 	unused helper functions?

Absolutely. As a rule, we should strive to test all of our changes as
they are introduced. With our current shell-based testing, this means
that we have to add callers (either via a builtin or test-helper), but
IMO a unit test framework would serve this purpose even better.

> 	The calls to the new functions that the unit test framework
> 	would make should serve as a good piece of interface
> 	documentation, showing what the callers are supposed to pass
> 	and what they expect, I guess.

Agreed, and as documentation, unit tests can be easier to read, since
they can include only the relevant details.

> 	So whatever framework we choose, it should allow adding a
> 	test or two to this patch easily, without being too
> 	intrusive.  Would that be a good and concrete evaluation
> 	criterion?

Perhaps, but the biggest blocker to adding a unit tests is whether the
source file itself is amenable to being unit tested (e.g. does it depend
on global state? does it compile easily?). Once that is in place, I
can't imagine that there would be a sensible unit test framework that
doesn't make it easy to add tests to a patch like this.
