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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B674C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B161154
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEFBGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhEFBGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:06:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1532DC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 18:05:16 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b17so3373900ilh.6
        for <git@vger.kernel.org>; Wed, 05 May 2021 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3URcUYW4qG3QdjwjFDxZvLNydXNwuYQEnFW7juVaB3o=;
        b=NCvD8MHnjajm1vnqo2nTVko2twFGInVLemWUfDbI9iuLG2L061B/QSWGn7CF6JSpp/
         L7xeGlXHzjOebcf2fSLJ16VpF38g/ntYJHZ9Yktj+BJ4/Xj1t7JDyOXdCyuDraHrVYIn
         iQ4z4ZRESNQaO/2sBcm1KdSwWywmahi9tZywmeHTscrefAsNZwvlWrK9rMxrfUUFim7h
         g2Zk1JRN0PQgzJ5LVxwhgJOhE5bMPcE06ylu/VF/EsmY9L7dA7CIAo2gD9AVyN6XScmU
         6Fw/mZnqCFJRGitG2Lk+xYJoSw09lAxcovpkkCHW7YBiZQ35btBXciMZnlfevsx5H68N
         uz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3URcUYW4qG3QdjwjFDxZvLNydXNwuYQEnFW7juVaB3o=;
        b=iV2uWnf+rYPR4F2s+wNslv2qmGw6LEUFtThjVuVjlhBrNwGLyMEJZ+zroll5hmtiu4
         mfVBXsOTGyxZwuSpWN8oAK4CPFjlo/vt5PWRIg/JOOjSru0GOYhCUP90QWhlOITUf/SM
         F++3iXurzTN8Ay9yo1oKFl1iIS44FW7zCXkRpJrW04J24GJXuFNtnIufeVGU+JNafHs0
         I7EQcbhHuEh1Mm2bPVSkmpJY9XRWLstK5AXbi5YKfmpK+TOaT79ZXz1uVtqqdTHJost9
         JeFictAOWiHQ0gXwc3r79hQ6Et3w8dEOTKLTQYYgTJgIayIzwYrbe5MnRHJiJvfqNIUV
         5b0A==
X-Gm-Message-State: AOAM532nqDzTKlhPQEt8GlgzJBSJrM3+ZCAg9DRa7zL/YOj/1VyQK5lh
        6QW1qoLRpZEAO5l0MDT//BYcwqu1fLw1mfB74dw=
X-Google-Smtp-Source: ABdhPJz/VbRIqvUhF8OCcpxiY+6hIb6ie/IDfgWaemzMt8wMnIKk9KtVcNY0kHVpIqdYYEowc8mt/Ilrohct1Pe4b7g=
X-Received: by 2002:a92:c7a6:: with SMTP id f6mr1622189ilk.17.1620263115627;
 Wed, 05 May 2021 18:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210505145204.51614-1-oystwa@gmail.com>
In-Reply-To: <20210505145204.51614-1-oystwa@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 6 May 2021 09:05:04 +0800
Message-ID: <CAOLTT8S5yDNZBkFs8+3sB8vTZQzTBsuTPXpD+d4wiM4ZR9X9QA@mail.gmail.com>
Subject: Re: [PATCH] add: die if both --dry-run and --interactive are given
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=98ystein Walle,

=C3=98ystein Walle <oystwa@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:53=E5=86=99=E9=81=93=EF=BC=9A
>
> The interactive machinery does not obey --dry-run. Die appropriate if
> both flags are passed.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> I think a better solution would be to allow this and improve the
> interactive machinery to handle --dry-run. This is what I could muster
> up at the moment.
>
>  builtin/add.c  | 2 ++
>  t/t3700-add.sh | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ea762a41e3..6077eb189f 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -457,6 +457,8 @@ int cmd_add(int argc, const char **argv, const char *=
prefix)
>         if (patch_interactive)
>                 add_interactive =3D 1;
>         if (add_interactive) {
> +               if (show_only)
> +                       die(_("--dry-run is incompatible with --interacti=
ve/--patch"));
>                 if (pathspec_from_file)
>                         die(_("--pathspec-from-file is incompatible with =
--interactive/--patch"));
>                 exit(interactive_add(argv + 1, prefix, patch_interactive)=
);
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index b3b122ff97..171b323f50 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -343,6 +343,10 @@ test_expect_success 'git add --dry-run --ignore-miss=
ing of non-existing file out
>         test_cmp expect.err actual.err
>  '
>
> +test_expect_success 'git add --dry-run --interactive should fail' '
> +       test_must_fail git add --dry-run --interactive
> +'
> +
>  test_expect_success 'git add empty string should fail' '
>         test_must_fail git add ""
>  '
> --
> 2.27.0
>

Thank you for solving this confusion of mine. For the time being,
it is an easier solution to make the two flags mutually exclusive.
But if we need to make `git add -i` support `--dry-run` in the future,
maybe we should passed the parameter `DRY_RUN` (maybe an
environment  variable) to the sub-process `git -add--interactive.perl`
and finally this feature may be implemented in `git apply`.

Reported-by: ZheNing Hu <adlternative@gmail.com>

Thanks!
--
ZheNing Hu
