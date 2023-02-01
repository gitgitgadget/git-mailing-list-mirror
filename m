Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD6C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBAQWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBAQWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 11:22:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C266EF3
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 08:22:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m2so52521635ejb.8
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=524l9gzFKteN1ih+ev09gIpwJVKoHJUySW+vcHV0ZIE=;
        b=NOZ/8iIonb/5oHy9DXXXQIk22nkiFkWuL193zgITswFl7Gj43gzAMvtm+PVk7Gj8XL
         Y4copaW8/HTUUQJQ/B0v5QerPC/pLmH56zk4ZXMMraqkushRrenAbUuzB6213hKA+DWi
         f+sj0QVzyIe99zP3I0voSUr0ycUsMy5m5MztRwjch0dEUHQXbUN0u87grvpAzV9DkRBM
         5oYy5BVlP0uanVwWQYTZoy9fAuyuALTGhKagvyaaXH0zvoWwDIM5PLvxLvX/W20ZSPe5
         uQX8/6lomrOhQsf4pxX3s8CEdTr/4BUN3dn+hCxZP2o/KI7AyBo1ZNtPQ/KVnALDjjCX
         ua5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=524l9gzFKteN1ih+ev09gIpwJVKoHJUySW+vcHV0ZIE=;
        b=hZCW1B9XdGlcnOQLWbFnwqqFNOxewD0DfqExTFSs5VORc+HNSfwOu4XNupC3pnXc+a
         QoxpSQy7WUzqgVty9c2PakBbWnXoHXJaWqdg4SB0BffnJz4Ttd4bljKpWDK0JA6C43SW
         3vYn00F4tMx4tWPbZxaTmTRYYiDKuJXAUNPwqC4+esPteanME55RBpjozcdDt7XRcYIG
         ZtFAEFeaxkBujarkZO+LiqZjxF2Il+awVkelJVN7hO9wxg1S9kDxK4vOKVbd9xOq92VP
         hxyDgvKh14M29IOoQ+9tPXtOUZY1MHh/TxOHGs4R2eqT5x6TjRbbj5n868Eth0FLJTG1
         mknw==
X-Gm-Message-State: AO0yUKU8GcBaEHN9h7YZIDiE+8/KSF0RAG6QDMhedj5Sq04YVfxvRS0E
        duvMjd89akaqyNibdy6U1g3nYlkN0AC8Tp0qRW68fKewjJs=
X-Google-Smtp-Source: AK7set+G6zbYbFjvhyS8umrnMLx/q7tTEL4QkUSsJzqSbWh7FUrbhIgW//jf5qixvXMrDOUNlRl/vNZIOiDnFp0KV7g=
X-Received: by 2002:a17:906:ecef:b0:884:3f4f:fa8 with SMTP id
 qt15-20020a170906ecef00b008843f4f0fa8mr786276ejb.29.1675268528961; Wed, 01
 Feb 2023 08:22:08 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
In-Reply-To: <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Wed, 1 Feb 2023 11:21:57 -0500
Message-ID: <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     demerphq <demerphq@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2023 at 11:09 AM demerphq <demerphq@gmail.com> wrote:
> FWIW that looks pretty weird to me, like the escapes in the charclass
> were interpolated before being fed to the regex engine. Are you sure
> you tested the right thing?

Quite sure. `git diff --word-diff` fails. This was just a smaller
example based on the linked C code.

Here's the output of `git diff --word-diff` (verbatim and dumped):

```
fatal=C2=AC=E2=80=A0: invalid regular expression: \|([^\\]*)\||([^][)(}{[
])+|[^[:space:]]|[=C2=BF-=CB=87][=C3=84-=C3=B8]+
00000000: 6661 7461 6cc2 a03a 2069 6e76 616c 6964  fatal..: invalid
00000010: 2072 6567 756c 6172 2065 7870 7265 7373   regular express
00000020: 696f 6e3a 205c 7c28 5b5e 5c5c 5d2a 295c  ion: \|([^\\]*)\
00000030: 7c7c 285b 5e5d 5b29 287d 7b5b 2009 5d29  ||([^][)(}{[ .])
00000040: 2b7c 5b5e 5b3a 7370 6163 653a 5d5d 7c5b  +|[^[:space:]]|[
00000050: c02d ff5d 5b80 2dbf 5d2b 0a              .-.][.-.]+.
```

--=20
D. Ben Knoble
