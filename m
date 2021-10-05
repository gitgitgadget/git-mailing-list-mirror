Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACAC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD8861186
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJEUyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:54:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40754C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 13:52:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l7so1624957edq.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KlxG4UMvqR52SzWvZmPWN0JWCUUWx1VUoGDiVBNLOO4=;
        b=KJZGiWZcQwd36KyYH9mB4za1KHx1vrOysq0rObA+5cQ0eQ9cuhaZLwYdjuFP4w0lQ8
         Tw9kTmi0NkW1hKZBSiyGv2UZN/nLhxv6419/bT80cCrClEls1zwggT6CuFCtj1mcQdwr
         cIb2WqakhiHZkr/hBiXzmNaNA4RFiSUMfQJ1U3hYzNzNQWkz+4Ug5C8/Is4aZDnJ1mCT
         yeljSs4r9Mi9/kLX8HhTC1XbxjDQTzHs9M6ag3oeIfT+JdSYu94uRbLd5yWOPhr1jUNz
         tebOKFwVantb9pUPg//kFzlKBpyCakonnYtVZXZry7LNXAWERwd6aeO57ae8m9s0YlS5
         6Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KlxG4UMvqR52SzWvZmPWN0JWCUUWx1VUoGDiVBNLOO4=;
        b=r/oU6bZozLmPpH6Csf6vhpjNIKBThKGy0IVm1ClfUJ+RrEREPHnr0uU5kHXBx5GXxe
         A+wo0HHgnGbrGnyBerb9PoAYH03Ln586mbiuww9QeCdpO/66xdfTHiI9+j2KMp+3Utc7
         OkztViB0+WS7R+7HHV1386JpW9acxAbvA4z82TSkdc1U96uUEjIF0nslFTkR6A0RreCR
         TowQJ9G2MnVz7OzL7KLPzZliAOKzGa5vl0EytPrIcknWidp0rpk/kHMmR9m6E6wvkPlz
         cZf3QgJBJuReRYUwNP9PTGwjp/37erugvFtHXFtJ2DlKfdsJxZOGvtUN9obnkS4JTjcz
         yaxw==
X-Gm-Message-State: AOAM531HqZlNP0S8Y9CF2Cyfomg7RK33O1aBMA4cWq3gcyp6ICamsP7q
        qTtF+cBRte031xchg5126WA=
X-Google-Smtp-Source: ABdhPJwBNASz/fjuAjD3N4MzyUUDtcsVaCG33MooX92tT+T/2DVtlPXP2LVwlcqu+R7qixUL2dM44Q==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr28603009edj.85.1633467143705;
        Tue, 05 Oct 2021 13:52:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j16sm3875277edp.62.2021.10.05.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:52:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: ab/fsck-unexpected-type (and "cat-file replace handling and
 optimization")
Date:   Tue, 05 Oct 2021 22:47:26 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87bl43jit5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/fsck-unexpected-type (2021-10-01) 17 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: don't hard die on invalid object types
>  - object-file.c: stop dying in parse_loose_header()
>  - object-file.c: return ULHR_TOO_LONG on "header too long"
>  - object-file.c: use "enum" return type for unpack_loose_header()
>  - object-file.c: simplify unpack_loose_short_header()
>  - object-file.c: make parse_loose_header_extended() public
>  - object-file.c: return -1, not "status" from unpack_loose_header()
>  - object-file.c: don't set "typep" when returning non-zero
>  - cat-file tests: test for current --allow-unknown-type behavior
>  - cat-file tests: add corrupt loose object test
>  - cat-file tests: test for missing/bogus object with -t, -s and -p
>  - cat-file tests: move bogus_* variable declarations earlier
>  - fsck tests: test for garbage appended to a loose object
>  - fsck tests: test current hash/type mismatch behavior
>  - fsck tests: refactor one test to use a sub-repo
>  - fsck tests: add test for fsck-ing an unknown type
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Will merge to 'next'?

I think it's ready, also noted last time around[1]. You had one question
on the v10, which I hope I answered to your satisfaction at[2].

Note that Jeff's just-submitted cat-file series[3] will conflict with
this, as they both adjust the same "garbage" object tests. The semantic
conflict is minimal/none, but the textual one is probably annoying
(e.g. his 1/5 uses a variable I split/renamed).

Jeff: Depending on what Junio thinks of queuing ab/fsck-unexpected-type
for next what do you think about rebasing your series on top, or perhaps
take a look at the v10[4] of it/ack it in case that helps with that (since
you've been looking at some related code just now...).

1. https://lore.kernel.org/git/87y27dq70e.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87sfxkpdqp.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/YVy1sx8Xb1xMLFQT@coredump.intra.peff.net/
4. https://lore.kernel.org/git/cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com/
