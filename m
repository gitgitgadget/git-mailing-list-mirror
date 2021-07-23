Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A7C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C88960EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGWQWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhGWQV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF161C0613D3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:02:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k4-20020a17090a5144b02901731c776526so9779692pjm.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T18N6/z5uaZR7NF1NEYqeeTNmTtPi2i9UaImKo4n3Fw=;
        b=e1n/gjWaC+exJsdCl5dLsrAKQqsGvmrPrSR3I88mE1EN7Mac4AL2+9LYu4UBIg7Ko/
         y7CBOB/jWho+eEDNSTC3KbJ/i+QsZDFW/p/1jIBUYb/H7F34Qh8AWuJiBgkRGGGww221
         td6tB1IquyFAJZEO1PrbpChF6jVHTJ+3G/A2SaYRyfqqHrMk78szrXPEnd9Qjh+ICyzs
         YD7mKbflmHR1Xj/lPXdXwWnbanLCLfOIAYDa/JRDUAjFm8zmdDzhp6T3reIrLF7eni1N
         YVesW/vW0QVLoSp0+DiR+dsW9KDsM6HSPI7IwUpbk7Lj3+V3d5+QKvRvwjbyVlo3FOF8
         VJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T18N6/z5uaZR7NF1NEYqeeTNmTtPi2i9UaImKo4n3Fw=;
        b=cQks3SEN6SNIKGNHbp70nOFBCqbl1fGTZqV8IRCat/q+pcEXPS6jTll7p9+pHY+M+J
         toKqKnC/RkpYbfFtm3zcmz8ZLXX9lKb/0fBs+q8Ob/7avTYXsSjpvD0nW9Pz9qLjNBkZ
         y/vMi1RPNddVMofGijyg//G+lHY5LYOb0ti/T8h9K+IbWknVlFw+syZVwzzcYnndIn4l
         KjV9UPNtsvjkrK1H130pOOjNhWK/INOLuGifu4ck9Pacam3TLUxJnA6FSSK7Q2HZrnOW
         aqd2zg1QNjr2xuz/OgNajqbShk72h8pavGN9W12sz+qaz4U7Ja+MesOZNWVuK0aUoC9N
         +eKg==
X-Gm-Message-State: AOAM533EEe7oPzSe9vwJYRNKiKszPWSY8BlAw4zCjpdNKOZGlZWu4j6Q
        oo3VvxhpiHa+TXYf3zpMwr0=
X-Google-Smtp-Source: ABdhPJxrrzCmaSHEBSYyY1UhaUU73lZRzpfF73zLD6OrSgD4Re7XQ4DgsIs9S4huiiCLVrnYYZmxdg==
X-Received: by 2002:a63:fb08:: with SMTP id o8mr5732802pgh.72.1627059751331;
        Fri, 23 Jul 2021 10:02:31 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id m6sm2945581pgs.75.2021.07.23.10.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 10:02:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Bug: All git operations fail when .git contains a non-existent
 gitdir
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <87o8atrpz7.fsf@evledraar.gmail.com>
Date:   Fri, 23 Jul 2021 22:32:27 +0530
Cc:     Tom Cook <tom.k.cook@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11ECE7FC-F85E-4731-9EE8-4DAAC7A6A08A@gmail.com>
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
 <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
 <87o8atrpz7.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-Jul-2021, at 21:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> [...]
> The timing of this reply after [1] suggests that you may not have seen
> that patch that fixes this issue (sans Junio's outstanding comments on
> it).
>=20
> Perhaps your E-Mail client is forcing threading by subject only, not
> In-Reply-To chains?
>=20
> 1. =
https://lore.kernel.org/git/patch-1.1-fc26c46d39-20210722T140648Z-avarab@g=
mail.com/

Yes, that is exactly what happened, and I noticed your patch a few =
minutes=20
after I sent that message.=
