Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BAC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 07:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9195C611C1
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 07:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUHM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 03:12:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0ABC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 00:10:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l1so27060650ejb.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 00:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NbckseHT9OVCFAMGE0WhyPwdGADdu+8WTs7q07m5FxY=;
        b=HJfRJDoJ8jMbtGVFbVRNx8czBq+Pdph3ND2CTZaW3WUL5LwPgSFIH4seQcPLQmTq/4
         1VmnSxJtflo0AmUEN0QybHkQFxsE/2aiT4paxtj+a18hIB5xua/vQc/HgG3iP+T9tiwI
         8GX8MMsplDR60PjJoqXW62/5g/KnwaSDdTMR+tGhiVsHtDGhzWURkEYQkHfFGWcxN0vr
         OoE/HK3yIQ0lNqZeAlI3+XrJVG9ZGbzao1c5efTde/agapLyqUTfv2yn3/zTutNx5Ouo
         pGTQtoAG6XSQvhWeGi4Iq//HdJ5iubGHU7nvxjd7vtlR6y2/HMPV7rW+3WVqVscxTS8k
         zrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NbckseHT9OVCFAMGE0WhyPwdGADdu+8WTs7q07m5FxY=;
        b=q7DtLTkmjRI+MqEdoKDw6Jafcn/Wtv06Ik8M5Moh09TWgVUt0s39D6ZFCZRlAQSN93
         pdziMHGV6DM7nG8fioHjmCrg3qJVz/ToaSqvjLJm/CJWOTjEplK0dvaL14NH4YUvsUIW
         G2UwkxKKWH6M77Fv8+YUYvvShbV/OcNm7/sZpBaBGQwH9pVvT1cuJwHTi36h2eBtwX62
         KDiyLX8R57Ton54Q0O9Xol7qZ/kJ3Fyj6cD4uqcAbjVhF3D6IZd7VTpMVsPn4h+M2Hss
         D+9e0oZoMYL8OnYrghfl49fEfjAWxR8NhJlJ4O9B5Cg0zAtQnKq+qxS62q8P03Z2pJ7P
         D53A==
X-Gm-Message-State: AOAM532PFaKt2jAGWPX190BDHD++U3k45VOM+KAf4q2KczmdOAJ3Txuy
        Ghsk8poEA+pYJR0xjW6q4W4=
X-Google-Smtp-Source: ABdhPJySOishTGuagIu2EX9GTPTjbeK6tSnCttZXbAAsYYinkVJmU8JFPi+k4kgIH8xEr5Ydjg5W4A==
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr9217544ejd.321.1624259410935;
        Mon, 21 Jun 2021 00:10:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n15sm10148089eds.28.2021.06.21.00.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:10:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/7] progress: introduce GIT_TEST_CHECK_PROGRESS to
 verify progress counters
Date:   Mon, 21 Jun 2021 09:09:39 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-2-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210620200303.2328957-2-szeder.dev@gmail.com>
Message-ID: <87y2b33d7y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:

> @@ -252,7 +255,11 @@ void display_progress(struct progress *progress, uin=
t64_t n)
>  static struct progress *start_progress_delay(const char *title, uint64_t=
 total,
>  					     unsigned delay, unsigned sparse)
>  {
> -	struct progress *progress =3D xmalloc(sizeof(*progress));
> +	struct progress *progress;
> +
> +	test_check_progress =3D git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
> +
> +	progress =3D xmalloc(sizeof(*progress));

Is this simply an unrelated cleanup/refactoring? I don't see how this
re-arrangement is needed for adding the git_env_bool() call.
