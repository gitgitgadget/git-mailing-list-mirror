Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F85CC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247D4613C5
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhFAMFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhFAMFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 08:05:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7DC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 05:04:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g20so5817248ejt.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=joqGfYEJc9FSg/dHPUXAJwj9lGLoM8mH8PXUYs4ccy4=;
        b=Jgu1BHUE8mhV3TN9FQn1VFW96yUn7tDq4dbKtXsbPu3aOWZo/9lQ/WbowpdNJ1Uz7v
         LOYXoUFPoU10S0kV/HKZjqeVCEnorrmeAJFdXOQ10dvdzN+DFET12PJQSZURbN9Nin7U
         yLeCDLnU4uTdstbcvL0mzY3xK2JlMlsOu1Ro5PG+g4zyNpjHiyoBFT8tI+a6Q2cixg5C
         uQ7jjafbu2KIimoN87mpv1sfa+IvTWS3RjGJpMtaKdJrPuxZEYw5jweKJhTo84AXq752
         F+V7bbTH+O6sXohDyKAdY/Ujhhgyvl4zhb9eZddwJEbJoyvnR+42D0N62Lso3opcBxcG
         v0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=joqGfYEJc9FSg/dHPUXAJwj9lGLoM8mH8PXUYs4ccy4=;
        b=H2P2QqKcvIT9u3ZBDxSRqIYbGi8h7U2L89I9JSJn5LaljKA0RRvOUVIFCqezlhyl5j
         CcovH67//aKTU60Akg9oQxd+q7xekn0/DI0G4BpPqEYoSui1skPAFm7A6qfKA7Tb9l/i
         e3tFd61Ab6o1MqiWhUwWoYswhsY+OX0Q6QOIdplNmFZUtfLWrOCqro9OU/e7FiRfqFFO
         SqCw4VFBJ3aXCdQAIirWCF5emEFIJAHjhNCQqKwPygMzmGp0tjuX68dBhI0M2lyS/B6U
         nU0mUbijK+uUpWwj6Ie4wX3eYJSrPVACB8MLTJKsCqcdDHf1/+n8DyD9D1DHIhtpotXs
         DHeA==
X-Gm-Message-State: AOAM5310ChAkJd6WLgMgISEBUHyO0qif9Mscay/5p9AnL0tcKkp5+goR
        XoIyv0J05OjKOa46B4xLXSo=
X-Google-Smtp-Source: ABdhPJxGsXw4ZO5l5oE6ff1pQ8XdVtx7UcTocpMDzHd8MgWbuwpq4ZjtKBD+B5VBZgp3ELen21beag==
X-Received: by 2002:a17:906:f6d7:: with SMTP id jo23mr9762796ejb.302.1622549047959;
        Tue, 01 Jun 2021 05:04:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m9sm7369255ejj.53.2021.06.01.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:04:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
Date:   Tue, 01 Jun 2021 13:50:52 +0200
References: <87bl8xmipo.fsf@evledraar.gmail.com>
 <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com>
 <CANYiYbG1vVqN-De0n2Ukexh0Jn8e_b2G1CPv24T1fbYgyhKjfg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CANYiYbG1vVqN-De0n2Ukexh0Jn8e_b2G1CPv24T1fbYgyhKjfg@mail.gmail.com>
Message-ID: <874keh94ga.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Jiang Xin wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B45=E6=9C=8827=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=
=86=99=E9=81=93=EF=BC=9A
>>
>> But no, the issue as it turns out is not Perl v.s. Sed, it's that
>> there's some bug in the shellscript / tooling version (happens with both
>> dash 0.5.7-4 and bash 4.3-11+deb8u2 on that box) where those expansions
>> like ${A%${A#??????0?}} resolve to nothing.
>
> That's the root cause.  It can be reproduced by running the following
> test script:
>
> ```
> #!/bin/sh
> # test script: test.sh
>
> test_commit_setvar () {
>         var=3D$1 &&
>         oid=3D1234567890123456789012345678901234567890 &&
>         eval $var=3D$oid
> }
>
> test_commit_setvar A
> echo "A: $A"
> echo "Abbrev of A: ${A%${A#???????}}"
> ```
>
> By running different version of dash, we can see that dash 0.5.7 fail the=
 test:
>
> ```
> $ /opt/dash/0.5.11/bin/dash test.sh
> A: 1234567890123456789012345678901234567890
> Abbrev of A: 1234567
>
> $ /opt/dash/0.5.7/bin/dash test.sh
> A: 1234567890123456789012345678901234567890
> Abbrev of A:
> ```
>
> This issue can be fixed using the following example:
>
> ```
> #!/bin/sh
>
> test_commit_setvar () {
>         var=3D$1 &&
>         oid=3D1234567890123456789012345678901234567890 &&
>         suffix=3D${oid#???????} &&
>         oid=3D${oid%$suffix} &&
>         eval $var=3D$oid
> }
>
> test_commit_setvar A
> echo "Abbrev of A: $A"
> ```

*nod*

>> Anyway, looking at this whole test file with fresh eyes this pattern
>> seems very strange. You duplicated most of test_commit with this
>> test_commit_setvar. It's a bit more verbosity but why not just use:
>>
>>     test_commit ...
>>     A=3D$(git rev-parse HEAD)
>
> The function "test_commit()" in "test-lib-function.sh" always creates
> tags and it cannot make merge commit. So I rewrite a new function
> which reuse the scaffold of "test_commit".

It's had a --no-tag since 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09). I also have patches in "next" to add more
options, you can just add more, having a --merge and maybe a way to tell
it to eval the rev-parse into a given variable seem like sensible
additions.

> BTW, sorry for the late reply, will send patch later.

My main point was that looking at this I think it's very much over the
complexity v.s. benefit line on the "complexity" side.

Even if there wasn't a --no-tag just using "test_commit" with a "git tag
-d" and "commit_X=3D$(git rev-parse HEAD)" is less magical and more
readable.

I.e. the mostly copy/pasted from test-lib-functions.sh function is ~70
lines, the whole setup function is 50 lines.

And as I noted with the whitespace getting lost in the munging the end
result is actually less reliable than just doing a test_cmp with $(git
rev-parse ...) instead of <COMMIT-XYZ>.

If you were trying to avoid the whitespace warnings then see the
"'s/Z$//'" pattern in t0000-basic.sh for how we've usually tested that,
i.e. had a "Z" at the end mark intentional whitespace for
test_cmp-alike.

There's a big value in the test suite being mostly consistent (which it
somewhat isn't, but we're hopefully getting there). I.e. the goal isn't
to optimize each test file to be as small as possible, but to e.g. have
the next person maintaining it not wondering where <COMMIT-P> comes
from, understanding some test_commit-alike that eval's variables into
existence, how it's subtly different (if at all) from test_commit etc.
