Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF8C25B06
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbiHITMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348449AbiHITLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:11:52 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94326ACF
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 12:03:45 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 129so12876133vsq.8
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3bEC8PuuEGRLhLISJdkqkBDWsE998HQjuMInk6uMIm4=;
        b=bsJCj4QXYLp+z7lmD1R/A33S1Sq+mYP5hhVXiNMZiCToz4kIcuwfse9WsPmJXAv/bB
         7EH1H6iPFojMZKxBq/WupOs0119cpDS7txXMG9asHzBeChdQ/9++sAIU6k6qxB50J9sR
         elyxuB8nCHNPxfY2kkGY+NL9AqMNXdr53AoV22Wx5ZQiURPONNWGz+Agm5OHTvMw5bez
         hf7LfWPGToQ8g+d0mQU4QQJAnYY4XnWHHBqEih3qdQW3+pvpQnkxOg9fKODNeQvgd3c6
         KK/Jeb+LNIuLvsZhXSaHDJa4olvQZH/Nh+c/UBUBq4OscdnZ1gj2oXXHclZrpDtI8l5W
         zQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3bEC8PuuEGRLhLISJdkqkBDWsE998HQjuMInk6uMIm4=;
        b=nTDo/0hOMqgstLJLHl6Kyis/Daz5y9mclEaSr0zwyCIEcy4CQ5Mr2zHhCRFYBQ+Nvn
         hlzP+upXGPoZ+FQHybhLMLJd5e/amo/jw0G/9N0zYiitjf2IHMx3xPb/a4DElKVgcBDS
         FeHTavN5PpnqeFlOlIYcw0nTn7RTsDugwVWph0dDTUsh4B5nss1E99+hjaXQJrDKo9S3
         pOiRUacHlVCKfuhTQwZSl0em2O0s7wWsmVEprUfMCaY2bNzebL0AEMzj0xYbdEmmS5Np
         tHuIC6CrG8/bYMLUKbDx3aF2at603ZdxzrH3bguZ0w4qiMdD8F8NiWJIc6LblZK7wTxv
         kNSQ==
X-Gm-Message-State: ACgBeo0rPpvaP1CK22J66ATJQIgVG4zRJefO7B3TnCHvD6Jl0Rna7jQu
        AP340AI3W4+v+y5p4feZN4PPaZgp2ycSkOEUbAtYglzr90Xnvg==
X-Google-Smtp-Source: AA6agR5tlDS2AkFmpZRRQPRIl2475NEV64+MqYuGx5Ybla4gbf5Of+C5EG25wyDEAeJ4DMObdDO6vZ5Dc0i12HPJyYs=
X-Received: by 2002:a67:ad09:0:b0:388:8e8c:55f8 with SMTP id
 t9-20020a67ad09000000b003888e8c55f8mr7743740vsl.43.1660071824285; Tue, 09 Aug
 2022 12:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220809182045.568598-1-calvinwan@google.com>
In-Reply-To: <20220809182045.568598-1-calvinwan@google.com>
From:   Alexander Meshcheryakov <alexander.s.m@gmail.com>
Date:   Tue, 9 Aug 2022 23:03:17 +0400
Message-ID: <CA+VDVVVQQ4=um_L_h=EQASPHD_oYjwZxecYewLrCAbQV_m4hwQ@mail.gmail.com>
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin,

Sure, let me demonstrate with clean git repo:

mkdir git_test; cd git_test
git init
touch =D0=9A=D0=B8=D1=97=D0=B2.txt Kyiv.txt =D0=9C=D0=B0=D1=80=D1=96=D1=83=
=D0=BF=D0=BE=D0=BB=D1=8C.txt Mariupol.txt
git add -A
git commit -m 'foobar'

Now let's check with GNU awk `git log --stat` strings width in bytes:
$ git log --stat | LC_ALL=3DC awk '/txt/{print length($0), $0}'
27  Kyiv.txt               | 0
27  Mariupol.txt           | 0
27  =D0=9A=D0=B8=D1=97=D0=B2.txt           | 0
27  =D0=9C=D0=B0=D1=80=D1=96=D1=83=D0=BF=D0=BE=D0=BB=D1=8C.txt | 0

And strings width in unicode characters:
$ git log --stat | LC_ALL=3Den_US.UTF-8 awk '/txt/{print length($0), $0}'
27  Kyiv.txt               | 0
27  Mariupol.txt           | 0
23  =D0=9A=D0=B8=D1=97=D0=B2.txt           | 0
18  =D0=9C=D0=B0=D1=80=D1=96=D1=83=D0=BF=D0=BE=D0=BB=D1=8C.txt | 0

See, all lines are aligned to have length 27 bytes. But on the screen
this looks distorted because length in characters differs.

On Tue, 9 Aug 2022 at 22:20, Calvin Wan <calvinwan@google.com> wrote:
>
> Hi Alexander,
>
> Thank you for the report! I attempted to reproduce with the steps you
> provided, but was unable to do so. What commands would I have to run
> on a clean git repository to reproduce this?
>
> - Calvin
