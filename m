Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A944C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9DF20872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTJ4dmc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgJGW24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGW2z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 18:28:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AEAC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 15:28:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 188so4848541qkk.12
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gAyxqnXJQEjOBCmXz5R6sgwtVRkzvFiL5zdBeMDZUJo=;
        b=lTJ4dmc+WTRJTJoYYaZqZ22uoHuC3EKjxdQYzigPI3TDc9oWzVk3s2smIZBEPHAJl2
         Y9F4ibYUm2F2sOUf1PEraint4OCsJP9oAMLYtipdi2dLieMoFcO3KTKAv1yd++mGQqAf
         +/GcHT6Bex787Vny037oR8pII6KRmgqkK2AQWtnU4R9scvEoVqoX83NEQDQHNk5tP4Z8
         rjQ4xhZJ3Uv44iGC00F77YgA2uSUwrkSC47Fez3UfPSBrjVgyA+LA52WymKDOq/fnjE+
         R+hk0brQoo4qJNCu/LDu5HUHeOXokg2SJAY/cql52UjLTQn1SZJxWaQIW0fC/3RuuUDx
         LawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gAyxqnXJQEjOBCmXz5R6sgwtVRkzvFiL5zdBeMDZUJo=;
        b=iHKp3pEKAs+3tcEHmC0it+DP1iuG4JbdYoFyxCmvFzw2SkR5KSQlrx4FmSMPqfL+Wa
         HkYSX6djamV+WX5jD8HHtBqGOTokh4ZLjVSN1qJYpetb+ri7A1lUq/0XaPi3QS77FWsn
         Yftmsl3tC5j1AuVROA0/coYzIGlk5J96WnG7iv7zls8wATQiRXIiCzwoHa+8X1vpIptp
         TH0F3SP3BOeaNIMULDOwpihWHeSdiEQj2I4SrIYgKtZ+63mK6fFqhY7rNla6TrU2uTSn
         97ozKHliIR54G4rumcDAMwygoxXWrmgSSHDo/kVcUkRuJfWp+OrP1iRNZ9mfZakio0BM
         ZS8Q==
X-Gm-Message-State: AOAM531nlg6k+voqChMhYWpj8ftWP72rNtHx8HSBzouMJujq2xZ31tEK
        0v8aXpmS3t+7IwOJ1NIGaZQsbnEaXMc=
X-Google-Smtp-Source: ABdhPJzzMYpdmc5O2OAoCUs/DmV8XTxDaXbXZZjN4wEehPWKM1r8u/oYrR0i9qIIikqAIbqgs0mmEQ==
X-Received: by 2002:ae9:ed05:: with SMTP id c5mr5021971qkg.484.1602109734880;
        Wed, 07 Oct 2020 15:28:54 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u4sm2485852qkk.68.2020.10.07.15.28.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Oct 2020 15:28:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
Date:   Wed, 7 Oct 2020 18:28:52 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8657EB7A-553F-41E8-AEB2-9903049FE346@gmail.com>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 5 oct. 2020 =C3=A0 18:41, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20

[...]

>=20
> * A handful of places in in-tree code still relied on being able to
>   execute the git subcommands, especially built-ins, in "git-foo"
>   form, which have been corrected.
>=20
> * An unused binary has been discarded, and and a bunch of commands
>   have been turned into into built-in.
>=20
> * A handful of places in in-tree code still relied on being able to
>   execute the git subcommands, especially built-ins, in "git-foo"
>   form, which have been corrected.
>=20


There is a duplicate entry there.

Cheers,
Philippe.=
