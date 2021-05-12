Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA41C43603
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD14461278
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbhELUhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381362AbhELTd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:33:58 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31579C06138A
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:30:00 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so8144220otc.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YvYX40gDZJTHBrJdFz2nLfe8CW2CsbycdTSMA/Kjnsc=;
        b=rzpUsPtV3hPOCl1wpzKIDh7GvgdKmD+Q3gpgdO7ORNmcj7EyWJClv2x8SOHyc4dXa9
         UmIoTnG5S6dANFi0xJBcl5dkDFdXzHKArtvFWdqxctcq5+qDdZ2cUSSxNwky9ZzSuUk3
         xh0zfHV4kNwd074QS3w4fEPbhsg9ewNygAAnRqEE6/FgN89E830VeBcBsWGQXFdbwLV8
         WV4QSmcRz7YIrUfGNEWW8kzjkfgS4Rj/fYZG1rOoWUJQAS2qBD6eSMseYg7SDLN1f+zO
         xB9oQoP7CbsITb/G9bPQia+hu3aKtDoUkw9c8bIxS9xMHnQVP1GfXIkcdrYFigt4h89z
         mlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YvYX40gDZJTHBrJdFz2nLfe8CW2CsbycdTSMA/Kjnsc=;
        b=jXyF6hAxbHuGAo38QC0/iyo9/7zeh4ddsgEQsGXviw9tXFvAxwmcTH5UR9qK5Ltb1M
         LWi4+NrGd0G9XaGAP2+BLKgZvX3z9fjQogYQE9fwGZIqZZB88s0EZBgUsmZduNRqzW0E
         oq98jnQdiOljmGDcUDDK84uDtETLK5YSw4cviXn0Q1yEcyTwrXNxUISJ2UmyhLCM3MPX
         JGmQgffxpWUvI/bn8KJoVqlclobvLHho3GR4CMdPQ/UHtAbF1BR3dkslg+YSHpmq5PG6
         ZgSDDQP/jyPn/HnWPaoEKfJKBfg+nQVp2AZOlZ5lQgNzqXpT3h1uK0EJpezAHReMCQZg
         OHkA==
X-Gm-Message-State: AOAM530otejIBrnr89miGsi1uZh0sHCQeCRNt2fnMPOOKHiDh9UucVx4
        IRRrSLz3QunfFkzovAOLSD17nTMLaatvlw==
X-Google-Smtp-Source: ABdhPJz8OOQDmnh1oPhHm0CkDK/m+YcdAilfhtroCL/5oxcmr8ZNrcPzWr7EZxaJ65Ga/88D3i3g3Q==
X-Received: by 2002:a9d:7d05:: with SMTP id v5mr22024751otn.49.1620847799595;
        Wed, 12 May 2021 12:29:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 21sm166357otg.4.2021.05.12.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:29:59 -0700 (PDT)
Date:   Wed, 12 May 2021 14:29:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <609c2cb5a88ba_71bd1208b3@natae.notmuch>
In-Reply-To: <YJt81neO7zsGz2ah@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
 <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
 <YJt81neO7zsGz2ah@coredump.intra.peff.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> We seem to have a problem with some escape codes. E.g.:
> =

>   -           of nothing). The other file, git-add--interactive.perl, h=
as 403
>   -           lines added and 35 lines deleted if you commit what is in=
 the
>   -           index, but working tree file has further modifications (o=
ne
>   +           of nothing). The other file, git-add&#x2d;&#x2d;interacti=
ve.perl,
>   +           has 403 lines added and 35 lines deleted if you commit wh=
at is in
>   +           the index, but working tree file has further modification=
s (one
> =

> and:
> =

>   -           Added content is represented by lines beginning with "+".=
 You can
>   -           prevent staging any addition lines by deleting them.
>   +           Added content is represented by lines beginning with "&#4=
3;". You
>   +           can prevent staging any addition lines by deleting them.
> =

> which is a pretty bad regression.

Is it? At leat in my system both are rendered correctly.

> The trailer misses the version field:
> =

>   -Git omitted                       1970-01-01                        =
GIT-ADD(1)
>   +Git                               1970-01-01                        =
GIT-ADD(1)
> =

> The "omitted" is part of doc-diff's attempt to reduce noise in the
> diff. But you can see that it's missing entirely in the direct version.=


This is indeed a limitation of asciidoctor: manversion is ignored.

I have a fix for that. I'll send it to the asciidoctor project.

> There are lots of whitespace changes for lists. They mostly seem fine
> either way. It also formats numbered lists differently:
> =

>   -            1. Delete the remote-tracking branches "todo", "html" an=
d
>   +           (1) Delete the remote-tracking branches "todo", "html" an=
d
>                   "man". The next fetch or pull will create them again
>                   unless you configure them not to. See git-fetch(1).
>   -            2. Delete the "test" branch even if the "master" branch =
(or
>   +           (2) Delete the "test" branch even if the "master" branch =
(or
>                   whichever branch is currently checked out) does not h=
ave
>                   all commits from the test branch.
> =

> I prefer the original, but could live with the latter (IIRC, this is
> something that can be configured via asciidoctor, but I didn't dig).

It is not a numbered list, it is a reference. I actually prefer the (n)
version.

> Links are a bit harder to read. E.g.:
> =

>    SEE ALSO
>           git-check-ref-format(1), git-fetch(1), git-remote(1), =E2=80=9C=
Understanding
>   -       history: What is a branch?=E2=80=9D[1] in the Git User=E2=80=99=
s Manual.
>   +       history: What is <user-manual.html#what-is-a-branch> a branch=
?=E2=80=9D" in the
>   +       Git User=E2=80=99s Manual.

That indeed looks weird. I'm not exactly sure how to fix that properly.

-- =

Felipe Contreras=
