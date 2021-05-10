Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B8C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717E16161C
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhEJTbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhEJTbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 15:31:03 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39ECC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:29:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so11469259oto.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hjA+7lJHusaL1K34q+KTCuNWymp0IGhBxJFuiFAefs=;
        b=u2kuAU8iAVH+atJ1awe1LOwCPAtrC5QfeQVIZOKHj7M/P4PtbpgZgBIuLQnz0HelNK
         0osE7+UxBqxp5RuYb1bembcTpLaH2GLtRIp4BbywmRWNyFCH1vCGqmHajY1s2UueB9M8
         bWUDyD4JXWjkSgSe3Bygy6sNVaZAjbSFDOSwZLdH6rnTKYHIhrFBnlfXUocFmjIFsYCe
         Htapq3GCI7tqoadcpfhZhhoxqbCkUrwrnxJT/mOjFrwvCTWy9XB2xNO+CIb10vj6AMfu
         fL5lbmwAXo7cwdyPcvaziyk8VAuxu15XWpuW/jUOUbo+sfP61mNwNn7pv6AfhfmlAWUs
         WQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hjA+7lJHusaL1K34q+KTCuNWymp0IGhBxJFuiFAefs=;
        b=b/P4RaMRn6GOdl6E0NW7VWdlDp+PSN/8viOdiwxl4h0uGxocD2xF1wPTwvzEBf4JuN
         Zja4cIDTgix1nFUs+InMjXIgYiEiyq1L1nGCOyPPZ6mFT0UJhHN6gEiP7dyXSHnR7MVa
         jFyeH/9T4gyZi9PfdLP6wdV19YAkq90WouYaJ9ZTh4iY4nYiTdtw9HC6xL1ywx7UwkSi
         qH08JUt2stW3kMVL66Yhoh/nl1k6TzPVseq9cAFiIqbvL6yv3xNfzQNNCpE6KRHpO/4J
         6tgDSiiUquSvLryJmNMUbw0OifT6sY9x8s6nyLwR6pSTVcWLwO1Yl5BKqqM0PJCkePYO
         iMKg==
X-Gm-Message-State: AOAM532UQBz6UdCLOCarCjSzExxN+45wp7Wi3ElGImR53rtxV1D4+HWP
        tfZiCH36zgj3+6vYUJM0XXn16iyg63f6e0Jv+vU=
X-Google-Smtp-Source: ABdhPJy7PCPjLYFbVnJC/MuLP61JabxGUeg9IxnnVjlRUvaJSSQSsYIzK6UCo6Q+AuL/9ExU3jUTwEnYEW40xQw8giw=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr131421otq.316.1620674997229;
 Mon, 10 May 2021 12:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210509215250.33215-1-alexhenrie24@gmail.com>
In-Reply-To: <20210509215250.33215-1-alexhenrie24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 May 2021 12:29:45 -0700
Message-ID: <CABPp-BFa484zCeXpzZ36ev2pBfDCH=Kp4wWWF_hZSQvgrf3LYA@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: split "distinct types" message into two
 translatable messages
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 2:53 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> The word "renamed" has two possible translations in many European
> languages depending on whether one thing was renamed or two things were
> renamed. Give translators freedom to alter any part of the message to
> make it sound right in their language.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  merge-ort.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 6c2792b10e..745a844b18 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3050,12 +3050,21 @@ static void process_entry(struct merge_options *opt,
>                                 rename_b = 1;
>                         }
>
> -                       path_msg(opt, path, 0,
> -                                _("CONFLICT (distinct types): %s had different "
> -                                  "types on each side; renamed %s of them so "
> -                                  "each can be recorded somewhere."),
> -                                path,
> -                                (rename_a && rename_b) ? _("both") : _("one"));
> +                       if (rename_a && rename_b) {
> +                               path_msg(opt, path, 0,
> +                                        _("CONFLICT (distinct types): %s had "
> +                                          "different types on each side; "
> +                                          "renamed both of them so each can "
> +                                          "be recorded somewhere."),
> +                                        path);
> +                       } else {
> +                               path_msg(opt, path, 0,
> +                                        _("CONFLICT (distinct types): %s had "
> +                                          "different types on each side; "
> +                                          "renamed one of them so each can be "
> +                                          "recorded somewhere."),
> +                                        path);
> +                       }
>
>                         ci->merged.clean = 0;
>                         memcpy(new_ci, ci, sizeof(*new_ci));
> --
> 2.31.1

I don't know much on the translation side (thanks for fixing it up for
me), but looks innocuous and correct from the code side:

Acked-by: Elijah Newren <newren@gmail.com>
