Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12309C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 11:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJKLIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKLIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 07:08:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B428BB89
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 04:08:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l22so19577279edj.5
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EbHNabV4A19H2cZ6wjF6vXOgfTLP/hGiqZLn1xaZHP0=;
        b=fWbUVtji9t+ZfJg5OJxY04t++rdcWYr1e/0SbKWANzU1/aba/K4yp1sCQbhW7pl3Fk
         dp3fsekJj633f8m2Sm0AZoOVAzxL4Bx4y6Un+Ijk7XGaFxYS8+nKs4ki9ECnxeTUCR11
         DLoghnfrOlzAfWFP7uGWu2uhNrLm8HjKSxfDbtC0E+wZE9WWpHF8TZc4zozZtcxkTmMC
         wml8d69VHOt/GCXC8LDJvEnSIMG9Tqk1usgSNFf67SHHG33LiiMJ+bEdV68WTxwTt8qR
         mzw3Cg034ZcVAJ2ZD7Awq8RCnJVrjy59DMDDYfGHNM8ON+qqFjgpYqi9p/zyXFhYtOSG
         AVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbHNabV4A19H2cZ6wjF6vXOgfTLP/hGiqZLn1xaZHP0=;
        b=ACcMP5xAvcS7Ho9su5N+dYFaNdnU/LH8tlPETHIwTeoS3tK6EORAZE4HcFPeGyUMQr
         AMgUAM2q/QQl+u3foUgkSjHSVERyQH9+pUkWla1rzV0GnSRzBne66SYVG2ugu8uVwPDu
         xj7lUq9bbCiJE2IYVQeq8r5yYgBV4yF/iPAgKs8HEPFnf3VJOuy8FTZ1NlXar0rQ/IZf
         Xy3TgCvA9N8i4JetcwOQU6vc6n4jM/yqYs08b1L4DUQV0nY4sOiOLxVEsRFaMqXG8QOD
         +HbiRrdM89bYL8NavyT8WPGeiVNqSyuYHioNBQyyt6bxKhl0+VIRxrTeRwzIeyqWYK+4
         7lig==
X-Gm-Message-State: ACrzQf2EzkEEjqVmdDc7tNXbWEvNT5cCDlFzeWtwewo/zprp6WQ02cLF
        BLeLBTied9fMLXNKaSJxzYw=
X-Google-Smtp-Source: AMsMyM6TeiqEEC+9/bx5kwz7+pIi0KmOW2rk626B171U3k7slc4XKbWpTy4i0PXsWJkdobPedSEj7w==
X-Received: by 2002:a05:6402:550e:b0:456:f79f:2bed with SMTP id fi14-20020a056402550e00b00456f79f2bedmr22585271edb.106.1665486485681;
        Tue, 11 Oct 2022 04:08:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p26-20020a05640210da00b004587c2b5048sm6642874edu.52.2022.10.11.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:08:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiD7E-003pdB-1F;
        Tue, 11 Oct 2022 13:08:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Date:   Tue, 11 Oct 2022 13:07:37 +0200
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <221011.8635bupqx1.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <221011.8635bupqx1.gmgdl@evledraar.gmail.com>
Message-ID: <221011.86y1tmobxn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Oct 10 2022, Taylor Blau wrote:

>> +void shortlog_init_group(struct shortlog *log)
>> +{
>> +	if (!log->groups)
>> +		log->groups =3D SHORTLOG_GROUP_AUTHOR;
>> +
>> +	if (log->groups & SHORTLOG_GROUP_AUTHOR)
>
> Nit (easier reading):
>
> 	if (!x)
> 	...
> 	else if (x & FLAG)
> 	...

Urgh, sorry about the noise. That's an obvious logic error, I don't know
what I was thinking...
