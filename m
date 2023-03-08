Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F1C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCHLRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCHLRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 06:17:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470EBA856
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 03:17:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so64251183edy.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678274242;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtkxOsMJewYO/sQwjq14QC2XTbaeS7jFWMAOqnwCh54=;
        b=l72uOfxs1P5oAlCWEYRHaIeUZVvwkh3ANzdiXC5t078pOSMLD6yw+JClacWHhh8gxO
         LvUE9AVSWaBbCart5WMqU/LhVWi7EgOQiCvZIdVk/y8QhKZsaV+Wl1/EQz1t6KmjAx2a
         ZM2kw5N+jUcpBUh5iCZBr/HNxeplFXCuZ1D7qvLBh7yBf5fWhNXfGRosxJWpTEBVJ0LN
         i1uhRwLBVLhhDvAtJaxO5E8Yy7iA5/q5YSxnuE7yL9XvGhLIJiHx9H9PBlgGo/T6rCe0
         2Rqq7knw2r0IpVNb01UQ177R+z6FALOinaCnoUwFQE267rzfe3t8eROgGJYuQwK7nywX
         FOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678274242;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtkxOsMJewYO/sQwjq14QC2XTbaeS7jFWMAOqnwCh54=;
        b=torKj8Lr78CrBhsUwa4X/Lb/E4/A3RE4kw4jG1mCQ/4VdmcORzvyMv4z+VLyVwag9g
         NpkUdPs+FhC+ljNhs7Lliw1jDGVUGKB4PcY/OgpEoM/EFjJVosuxlCH4KcRaHd5km7gJ
         /fzSHVUinnsy6LdsWLBKQtdhZ99PaKQM91C7G86W0Sls+zUkncypeXBlGIyYN7vvWgnc
         SHcKN4Y4lLA1bNcrQaTxoZQk/jSo/2E6A1uhTJ4bh44A5e5elNQ59vYlfFCHnFrc0izT
         018ZvsAx4cmEtNJHYShCi7NBtWd9fzHfJmvH32ZH7QRY+NF1GIQl3CX+hj2S/PwIFpw4
         BcZQ==
X-Gm-Message-State: AO0yUKVMqWUJBHHBhix/kUZtADt/+UygiVxeNvk6QY1xk5qvlQCvo8MU
        payrtAsg3nOzYpjBiigQLWPQK0DZur4/IQ==
X-Google-Smtp-Source: AK7set9XbFkDlk9mlha5ug799Ds1OP7VzVWe2hmL4eGWPOgwY3/2/OJwn33wBK7jvS6qT8Rd6M59JA==
X-Received: by 2002:a17:906:2297:b0:8f8:1501:be60 with SMTP id p23-20020a170906229700b008f81501be60mr14860491eja.7.1678274241642;
        Wed, 08 Mar 2023 03:17:21 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090633d600b008b907006d5dsm7470503eja.173.2023.03.08.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:17:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZrnM-000vqc-2X;
        Wed, 08 Mar 2023 12:17:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
Date:   Wed, 08 Mar 2023 12:15:16 +0100
References: <20230308090536.2562917-1-felipe.contreras@gmail.com>
 <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
 <CAMP44s2NJefUOzpyq=qbWSi+X-GnVTXaEgT8dM4zMPSzm29yag@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAMP44s2NJefUOzpyq=qbWSi+X-GnVTXaEgT8dM4zMPSzm29yag@mail.gmail.com>
Message-ID: <230308.86ttyvxzjz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 08 2023, Felipe Contreras wrote:

> On Wed, Mar 8, 2023 at 3:16=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason <avarab@gmail.com> wrote:
>>
>>
>> On Wed, Mar 08 2023, Felipe Contreras wrote:
>>
>> > When the list of files as input was implemented in 6508eedf67
>> > (t/aggregate-results: accomodate systems with small max argument list
>> > length, 2010-06-01), a much simpler solution wasn't considered.
>> >
>> > Let's just pass the pattern as an argument.
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > ---
>> >  t/Makefile             | 4 +---
>> >  t/aggregate-results.sh | 2 +-
>> >  2 files changed, 2 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/t/Makefile b/t/Makefile
>> > index 2c2b252240..6bc878558f 100644
>> > --- a/t/Makefile
>> > +++ b/t/Makefile
>> > @@ -140,9 +140,7 @@ aggregate-results-and-cleanup: $(T)
>> >       $(MAKE) clean
>> >
>> >  aggregate-results:
>> > -     for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
>> > -             echo "$$f"; \
>> > -     done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
>> > +     '$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECT=
ORY_SQ)/t*-*.counts'
>> >
>> >  valgrind:
>> >       $(MAKE) GIT_TEST_OPTS=3D"$(GIT_TEST_OPTS) --valgrind"
>> > diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
>> > index 7f2b83bdc8..2efc2c37cd 100755
>> > --- a/t/aggregate-results.sh
>> > +++ b/t/aggregate-results.sh
>> > @@ -8,7 +8,7 @@ broken=3D0
>> >  total=3D0
>> >  missing_prereq=3D
>> >
>> > -while read file
>> > +for file in $1
>> >  do
>> >       while read type value
>> >       do
>>
>> This leaves this code in contrib presumably broken:
>
> Right, I didn't know the "contrib" code called that.
>
> Easy fix.
>
>> But overall I like this direction, if we can just change that contrib
>> Makefile as well to use the new mode the script excepts.
>>
>> I think we can go even further here, and just pass the
>> $(TEST_RESULTS_DIRECTORY_SQ) as an argument to the script, then have it
>> do something like (untested):
>>
>>         results_dir=3D$1
>>         for file in "$results_dir"/t*-*.counts
>>
>> Which I think is a bit more obvious, and since the only task of the
>> script is to do exactly this, there's no reason not to have it do that
>> search by itself.
>
> Or just:
>
>     for file in "${TEST_OUTPUT_DIRECTORY-.}"/test-results/t*-*.counts
>
> And don't pass anything.

Yeah, I think that would work, but at least on an ad-hoc basis I've
sometimes saved away the "test-results" directory
(e.g. "test-results.prev").

I think it would be useful if the script part of our tooling was happy
to accept any name for such a directory, and then examined its contents.

But I don't feel strongly about it, and I don't use aggregate-results.sh
in particular (I always use "prove").
