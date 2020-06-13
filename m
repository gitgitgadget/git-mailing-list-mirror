Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35945C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B820789
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrVVwMoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFMTl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMTlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 15:41:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD3C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 12:41:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so13371882eja.7
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6OB8aseJOxwXkbgJPnGNqNw8N1IAHjzJp88D/UWNJg=;
        b=CrVVwMoT6RMDMmMvYjfSDv1MPUvd+fRlldloFk7b9HU3Rf5DzbYt9gfxMZgVwtDcRM
         dw7/nEkYExFE5iIoAJq+DtNbRCad+VcZksF1fRa+RjHlqOyVtMLGZf//MOETJO/6CYyu
         MX6Gt9CgZ5DW3fhACRMaHhzVElHj9DfXXmrtVesNVqgxWARDYLMwoyRtGZSxEi6XNl3Y
         CR5oHFrvmZ83jxJAS+C3yb8TWu4c+Bw9rV+lE8zDrWJK/66Urfl6HlG8M9PmWBlN3GQG
         Oi3/2XQyEHU1RQNKMlLLeSJakq9SEUyvFtSqw6E3mzPPrPrM+3KR1guf4n+jTICcW927
         NrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6OB8aseJOxwXkbgJPnGNqNw8N1IAHjzJp88D/UWNJg=;
        b=tZgqJpfuZl8Xm1y8k73fVP1CVY916p6C03aETX5KFSwF4CH/SHN4xzIq6uG55kNEEv
         zYU3ied7de70qqaj0MWIWUW1pqkOEM61fORGC13eWQUXXdUrzvZseI1BaM8uwcmI9CsN
         6GhA4JdKweJopfU93L54biRAZHrmdMN0nQeg5qABAsLYVZAh3pN55PCE/srNpchMCeTs
         3tQIHIyNS1/M4HQiPvKKtBhP/vTpBu1SQsBLUEqWiwfF9ilUpmN08y0wezu0zcM0hqO6
         zHJc2dO0ozUf8qKw2OPsMK9tRJkNs5BHHN1klwvUaP6CMez2UPsx6gZMvBYA1gzZc1AQ
         KUgA==
X-Gm-Message-State: AOAM533niUWpLrC5vh/lyVXMsnqEt4DxdWObR8CoGzQLUSal+CRfz9f5
        BtUN7khEL24rfnpF38hcCBsUJ1klkt3ou+j2zg8=
X-Google-Smtp-Source: ABdhPJx55RC5YcFaaTVcAmSZHhzvZsT5LMxwC/S8q0wBMnTigx/+LyGWOf8YCTRV1d1YQAK8QlohqjijRLvKm+UvuXs=
X-Received: by 2002:a17:906:7f02:: with SMTP id d2mr6640860ejr.211.1592077313664;
 Sat, 13 Jun 2020 12:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-6-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-6-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 21:41:42 +0200
Message-ID: <CAP8UFD02QdZeq4Y4cGpLL3H6xeW1qUFXw-=9ONn3s8n9vRL8sA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/6] stash: remove the second index in restore_untracked()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index cbe37cd24b..1eafc1fe8d 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -359,29 +359,16 @@ static int restore_untracked(struct object_id *u_tree)
>         int res;
>         struct child_process cp = CHILD_PROCESS_INIT;
>
> -       /*
> -        * We need to run restore files from a given index, but without
> -        * affecting the current index, so we use GIT_INDEX_FILE with
> -        * run_command to fork processes that will not interfere.
> -        */
> -       cp.git_cmd = 1;
> -       argv_array_push(&cp.args, "read-tree");
> -       argv_array_push(&cp.args, oid_to_hex(u_tree));
> -       argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
> -                        stash_index_path.buf);
> -       if (run_command(&cp)) {
> -               remove_path(stash_index_path.buf);
> +       if (reset_tree(u_tree, 0, 0))
>                 return -1;
> -       }
>
>         child_process_init(&cp);

Is this still necessary?

>         cp.git_cmd = 1;
>         argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
> -       argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
> -                        stash_index_path.buf);
>
>         res = run_command(&cp);
> -       remove_path(stash_index_path.buf);
> +       discard_cache();
> +
>         return res;
>  }
