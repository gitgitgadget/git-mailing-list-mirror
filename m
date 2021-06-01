Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066FBC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB32E613C5
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhFANWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 09:22:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783BC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 06:20:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so21120952ybe.2
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gO5KMmMCnmgOgg/TPyVCkKEHfOR+jGSB+pUq/cRnPFA=;
        b=h8vZLPzyKibfdJ8C8mJm8H4OGLp8NHtjeD5sCX2G3fTEALn4Y9Td2zgpj1qg2POsmB
         cfvtrWdtiGdebXVYzuZiHvWGzkiraj4fRJH7XLThT1iAxkMFGXwUBoZDpjtdZiXO3v0z
         N6U6n49oS7dP1eTT+EPZHCzvI7XRWgkRatra5m0TXNntJutvlRRGESUIG4feq4AoZ3Bl
         m38Ou64ir2Z7no/LZZBQs6YlUOW4HlAxZ9Nm12wXOZbNQ5AcaoVs829t3Dxk7hf6508w
         vIrd3XIXYgHnw3CRRVLpb5ocRKJYB0oS+TuLLltxOTyWeTM1MU4GbCLUdKm8zni04O24
         Fmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gO5KMmMCnmgOgg/TPyVCkKEHfOR+jGSB+pUq/cRnPFA=;
        b=TVpGYURZ08M/8xAcpF3EhGkZf5n4ncTOOX3pNooAH0feXVDE/y1o1WQXM9La56pq6i
         vQpDlHkoyCnUjum0Wmo/RQKD3eovvP6s2pxx3qLxrW1dpV8O7vvHxhofWp15uyzJBXU/
         L7QvYXqhkSTX0XSqe7EpogJw6zemoFhxyYp5Uw36QcNs0xvKX54UbP86MQFoevf/ro3l
         DH7NnrXU9l673iqndm+Uf+XiUp//zXh3pSeFlLdN79ja8+3w8OB4+RZiIk0EVgjAlAd8
         XOmBhMzqTtZqQq0rxNv9llfj9D6rmEuE7svLjpy0Ihfewcc2YjftX4T3FwGdTYTGG0Np
         jgpw==
X-Gm-Message-State: AOAM532+OY78pAlzw5/NeTaHgcOSZ9somzt/uSmecbu27idw3nxni0A5
        V7NkjBV+iotLpG3DnrZY4v6KnFsiXnzvUP+qs/4=
X-Google-Smtp-Source: ABdhPJwU7gBOIqFwSV2TaxEC1F3Yoc/XXqadCJ/3HhRbclmMFF6+kD9gBY0rkHZEmX15lnSDawb3s6AfRhG83Oxy3ZA=
X-Received: by 2002:a5b:5c6:: with SMTP id w6mr38250323ybp.279.1622553656557;
 Tue, 01 Jun 2021 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <87bl8xmipo.fsf@evledraar.gmail.com> <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com> <CANYiYbG1vVqN-De0n2Ukexh0Jn8e_b2G1CPv24T1fbYgyhKjfg@mail.gmail.com>
 <874keh94ga.fsf@evledraar.gmail.com>
In-Reply-To: <874keh94ga.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 1 Jun 2021 21:20:45 +0800
Message-ID: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:04=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Tue, Jun 01 2021, Jiang Xin wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B45=E6=9C=8827=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=
=86=99=E9=81=93=EF=BC=9A
> >>
> >> But no, the issue as it turns out is not Perl v.s. Sed, it's that
> >> there's some bug in the shellscript / tooling version (happens with bo=
th
> >> dash 0.5.7-4 and bash 4.3-11+deb8u2 on that box) where those expansion=
s
> >> like ${A%${A#??????0?}} resolve to nothing.
> >
> > That's the root cause.  It can be reproduced by running the following
> > test script:
> >
> > ```
> > #!/bin/sh
> > # test script: test.sh
> >
> > test_commit_setvar () {
> >         var=3D$1 &&
> >         oid=3D1234567890123456789012345678901234567890 &&
> >         eval $var=3D$oid
> > }
> >
> > test_commit_setvar A
> > echo "A: $A"
> > echo "Abbrev of A: ${A%${A#???????}}"
> > ```
> >
> > By running different version of dash, we can see that dash 0.5.7 fail t=
he test:
> >
> > ```
> > $ /opt/dash/0.5.11/bin/dash test.sh
> > A: 1234567890123456789012345678901234567890
> > Abbrev of A: 1234567
> >
> > $ /opt/dash/0.5.7/bin/dash test.sh
> > A: 1234567890123456789012345678901234567890
> > Abbrev of A:
> > ```
> >
> > This issue can be fixed using the following example:
> >
> > ```
> > #!/bin/sh
> >
> > test_commit_setvar () {
> >         var=3D$1 &&
> >         oid=3D1234567890123456789012345678901234567890 &&
> >         suffix=3D${oid#???????} &&
> >         oid=3D${oid%$suffix} &&
> >         eval $var=3D$oid
> > }
> >
> > test_commit_setvar A
> > echo "Abbrev of A: $A"
> > ```
>
> *nod*
>
> >> Anyway, looking at this whole test file with fresh eyes this pattern
> >> seems very strange. You duplicated most of test_commit with this
> >> test_commit_setvar. It's a bit more verbosity but why not just use:
> >>
> >>     test_commit ...
> >>     A=3D$(git rev-parse HEAD)
> >
> > The function "test_commit()" in "test-lib-function.sh" always creates
> > tags and it cannot make merge commit. So I rewrite a new function
> > which reuse the scaffold of "test_commit".
>
> It's had a --no-tag since 3803a3a099 (t: add --no-tag option to
> test_commit, 2021-02-09). I also have patches in "next" to add more
> options, you can just add more, having a --merge and maybe a way to tell
> it to eval the rev-parse into a given variable seem like sensible
> additions.
>
> > BTW, sorry for the late reply, will send patch later.
>
> My main point was that looking at this I think it's very much over the
> complexity v.s. benefit line on the "complexity" side.
>
> Even if there wasn't a --no-tag just using "test_commit" with a "git tag
> -d" and "commit_X=3D$(git rev-parse HEAD)" is less magical and more
> readable.
>
> I.e. the mostly copy/pasted from test-lib-functions.sh function is ~70
> lines, the whole setup function is 50 lines.
>
> And as I noted with the whitespace getting lost in the munging the end
> result is actually less reliable than just doing a test_cmp with $(git
> rev-parse ...) instead of <COMMIT-XYZ>.
>
> If you were trying to avoid the whitespace warnings then see the
> "'s/Z$//'" pattern in t0000-basic.sh for how we've usually tested that,
> i.e. had a "Z" at the end mark intentional whitespace for
> test_cmp-alike.
>
> There's a big value in the test suite being mostly consistent (which it
> somewhat isn't, but we're hopefully getting there). I.e. the goal isn't
> to optimize each test file to be as small as possible, but to e.g. have
> the next person maintaining it not wondering where <COMMIT-P> comes
> from, understanding some test_commit-alike that eval's variables into
> existence, how it's subtly different (if at all) from test_commit etc.

Will send a patch for quick fix for t6020 which is broken on older
version of bash.

After changes on "test_commit()" of "test-lib-function.sh" has been
merge to master branch, I will try to refactor t6020 again to remove
`test_commit_setvar()` and reuse `test_commit()`.
