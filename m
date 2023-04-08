Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6944C77B61
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 05:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDHFBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 01:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDHFBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 01:01:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F3CC01
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 22:01:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so4995209wms.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 22:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680930087; x=1683522087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF72RZy6Lg3Abkq5r49TDt8ODdQqgH+JoDE9ap8+4F4=;
        b=RkDOIn1VvUUUJJTAd8XS+cL4rPVeUVl6zGK2hKOgtuZnqqV5QUJX5S5t+mNnBuMt8H
         Nnn8zTuPckM2vaCqMSs5H8PbF4nwSpe9xEaFNYkQXIVjVW6aZpPgzS0Xcp4XNMm9R5hE
         MMBXIMv0Q0XIXfibQQhUZL7zeKWgjB7JW/rY2D+uxAYfKbzTYENLOwCSBL8N6h9fnebv
         WVtAogGGlTp8QYIHQzY/BowSqZ/EC9I2JNScbKTviV2ph8DU7Bxbd745pJltWYv9+Z+L
         E4LmisqGfK/SNiaTHn//+aks0Oig10/Y8FRKOdObAIMDEfCZY1/6cRnhoQge/nm1Z5IB
         zzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680930087; x=1683522087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF72RZy6Lg3Abkq5r49TDt8ODdQqgH+JoDE9ap8+4F4=;
        b=YvmX7XKI7xzUwu9snWsR9gUxd7Z/1Zt0jmGkgGCoi6jICfaVBS+KuD+hXjRDcm5taf
         xZYMPY2dO/TYk/V5dhShaZNSc1a/9Pzs9DyZzIAdxUmFk1iTDkJcUetQIERM3LL1J06G
         OOcM5GGJFfM0SyYpR7Tcdeejrro0H/CEnaH0hf6ZJs+gl1f/f4CmK80FHOKubnOdJ39f
         j8sSnufzpnMno/dJQKTzeNCS4puTm2MHZoBzoaqIo2KTatBbVrPng/ZcuhkkHtvK5vRo
         4+9DJg/VJdw+/sHL4BfC5wwe9c6BdrrCI1JSFYmm2mDvqwDYH8nI3EwEPH5v550qTRBQ
         l6wQ==
X-Gm-Message-State: AAQBX9fo6cRddh6fxgksNrzrD6aqPMAXngZNRBz1e6/zK7sxHWzg7dDK
        Qzo+Bdfh8SP+jHqjTx8qQJ6l6DhL8KnPjWlqj0c=
X-Google-Smtp-Source: AKy350bH7nP8YmEVysXIlQlls42DSYQTM4X3Sfk0P0GokhzgQMdR1aXzdqLAIRuksRug0GVyeuyA1sO3LinceVZDyBY=
X-Received: by 2002:a05:600c:3786:b0:3ee:143f:786d with SMTP id
 o6-20020a05600c378600b003ee143f786dmr158379wmr.4.1680930086816; Fri, 07 Apr
 2023 22:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> <xmqqttxvzbo8.fsf@gitster.g>
 <CANgJU+U+xXsh9psd0z5Xjr+Se5QgdKkjQ7LUQ-PdUULSN3n4+g@mail.gmail.com> <065bcdcb-5770-5384-5afe-4a4d29272274@cs.ucla.edu>
In-Reply-To: <065bcdcb-5770-5384-5afe-4a4d29272274@cs.ucla.edu>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 7 Apr 2023 22:01:14 -0700
Message-ID: <CAPUEspjtN-cwm=Nn=hMCcbOcOgPaVHsBfLW9TXn1HZrxtRR3BQ@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     demerphq <demerphq@gmail.com>, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org, pcre2-dev@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2023 at 12:00=E2=80=AFPM Paul Eggert <eggert@cs.ucla.edu> wr=
ote:
>
> On 2023-04-06 06:39, demerphq wrote:
>
> > Unicode specifies that \d match any digit
> > in any script that it supports.
>
> "Specifies" is too strong. The Unicode Regular Expressions technical
> standard (UTS#18) mentions \d only in Annex C[1], next to the word
> "digit" in a column labeled "Property" (even though \d is really syntax
> not a property). This is at best an informal recommendation, not a
> requirement, as UTS#18 0.2[2] says that UTS#18's syntax is only for
> illustration and that although it's similar to Perl's, the two syntax
> forms may not be exactly the same. So we can't look to UTS#18 for a
> definitive way out of the \d mess, as the Unicode folks specifically
> delegated matters to us.
>
> Even ignoring the \d issue the digit situation is messy. UTS#18 Annex C
> says "\p{gc=3DDecimal_Number}" is the standard recommended syntax
> assignment for digits. However, PCRE2 does not support this syntax; it
> supports another variant \p{Nd} that UTS#18 also recommends. So it
> appears that PCRE2 already does not implement every recommended aspect
> of UTS#18 syntax. PCRE2 also doesn't match Perl, which does support
> "\p{gc=3DDecimal_Number}".

Not sure I follow the whole logic here, but PCRE2[3] (search for
"general category" which is what the "gc" above stands for) only
supports the abbreviated form of the unicode classes and `Nd` is
indeed the one that corresponds to `Decimal_Number`.

Carlo

[1]: https://unicode.org/reports/tr18/#Compatibility_Properties
[2]: https://unicode.org/reports/tr18/#Conformance
[3]: https://pcre2project.github.io/pcre2/doc/html/pcre2pattern.html
