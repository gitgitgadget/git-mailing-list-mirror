Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93AC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCHJ4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCHJ43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:56:29 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F99BA7E
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:56:28 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id t39so14036173ybi.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678269387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKvBpBtmj7lIxjFEdhdWveJnuWaqBU8oXWym8Q9RNMg=;
        b=iYZisqAJ5ULHXqg3UEfeaNXYRhkXZuJBDMINLxnIgaOOdQJDCj6raWPA5nDhJqxevd
         afjjV08BqbIKmj/pxuqSwV/HHw5eU/lkY9qp7L2/Dfvyc2huJ4xJzHKWItPWmfaVYQYf
         2QNn0vCL+iZlyIkgMbPXfgxIx0gWEXQLWt5VLOViHwGshtoJ+7KCdcLL8aay4jeOGEc/
         3Uk2OU3PdB9nNzUFhxseZAu2ewgQJB3jkyW7r1+BkSjBcpQZu27WXK0ep+KdlLTBeNHa
         gZWC+1MH3Dw6qqt1ZjCbpM0xz/KXiAMS4ZYIOn2gL/7hKNoKWm+LhvK4pi4gUNKj+7R4
         /krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKvBpBtmj7lIxjFEdhdWveJnuWaqBU8oXWym8Q9RNMg=;
        b=OO5XzUO9gYZJ7w704oMGfpzqtSmPowt1Hx9rpXDZZUl1JqRtzSzfMRcy1jVPMFIPf+
         YUfzb0xElArOkg5f4hYUh1F0Ebg/7m37oqBIVa0F9WNY0tjILpM0daNtWM3MStgLwTgZ
         GR9O/qsI073cA5Xwn2ZNj/GiID2MujbFdnSlC12dkPJ2TqX9OrMrweqtVffmMuOsIkZG
         eKkKzFQKz75TG2Zd9o/a9YNjJghJ80oJ0yr7PcFeef31O7SYdP2PTI9WUdJn70Fi7Et0
         uY4ccOav2SUwrUP5UngdHM19gJ7XqDKC+R1YRVAmUnH3SfS5qJ+gYo6EwKmtRmvx30jy
         laVw==
X-Gm-Message-State: AO0yUKWlCSyF61ztSNQ5yo4SqLPv9G4BVDhxY55KDk5IshPzU+d2aXBy
        k5074n1S3FUGya9g2T61bCddGVEOUFAZ56fljuQ=
X-Google-Smtp-Source: AK7set/FWTjjMqbk3Y6I0cn5CoAlqOl9nDUaiGYY2zC6irvqYoKHX8rZF6rljLUn2WWTle9RQr30szsXJp9n3gedpik=
X-Received: by 2002:a5b:70c:0:b0:a3f:33ad:1ba6 with SMTP id
 g12-20020a5b070c000000b00a3f33ad1ba6mr10838257ybq.2.1678269387072; Wed, 08
 Mar 2023 01:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20230308090536.2562917-1-felipe.contreras@gmail.com> <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
In-Reply-To: <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 8 Mar 2023 03:56:15 -0600
Message-ID: <CAMP44s2NJefUOzpyq=qbWSi+X-GnVTXaEgT8dM4zMPSzm29yag@mail.gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2023 at 3:16=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
>
> On Wed, Mar 08 2023, Felipe Contreras wrote:
>
> > When the list of files as input was implemented in 6508eedf67
> > (t/aggregate-results: accomodate systems with small max argument list
> > length, 2010-06-01), a much simpler solution wasn't considered.
> >
> > Let's just pass the pattern as an argument.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  t/Makefile             | 4 +---
> >  t/aggregate-results.sh | 2 +-
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/Makefile b/t/Makefile
> > index 2c2b252240..6bc878558f 100644
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -140,9 +140,7 @@ aggregate-results-and-cleanup: $(T)
> >       $(MAKE) clean
> >
> >  aggregate-results:
> > -     for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
> > -             echo "$$f"; \
> > -     done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
> > +     '$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTO=
RY_SQ)/t*-*.counts'
> >
> >  valgrind:
> >       $(MAKE) GIT_TEST_OPTS=3D"$(GIT_TEST_OPTS) --valgrind"
> > diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
> > index 7f2b83bdc8..2efc2c37cd 100755
> > --- a/t/aggregate-results.sh
> > +++ b/t/aggregate-results.sh
> > @@ -8,7 +8,7 @@ broken=3D0
> >  total=3D0
> >  missing_prereq=3D
> >
> > -while read file
> > +for file in $1
> >  do
> >       while read type value
> >       do
>
> This leaves this code in contrib presumably broken:

Right, I didn't know the "contrib" code called that.

Easy fix.

> But overall I like this direction, if we can just change that contrib
> Makefile as well to use the new mode the script excepts.
>
> I think we can go even further here, and just pass the
> $(TEST_RESULTS_DIRECTORY_SQ) as an argument to the script, then have it
> do something like (untested):
>
>         results_dir=3D$1
>         for file in "$results_dir"/t*-*.counts
>
> Which I think is a bit more obvious, and since the only task of the
> script is to do exactly this, there's no reason not to have it do that
> search by itself.

Or just:

    for file in "${TEST_OUTPUT_DIRECTORY-.}"/test-results/t*-*.counts

And don't pass anything.

--=20
Felipe Contreras
