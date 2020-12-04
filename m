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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC986C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9066722C9E
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgLDXIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLDXIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:08:16 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3826C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:07:36 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so8023075oif.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bDYMxkSDTH0xPv7gb1NAgm6YB4AyB8X7vtSCq76LSE=;
        b=X+mq86Yar+oMIKJV/VF+PIADFz5lzX3fU6kw3oeVQYX2f00fBz89b29qpKTvpZKiiY
         2DNprZaTinAO8KRq8JC1LOUGhH4i+3nUfu8FhZj3gFCkdBJtHJmvAzmMaKE0TdWgeuX8
         IY6GAN/nqJo3h2TPGL5n5AmY5P04PGDSqaO9AYoDGbcuwZfX/HNt848PPyltUTGO/v1O
         jRD9MzXrvtwjQ6pxcvv4NaYZsiLrAAlC6GmN6f9y5zi4ssSITgbhBtFyy6cqsnfd9Cb2
         ZGT5WW70qFys2ub1+Md78MFotiRzi41Y2r/T90rgmlrRguJRcE1WQBIdY/zPbF6N7s+9
         t39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bDYMxkSDTH0xPv7gb1NAgm6YB4AyB8X7vtSCq76LSE=;
        b=PMBcZj1G2VaQFfL703f0Mq43sRIAts/K7VGWh1ZkepCCDu/1P1pmDQ4suiRPIVUXa/
         cr2gOc82Qxo2SDD6Sg4dJPziDCUo6PmswAK/Fu+qwYjBRHXC0eTq6P0VYpUIA24OsAp4
         zazIh7ZOXKK2p3Vcd5TNkaYIxaNSQ533ov2bcKJX0328BsObVBsjmwj0b/hMsbKSF6nH
         Ru1HkwbtUf6btMR0hxCh1aYWOatmO5hktkWo6Lkwr/rZ4rHjp5omDH7H/rMCGj+9BHGy
         crS3D+BzHpZh9BlSBtfuPHmWHKdmyMgiGvMpadGZOdIfTRglc62K1NlCCmCIbVR74wXk
         ldwg==
X-Gm-Message-State: AOAM5303JZumY44wyoFCgQlcPZhyD7iGkNHQTPAy6lOrmWxynl4QQc15
        79e3YiYetKjeAQXJVD/UXjtDAG8sdkm2V/NEosU=
X-Google-Smtp-Source: ABdhPJwE4jF86k8jqdYYyXmQusO/+YildIM8FR+sfCYBheSkc3yxFR5l1aalsiL4ZuFwrHiT/kc5eVVjysrORzarQ5Y=
X-Received: by 2002:a54:480b:: with SMTP id j11mr4876649oij.31.1607123256022;
 Fri, 04 Dec 2020 15:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-5-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-5-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:07:24 -0800
Message-ID: <CABPp-BHjzzhqQW8YY5podav+TU8Eixhp7g-VrQ-tva-0ztAtvA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] pull: cleanup autostash check
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
> This essentially reverts commit f15e7cf5cc.
>
> Once commit d9f15d37f1 introduced the autostash option for the merge
> mode, it's not necessary to skip the fast-forward run_merge() when
> autostash is set.

It helps reviewers and future code readers if you provide a little
context when referring to commits, making use of git log's
--pretty=reference option to get the output.  So, for example, here
your commit would read:

"""
This essentially reverts commit f15e7cf5cc (pull: ff --rebase
--autostash works in dirty repo, 2017-06-01).

Once commit d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)
introduced the autostash option for the merge
mode, it's not necessary to skip the fast-forward run_merge() when
autostash is set.
"""

I still found it slightly hard to follow the explanation even with the
added summaries, though.  An extra sentence at the end of the second
paragraph to make it clear what is being changed ("So, change the code
to fast-forward even when autostash is set.") seems to help.



> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 6279e9ee37..c38548dab8 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -927,7 +927,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         struct oid_array merge_heads = OID_ARRAY_INIT;
>         struct object_id orig_head, curr_head;
>         struct object_id rebase_fork_point;
> -       int autostash;
>
>         if (!getenv("GIT_REFLOG_ACTION"))
>                 set_reflog_message(argc, argv);
> @@ -960,8 +959,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (get_oid("HEAD", &orig_head))
>                 oidclr(&orig_head);
>
> -       autostash = config_autostash;
>         if (opt_rebase) {
> +               int autostash = config_autostash;
>                 if (opt_autostash != -1)
>                         autostash = opt_autostash;
>
> @@ -1030,13 +1029,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                      recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
>                     submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
>                         die(_("cannot rebase with locally recorded submodule modifications"));
> -               if (!autostash) {
> -                       if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
> -                               /* we can fast-forward this without invoking rebase */
> -                               opt_ff = "--ff-only";
> -                               ran_ff = 1;
> -                               ret = run_merge();
> -                       }
> +               if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
> +                       /* we can fast-forward this without invoking rebase */
> +                       opt_ff = "--ff-only";
> +                       ran_ff = 1;
> +                       ret = run_merge();
>                 }
>                 if (!ran_ff)
>                         ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> --
> 2.29.2
>
