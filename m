Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F33C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC55261289
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhGVMuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhGVMue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:50:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD12C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:31:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o8so4396505plg.11
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jbd6o0BCYh9ctJ3lZO/pb3SjqjR/gVS6KaIo6wM1nPA=;
        b=NI87pz4MbcFsYY/J/0wP3l9h0G6Zq4iCc402qb7USpoBaW5qmgpn7laxu8iVXHgPq2
         /RFkWv3YNuRbIjDqdDea0+Jh0Y9HgoakLQt3P8m9w6g0Qu9n+NsALeDIl3Vq7SpvCmA5
         slI2VX42OJY2TQ8/MFofVg+QPHFKTAvxOtPXYDjIeGzzDocn21mO3lrBhPsg16kxOY4a
         64HwgzieS9Fsz/ca0SC+kuJ7GxomanONC9uSEeU5YwJh1hcECLo/+q6vJA/6Br42Yf1y
         UfHiEp+2DVjprSwYeqcKXgYVy2ZChVHsQDBAsgK7cdBFoVKI4eOlxkW+jQxxE1Ocv8ua
         HMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jbd6o0BCYh9ctJ3lZO/pb3SjqjR/gVS6KaIo6wM1nPA=;
        b=oNm389zyEEHbXg27yGUO73JI+ssXLMIGO4eKM+8LCIdtp3bYX+VyZKqFRX81rdPkLP
         01cVh6//3NyzgXOO6ddPGUCWEE478zemsJ6FibMU5gYI2wST/0gsvpzhKRZ+IOw/q4Fo
         q0YCkNhk9VzIO1BnYhBiPeGiPw2DI77i/rRHL/AwblugAN8gOpJQTX0UAhz88LmGnA4m
         KAPpztoRUAVfy9Wprtugt4GsiF7ZvZD5ik6Q6vOHdC6H8Q7IPierbUYzTzAKpXKgR5lX
         eBTXNYBTRK81hABXtExwkUWpTuKunLMrVZp70E1GhhHh0VRpGix1wilr3XmP8okYw5+b
         6F9Q==
X-Gm-Message-State: AOAM532zAsR8uLBaRUzTcR0wyOCykleoKoNhYPMBPoUvMCo47OOJR7tK
        xFbvxhSrsc7RViEuD6wYCUqtq5eNXgcy/4ky
X-Google-Smtp-Source: ABdhPJx9YeJTdtQhvWHs8CP/JNL8fhJcUfAMuRgt5z7f9TPm8Jp7dgP8n1cTyrFqKy7bzKkwDHvY/Q==
X-Received: by 2002:a62:a507:0:b029:30d:82e1:ce14 with SMTP id v7-20020a62a5070000b029030d82e1ce14mr41907975pfm.29.1626960669010;
        Thu, 22 Jul 2021 06:31:09 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id t6sm3079652pjo.4.2021.07.22.06.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:31:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <20210722112143.97944-1-raykar.ath@gmail.com>
Date:   Thu, 22 Jul 2021 19:01:03 +0530
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7C71B08-8C7C-4D30-88FF-58B3080A76EF@gmail.com>
References: <20210722112143.97944-1-raykar.ath@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-Jul-2021, at 16:51, Atharva Raykar <raykar.ath@gmail.com> wrote:
> [...]
> This patch depends on changes introduced in 83913dd5b6 (t7400: test =
failure to
> add submodule in tracked path, 2021-06-18), which belongs to the
> ar/submodule-add (2021-07-12) series[1].
>=20
> This changes in this patch are no different from the one in my first
> submodule-add conversion series[2] which has already got some reviews =
before.
>=20
> [1] =
https://lore.kernel.org/git/20210710074801.19917-1-raykar.ath@gmail.com/
> [2] =
https://lore.kernel.org/git/20210615145745.33382-4-raykar.ath@gmail.com/

A correction:

This patch depends on that same topic, but a different commit, which is
559e49fe5c (submodule: prefix die messages with 'fatal', 2021-07-08).=
