Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5895C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB388610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhIHEsO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 8 Sep 2021 00:48:14 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38653 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhIHEsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 00:48:13 -0400
Received: by mail-ed1-f48.google.com with SMTP id q3so1086701edt.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 21:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6UvNrcOFZonFOtoQK8dSAoE/u99eYBxhnwwXY9EIKw=;
        b=t96hHZDp6XATA1I2udrT11q2hsx/G25R2TOnAWfFoS6y6G5ALyQ5lEl9/NPVdj1cp9
         jPxuH2zBAQjU3bP43MP9H/Q/Gq9nsve/VNdCUw61PXJWiPl79p6rZQvU7JxkIzzyMdBa
         +XE7zBrcFrRtZq7yrApdFmna0TzWZeweeUQEr/Vg6HD1oTDlZ/1wVC1wZzy7yXuZKCgf
         KXcEpKPLgv1XiADRY54mL2YAB+2iNizWa7hMjlCn04Js7gDwMfGZcI5JkhH7oK+VIvdv
         lw+Su5zEJDKpm0lEicTx5+SciBl4OOn9OV9hMOSHWGb9CLYTPDbG0LmY8+w12G9UrrGI
         oLUw==
X-Gm-Message-State: AOAM530stfsbb0AaFDcCRt7ueOA6O/Jscd48p/3wOLLGqXfKpm4swuvu
        oExOWZhrmiMZ71HXCYhbqqVJJtZc6okL9DjHvk4=
X-Google-Smtp-Source: ABdhPJxJHqgxftN7aDhMS3UI+RYZUrL0lwIzpp6akz24GyKhB3rmeRI+Gkkrt/ceDUd0zMIzh8uD7qUAsMeE3gNZRKU=
X-Received: by 2002:a50:ed0b:: with SMTP id j11mr1848655eds.97.1631076424850;
 Tue, 07 Sep 2021 21:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
 <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com> <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
In-Reply-To: <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Sep 2021 00:46:54 -0400
Message-ID: <CAPig+cTHFpE-GZvCpwVAmkXkVybHsU=CB_UWrU7TwYcW3KLuaQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tests: add a test mode for SANITIZE=leak, run it
 in CI
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 5:30 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> [...]
> A test tests setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in
> turn make use of the "SANITIZE_LEAK" prerequisite, should they wish to
> selectively skip tests even under
> "GIT_TEST_PASSING_SANITIZE_LEAK=true". In a preceding commit we
> started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
> it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".

Is the wording "A test tests setting ... setting" intentional?
