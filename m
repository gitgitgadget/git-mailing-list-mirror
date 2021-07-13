Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85866C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D336135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhGMXJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhGMXJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:09:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAEC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:06:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l1so417415edr.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5qEw27dStp6Zii7KRV+huBDN32KhB2CV/M9pXi/4P4w=;
        b=dVtMptW6u1PJKaaU3q+kWR09il+qCgpEYhUmBvzlQfl62tTbXhHUmBDA9HnRg3XfB4
         O7OFKx3OSAzveKUt4lxfjIrIn2ZSvRXhOeQR+BuzCDclNVTQK4/3p7C7WTtH0TTg7GQY
         fQEa7WuC+7YLcMD34PqZE9iHXCHTg8u6Ko/mulmXukL+v95UJ391GRnUdxIWFniOdhse
         HAIfcI8oh23Otsv/L1+N18/Vs6+ugXJ9B18w0Q2P6q+p+DSqpFJRizRs1JmPWHzvRWqw
         Z0O+HsXYTsW6G6mZZdqPMftDwMrQgp6X76v4ffO7ovRrfXRCgMh8qmhlNbFVY0AaKbWp
         JVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5qEw27dStp6Zii7KRV+huBDN32KhB2CV/M9pXi/4P4w=;
        b=Z4wlagEZtQKR1URa1CeBy8np19aLEFuwoO4kZyCdZnG8AjXHMhqSRxVylNF1Y+cWdZ
         ghPiodlNd8n87/EeQqB5rnZtplQ3FuIwWSl6k3rr1uEYKxmQ9h6iCTu5k2iHn9rs7gNQ
         sBuabcjUR/mNF2gIbPoSmLEO3Cr7HyoCkglf5ugzz9gbiOcFWhR0woMIF09MvH7EFGm/
         DLB5iyfqDs+eQ8SVw1V4MNhtjw0H60vb1KKL1tDZW+FXBU+U/J+jYFaYV8udIG5BBceV
         dgQz6mMRUf54OjKTZEGJBVztb0U7czcUmwraVIaA82W/9qwP3Nj7kc+ZcQX7hc+Nw5oZ
         W4EQ==
X-Gm-Message-State: AOAM531/GdR8NeojHcKaOlTTlF5lj7cXY7ReFBzSBJRKhPHAXX4DIDxS
        bRDCAHqBlRar3Wl2YujZaOk=
X-Google-Smtp-Source: ABdhPJyb87LE3kVVomntvtxJyQ8AXzfkiuV/mzydruF8oxB0zBNgDq5m/zNGAilfLFAw/jmquUmiQw==
X-Received: by 2002:a05:6402:22bb:: with SMTP id cx27mr8850352edb.96.1626217588333;
        Tue, 13 Jul 2021 16:06:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i14sm80609eja.91.2021.07.13.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:06:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] add missing __attribute__((format))
Date:   Wed, 14 Jul 2021 01:05:47 +0200
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
 <xmqqfswh26gs.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfswh26gs.fsf@gitster.g>
Message-ID: <87eec13jbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> [...]
>>     - ## advice.h ##
>>     -@@ advice.h: int advice_enabled(enum advice_type type);
>>     - /**
>>     -  * Checks the visibility of the advice before printing.
>>     -  */
>>     -+__attribute__((format (printf, 2, 3)))
>>     - void advise_if_enabled(enum advice_type type, const char *advice, =
...);
>
> This has become a separate one, because...?
>
> OK, the addition to advise_if_enabled() reveals an existing iffy
> caller, so you chose to fix it and to annotate the function at the
> same time in a single commit at step [5/6].  Makes sense.

Right, it's the only case that revealed an in-codebase warning, so I
thought it made sense to split that up from the mechanical addition of
__attribute__ elsewhere.
