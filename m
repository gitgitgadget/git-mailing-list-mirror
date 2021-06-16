Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2FC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981AE6109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhFPU6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhFPU6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 16:58:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC75C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:56:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so3917483otu.6
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fJ1uKUQF92SuHbglXlixVeHAsiWIdYKh8X0Mlo525ik=;
        b=GJBJd0GxMeyTRbX8bo9Ma2IRqvDFc2/edS98S9NwWddJIGoMxvXOxDa+TFp/qMvW73
         /hnYtHTR+SOaEGjd2O2Jln4d4GXYI4EDkhUcXpDUh4I2jkCj3eJdaH1ZtTFPGPZZWl2F
         03HdR1fienap2KSo9PnK1RdegvypcCw4e3WqNp7FiZLG8/+4IeE4UYEeBsrMV1+HyRMB
         A2nXq6HsTmkcOWmb2oNlgHLGwCCJ4absQmvxCHCSIMqclyb9QLKzkQXxENOHtTj7XYXK
         SuP7RkqcfRKmmkoHm6y6tD5FQTlXM7wL3kj5cxulPyJVaHP4ZsDBGSKLWvCbtNdZPfDK
         ZCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fJ1uKUQF92SuHbglXlixVeHAsiWIdYKh8X0Mlo525ik=;
        b=OF+1xeBImwmioCJQhkbQPD4Mw2+MOHV3jwfKatbBPBHNv5oLVDIqDRlbi3MvuEYCjD
         qmExOIJ0Fttv5G/aYLr0FdOz6cefkYfIkOLXgb36nRZoWdnPwpMYiO2jbef3be1TchBq
         1Pzi+/CvY0TBIdO5E+aMbuTZhCiYtIicp9L6XB6KAhNTGZk1AUPVer4mM7603wwJjJRO
         FEpOvYWbnozJwYPCGzz0qzWhSQVV/caYHIlONW25gNUQCPVp6otfU7KFpwNlGj/xfvHp
         hi5i+ND4QeFBEe0Yg43uduj8PkEyb+qp23fzdd3VR4Wk6MzIGMQQ25dki6wZuHzvoYqN
         STRA==
X-Gm-Message-State: AOAM533p4RSRbPTqbxHaHITR0tUzuSfvLI8KE9SQxBsvhvJoq9DxyeCg
        lDwCj5z23U8vI88d/p2nwss=
X-Google-Smtp-Source: ABdhPJymqc1TIWlEujUe6c1gZ/bh86cELqGMKaPqtUOuH4+iayHRhJZWVkEqWFBw9Fkc0vvHeo/pNw==
X-Received: by 2002:a9d:2227:: with SMTP id o36mr1529440ota.309.1623877000062;
        Wed, 16 Jun 2021 13:56:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z5sm795399oth.6.2021.06.16.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:56:39 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:56:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <60ca6586607f5_602720852@natae.notmuch>
In-Reply-To: <871r93ym8q.fsf@evledraar.gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <60c8db3558fb8_1296f208ac@natae.notmuch>
 <871r93ym8q.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Tue, Jun 15 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> I suggested in [1] that the "alice" and "bob" examples in our
> >> documentation would be better written without a reference to such
> >> fictional characters, for reasons that have nothing to do with tryin=
g
> >> to bend over backwards to avoid any reference to people's gender. It=

> >> just makes for better documentation.
> >
> > I'm fond of Alice and Bob, and I'm saddened they are the latest casua=
lty
> > of the culture war, but if we are avoiding gender of examples, it mak=
es
> > sense to let them go.
> >
> > However, I want to defend this usage a little.
> >
> >   1. Alice and Bob are familiar, so it requires less cogntive load fr=
om
> >      the user.
> >   2. Alice and Bob promote the usage of git as a distributed VCS, whe=
re
> >      unlike centralized VCS, you directly use the repositories of you=
r
> >      colleagues.
> >   3. They provide some relief to an otherwise sterile landscape.
> >
> > I don't think these changes make for a necessarily better documentati=
on,
> > just a more sterile one.
> =

> Fair enough, for what it's worth I wouldn't recommend against using
> these names in general, I would think you'd actively seek out those
> actors in e.g. cryptography documentation.

I have not read cryptography documentation, so for me Alice and Bob are
simply two illustrative colleagues.

> And as argued in 1/6 for those users who /are/ aware of "Alice and Bob"=

> it's needless distraction. Maybe it's just me, but whenever I read
> references to them I keep waiting for the cryptography angle to be
> introduced. None of the uses in our documentation reflect that canonica=
l
> usage.

It's probably not just you, but the vast majority of readers are
likely not aware of any cryptographic reference.

> There's also just weird things in our documentation fixed by this
> series, such as referring to a random file tracked by git as "bob"
> instead of the more obvious "file.txt".

OK, _that_ I agree it's unequivocally an improvement.

Cheers.

-- =

Felipe Contreras=
