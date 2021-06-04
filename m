Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B31C4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269D1610CB
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFDDsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:48:23 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42824 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDDsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 23:48:22 -0400
Received: by mail-ot1-f44.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so3453877oth.9
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=INl5xUyZGNMWE3nyjWdP3iMMWSIskgLBroneYFWhhps=;
        b=jUEgIGphWn4to1GcSQmyDnCgY5hQTn5O3gluiAOZDMwvtCAv7mnpC1gnNrV1YQJ0cM
         oybtnhJ8tbqTybGtO0QVn0Pz9fmyGyiItfTwB97hZ3nLFBFW0kiAjbE5eMQFjK1q2z3Y
         hVEn27F7tQa2BhPO6GN+QX7J6nzVWqw+b2Qu1huzZnBtgqdoMSreINxnZl+SS49TMNJ2
         8+Hxx3F9tCMWKCa1B2ChIBbKF3p5EGcu3X3srsIleZYbOiY3Zz/CXV8/PjZxBBdED8B3
         LNVEommMaRLnEEkhxip1ZgLXaZZ7urX5ggjbXpLyOZd6iY09zpHCH8YPt9KI3qCuGWUf
         y3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=INl5xUyZGNMWE3nyjWdP3iMMWSIskgLBroneYFWhhps=;
        b=GOjLGk+8GLEKabvuw80vSyB5w0RY9O+e119m2imegXRmwOGevOykm3d1uLUOJ+iirI
         +JbEVk+ONDQauyja7yCmXUH5XJQDzjHyQ3EyAvmUFEx2EOB/3zI/Z8G6o70Vt4i9BtaX
         VNimO8WwHyhTC6CMeH2sSfgiEQsf62NkAhzeHjQLwU+OZb07Yy100GA8Fyn6D8NVQsCr
         rAgZEF2lxHFr+3jMYlW8HKizGiaKrXHNmMtn3FqbH+xNkUZam8+PvJ+Wyfu+gIPwrlN7
         CJJSUHGPH1erita3kOlDQAHLPPbyq7vBnD98HenJSt1OfDi9x/cMFjuMvm/P/uE2sqKm
         4XxQ==
X-Gm-Message-State: AOAM531coFcDDdyRDUrqntQ+TEcJXzY4L8Jdu47vUEHaCmjSJbCBE+uQ
        l4ct2HPI5+ZnQvMSRkIdTFo=
X-Google-Smtp-Source: ABdhPJy3XeRd0RMT5chQuTf3XHxGCz82Oz95DhJdxJ8iyUH7JtEs8wfal1SjM4YIu/p2H3NPLXdm4g==
X-Received: by 2002:a9d:1b24:: with SMTP id l33mr2109001otl.309.1622778323678;
        Thu, 03 Jun 2021 20:45:23 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b3sm220618otk.54.2021.06.03.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:45:23 -0700 (PDT)
Date:   Thu, 03 Jun 2021 22:45:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
In-Reply-To: <YLmLyT0XmQ/lOBKg@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
 <YLmLyT0XmQ/lOBKg@danh.dev>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-03 21:07:24-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > > On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@gma=
il.com> wrote:
> > > > All you need to enable 2fa is demonstrate that you can *use* 2fa.=
.. So
> > > > you need an OTP client.
> > > =

> > > In the past, when I tried to enable 2FA, Google always asks for my
> > > Phone Number because of *security* and *safety* reason.
> > > =

> > > I tried to create a new Google account to double check my memory,
> > > Google now requires a phone number in order to *create* new Google
> > > accounts.
> > =

> > Presumably if you don't have a Google account, then don't have a
> > gmail.com address, and you can't use Gmail.
> > =

> > So why would this thread interest you?
> =

> The first point ;)

Which is?

-- =

Felipe Contreras=
