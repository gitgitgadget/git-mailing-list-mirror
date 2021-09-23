Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11EC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0FB60F6F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhIWCLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbhIWCLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:11:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B01C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:09:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y89so6816948ede.2
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A/zRLFGaDI7TWfYr7hqnMrDk5m++xH8R1p0aUzaerbM=;
        b=iNb33eozbOsbryAzRTkxnO4s/SzHH0AzqXPDBRJu8CwKmwdhzaao7sMcZMvFwhF69x
         0UkMHaULkgbZFdba0xxOKjifMxYjIMVAA4AO2yl9QpLD6daNnu54Tia6j4q6H8H3IcfG
         jh8FEzuasRviK9YUTK6YqutG0HztXYGiMnmo/NbxM0KdrBW3icFFFJcL7x5WvKVnrtyg
         heFratN85NS2HaJM2M5724GpmnIdxJ+GEFM5hxEYuDBC0UMU0lHeziCF2CWLnAuW8IsI
         EgzxpgcbWCkYy/onfDQlLXDkQoZWzMKaiQvtJMsOpAPQah0XiMAVtHNzBhY0PVnhOTFE
         GcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A/zRLFGaDI7TWfYr7hqnMrDk5m++xH8R1p0aUzaerbM=;
        b=An25MLMxaLfe1UVnNJhfWbIdcbgYrVYi2i4WO5iK8ldNmC4Fb5vNMSEzj1gBabMUNU
         LaSWGvISNr1P4S3vphq/mfMZGswI7KioAhJs/ytpZOSFZGLYbfzd945EMrTktI+mhG+0
         ZphxG57q9TPUDyUwktHFJlqUYVgnFIcY/8DjjjBuCVBfGbTUewrywQP4sHsSf0ek+lKx
         tVqDtJnkU0atxXIJa0v4CA+6njn8Ho/zP4bt7AKdMt3W0l1OUjaTjkjBlYDIHmtVwrQL
         iMEOdyxTQqYIGwC/uNbg4FmPTq1ddAC3kxd07Yk3EV9grlWhT8HBoUKM57ebVtV5sOgN
         MjMw==
X-Gm-Message-State: AOAM5308gfgJvvJ2gWlPn2PSS76Wxj/r9+9xEd5XQP3Ls1jjuR7ZMDOd
        Lv3gPxgh856rQomN8nB2WKM=
X-Google-Smtp-Source: ABdhPJw/ZGePf0znC+rCTpQ/MNscOf2TOyufuYO6eFxRgIGMau2UepDHvuLZi/hC571lg7FUl6Fm9w==
X-Received: by 2002:a17:906:7302:: with SMTP id di2mr2504803ejc.409.1632362985789;
        Wed, 22 Sep 2021 19:09:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b14sm2244631edy.56.2021.09.22.19.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:09:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, levraiphilippeblain@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Makefile: avoid breaking compilation database
 generation with DEVELOPER
Date:   Thu, 23 Sep 2021 04:08:29 +0200
References: <20210922183311.3766-1-carenas@gmail.com>
 <20210922185702.4328-1-carenas@gmail.com>
 <YUvbU9HX6JA+MKd0@camp.crustytoothpaste.net>
 <CAPUEspjJdkPgpWvLJKNks+Uu-tZmahw6U3pa+XBkMB6_m_dtRQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPUEspjJdkPgpWvLJKNks+Uu-tZmahw6U3pa+XBkMB6_m_dtRQ@mail.gmail.com>
Message-ID: <87czp059g7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Carlo Arenas wrote:

> On Wed, Sep 22, 2021 at 6:41 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>
>> > diff --git a/Makefile b/Makefile
>> > index 9df565f27b..d5c6d0ea3b 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE =3D no
>> >  endif
>> >
>> >  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>> > -compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
>> > +compdb_check =3D $(shell $(CC) \
>> >       -c -MJ /dev/null \
>> >       -x c /dev/null -o /dev/null 2>&1; \
>> >       echo $$?)
>>
>> Are you sure this results in a functional set of files?
>
> no; it does not
>
> This call is only meant to be used to check if your compiler supports
> the feature (which as =C3=86var points out[1], might not be the best thing
> to do in this case), though
>
> After this fix the files are being generated (in a different place
> with their expected flags) and look healthy, but would be helpful to
> know you see no regressions.

I had the same thought as brian, but you're right, since we never use
the result of this it's OK.

IOW this check is really functionally equivalent to something like:

    cc --help | grep -q -F -- -MJ

Or whatever, i.e. we're just checking if it's clang & supports the -MJ
option.

> [1] https://lore.kernel.org/git/87tuic5cdo.fsf@evledraar.gmail.com/

