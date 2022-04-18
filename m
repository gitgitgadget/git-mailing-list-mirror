Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5143C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiDRSAS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 Apr 2022 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiDRSAR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:00:17 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FD34665
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:57:36 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id q19so20188876pgm.6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6TKao+9e0tQ4UdhLogu1J04zgoqZ8x7Jvm3MMOVx7D0=;
        b=J9UC3nCmC+Qgnfc09rMEVldA70GTztdtg4fww1ask6HjyOWr3i3a7q2gwRXFbwFxZi
         6d9hVV2ohA+XMCwex2UkaSOjLueiMFZ7H8D8Zb4nnpgcV9V1+zBACEtpDK5CBF0UlTQk
         3KfuQg3ACBVcZQ0ArhA/DcYX88PsqJgFH0mJ2LEoLfXfICdtCc9Cq/ljTKNIDJZOIGqZ
         P8g2l21vK8RLtgDWcf4T3dXU2bpWs5W7C6pnWWlqMfh24D7FVFCwhTiFyW+BjtaiiptV
         M5fyvxidp6Xj/nOWsErdp5T/oOapR1U9P1QOy/32C70ozuMGPCzkhT/NWg5Tn5fYqgSb
         2O4Q==
X-Gm-Message-State: AOAM531oHbnujI/uhpK+QGEQ9/tq2nPpJacANoCJ2bmKn7wheZsRdnT8
        m4UDkN6MxUOhZ6c36thi8jwR0PuDh+Fwl4+Gi0wrVwIJYPw=
X-Google-Smtp-Source: ABdhPJyOvzPmIXyc1Jw0WhyDrJyqZqmOzUTHj7OQNcKYJar8h1xKjB/ufCkpGJHLI2XB7cLGS0TVJDPSRHaLuFZDe5s=
X-Received: by 2002:a05:6a00:23d2:b0:4fa:f262:719 with SMTP id
 g18-20020a056a0023d200b004faf2620719mr13649163pfc.4.1650304656016; Mon, 18
 Apr 2022 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <patch-v4-31.31-4fc67e668da-20220418T132809Z-avarab@gmail.com>
In-Reply-To: <patch-v4-31.31-4fc67e668da-20220418T132809Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Apr 2022 13:57:25 -0400
Message-ID: <CAPig+cQi1sRt_fMi13LtFvDL3J3ZcNaOzTugQaN-T41YAgw5Nw@mail.gmail.com>
Subject: Re: [PATCH v4 31/31] CI: make it easy to use ci/*.sh outside of CI
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 12:29 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In preceding commits the ci/.sh scripts have lost most of their
> CI-specific assumptions. Let's go even further and explicitly support
> running ci/lib.sh outside of CI.
>
> This was possible before by faking up enough CI-specific variables,
> but as shown in the new "help" output being added here using the
> ci/lib.sh to provide "CI-like" has now become trivial.
>
> The ci/print-test-failures.sh scripts can now be used outside of CI as
> well, the only GitHub CI-specific part is now guarded by a check that
> we'll pass if outside of GitHub CI.
>
> There's also a special-case here to not clobber $MAKEFLAGS in the
> environment if we're outside of CI, in case the user has e.g. "jN" or
> other flags to "make" that they'd prefer configured already.
>
> Using "ci/lib.sh" as a stand-alone script is much more useful if it
> doesn't hardcode NPROC=10, let's provide a poor shellscript
> replacement for the online_cpus() we have in thread-utils.c to cover
> the most common OS's. It was suggested to use "2>&1" to invoke
> "command -v", but per my reading of [2] and my own testing that
> doesn't seem to be needed. Perhaps it's only needed for "which(1)"?

Not redirecting stderr makes sense. I almost certainly accidentally
typed "type foo" reflexively even though I meant to type "command -v
foo", which explains why I thought redirecting stderr was needed. The
explanation above probably would have best been done simply as a reply
to the review thread rather than as part of the commit message, but
dropping it from the commit message is not worth a reroll.

> 1. https://lore.kernel.org/git/214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com/
> 2. https://pubs.opengroup.org/onlinepubs/009604499/utilities/command.html
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/ci/lib-online_cpus.sh b/ci/lib-online_cpus.sh
> @@ -0,0 +1,26 @@
> +# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
> +# that presents a chicken & egg problem. But if we move it to a
> +# stand-oline command...

Um, what's a "stand-oline"?
