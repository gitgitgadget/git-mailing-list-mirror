Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27395C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E8760232
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhHQKU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbhHQKU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:20:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32381C06179A
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:20:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so27774018wrr.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XsLqsKXgDlfbt1m4XTuOkH20djuSNgqE8mqyJaKDwzw=;
        b=Dfx88k0rkjJWiYjLoknxEXur/3VauXQtmOXGUQ5xMZ8hB0hl6Os9/wIwKr+o80kJgu
         +EQRqOhk2smvqxKrjn+lST0CPR+Oo9lhKCnxTFq4eTwmcuxQJ7kgui7iAh0zvnLE1x7K
         L6DZrRwxmnPiL+C5fuvvyHUzODwFkwmaxL8XMM/ZyIWAjlFBf+HFCLJpMabzPwT+vH9u
         NoQCBGfy8ehxnpHuwV39rrm80jeMGt80cI42Ea8Bw3shJz+QAw+f56qZalD8Pl+ypo/n
         41j7H70Uinlq9EW6+CtcG7nwg3QgPhTtqQMN5yUeX3YVW4AIMP5F7BVnjlDWPtiBUGsy
         NGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XsLqsKXgDlfbt1m4XTuOkH20djuSNgqE8mqyJaKDwzw=;
        b=ny6Rg2BM4ixQD5/OKJu3mRnUwcTCPPx9hrKtTaTSX/0a7q2RCxadwOqp3A3o2bIkgJ
         vLrDokwjnHt1oVbvRH0Yr266ETC0O00/XD+8mcTZpxJpmwdrgj2DzCGalJoPmXIqhlQm
         Y+an2zqD3P3P/CDcWWVNtVkxpePVUA9Dt/bQUA6/h/uZ3OHqAmCphZNQuK43vZZp23Rl
         pqllW2nKa7zka1JrZ+CuvsBlBZnbkQVqIgNLb7Bpy9NrigImeVdL+YGRzZK75WJzowib
         lDDXnNT8Rr08XWQEjCzrOakgWaYFPjpfbk3Jhxn5gnCShsZOagZfolZRX2vVDaHg2x7f
         llnA==
X-Gm-Message-State: AOAM531OhQPRxoQzddiemO1LpShKm3fGlTlvEZmFThGYmNuT7eRnPO07
        Gk6BuYHK+g92er37M6XNUEDILw==
X-Google-Smtp-Source: ABdhPJyilDXv51Y7EMpLRVOaG6+KD7CFx5sOAUTM1T+k76v/DOLifEhUvH4z6/Y7C6deiyiLM4ueIg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr2969159wro.270.1629195609599;
        Tue, 17 Aug 2021 03:20:09 -0700 (PDT)
Received: from smtpclient.apple ([185.116.113.208])
        by smtp.gmail.com with ESMTPSA id m39sm1751796wms.36.2021.08.17.03.20.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:20:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [QUESTION]Is it possible that git would support two-factor
 authentication?
From:   Matthew Cheetham <mjcheetham@github.com>
In-Reply-To: <D8CFA50F-266A-4995-8058-D29A2D490D5F@github.com>
Date:   Tue, 17 Aug 2021 11:19:53 +0100
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <673E5460-E431-42B9-943A-E5AF47CB4508@github.com>
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
 <9b199de2faab11eba548a4badb2c2b1195555@gmail.com>
 <0d301aeafc0b11ebb27d0024e87935e7@oschina.cn>
 <nycvar.QRO.7.76.6.2108150001480.59@tvgsbejvaqbjf.bet>
 <BEBB4A79-9773-4701-A8C5-06C20AB42686@github.com>
 <1F2C610F-8800-466A-A0CA-7A6068A14805@github.com>
 <D8CFA50F-266A-4995-8058-D29A2D490D5F@github.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "lilinchao@oschina.cn" <lilinchao@oschina.cn>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Re-sending, this time without HTML)

Hello!

> On 14 Aug 2021, at 11:02 pm, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi,
>=20
> On Fri, 13 Aug 2021, lilinchao@oschina.cn wrote:
>=20
>>> On 8/11/2021 7:00 AM, lilinchao@oschina.cn wrote:
>>>> Many websites support two-factor authentication(2FA) to log in, =
like Github, I wander if we can support it in application layer.
>>>> When client clone something, they need  input username and =
password, it is like a website login process. For security, we can
>>>> enable  2FA during this process.
>>>=20
>>> Typically, this is handled at the credential helper layer, which
>>> is a tool outside of the Git codebase that can more closely work
>>> with such 2FA/MFA requirements. For example, GCM Core [1] supports
>>> 2FA with GitHub, Azure DevOps, and BitBucket.
>>>=20
>>> [1] https://github.com/microsoft/Git-Credential-Manager-Core
>>>=20
>>> The mechanism is that Git attempts an operation and gets an error
>>> code, so it asks for a credential from the helper. The helper
>>> then communicates with the server to do whatever authentication
>>> is required, including possibly performing multi-factor auth.
>>> All of these details are hidden from Git, which is good.
>>>=20
>> Indeed, this is good, I've experienced this tool these days at WSL =
and Windows,
>> but finally I hope these features can be supported by Git itself, and =
then the user end can easily configure it.
>=20
> The problem here is that 2FA is highly provider-specific. And that's =
why
> Git itself refuses to implement it. Hence the credential helper layer.
>=20
> Ciao,
> Johannes


Johannes and Derrick are correct. Sadly, there is no standard =E2=80=9Cmod=
ern" authentication/authorization stack that Git could support in =
practice.

You may think of OAuth2.0 as being a good choice, and you=E2=80=99d be =
right for the most part! However there are several shortcomings today.
Plenty of vendors implement OAuth2 in different ways (technically =
they=E2=80=99re not following RFC 6749 [1]), or have extensions to the =
specification that end up being required for most use.

At the same time there=E2=80=99s no standard discovery mechanism for the =
various required endpoints to avoid having the Git project =
=E2=80=9Chardcode=E2=80=9D this configuration for each provider - the =
Git project should be agnostic.

OpenID Connect [2] extends OAuth2 with some useful things like endpoint =
discovery [3], but that is also optional to implement and still requires =
some server-side registration and administration (that is vendor =
specific).

There=E2=80=99s also the question of user interaction. Often this is =
tied to specific, opinionated choices like: user agent (browser), =
operating system integrations, YubiKey or custom multi-factor =
authentication solutions (SMS? biometrics? OTP apps?).

There may be more that Git can do to surface authN/Z challenges to a =
credential helper (such at Git Credential Manager [4]) that might help =
in making auth in a post-password world less painful. The project is =
open to contributions to any vendor or auth stack.

[1] https://datatracker.ietf.org/doc/html/rfc6749
[2] https://openid.net/specs/openid-connect-core-1_0.html
[3] https://openid.net/specs/openid-connect-discovery-1_0.html
[4] https://aka.ms/gcmcore

Thanks,
Matthew


