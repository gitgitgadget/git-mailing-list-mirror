Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E5C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 02:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiAVCdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 21:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiAVCdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 21:33:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE0C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 18:33:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ah7so4927783ejc.4
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 18:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7nTm0O5P7laflJ0qvAdE3m4zf3jqsGte3VaDiEtFMrY=;
        b=AhjOBms3md00BhDYb74Ns4LKUwUM1T4bhDT8N4roi3GBI1Id9mWZQJJhMFybdyCk2m
         g9jfLR49dYqiPHgJxNjllzRSzkRk5X66IgLJmmRicW1MqBMZzTaQnT3Unj5jdQYzU3S7
         wkbS4JbA177LP5u5p1P5O7PngKjiEeETUiOL10XSPlV9/K7Cdgt5HTU+OiPHCoWkk/vC
         +bsjhXVHsceJ5IQMa1DwVsd/aT045fb+6ilVhbnnI1jikIYfa9OdS0XwyUmYRHf41QYs
         b4WEDnLBgoHaCpMPvJd60UHuuKEsyrYWrx/U3QHFwmY3e96LnxQ749KO3Wjl8oF0dxcw
         EJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7nTm0O5P7laflJ0qvAdE3m4zf3jqsGte3VaDiEtFMrY=;
        b=aZIoI+VFmpjfn+EWGffVKi0VOb4lVfLz66kYn5jWRFPWh4Mxg34O+ruF2w9tYPWeEv
         sLcyTE3kS/AdNUkSosM2/4DdZkdKvnqORLHDrwpd72oVMNENyYgBt2qzFe3jAAPoqjNT
         7c5/eFZi8ilslB7yLZwzAKkjpTlclmROM9vJwOZKTH7hjiaW+u8rrLm1LJxf9DJW5CBf
         QohE2y4+RZxYJiksNeUkuKuF03eVjdUJbpQieI9Qys+OxFT/gTss1Kzewq+IZ+SYUBQX
         8rJc86gVnI6KdwAg8ljtW+DA+DTgXp0MyjYwgjWzfAw0aeiksZ0C9rRW4bJwMqHDr7BJ
         J2bQ==
X-Gm-Message-State: AOAM533BRIoZwRMeZ7lEBsUT1U2U1KRTDQTi85yATg5rK11vm2AM04ys
        WNrxjb6ksjrZqgbFaMjjoE9FKHhbV8Z+Q33IGa8=
X-Google-Smtp-Source: ABdhPJz+BZdbPwAN96hbrPlOUR1kvamSEZWo/9w+BrK5iknGtjh+0N9BzbsRpDA2USDlUuouGyadLPvfjUp/eoGFuzc=
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr5372255ejc.100.1642818810008;
 Fri, 21 Jan 2022 18:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20220120185548.3648549-1-jonathantanmy@google.com> <20220121174441.3991963-1-jonathantanmy@google.com>
In-Reply-To: <20220121174441.3991963-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Jan 2022 18:33:18 -0800
Message-ID: <CABPp-BG9rxJsA9XwgUxpny5TDW4W7Z85PAkBdzKJXrSJxAim1g@mail.gmail.com>
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wro=
te:
>
> When creating the sparse-checkout file, Git does not create the leading
> directory, "$GIT_DIR/info", if it does not exist. This causes problems
> if the repository does not have that directory. Therefore, ensure that
> the leading directory is created.
>
> This is the only "open" in builtin/sparse-checkout.c that does not have
> a leading directory check. (The other one in write_patterns_and_update()
> does.)
>
> Note that the test needs to explicitly specify a template when running
> "git init" because the default template used in the tests has the
> "info/" directory included.

If wanted, you could avoid that by using `git worktree add ...`;
git-worktree will create a $GIT_DIR that does not contain an info
subdirectory.

(No need to resubmit or anything, mostly I'm just mentioning another
way folks might have triggered this issue.)

> Helped-by: Jose Lopes <jabolopes@google.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes from v1:
>  - made test simpler
>  - added attribution to Jose Lopes for finding and making the first
>    draft of this patch (after confirming with them)
>
> =C3=86var mentioned "git sparse-checkout add" but I think that that is a
> different problem - in the "git sparse-checkout init" case, we could get
> into this case with a template that does not have .git/info, but in the
> "git sparse-checkout add" case, the user would have had to explicitly
> remove the info directory. So I'll limit this patch to the "init" case,
> for now.
> ---
>  builtin/sparse-checkout.c          | 3 +++
>  t/t1091-sparse-checkout-builtin.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 679c107036..2b0e1db2d2 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -471,6 +471,9 @@ static int sparse_checkout_init(int argc, const char =
**argv)
>                 FILE *fp;
>
>                 /* assume we are in a fresh repo, but update the sparse-c=
heckout file */
> +               if (safe_create_leading_directories(sparse_filename))
> +                       die(_("unable to create leading directories of %s=
"),
> +                           sparse_filename);
>                 fp =3D xfopen(sparse_filename, "w");
>                 if (!fp)
>                         die(_("failed to open '%s'"), sparse_filename);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index 42776984fe..3189d3da96 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -79,6 +79,12 @@ test_expect_success 'git sparse-checkout init' '
>         check_files repo a
>  '
>
> +test_expect_success 'git sparse-checkout init in empty repo' '
> +       test_when_finished rm -rf empty-repo blank-template &&
> +       git init --template=3D empty-repo &&
> +       git -C empty-repo sparse-checkout init
> +'
> +
>  test_expect_success 'git sparse-checkout list after init' '
>         git -C repo sparse-checkout list >actual &&
>         cat >expect <<-\EOF &&
> --
> 2.35.0.rc0.227.g00780c9af4-goog

Patch looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
