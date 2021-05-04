Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F876C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E34613CF
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhEDUXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 16:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhEDUXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 16:23:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B79C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 13:22:36 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t8so114067oij.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8I9d5o5oMUKQdmU6DaFVnhCjEf129g3Y9PsvQi8QT4o=;
        b=td+SLAg0OqLzgxNSn0yPyyFqmn77NkGXEsNe7C4ne5mRd+04sWesDEDFabAPC/fKAk
         1up2hGb8NDxl6VpqNRJ3V3heCJlQjKx09Uox4ZtQoczuRNAWwrVRav/Pfh0q3X8TDlIY
         7OAJQ4yEPLKpGbYoGjsR2C3Zli+b49TdXL1gcJPxE00BTM60xFNwicPKm6QwFmyTznIU
         kGPSizAWvICdMc3zAlmicAX6SXcsWmLlcYsaA6ACoX1iAm30NAsFvkibaVPiSQQZ51tw
         hZW98VRmLVjLXhAA4TTqCFXs9q4Yq6F0491PKtDPGM3AUXNRYWIMSlPKQaI+yPG69Pjk
         8X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8I9d5o5oMUKQdmU6DaFVnhCjEf129g3Y9PsvQi8QT4o=;
        b=JKEPnA9nWac7QWuQV7ZcKVhwFB0dzEIjFq+ps4MsJ1hg+sPyJxBLP1oLkFEFUDVd9t
         xqc2n11wL+q9/y11NIGdvIQnRJt5ErPBCw6M792fSBVzWQrMA8j8qNgb3PbPR4JiBkP6
         dRHNilPoAmUvv9BOdhgof9Z3XsPtakl99j4xUyidxTqTbGQThNDIU0wqABm3XC97PLHu
         dvU+XPDfHVAedzuv5vdYu+zzblCUJygFMoiuI7uEsDTJuLLkWOjAdJ/MJgWmstd2BD8b
         9LQW2p/9eu0TnICn6Z65Bn/iahXhbruKV/09twQDGj0BEmE1QWeCZhGvqMaBfHa+EwVB
         FN3g==
X-Gm-Message-State: AOAM531xfkX8rVbYbA7oYNqWlymNaIwf8l0dYH1vUg1lRd4f31Nir0nr
        S56YRRy5ygFZBR1r9bIbxus=
X-Google-Smtp-Source: ABdhPJwTR7zup4+v6GKH33+AoxD4tTplzIzsMeVSrv6ymKDIbWnPy5Yyv7SjhJiBKjnKXjsjPWrFqg==
X-Received: by 2002:a54:450b:: with SMTP id l11mr4306455oil.68.1620159756378;
        Tue, 04 May 2021 13:22:36 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m67sm881498otm.69.2021.05.04.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:22:35 -0700 (PDT)
Date:   Tue, 04 May 2021 15:22:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <6091ad06cecb0_b34a8208bf@natae.notmuch>
In-Reply-To: <87a6pawmyu.fsf@evledraar.gmail.com>
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g>
 <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, May 04 2021, Junio C Hamano wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> It's effectively synonymous with saying "we still want to support gi=
t on
> >> platforms that are so broken they can't even run a single test in ou=
r
> >> test suite".
> >
> > Not really.  Those on such a platform would (rightly) say that it is
> > the test suite that is broken and out of compliance.
> =

> Indeed. But the lack of any reports about that suggests that in practic=
e
> this is universally supported enough to be a hard dependency.

It is universally supported but not always in the same way, which is why
it hasn't managed to become part of POSIX.

I for example stumbled upon an issue where 'local x' does not work the
same in bash and zsh, triggering a huge discussion on the zsh mailing
list.

However, if you set a value (e.g. 'local x=3D') then you shouldn't have
any problems.

  f () { local x; echo ${x-unset}; }; f # this behavior varies

For a full discussion check [1].

[1] https://www.austingroupbugs.net/bug_view_page.php?bug_id=3D767

-- =

Felipe Contreras=
