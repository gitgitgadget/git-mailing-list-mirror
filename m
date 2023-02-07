Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE7C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 03:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGDkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 22:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGDkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 22:40:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4015723866
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 19:40:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h24so20612298lfv.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 19:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc44nuWum48ol3R4ZIjHTKqaMNZlpg5IJAATZjCteIw=;
        b=DLALGYmq7l/RCUpWnVdwOIrlPvAeryiF6yKOyI1NlQnRNPJZT7OjoXoEieu729NvD/
         1d4gv9UZCS16vJfHF9c1SoeDWxdGN8c0ZEa/KFmbqamXWLBIzNGI8/5ARTV4JroR/Kcn
         YMzNFA7rviIHnHkC078APxRJ/8E3CN6guaGVDM+eBxXoOnMk8+954q7kOP38CzB2kIl/
         sLcbF9I0NfYePZVNFy25R2EW8E7XhEa3SGxJysQ23ym/aHsrZBHiA/phhrmIHbt8Sk83
         7DcgX3gJhhThXT4QBv3oEcG7tlAaQ8vpaVsEkZfKyb+7LxuuabjuEyVYDUl5o206BVR2
         Ca3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc44nuWum48ol3R4ZIjHTKqaMNZlpg5IJAATZjCteIw=;
        b=foERGZVjRHIcXMH+uAoYNOgiDot7NONKbCy24U28NER8SeovBGXVANHeAWEY0xjFrK
         YhYISMGTC5epjVz/OHTyT2ckemW1rDDbWYZulLFwGaf4tqIqfXmY+Lw3oxBvTAUzFBAu
         j4rK6DPZOC/hfr0WBKqpSSLb0urC5dKrwgE+GsGKZIZVVw5gd1kuZQkQV2TAk951Ab/+
         xCQo7pJnMvdIJ448Q0HU78Lj7D0fjLZ0FsScsnyObsyhWxh7jVMMHtHdXS/fZ8AqwzMU
         Zjrn9IHrmJ3hx4KzYCwkXq8BS4PfDOsAl9GqG4inB9UsHy+j3FdW7xMA7e/yQzGxcJKg
         Tr6Q==
X-Gm-Message-State: AO0yUKVEJi3AGgsEJioSTzkw0EWtZcdQteAhc/pdcWgsxEfFDd3se9wT
        KLBWsLWrh43ZodRNLt2vwVUmLFQO2F9MdkrpE34=
X-Google-Smtp-Source: AK7set/fScSPzM/7vRiPFJVyyghqkBKLTxOawTxty2YkT290GbH4VHUsuS8hlOcPNlNY2pyMrnPrSY48mLSb0X9G2ho=
X-Received: by 2002:a19:700c:0:b0:4d5:82d8:c13a with SMTP id
 h12-20020a19700c000000b004d582d8c13amr253649lfc.62.1675741220476; Mon, 06 Feb
 2023 19:40:20 -0800 (PST)
MIME-Version: 1.0
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Feb 2023 19:40:00 -0800
Message-ID: <CABPp-BE4o-8A4B4dV0bWo+7J5S_0s8UgZA4LRN=nyupKzqbXRQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] leak fixes: various simple leak fixes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2023 at 3:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> See
> https://lore.kernel.org/git/cover-v6-00.19-00000000000-20230202T094704Z-a=
varab@gmail.com/#t
> for the v6. Changes since then:
>
> * Corrected the 17/19 commit message to note that it free()'s an
>   entire allocated struct, not just its "flex" member.
>
> * Per my replies on 18/19 and 19/19 in v6 I think those commit
>   messages are correct as-is, so sending this in in case Junio's OK
>   with picking up this version.

This version corrects the issues I noted in v5 (actually v6 did too, I
just didn't get around to reviewing soon enough).  Thanks for working
on this, =C3=86var!

Reviewed-by: Elijah Newren <newren@gmail.com>
