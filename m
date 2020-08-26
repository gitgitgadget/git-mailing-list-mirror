Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33655C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D1620737
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHZBYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:24:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46481 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgHZBYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:24:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id k25so256898edj.13
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 18:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StjS9ZkvEXi6LATK4nD2Hi8dGG/9M8sPJ0ewjwv4szM=;
        b=r1G+ShdZOEAyqEivR1lbIDA+gNqttSO1+g8jj92/2MoxcUo7+guCic30yqVvwzFggT
         Y1+3kmQFhkMI8O0woK9Jk5wHvN9X7U44l5SmX4ZGTUVPncdvZgkjZjHIDO0Cs3wfRUYD
         fHaxl09QTU0CbpRvggz37DQCrBduXK9NZgCB49SqSnhiuMV0bqv4ffX6ee4ftbUB/4r0
         +3CqEprb+GlFdoq4j9iV9PGItCUU8bedJ67aUM1cZdIo641qSsHw8zFnGeerMpP8c/ft
         zj7dxHK60uaRkwqf/NWjpqCnMm074SUUpdL4UXwVdpbWe3FHFzuaeOynsjhoGOeDLLv6
         hYfA==
X-Gm-Message-State: AOAM531r4WWky+8oply4RHKSt+0FmpdMg1gJVe5uAezL7MHdsEJJUhcy
        f1VLQ1FHXZwXSm7I3rjtCPb5qu5Pupwq0rAp6t0=
X-Google-Smtp-Source: ABdhPJyFkkjBP25GZmJ0U7IN7WONqO/xzN83KLu3y7NecwdGFxICPjrT8WxYtaOcPaLhBklI28pnlrGm8jln6ulQXK0=
X-Received: by 2002:a50:b081:: with SMTP id j1mr12503883edd.291.1598405062112;
 Tue, 25 Aug 2020 18:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com>
 <20200826011718.3186597-2-gitster@pobox.com>
In-Reply-To: <20200826011718.3186597-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Aug 2020 21:24:11 -0400
Message-ID: <CAPig+cTvLaOD1idfB2M0-QSfXXKBe5-FnWSU9E0PaUMHAoGj1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] transport-helper: do not run git-remote-ext etc.
 in dashed form
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Runing them as "git remote-ext" and letting "git" dispatch to

s/Runing/Running/
s/them/it/

> "remote-ext" would just be fine and is more idiomatic.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/transport-helper.c b/transport-helper.c
> @@ -128,7 +128,8 @@ static struct child_process *get_helper(struct transport *transport)
> -       strvec_pushf(&helper->args, "git-remote-%s", data->name);
> +       strvec_push(&helper->args, "git");
> +       strvec_pushf(&helper->args, "remote-%s", data->name);

Rather than pushing "git" as the first argument, would it instead be
more idiomatic to set `helper->git_cmd = 1` (or would that not work
correctly for some reason)?
