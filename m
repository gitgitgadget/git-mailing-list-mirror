Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12989C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED33761245
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUU6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFUU6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:58:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1393C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:55:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19141558otl.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAUCZJL0d+dbNVw9tA4aW/S0dRnx9mZ9nKX/tW9bT3s=;
        b=UTG+OyFW13Emasi+oLSE2c+YprOr9Op7FnoEkAZOZgS3syKncPS6aow3GRFUvJDcjs
         0/g5IwQAJpcuIlTv7k2lztuyLVSTimEUQa/r2UheYDqFyz64tGrPLwUKsS78QVh1SW+i
         e99mfvNJDeE7a/n6/Z0dfZsq68RQJ235Uh64uALKj6Ds7XSe8Gx+/+ifdjLMDdmwkCeR
         taR0g6ItKM/nsMULboqzdYRnsaBm8FRb2JLlSDmxllE7iXMPLPWOwoB4EW91Nty/oHFN
         4MN+NQVky9P5JiMTx7OyweFvUDQXLau7L3sHB5nAFm7p8zUsQy4kJw0hP84loC5yYUub
         SKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAUCZJL0d+dbNVw9tA4aW/S0dRnx9mZ9nKX/tW9bT3s=;
        b=eSuJJxtUG2rSFhi+SgO9ylq6FUPWPIYg++KsGfYzUbnU7wFYYfI5iaBAnRQhO1Qiib
         Z3JS2MzrfHH1r+TqigaLcmkxn/WyFKHgtxzO00JIak2aHTal83PIIZ81cJkmA86BttR5
         oxe91RbA2BT0euGya5lVlUvmiXAOoN8S8ll8IsSAL7CahoCmCTwYDYG9E31W92i0VhyQ
         YTxsjzrX311y8+TDgjG6ts9RqbQnxbsNpO5km9rCLJUuYnf1a6KXUiRhFq4SVt59u5ft
         gfgfOwHQOz5XE1PU6lzWSccZjTGdDiOb70FSjVlozHwXL7WQbCi2+QTQdcvrd6uzGSME
         K1Iw==
X-Gm-Message-State: AOAM5328ZFbcL0ZY2J1vy0h0/ojbmI14m5e0fy1DuRTuE8geKrhmPeTa
        gAaYFWhshoJ6gRiJIgeuWUWzjzOfYosWqBtzAkE=
X-Google-Smtp-Source: ABdhPJwIuecySbC3wDjvUyGiHD0AZKgqnSNm/4eQWQQRX6wZNXnDvJANJYKV519Wv/1lrCQd3GnfQR8hLKEtcZwhTyk=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr1061ote.316.1624308946238;
 Mon, 21 Jun 2021 13:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-5-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-5-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 13:55:34 -0700
Message-ID: <CABPp-BGBKC5y-8Kk4Et9O8LMOwypQfxDxDZ3BEMNLaya30jkxg@mail.gmail.com>
Subject: Re: [PATCH 04/12] builtin/for-each-repo: remove unnecessary argv copy
 to plug leak
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> cmd_for_each_repo() copies argv into args (a strvec), which is later
> passed into run_command_on_repo(), which in turn copies that strvec onto
> the end of child.args. The initial copy is unnecessary (we never modify
> args). We therefore choose to just pass argv directly into
> run_command_on_repo(), which lets us avoid the copy and fixes the leak.
>
> LSAN output from t0068:
>
> Direct leak of 192 byte(s) in 1 object(s) allocated from:
>     #0 0x7f63bd4ab8b0 in realloc (/usr/lib64/libasan.so.4+0xdc8b0)
>     #1 0x98d7e6 in xrealloc wrapper.c:126
>     #2 0x916914 in strvec_push_nodup strvec.c:19
>     #3 0x916a6e in strvec_push strvec.c:26
>     #4 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
>     #5 0x410dcd in run_builtin git.c:475
>     #6 0x410dcd in handle_builtin git.c:729
>     #7 0x414087 in run_argv git.c:818
>     #8 0x414087 in cmd_main git.c:949
>     #9 0x40e9ec in main common-main.c:52
>     #10 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 22 byte(s) in 2 object(s) allocated from:
>     #0 0x7f63bd445e30 in __interceptor_strdup (/usr/lib64/libasan.so.4+0x76e30)
>     #1 0x98d698 in xstrdup wrapper.c:29
>     #2 0x916a63 in strvec_push strvec.c:26
>     #3 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
>     #4 0x410dcd in run_builtin git.c:475
>     #5 0x410dcd in handle_builtin git.c:729
>     #6 0x414087 in run_argv git.c:818
>     #7 0x414087 in cmd_main git.c:949
>     #8 0x40e9ec in main common-main.c:52
>     #9 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> See also discussion about the original implementation below - this code
> appears to have evolved from a callback explaining the double-strvec-copy
> pattern, but there's no strong reason to keep that now:
>   https://lore.kernel.org/git/68bbeca5-314b-08ee-ef36-040e3f3814e9@gmail.com/

The link you give shows that Stolee was looking forward to reviewing
your patch to fix this issue, so cc'ing him so he can do so.

In general, it helps to cc folks who were involved in earlier
conversations about an area being updated, or who know the code area
well.

> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  builtin/for-each-repo.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index 52be64a437..fd86e5a861 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -10,18 +10,16 @@ static const char * const for_each_repo_usage[] = {
>         NULL
>  };
>
> -static int run_command_on_repo(const char *path,
> -                              void *cbdata)
> +static int run_command_on_repo(const char *path, int argc, const char ** argv)
>  {
>         int i;
>         struct child_process child = CHILD_PROCESS_INIT;
> -       struct strvec *args = (struct strvec *)cbdata;
>
>         child.git_cmd = 1;
>         strvec_pushl(&child.args, "-C", path, NULL);
>
> -       for (i = 0; i < args->nr; i++)
> -               strvec_push(&child.args, args->v[i]);
> +       for (i = 0; i < argc; i++)
> +               strvec_push(&child.args, argv[i]);
>
>         return run_command(&child);
>  }
> @@ -29,37 +27,33 @@ static int run_command_on_repo(const char *path,
>  int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  {
>         static const char *config_key = NULL;
>         int i, result = 0;
>         const struct string_list *values;
> -       struct strvec args = STRVEC_INIT;
>
>         const struct option options[] = {
>                 OPT_STRING(0, "config", &config_key, N_("config"),
>                            N_("config key storing a list of repository paths")),
>                 OPT_END()
>         };
>
>         argc = parse_options(argc, argv, prefix, options, for_each_repo_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>
>         if (!config_key)
>                 die(_("missing --config=<config>"));
>
> -       for (i = 0; i < argc; i++)
> -               strvec_push(&args, argv[i]);
> -
>         values = repo_config_get_value_multi(the_repository,
>                                              config_key);
>
>         /*
>          * Do nothing on an empty list, which is equivalent to the case
>          * where the config variable does not exist at all.
>          */
>         if (!values)
>                 return 0;
>
>         for (i = 0; !result && i < values->nr; i++)
> -               result = run_command_on_repo(values->items[i].string, &args);
> +               result = run_command_on_repo(values->items[i].string, argc, argv);
>
>         return result;
>  }
> --
> 2.26.2

Patch makes sense to me
