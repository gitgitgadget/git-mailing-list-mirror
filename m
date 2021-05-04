Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78043C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD62613B3
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEDMeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDMeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 08:34:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DAC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 05:33:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y7so12864646ejj.9
        for <git@vger.kernel.org>; Tue, 04 May 2021 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xKPkPxN3edqcDQAXXIwD4r1L62VwZfdfclqg+gzFS6k=;
        b=lqlVji5fmEQxWTf4g5/jWPQltrnvk5Yp9gMTj2tB/XEqByvF3zMdnB+OYuMPpW2PWF
         +HGylxH2gBby7dxKoWRq5UQkmalYVbEpLd8JjQG+aNBfHZs/r9jt+1c11PKuvsju7+Vl
         YIH0iFsyBnS6gS60B3TcNyVXn1INnFRO/52hmv5LGqjkm7aFJ9IR+r2bCa8QhBGi8t1q
         +JDqCeW019unIq+J4V30oKzOY+PStkdOB+3PwaqQapTM36t2nqLQXSm3Kp48uOLFHM2q
         5Wj3C/lIdWr98VyLwmWV9kR/llJhil04itN9ftpgkyv7vbjVwC/fE/uJLYbfuDK6Q0HS
         4aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xKPkPxN3edqcDQAXXIwD4r1L62VwZfdfclqg+gzFS6k=;
        b=RRv5/lPLIUV6bZzqopvWOXld1ziPdT+KTgkiYo6A0X6Neuv0j08SWVBWcZGc8SR0Dw
         T+CQYJCszRJ4EJCaY/HQawTDTI70P4RJL45+g/S8vXQb4FZaCmykVFBOKDg5ieEmcASZ
         1nDvpveIpIfbLDhUfO/OnA4F1OBW6YF7Es+TXtpgFKY4C7dS1l4h8+THLApqnd4dkUOz
         Dl7XmDSVUFRo0Iy9q7uO2m6SgthdWFti+NTpNMxYEj3stvXgsvjRHac5Jjodi3uy1efN
         x28d5KEK39aFmvuqpizfxooFnZlwQOWruqYlYKXYRoyLhhoym3jG9xJsYSCviiTP9vf2
         A5MQ==
X-Gm-Message-State: AOAM530n9z6YVNS75o3mViSlkl8+Ka325P0tF3yDKgzpF4p6FXhtVi0F
        dBFf1wYD08tV8KmbtmH5haJUThTUFX4=
X-Google-Smtp-Source: ABdhPJwxIfzU3WBX8oSLus0zDkjeShDIrPl8FcQPxJQU01wBfE9CnhbnvO7e0I0hG8fC0Zo0ha1AkQ==
X-Received: by 2002:a17:906:a403:: with SMTP id l3mr22311806ejz.251.1620131590416;
        Tue, 04 May 2021 05:33:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r16sm5881375edq.87.2021.05.04.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:33:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Date:   Tue, 04 May 2021 14:27:24 +0200
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g> <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com> <xmqqpmy76w31.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqpmy76w31.fsf@gitster.g>
Message-ID: <87czu6wuf3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Is there any portability reason to avoid "local" in the porcelains? I
>> don't have any plans for using it, but I don't see why we'd explicitly
>> forbid it.
>
> Things that are not even in POSIX are forbidden unless explicitly
> allowed.
>
> In general, he way we encouraged people to think has been "don't use
> it, it is not even in POSIX" and "even if it is in POSIX, we know
> the support by platform/implementation X is broken, so let's not use
> it".  It has been successfully helped us to stay out of portability
> troubles.
>
> There may be a few tiny cases where we said "practically everybody
> we care about has it, even though it is not in POSIX, and it makes
> our life so vastly be better" to explicitly allow some feature,
> though.
>
> And "local"?  Not absolutely essential, unless you are doing a
> library that you want to avoid stepping on users' toes.  Besides, we
> are no longer adding scripted Porcelains left and right---rather,
> people are actively rewriting them.

[You mailed me off-list with "Did I forget to say it is not even
POSIX?", I had this reply to that, also applicable here]:

BEGIN QUOTE

I'm aware that it's not in POSIX. What I'm getting at is that anyone who
doesn't support this must have been failing t0000-basic.sh since
01d3a526ad9 (t0000: check whether the shell supports the "local"
keyword, 2017-10-26), released with v2.16.0.

And all tests of any kind since 78dc08875cd (test-lib: allow short
options to be bundled, 2020-03-22), perhaps earlier, I didn't trace the
full includes, but that's the first use in test-lib.sh itself. Released
with v2.27.0.

From my own cross-platform testing and us not having any reports about
this I very much suspect that this is one of those not-in-POSIX but in
practice supported everywhere, or at least anywhere Git has been ported
to.

So just saying it's OK to use unconditionally of "in t/?" should be
fine, like e.g. some of the C89-plus-XYZ features.

END QUOTE

Afterwards it occurred to me that your stance on in-tree *.sh goes
against e.g. brian's opinion on it expressed in reply to [1], i.e. that
we might justify future new *.sh built-ins.

In any case, as noted above I really don't care much about using "local"
in any *.sh built-in. I just don't think this "We do not use it in
scripted Porcelains[...]" clause is needed at all.

It's effectively synonymous with saying "we still want to support git on
platforms that are so broken they can't even run a single test in our
test suite".

1. https://lore.kernel.org/git/patch-1.1-83266f30b67-20210417T084346Z-avara=
b@gmail.com/
