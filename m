Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D987C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1169613EA
	for <git@archiver.kernel.org>; Sat,  1 May 2021 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEAJSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 05:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJSO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 05:18:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE65C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 02:17:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b25so707682eju.5
        for <git@vger.kernel.org>; Sat, 01 May 2021 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eQxuNzQ53wwGZzJoOnHBwSoQxRgca4/hRj0Hj4WW+qE=;
        b=G1rR4ZlSQlWSSrdXflvXm1rU5WMBv3VfRBp8oIlNTHfVtXXZ8OIYD/ZHgJrKp3JPtQ
         Fk0VnnhLVdvzpBMo12vco3Ny9ZwJSlsw5z1t/GSncPa94pSBTB3FQqKdbEqo835idu3b
         ZOkdn1zfeJtZkpUPLEJyYWqpZZc/aVMTiiPNrBahRDknIIvwy4c7Uh3nos0kL4zZlUuQ
         Z0+NV7Q8zcyF75Z8XX4IkOvSzOHOJtd7UywjegI0HHgN+rPdtEB9YG3I8/yfEoNVIrx6
         GTvgVkjDGJuVWTEJocojR8YSL3BQZKTbNojuMspJzQnsouvXN1YbuyO65i3LZIHP8ZxU
         numQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eQxuNzQ53wwGZzJoOnHBwSoQxRgca4/hRj0Hj4WW+qE=;
        b=F6sg2fWizkmy9Y/k/nEk1tsg6hteYsIfZ5p6aNDU3xwlbfbQ77/jNWbXHcAWG9Gzpw
         bMRLabUfxz4zaXwRyIrR8aHleyJlxcilce/cwl6wfB55DR431UGda7YaWwLg4gY0f03P
         vQ5fuk+VhD5MxiwqTrEmo6VL+CAoo0eOZ9QBLgZVIF6r8509NDEsgIk0Dby/OgjUHDx7
         LBmoYissocJqOT4FQwpMwGqYvOzSskWtYqfZ0Jl/BOSVv5SxIFSvRa4fabAre/XcAkBZ
         gUMZXyuEpd5QcyS8brxR2PuKy/IalDqGqwi5cWud5HZu4veRr9FXeTJddjpp6s02BbrF
         m+IA==
X-Gm-Message-State: AOAM532LrHUJr2yNfYqW6lTan8GJSf2YTVgIWwlUkewMQRL9RSdpHDkG
        VxkAhmtv1li0WBZrB7HhfJSBd61p/V8=
X-Google-Smtp-Source: ABdhPJxYnzhNrtoEdUjSjnIP863zi8Fnch35A+Jy/WNyL6KGImBFKP3JH9ir1O5aiDKEHdYAD4lW2g==
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr8399468ejb.335.1619860642796;
        Sat, 01 May 2021 02:17:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hp29sm4561233ejc.47.2021.05.01.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 02:17:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH 1/2] send-email: remove non-working support for
 "sendemail.smtpssl"
Date:   Sat, 01 May 2021 11:15:43 +0200
References: <20210411125431.28971-1-sir@cmpwn.com>
 <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
 <patch-1.2-ee041188e55-20210411T144128Z-avarab@gmail.com>
 <xmqqk0p8hc5v.fsf@gitster.g> <8735vwfvln.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <8735vwfvln.fsf@evledraar.gmail.com>
Message-ID: <87a6peyfry.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Apr 11 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> So let's just remove it instead of fixing the bug, clearly nobody's
>>> cared enough to complain.
>>
>> Hmph, is that a safe assumption?  They may have just assumed that
>> you did not break it and kept using plaintext without knowing?  If
>> we do not give a warning when sending over an unencrypted channel in
>> red flashing letters, that is more likely explanation than nobody
>> caring that we saw no breakage reports, no?
>
> Maybe, I think in either case this patch series makes senes. We were
> already 11 years into a stated deprecation period of that variable, now
> it's 13.
>
> If we're going to e.g. emit some notice about it I think the parsing
> simplification this series gives us makes sense, we can always add a
> trivial patch on top to make it die if it sees the old variable.
>
> I don't think that's needed, do you?

Junio: *Poke*. Was going thorugh my outstanding patches, I still think
it makes sense to just pick this up. Especially with the related
discussion later about how common in-the-wild service providers would
just not support AUTH non-encrypted, so in practice I think it's even
less likely that anyone saw silent breakage as a result of this
already-deprecated variable being ignored.
