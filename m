Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA80E1F461
	for <e@80x24.org>; Tue, 14 May 2019 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfENMqo (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:46:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41705 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENMqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:46:44 -0400
Received: by mail-io1-f66.google.com with SMTP id a17so12896942iot.8
        for <git@vger.kernel.org>; Tue, 14 May 2019 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClAomCRXLcJGawwvkLn8jjfSkM0UjirWYn3rKCwtQtg=;
        b=T4QuRZOtqrap5G3ky8Jwag1aZ/9HJ6dqal/Ogk3YQmOAgiOb4Gbpv7LJy1sIXRtYtC
         IrUFkVnBoc7JjF4kHaot+MnHFq6StWd14R9mg+hJgZ4+cLhAPMDjdEtv5MMIL3UAt3Ie
         Wvi79YWsW4+ImTMJtJeRGy8mNqN4lf8henm0lrgqU2es6uNRfKi8FEkXgusm23Mt1VlX
         H9ZTH9yQocJwKjs1HR/Hk9Cq2DlKx2n7WKfhSU1fBk6sxSWw9oHPp1pmmXS4NaxLByQM
         YzBB971rKeIq6qsjri0mbvNHElgOuZ7M6zpDmfkA+UFXZaw4FMcu6xY7BEPZ1z/4oOAi
         DalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClAomCRXLcJGawwvkLn8jjfSkM0UjirWYn3rKCwtQtg=;
        b=CWgdO8WA/vNMMVVO0NhWkDrWsOqQgQJSKcTWgVRvFk/Z+24yyLnhWv0TTF2pEOfLmK
         XR3tjrlcWy5rgJ2rSonVHeyXkveE9P0JYn10TWSgaqvRd8ew5mc81MYfW2z1j04iL4pB
         wmwHyq91gyap3gj0kYR7SeML5FpRtQXHMGZSmx5G/2NQnM4GDblfTEVv7tx+VG1VkNhi
         78kgldAUfzHWOl9it0SQo8bNTj+uZgpwEQcP1bVL16Nu81tQD+UQRZaZqW7cdSNgY4Le
         seaJLRcfs868BaWCIVGxi+npxBZHYMP+4Wet1JAAbREHhPF1/TRbWYUvhrb0IKto2qnp
         Y+jg==
X-Gm-Message-State: APjAAAUmJ/nKHa+fM4I2UYeSEnhHmSbjqwrrDY4z80Y7+be0dWlMYFcK
        1y6lN5pygAx/JqtDJ4kOlMTnR0BX/FCznMrFkDQ=
X-Google-Smtp-Source: APXvYqytQ1RRo9Hpp1pC2cULc72H/q2DQpseqg1kUq3uwRBsmyi09tfZhhe5+Fj0J3pdEnRv9G6dTpeQNkd7I31PQmQ=
X-Received: by 2002:a6b:8e84:: with SMTP id q126mr1099288iod.118.1557838003210;
 Tue, 14 May 2019 05:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-2-sandals@crustytoothpaste.net>
In-Reply-To: <20190514002332.121089-2-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 19:46:17 +0700
Message-ID: <CACsJy8Ba98baQ2wZnMZyEva6gxO1ROZ4qJFTOdrCUXDMwrHnXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:24 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> -int run_hook_ve(const char *const *env, const char *name, va_list args)
> +int find_hooks(const char *name, struct string_list *list)
>  {
> -       struct child_process hook = CHILD_PROCESS_INIT;
> -       const char *p;
> +       struct strbuf path = STRBUF_INIT;
> +       DIR *d;
> +       struct dirent *de;
>
> -       p = find_hook(name);
> -       if (!p)
> +       /*
> +        * We look for a single hook. If present, return it, and skip the
> +        * individual directories.
> +        */
> +       strbuf_git_path(&path, "hooks/%s", name);
> +       if (has_hook(&path, 1, X_OK)) {
> +               if (list)
> +                       string_list_append(list, path.buf);
> +               return 1;
> +       }
> +
> +       if (has_hook(&path, 1, F_OK))
>                 return 0;
>
> -       argv_array_push(&hook.args, p);
> -       while ((p = va_arg(args, const char *)))
> -               argv_array_push(&hook.args, p);
> -       hook.env = env;
> +       strbuf_reset(&path);
> +       strbuf_git_path(&path, "hooks/%s.d", name);
> +       d = opendir(path.buf);
> +       if (!d) {
> +               if (list)
> +                       string_list_clear(list, 0);
> +               return 0;
> +       }
> +       while ((de = readdir(d))) {
> +               if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
> +                       continue;
> +               strbuf_reset(&path);
> +               strbuf_git_path(&path, "hooks/%s.d/%s", name, de->d_name);
> +               if (has_hook(&path, 0, X_OK)) {

Do we want to support hooks in subdirectories as well (if so, using
dir-iterator.h might be more appropriate)

If not, what happens when "path" is a directory. X_OK could be set
(and often are) on them too.

> +                       if (list)
> +                               string_list_append(list, path.buf);
> +                       else
> +                               return 1;
> +               }
> +       }
> +       closedir(d);
> +       strbuf_reset(&path);
> +       if (!list->nr) {
> +               return 0;
> +       }
> +
> +       string_list_sort(list);

This is going to be interesting on case-insensitive filesystems
because we do strcmp by default, not the friendlier fspathcmp. And the
".exe" suffix might affect sort order too.

But I suppose we just need to be clear here (in documentation). They
can always prefix with a number to keep hook files in expected order.

> +       return 1;
> +}
> +

> diff --git a/run-command.h b/run-command.h
> index a6950691c0..1b3677fcac 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -4,6 +4,7 @@
>  #include "thread-utils.h"
>
>  #include "argv-array.h"
> +#include "string-list.h"

'struct string_list;' should be enough (and a bit lighter) although I
don't suppose it really matters.

>
>  struct child_process {
>         const char **argv;
-- 
Duy
