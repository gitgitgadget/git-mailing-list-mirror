Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB0BC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459D060E0C
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFITpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:45:16 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35706 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:45:16 -0400
Received: by mail-ed1-f41.google.com with SMTP id ba2so28143149edb.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySn53IDzTnwy4+0kv+PZfXaJZACoVqlsjneVJK7PFF4=;
        b=kMYVq7KY/RL+/wfAtwRO9bg31stbzQ/LdopN3DENcpdoIo3NmM5gNJCPbiUfddLe5R
         4by0dgbdvdG+txfGbNdAps4XTtW+y6G8Qnqjo3tVdWXRjR/bNte+LvPFAIyAk9tMA16Y
         iwETjnEp32Y2C62NkZK+g370Fff/HgYyFb58HAc5xfN9WDKH+XenrR5L0Mygb6+ptubZ
         wmRDjlQeI6Hv6IMLivkdk5JbrCBhW4A1GZl0n1i/5AhxmaqOPpsmA/vgCw/mm21hENdo
         0mBqYOHyKj7/lfUCVZ0FMS/N/MpqabI5Q2Gf0aqowY0ED+Iuw5yWf1q0spBVMblX108d
         6pIA==
X-Gm-Message-State: AOAM532qDGc1eQ0U0ke0vAdPDeGVWUVmk/Fy6ZxwLiAo5jctnH4nYpYy
        3GPbFvDSJL+zuepSFkosXMO4UR2JzzaE7U9Tg7c=
X-Google-Smtp-Source: ABdhPJwB/vgas8g0+gWJsWqGZXjsWkRkbpzIXO94ybYlWaaIeo0GfWJVcGSijEqno2GcS03fpizFpRZfATLSVEOuBIo=
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr983775edb.181.1623267784993;
 Wed, 09 Jun 2021 12:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210609192842.696646-1-felipe.contreras@gmail.com> <20210609192842.696646-2-felipe.contreras@gmail.com>
In-Reply-To: <20210609192842.696646-2-felipe.contreras@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Jun 2021 15:42:54 -0400
Message-ID: <CAPig+cSK1YkFwQASuV1n4fr5Ko8tH8QGxvVgQ=Vd0MeY9BSrzw@mail.gmail.com>
Subject: Re: [PATCH 1/7] test: add merge style config test
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 9, 2021 at 3:29 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> We want to test different combinations of merge.conflictstyle, and a new
> file is the best place to do that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> @@ -0,0 +1,44 @@
> +fill () {
> +       for i
> +       do
> +               echo "$i"
> +       done
> +}

This seems to duplicate the behavior of test_write_lines()...

> +test_expect_success 'merge' '
> +       test_create_repo merge &&
> +       (
> +               cd merge &&
> +               fill 1 2 3 >content &&

... which could be used here instead:

    test_write_lines 1 2 3 >content &&
