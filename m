Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFAC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 06:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhLGGVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGGVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 01:21:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC657C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 22:17:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c32so31070140lfv.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 22:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVrKkXVC1xfIjPQ2RiLTajglJdpe/FlfmO1Nd1+UpuY=;
        b=blmk2Vf0SgUD29ylKxDUCRiNhhb66yuVQwq/mfvcqM8nQakjvWj+m6rtBca5jP3sla
         49J62sPob9zwbclNZFu8GrLhsUmMHMVLS/pn3GQhhGHECdoZoR2LT0cJzYiTlIFVbgqO
         PiMCDFddKT9gdN6bB2Ow+30pwqm8WO3qUrIn070AltnVtlT34WFB1qAUVfia5zk/Md43
         iAHGD6IN3s/IZVMD029sQYgv2Z6sU+ZB2FDwGHl7X+IhUF6/wjtcPbtfxstN0zwdfy/2
         EYDGCf6cWZZ6OKYgH/GqsYAqVcqULcwwv77qiS9CQomqpMm7mOyg16emmCYTTnDzVbvK
         M5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVrKkXVC1xfIjPQ2RiLTajglJdpe/FlfmO1Nd1+UpuY=;
        b=3AlgJZelwzUXfhKiNVXKQ9FUT+7PQ07SwzkjaDZif0CzMbjLZYRlmbDmeBKruxrC+r
         9Vcg4VNwye2YLKhcsO3+tZ1sPSoNKHbUQ8+PVLi7IpRMES73fFAHkSBz0+gpasMshSdd
         TwKbv3OJmQ/wPzOgmfyC3TjfNqViq+ihaicHvZP88icNK/KKw6XUA7FCaIRKg3IX5MLw
         hOswhCWr4UrvLE/R7S0qURKXhp3bcqK2XpsCVkCK9PP/ysKdkLVw3M91gEMQDBBbox55
         L1kkMvGIgY5tbfBwMzNDMAg/azQlAGx6Km+nkdv8bytiASZi3RZ5/eSdd3mXgTg2iiKC
         58VA==
X-Gm-Message-State: AOAM5300TCZFghzcpdXrLnrQ5I9tsMaRMoDjY3qRtQSQD++U5YakSlEi
        WbWmneCaqEEf0kZxif+G+liVXNY47S7xmcYeY6di9RBudRuqV/BY
X-Google-Smtp-Source: ABdhPJwLP7DgqwhJlEB0ibx3+db5blSmvS2ql6bTSdyOImaxffc/XsVCXgGKpIzsRU18k8x47WQ08pedM4y89Bi/Dlg=
X-Received: by 2002:a19:6454:: with SMTP id b20mr39458688lfj.469.1638857869996;
 Mon, 06 Dec 2021 22:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-6-chiyutianyi@gmail.com>
 <211203.86ilw5ssar.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86ilw5ssar.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 7 Dec 2021 14:17:39 +0800
Message-ID: <CAO0brD32=0Gc4_5-aJS5MYicV3uuuMkqpo3adVAELq21V8EvdA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 9:59 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-d=
elta-objects.sh
> > new file mode 100755
> > index 0000000000..01d950d119
> > --- /dev/null
> > +++ b/t/t5590-unpack-non-delta-objects.sh
> > @@ -0,0 +1,76 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2021 Han Xin
> > +#
> > +
> > +test_description=3D'Test unpack-objects when receive pack'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success "create commit with big blobs (1.5 MB)" '
> > +     test-tool genrandom foo 1500000 >big-blob &&
> > +     test_commit --append foo big-blob &&
> > +     test-tool genrandom bar 1500000 >big-blob &&
> > +     test_commit --append bar big-blob &&
> > +     (
> > +             cd .git &&
> > +             find objects/?? -type f | sort
>
> ...are thse...
>
> > +     ) >expect &&
> > +     PACK=3D$(echo main | git pack-objects --progress --revs test)
>
> Is --progress needed?
>

"--progress" is not necessary.

> > +'
> > +
> > +test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
> > +     GIT_ALLOC_LIMIT=3D1m &&
> > +     export GIT_ALLOC_LIMIT
> > +'
> > +
> > +test_expect_success 'prepare dest repository' '
> > +     git init --bare dest.git &&
> > +     git -C dest.git config core.bigFileThreshold 2m &&
> > +     git -C dest.git config receive.unpacklimit 100
>
> I think it would be better to just (could roll this into a function):
>
>         test_when_finished "rm -rf dest.git" &&
>         git init dest.git &&
>         git -C dest.git config ...
>
> Then you can use it with e.g. --run=3D3-4 and not have it error out
> because of skipped setup.
>
> A lot of our tests fail like that, but in this case fixing it seems
> trivial.
>
>

OK, I will take it.

>
> > +'
> > +
> > +test_expect_success 'fail to unpack-objects: cannot allocate' '
> > +     test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>=
err &&
> > +     test_i18ngrep "fatal: attempting to allocate" err &&
>
> nit: just "grep", not "test_i18ngrep"
>
> > +     (
> > +             cd dest.git &&
> > +             find objects/?? -type f | sort
>
> ..."find" needed over just globbing?:
>
>     obj=3D$(echo objects/*/*)
>
> ?

I tried to use "echo" instead of "find". It works well on my personal
computer, but fails due to the "info/commit-graph" generated when CI on
Github.
So it seems that ".git/objects/??" will be more rigorous?
