Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F6C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A4322838
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLDXfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLDXfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:35:10 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE4C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:34:39 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w3so6290969otp.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlpnkpLKKxo9oLS1AJp4JQaY4wqroDxDbIbRNE/17II=;
        b=oqD3vCCqMXsAwzrd9jsukvW8aHo+zwe2fatIxzZxwHqCnq3iJdfTeCtPDNO9et4FiS
         gf8KygUuzERYrTz3N6D7N7U2+EHrcriSvKAnbSxndT0VzNHC1Fy8XEkBFXrnWN7ebKdP
         jS+C1IomRYVvdsyGnNlkBEZ4w4C0rIqVOtzLOVmvqizhrfl8uXTSJAyY0WRuKeuFQZGY
         l6bS2GHDoVIju5zTk5JV00/WrmTovqIH3+VQiLWwdlwnI6MVir38pks34Nr9FW98X2ss
         zsUcd29ikWFdzRdEQ2BgCrb3FMLRpJDFOSpYANAkUSWKpmsE5yY4h9TPTvj0VIci2kvX
         iWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlpnkpLKKxo9oLS1AJp4JQaY4wqroDxDbIbRNE/17II=;
        b=Iio9JDFNATWJcXqTlflxF5enFwKnQjSws0Ri+NEBAshwTEvcG7WLcwcNzNyA2d4Xjs
         ITxG1lWS6RnhvG+NWgHMXoUVuQIcI4kV6qIEKAeX5hquABS8zTjYzCFeyPCvgTAPXb2r
         A7PCO7c0oki1PhhEXQ/p8VAmvWPjfq0BRjJTpZRqwav1FsTPwv0UvOQ6JtC56uevlJI+
         IKcsz/nTcNZNg8OFIock0ureQSJxyr/hgW3tDIKR6oUxDRV+FcNRwSENo8vW94dWpsng
         OAyBM+EdAxHrVgynrKZHmi4OdM1LUQa9qOX3n8W09ixw88mZDlJaVGYEbNaln9Xdi1ed
         zNVg==
X-Gm-Message-State: AOAM531VD3Nlb9eL8c+bDr2W23ps3MP8qYgvB7AOw4t+Uhl1qvOdT/v2
        iH+MAZvpuBaTusA8j1petoBBz4Nb5fhfijAQQY8=
X-Google-Smtp-Source: ABdhPJx80gL5/ujYaD6PCGN7efBVNb7aMSTvgH7b1uxnUdVJKao8uVG+bd7blt3LDxYLXVky5/ub/EE0rdqgwZQT8rM=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr5374802oti.345.1607124878651;
 Fri, 04 Dec 2020 15:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-11-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-11-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:34:27 -0800
Message-ID: <CABPp-BGftkZqJ1GuB-7-7PCo3zOYn_Rr1yu4wv6hwtDea5_oYw@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] pull: add proper error with --ff-only
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> The current error is not user-friendly:
>
>   fatal: not possible to fast-forward, aborting.
>
> We want something that actually explains what is going on:
>
>   The pull was not fast-forward, please either merge or rebase.
>   If unsure, run "git pull --merge".

Sorry to be a broken record, but I don't like the suggestion in the
second sentence.  I've said it enough times that I'll quit harping on
each instance.

> The user can get rid of the warning by doing either --merge or
> --rebase.
>
> Except: doing "git pull --merge" is not actually enough; we would return
> to the previous behavior: "fatal: not possible to fast-forward, aborting."

Do you mean that the changes in this patch aren't enough and that
future patches will address this shortcoming?  Or do you mean that
prior to this patch such a bug existed?  Or something else?

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c  | 34 ++++++++++++++++-----------
>  t/t5520-pull.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 6ea95c9fc9..f54ff36b57 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1015,20 +1015,26 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>
> -       if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
> -               advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> -                       "You can squelch this message by running one of the following commands:\n"
> -                       "\n"
> -                       "  git config pull.rebase false  # merge (the default strategy)\n"
> -                       "  git config pull.rebase true   # rebase\n"
> -                       "  git config pull.ff only       # fast-forward only\n"
> -                       "\n"
> -                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -                       "preference for all repositories.\n"
> -                       "If unsure, run \"git pull --merge\".\n"
> -                       "Read \"git pull --help\" for more information."
> -                       ));
> +       if (!can_ff && default_mode) {
> +               if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> +                       die(_("The pull was not fast-forward, please either merge or rebase.\n"
> +                               "If unsure, run \"git pull --merge\"."));

This is a much better message for when the user requests --ff-only.

> +               }
> +               if (opt_verbosity >= 0 && !opt_ff) {
> +                       advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> +                               "discouraged; you need to specify if you want a merge, or a rebase.\n"
> +                               "You can squelch this message by running one of the following commands:\n"
> +                               "\n"
> +                               "  git config pull.rebase false  # merge (the default strategy)\n"
> +                               "  git config pull.rebase true   # rebase\n"
> +                               "  git config pull.ff only       # fast-forward only\n"
> +                               "\n"
> +                               "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +                               "preference for all repositories.\n"
> +                               "If unsure, run \"git pull --merge\".\n"
> +                               "Read \"git pull --help\" for more information."
> +                               ));
> +               }
>         }
>
>         if (opt_rebase) {
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 9fae07cdfa..fdd1f79b06 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -819,4 +819,66 @@ test_expect_success 'git pull --rebase against local branch' '
>         test_cmp expect file2
>  '
>
> +test_expect_success 'git pull fast-forward (ff-only)' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       git pull
> +'
> +
> +test_expect_success 'git pull non-fast-forward (ff-only)' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       test_must_fail git pull
> +'
> +
> +test_expect_failure 'git pull non-fast-forward with merge (ff-only)' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       git pull --no-rebase

Do you mean `git pull --merge`?


> +'
> +
> +test_expect_success 'git pull non-fast-forward with rebase (ff-only)' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       git pull --rebase
> +'
> +
> +test_expect_success 'git pull non-fast-forward error message' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       test_must_fail git pull 2> error &&
> +       cat error &&
> +       grep -q "The pull was not fast-forward" error
> +'
> +
>  test_done
> --
> 2.29.2
