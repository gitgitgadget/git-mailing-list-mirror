Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4861C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiLTAJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLTAJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:09:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F810B26
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:09:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so14780301pje.5
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAfCz8cwT0hU37Yp2W1nXZ1UrE9GKBUhK46JCdCglXQ=;
        b=ZsHzt2s9hCXX09ws/7t9Rsd10r+EZzszp+Mr3Z75/pmmLEV9Qpu96mN7OS7pW7VVDG
         fljSOZNNjWITmh1ehn67gGVHZxqOgGaICJyNHJSQeFOWQs5TZm/YaexYyB/2+60Jj5Tl
         kMgCbx4bXjhneN8CmLdDmaO8wT4nIpYblJv0gJVh3MG6q6A9fgyhcCkhonNhspvQdWYM
         hXd3fHJReJ3PgxAuKjjSozQ6jGbrqLC3sf6JxcbD+QopJDhMulk4NxePFSwCnLMTwuRo
         NHHl94atX9WLvhHeLUGYj35l7cbCfJQQ/JePoFJC+c2XiMZ8ZC9TRocDU+6JVsm7+I0O
         gG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAfCz8cwT0hU37Yp2W1nXZ1UrE9GKBUhK46JCdCglXQ=;
        b=PRtYoe72UGqMOZE8hdhSWHVss0az9feBn7BPJ0wAEPD9mTVnB+gXdl+F+R5EeV4ncz
         s1bdiRdMIF9mA/z6ZGobUEM1jl3MOzTYCun/9xPrO+7PK6HTzalVjXAnqGOxn+41UjB2
         Hsfx/nKVRZ4ag8h+HFxkYCQT4UA8Qu/5xvFX2QOCk89N4t/U7xUQmO4TXgZ3KSWn6m4Z
         5QlwE8hlPzbwHCYBSMNlLES9nDsfbQK+sjD7LqfDawvT2tlQbabKYNyd92+HDr0aI1w2
         ob5wQzghsrE0KnqIVXY2PCWn37l8PSZ13if2wDsCd6y9WBlFuJT1l2peMXRp7NNy48DK
         8T9w==
X-Gm-Message-State: ANoB5pkhAIisOoR9E/U1uJHQPMrlrvAbhGbvI+UDyBgJE6oWX/u/h8YR
        cfQgtavYcbsWVuB9agle5+0=
X-Google-Smtp-Source: AA0mqf5jZmDo7fqCMiR8APqETMEFc3OQzHwJ2KoeTwsnj8aPvpDT5qgxpA46Cs4He/7KQ2Z5zbXASg==
X-Received: by 2002:a17:90a:e10d:b0:219:e38b:5079 with SMTP id c13-20020a17090ae10d00b00219e38b5079mr45631101pjz.38.1671494977416;
        Mon, 19 Dec 2022 16:09:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090a5a0f00b002192529a692sm10025669pjd.9.2022.12.19.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:09:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 2/6] t/lib-patch-mode.sh: fix ignored exit codes
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
Date:   Tue, 20 Dec 2022 09:09:36 +0900
In-Reply-To: <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Dec
 2022 11:19:25
        +0100")
Message-ID: <xmqq4jtr2awv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
> 2009-08-13) to use &&-chaining.
>
> This avoids losing both the exit code of a "git" and the "cat"
> processes.
>
> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
> discovered it while looking at leaks in related code.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/lib-patch-mode.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Looks quite sensible.

> diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
> index cfd76bf987b..89ca1f78055 100644
> --- a/t/lib-patch-mode.sh
> +++ b/t/lib-patch-mode.sh
> @@ -29,8 +29,12 @@ set_and_save_state () {
>  
>  # verify_state <path> <expected-worktree-content> <expected-index-content>
>  verify_state () {
> -	test "$(cat "$1")" = "$2" &&
> -	test "$(git show :"$1")" = "$3"
> +	echo "$2" >expect &&
> +	test_cmp expect "$1" &&
> +
> +	echo "$3" >expect &&
> +	git show :"$1" >actual &&
> +	test_cmp expect actual
>  }
>  
>  # verify_saved_state <path>
> @@ -46,5 +50,6 @@ save_head () {
>  }
>  
>  verify_saved_head () {
> -	test "$(cat _head)" = "$(git rev-parse HEAD)"
> +	git rev-parse HEAD >actual &&
> +	test_cmp _head actual
>  }
