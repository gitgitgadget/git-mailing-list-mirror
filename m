Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F41C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123BC611BD
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhE3QY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhE3QYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:24:25 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB115C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:22:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so8763947otp.4
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vd5sNN5dpnQ9D657Kxv7q83i30x+y+PGjJ4POHs0EUM=;
        b=RH1n3Md3FHGoL58Su1183XQ+SPPFHyHMGLj+IVPORh4V5z2Muo1p4OCU6IZ0KpDvUA
         tBpAU0EJ6R4yIoL3t7c3DVspRB0VR/CPq0vUOF8mcwWDBVtR8UYZF7Wb4I/k2EwdIrmE
         i3ULQbC2Y+i0yVJH3+HW+kWZex1Zh0DLxiBl04g9lMTkPKmaC9INiL0iZePO8DaBv+gA
         Z3y46hyffLDoX44OoG4rbiZsIouoWDSw+8F7KSRvkiUhStU+IQ/FaEA3CNw9Ldt32gIp
         +gfQ+lI4SAPyW5Ar3XR2/lIyz1KevilBojakLMrL+Pl7QFgCH5+8kgoogWGiMXRv2c/A
         9XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vd5sNN5dpnQ9D657Kxv7q83i30x+y+PGjJ4POHs0EUM=;
        b=YJRhVc1zch+o/2qnsWUmh8jDRnwQLFQomO/CdvEMJyARxPEoiS/NlWJwkeiJeSGdCU
         EeDBmzpKzSZw0TU2bFVqYn8t2ZH4BU9rSjee+Ca9uYwvTsRr5sDSWIiFj1sdjAOD8rdM
         AwlgpsrkO90nOxRDPN5QVhG5jEyMJbL8L4gTO/s+5YVfauV9+Gryct0ncU2/v7IKZzhh
         G9z61uLdMD8ne/NrPc2jzP3YhEqGv5E1XelxQB28cpjIv2nTFCKj9X9Zlxm9U52QmIYM
         1MYX38ZfDUktlwnvrgUCyT8h9uBZpuWj4fjErrt/5GTpzsLLeT8FIu1Bf+adRHsELL+V
         GyHw==
X-Gm-Message-State: AOAM531qzTcUAvPp3bPFKujEAG0iLOoYKpt+XI/yaQfprWu63XWCaO6+
        QTNUNG2nX3li1Grv3xLOYsdHEQI87G25dw==
X-Google-Smtp-Source: ABdhPJygULq0x6jnMIsOstIRykPDnXkEd1QcENo5JlIUR9W1bqK6vI99Ity3SP9R6mIuayLBX7jV4w==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr14217055otk.262.1622391766141;
        Sun, 30 May 2021 09:22:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x9sm2389392oig.18.2021.05.30.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:22:45 -0700 (PDT)
Date:   Sun, 30 May 2021 11:22:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b3bbd48b00b_b937208d7@natae.notmuch>
In-Reply-To: <87a6oc318s.fsf@evledraar.gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <87a6oc318s.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 0/6] Unconvolutize push.default=simple
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sat, May 29 2021, Felipe Contreras wrote:
> =

> > Tired of jumping through hoops trying to understand what the "simple"=

> > mode does, I decided to reorganize it up for good so it's crystal
> > clear.
> =

> I'd find the end-state even more readable if this "triangular" wasn't
> passed as a parameter but we just did the top-level dispatch based on
> that, i.e. "simple" is really internally SIMPLE_SIMPLE and
> SIMPLE_TRIANGULAR, why not dispatch on that? Our internal enum doesn't
> need to 1=3D1 map to the config setting.

Yes, but where are you going to make sure you are in SIMPLE, and not in
CURRENT? Surely you are not suggesting to modify
git_default_push_config(), which is pretty straightforward. So we would
need yet another enum.

I don't think there's a need for that, as you can see on the patch
series on top of this, there's not even a need to dispatch anything.

> Part of that's that I prefer reading code in the current "master" which=

> is if -> die -> most of the rest of function, v.s. your end-state of if=

> -> stuff -> else -> most of the function being indented to that "else".=


I prefer that as well, but unfortunately in this case we need to do
something after the checks to die(). I could add a goto, but for just
one conditional seems like it's not worth it.

Either way this is a temporary thing, because in the next patch series
the code becomes pretty quickly:

  if (!triangular && strcmp(branch->refname, get_upstream_ref(branch, rem=
ote->name)))
          die_push_simple(branch, remote);

And then:

  if (triangular)
    break;
  if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
    die_push_simple(branch, remote);

Cheers.

-- =

Felipe Contreras=
