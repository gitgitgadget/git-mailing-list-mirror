Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E8C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7645161157
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhE2IP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhE2IP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 04:15:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAAEC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:13:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id jt22so8754159ejb.7
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ChpXzfuF7ByQqBXgr6gEwm1mP4GbBmaNGZK9dR5vrWk=;
        b=qP9ipH6K9ubJtHIhE8awR8E+sKSig8iWx48NnNPj8F/9iQVpsAJVkwozlVRaULtFb/
         z4YXZZec+txAP9BM3KlcH2TD8hxAyXJbesLLUVlaldJEZENTGYhOTL7o+RPM4GrIyzBL
         6Oyc00p/JxLCKApjvXGuxQLCXdNtmCa+RgLdOdmXd8K97oI9TvUImiNqbdoGdmg+QDNU
         6rr/z59MC/1RZRNFL8rYJG3xxMFR6xj8a2W8rrunimtN+XInMFCC0tUFrNd0HN4YjiXR
         TDbrh2UnIde2TIT2uzq4sYd9Eb46/+ROKlnv9yT2cbaXaMsCvwFserhfhIf2lZ5oav8k
         ektw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ChpXzfuF7ByQqBXgr6gEwm1mP4GbBmaNGZK9dR5vrWk=;
        b=d/sOFnE+JYdTV+KcnTNtwIsHWYXzznpM6hozAiUeO4cNdt2VYjm6xbA6rtkkJ6G0Z4
         vUVFS7LISso1uAk8WQpuMQpQRNKg2IgrMmScfAhDSu8iX0e80djO4YfkAlQ2U5H1Veau
         RKCB8Iv+dLh7QNIk5Tvo586jLn2O2pg8iFZ7BGCco6Y/YBtM4aeAAyNJaox5Lp0jxnC8
         LiFC11tbAV2PssoNq/yoaqNJ7KDDF0Uk4p9tC8/NJFaZSyJyyb2Je+90bSrlXkZ0N7WW
         iJLdVvZK7/5XZ6ZN5EAzaZAtA9GShZrjSV0GlBVJ/Ps1VfP9/LW3tVLApv+/L+8NkOy8
         1wfw==
X-Gm-Message-State: AOAM532aGm+X6/4Rpl5CaAGDze4GSxD4pWc+ZjPsn2lIw/ZxJf6Z13og
        Q+ySt4lf5zauhd41u9YMakVBNYAn0vSl5g==
X-Google-Smtp-Source: ABdhPJz7ouAz5iBtsPA9ARarpWyXHz5GLok4lRNXHRKEkLdVQhP0VZrNBPdfTAqs26eE9iWd2EWHaA==
X-Received: by 2002:a17:906:2a1b:: with SMTP id j27mr12842915eje.370.1622276029117;
        Sat, 29 May 2021 01:13:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id he37sm3191029ejc.61.2021.05.29.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:13:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v5 10/13] send-email: lazily load modules for a big speedup
Date:   Sat, 29 May 2021 10:12:53 +0200
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-10.13-9f21bc6e6f2-20210528T092228Z-avarab@gmail.com>
 <60b112638fc47_4b03220885@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b112638fc47_4b03220885@natae.notmuch>
Message-ID: <87im322c04.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 28 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Optimize the time git-send-email takes to do even the simplest of
>> things (such as serving up "-h") from around ~150ms to ~80ms-~90ms by
>> lazily loading the modules it requires.
>>=20
>> Before this change Devel::TraceUse would report 99/97 used modules
>> under NO_GETTEXT=3D[|Y], respectively. Now it's 52/37. It now takes ~15s
>> to run t9001-send-email.sh, down from ~20s.
>>=20
>> Changing File::Spec::Functions::{catdir,catfile} to invoking class
>> methods on File::Spec itself is idiomatic. See [1] for a more
>> elaborate explanation, the resulting code behaves the same way, just
>> without the now-pointless function wrapper.
>
> I would reference `man File::Spec` rather than an email.
>
> And while this change makes sense, I think it should be split in two.
>
> Instead of doing:
>
>   -use Term::ANSIColor;
>   -print color("reset"), "\n";
>   +require Term::ANSIColor;
>   +print Term::ANSIColor::color("reset"), "\n";
>
> We could do this in one patch:
>
>   -print color("reset"), "\n";
>   +print Term::ANSIColor::color("reset"), "\n";
>
> That is just no-op noise that we can mostly ignore in the review.
>
> Then the actual change to require Term::ANSIColor selectively would be
> much simpler to see.

You mean do the change from imported functions in one commit, and then
sprinkle the "require" in another one?

I think it's clearer this way, you can't really assert that it worked as
intended (i.e. you have no more imports) without the s/use/require/g, so
it makes sense to do both as one atomic change.
