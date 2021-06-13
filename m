Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF08C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 21:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429326108E
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 21:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhFMVo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhFMVo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 17:44:59 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15BC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 14:42:57 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so2200125oor.6
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=laR/4yGctlKDK/DDsThu0VZ8RQI02pQ5ddLrMAdnMAU=;
        b=MuYrLawxx6cHvRCnrFH6+uKAdBKqljezIgHjLJ0iKRy1ocL8Ej3vlKDjv8FCXJ6J6x
         dW6Tuaj7zht+ZdgVbkr/GepvembFGSWnRvqjw3/CyXCbOlChF3AorklKfUaXx/JeDCWD
         T6OKC9xBVX7Wv/D7loV3mc11w2aM1p9hURlxF1/eqHd6HDNvWxvl/VZPjxQOh7dQEyGK
         8EZ4FKXM1uOLkYHfzhz1oaGQS33/i8g3RqTCpdWW4QJ299SnjWI/azRVt8vBi2okK7Tu
         UgJfbYgEH+2dfavvdA9yDf4OsctSjg2AHxw5+4GN1EdeHK7VDvMvcP8mc3GXPIj7jfzG
         W/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=laR/4yGctlKDK/DDsThu0VZ8RQI02pQ5ddLrMAdnMAU=;
        b=qv87VZSjnqN7RB8bJmIeVcoXZPxMn1r2N7qQjy0PUD2AuCUv1wvj7sl1JD1CIBHtKI
         8vhK39nOfwP/h2M+BVDqIEAKBWHQiScrTPTO01yFkPx0GWBF5d7eMPfgsVGuCuyzsOSg
         um7KRZcSoB3oc1OLpnPUpnLFdrt9q/G9T0jXl2EscsEyiBxOnZgVoEgFkKaOmz+JyEU2
         p9TBqwjNSDNWcr2gyplIAIVHxAjvwBS82h6o5Jjztno0wSvi0vb1HDisVwfDntJN+h/p
         4OssbW+y5tCraCls587sBgVPhE+Bdmiat6w/ftP5e6CemqHlvuD2JhA8kScSHpYBAhaG
         ULJA==
X-Gm-Message-State: AOAM530qjntWJ+ZeZKdI0nd99TbOVEd4E/ydvVISim21JNVWPGk79oPL
        6N39MpkiVlf84uEEdjFsk/E=
X-Google-Smtp-Source: ABdhPJxULNtSIHo6gN3CNwRamEkA+RqQl8qUOP9Z4Xij4yKn84kwnTeLhzxgwRMxsYGDGjBFW3aMWg==
X-Received: by 2002:a4a:6142:: with SMTP id u2mr10868208ooe.9.1623620577299;
        Sun, 13 Jun 2021 14:42:57 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z4sm2952325otq.48.2021.06.13.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 14:42:56 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:42:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c67bdf5b77e_f569220858@natae.notmuch>
In-Reply-To: <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <87bl8928q9.fsf@evledraar.gmail.com>
 <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 13/06/2021 14:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > =

> > On Sat, Jun 12 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote=
:
> > =

> >> +	   { test "x$1" =3D "x!" && test $# =3D 1 ; }
> >> [...]
> >> +	if test "x$1" =3D "x!"
> > =

> > We don't use this test idiom in other places, it's OK to just use "$1=
" =3D
> > "!". I think we're past whatever portability concern made that popula=
r
> > in some older shell code in the wild.
> =

> Slightly off topic but if anyone is interested in the history of this =

> test idiom and why it is no longer needed there is a good article at =

> https://www.vidarholen.net/contents/blog/?p=3D1035

Very nice! I often wondered why people did that.

-- =

Felipe Contreras=
