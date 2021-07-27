Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C5C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 03:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD57660F37
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 03:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhG0CZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 22:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhG0CZC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 22:25:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C6C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 20:05:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c18so11067003qke.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Sw9tJqSq2Sfy9bkhhkMXaSNAH4EARWMnJMCMbSovSw=;
        b=KCNRCt+05yfG5yVKXd76SITePzYCxdU7WDLU93AIRElXt7Cg3i8/mWbUyoH5LzzeYu
         jKCFW+R1+OEzRonSV+seSXwft929I0PH3RSQC2Q/DMQzqVWFjDPhZVtiwKy+mA0xsfBC
         TDh/gAvkARbBnpMVNk3/SSKMR8gT2ZHHtHHEr+3vGcp/cE2AuUk7MWa7wlt91G8wRv8S
         3FUouoB0LiGZ9xa1K8dLWRnVpS9BGDKQ0ErzS8aX7cyQiC6U9iKqMn8ilkWTtk4kBmhH
         Ltd6pkGJDHCrrnTaJ2N9t8/+s0lWCM5GrgsSsI4NNweDZ08bwGSDs0RHSq9yBkWm0ZjF
         DbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Sw9tJqSq2Sfy9bkhhkMXaSNAH4EARWMnJMCMbSovSw=;
        b=rrSiAkTpGW1mTOEW1VF7rKUmxE02cHyTybWIgGlXvFsOQ9pcPbsaFrn+sRysCEO60R
         DudI7pXRsckqJQeAmdZIgHl2tj0oVAE+FJZ98oebFhqDq+o3Qo+3wzTY+vM7Zn1bFiDV
         +ziKWg4qzycJ/ByUMYGvGgZpf/C/CGHwRsSPhrmgXMOeFmfbXxNcUlC5d98eU4OC6DGL
         tES3bayI+VVQKBetCJrzAJFjZri0QlLBHfw90jjG04uYEx2apKH/xns6Vipv3rxRarA3
         R5cOtG3avWVy+vHoyJiCHKHnTdP6u7JAT2cTARcIGo/+CW23TiV8qGLaIPTO5KmKX8OY
         REqA==
X-Gm-Message-State: AOAM531mlYtRQjbW1XTaH99V2HMor93HZHua4btU+b0OaurDSbYNdpQB
        aibJ8NZ2INi/Meanxrctg/9Jo1Gf7/+LwA==
X-Google-Smtp-Source: ABdhPJzUqWh9LdF9nxpkiBDhv9GygqaeIYkL2o/v/WuQEwj6ylILTTRW7WFF8OCO8MxkW+sR1AUbDw==
X-Received: by 2002:a05:620a:4043:: with SMTP id i3mr20581945qko.27.1627355129112;
        Mon, 26 Jul 2021 20:05:29 -0700 (PDT)
Received: from smtpclient.apple (host-68-169-160-88.MIDOLT1.epbfi.com. [68.169.160.88])
        by smtp.gmail.com with ESMTPSA id x125sm1044193qkd.8.2021.07.26.20.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 20:05:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
From:   Evan Miller <emmiller@gmail.com>
In-Reply-To: <xmqq8s1sfqez.fsf@gitster.g>
Date:   Mon, 26 Jul 2021 23:05:27 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <372227AB-E4CF-42B6-9B08-261037F39B49@gmail.com>
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
 <874kcgsh94.fsf@evledraar.gmail.com>
 <YP9jU194U7S1PFxS@camp.crustytoothpaste.net> <xmqq8s1sfqez.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jul 26, 2021, at 22:20, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> This suspiously sounds familiar.  Asking for "close ssh connection"
> in the lore.kernel.org archive finds this:
>=20
>  https://lore.kernel.org/git/YKTg8nYjSGpKbq8W@coredump.intra.peff.net/
>=20

The described symptoms match what I am seeing. It makes sense that =
ancient hardware would bring out the bug =E2=80=93 triggering the server =
timeout with a long local computation.

Switching to protocol 0 successfully works around the issue. This =
concludes my interest in the error. I suggest reviving a discussion of =
Jeff King's patch here:

=
https://lore.kernel.org/git/YKU4mbq%2Fam%2FliAN4@coredump.intra.peff.net/

Evan=
