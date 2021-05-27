Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A1C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE16A6109F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhE0Mxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhE0Mxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 08:53:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6530C06138B
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:52:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so670531edt.13
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KpSerkcgT6l7hmTXsvlXlg6iNS1OpsA78dlRu7yKTWw=;
        b=gM2j5WeOzJJK4HvoPhwGPqdJpo780jyY0HbblbtcsOSMiDcyF1nitKUAOmKUoXF+Pz
         F4CjNTk/+Qn2zNgZC0eV47U0ZL1uYcGAbQWoER4aM+RSJ74St80u/hctK9O54O6k8TmJ
         WAF0mqxr9+SMCS8afFO4ikSZdgNOG4GYWlR+DNQcb6FkzZR47xvimL2W2EaRXllfT5Bp
         ca95q6CkukkPZpGtdRI6n2RICgM/PjOGDL5AzMFqUSUTfOYpod/x+vhxYfO1doSoLRgK
         yMVUyjEo7c74YcBzdw1KRAht9VJcK0/Jt7QNiBgCCFZZvv7rLq4TYY0IiHPIySCtopLt
         u++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KpSerkcgT6l7hmTXsvlXlg6iNS1OpsA78dlRu7yKTWw=;
        b=S7TrgNF1Xi0j5g7PQbd1MjZppQVPLV5u/XwvKJnJmWOMVIOAW7AqSMiiSFBqk7YfZC
         0DYo9tdxib41Ru8J6qPn3CaIWtqgCXR+ZuQu8vDw3QtWi4yccR3TR4yoArLS71pjmed1
         3/C0aX25mJ7LxLgikSS+/YnXUCxnvySjwCA5IEgNdHUY1mWD0xp2EwQ0scX84cR49Nkg
         n/5dxEtqYn2YjDFk27YcZO4UkbBWM7bIGeE6Z1juxWYVRZC4yGX5qbgqDRHDYVghzAKs
         ZDjpu0DL+QJz05xxlo/5rTz7crvl57e+GrlaDyM48ujbgS3KTFPQYeTnTb4QgS0teHIp
         otAg==
X-Gm-Message-State: AOAM533qtge+ZtVrsr3Y/W2u5q7BCwmFDkBIA0oF53NptzrXW1ATm2o4
        Rn7XVJlNIAaTIpUPVm0fNiQ=
X-Google-Smtp-Source: ABdhPJyJV6inT0OnNUFh4lZJPBwwxCrMhT9qkYYOZRUdT302YLIwpzWQdhDra15IFXNGfbglImTi0w==
X-Received: by 2002:aa7:ce91:: with SMTP id y17mr3912883edv.83.1622119929127;
        Thu, 27 May 2021 05:52:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id yr15sm965165ejb.16.2021.05.27.05.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:52:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: move builtin-only code to its own header
Date:   Thu, 27 May 2021 14:51:39 +0200
References: <878s41m5nc.fsf@evledraar.gmail.com>
 <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
 <xmqqa6ogamwb.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqa6ogamwb.fsf@gitster.g>
Message-ID: <87o8cwl4p4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Move the code that's only used in builtin/pack-objects.c to a new
>> builtin/pack-objects.h header and out of pack-objects.h.
>
> I've amended the early part of the proposed log message in
> preparation for merging it to 'next' and then later down to
> 'master'.
>
> Here is what the result looks like.
>
> Thanks.
>
>
> Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Date:   Thu May 27 02:52:51 2021 +0200
>
>     pack-objects: move static inline from a header to its sole consumer
>=20=20=20=20=20
>     Move the code that is only used in builtin/pack-objects.c out of
>     pack-objects.h.
>=20=20=20=20=20
>     This fixes an issue where Solaris's SunCC hasn't been able to compile
>     git since 483fa7f42d9 (t/helper/test-bitmap.c: initial commit,
>     2021-03-31).
>=20=20=20=20=20
>     The real origin of that issue is that in 898eba5e630 (pack-objects:
>     refer to delta objects by index instead of pointer, 2018-04-14)
>     utility functions only needed by builtin/pack-objects.c were added to
>     pack-objects.h. Since then the header has been used in a few other
>     places, but 483fa7f42d9 was the first time it was used by test helper.
>=20=20=20=20=20
>     Since Solaris is stricter about linking and the oe_get_size_slow()
>     function lives in builtin/pack-objects.c the build started failing
>     with:
>=20=20=20=20=20
>         Undefined                       first referenced
>          symbol                             in file
>         oe_get_size_slow                    t/helper/test-bitmap.o
>         ld: fatal: symbol referencing errors. No output written to t/help=
er/test-tool
>=20=20=20=20=20
>     On other platforms this is presumably OK because the compiler and/or
>     linker detects that the "static inline" functions that reference
>     oe_get_size_slow() aren't used.
>=20=20=20=20=20
>     Let's solve this by moving the relevant code from pack-objects.h to
>     builtin/pack-objects.c. This is almost entirely a code-only move, but
>     because of the early macro definitions in that file referencing some
>     of these inline functions we need to move the definition of "static
>     struct packing_data to_pack" earlier, and declare these inline
>     functions above the macros.
>=20=20=20=20=20
>     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good to me for what it's worth, and I see you merged this down
already, thanks! Git builds again on the Solaris boxes now.
