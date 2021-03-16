Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099DC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C6965239
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhCPG4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCPG4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 02:56:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4BC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:56:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 75so8138256otn.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=liFsRgPnNXcjOoy4F/5/P/uRL3BuG2lHJhUCPyFAIj8=;
        b=N/icE7RBfoCrNwL3E6k2BMnNRGCA2932WliZsNCw6eGVU+l1aMrO/pHyrDutZB2Mt9
         n7rH2gIZD8Qyjh8p8vchCxJKanlEsMaKcKv9tk4Cngik2gqms5wrk4xSfj0vZI07JD5g
         FfNtr1eZ/TcMnDJn3bXRr+P3ey7SO/rrYNwcmi+Us0GT/CVnU+l4NL4hvdtLEBEYOAjH
         qhwoIKtUAzdBmEiJ560mft4jFYp6EjcOl8kEFki2jZvIfJW6Lp4UwK6YyqtQe8SJez08
         +3P26SVRICCUpvaw7m0gScRZPJdZs86QrgHbA/MQjNdXjIGrGgRtC9TdPonwgPDy7fGH
         Ncqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=liFsRgPnNXcjOoy4F/5/P/uRL3BuG2lHJhUCPyFAIj8=;
        b=JpY7zBKSqONUDMYTaX0BMwmna7hvdZ8iVJbFAOtfIu0oR/pBQfyNyAjsajkNGYi3vQ
         kT9FufgRqEM+1vrr9n3Wh4GflNQPZVKlXxpEEuMQ8jiVLxaOGIF7sWVfwZSOnJrh2xBT
         wVtI3tbxs/x/YUl+lCyzy9LkS++4TG4WcOZ8OVoxuZoob+mSGrxP5+W4Eb15PVM01l/r
         5sQyQmcyGxIoBNfnFNjGjvHHLF0rpRVKmKocdN3U+xBZOYduzIzTRbcz3E04yFKulxpP
         C4JMUIMucP/LXfT8br5eincVVxCM1biE2VgMwoBQLK6g4BQgD00bT7iCnsRYBug/rpQD
         PnjA==
X-Gm-Message-State: AOAM533MpdWa/LY/mZb2Fw4W1LmvpBr6wNSjvCayKEan50NG/a9IDaB9
        1+LloZk0Az2+BSdMdQAk/dsMJvFvO+DiOM2OcWk=
X-Google-Smtp-Source: ABdhPJwRTrv5p6JCKSmzdAxRO1oYbw8YzXKzjgRexwxO/Gf+RdUMJdthT2pR6MkfFIX79GmXOb59kPpXSP1lQgC0WWU=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr2423479otf.345.1615877762355;
 Mon, 15 Mar 2021 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210308150650.18626-1-avarab@gmail.com> <20210316021312.13927-29-avarab@gmail.com>
In-Reply-To: <20210316021312.13927-29-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 23:55:50 -0700
Message-ID: <CABPp-BGsGsq93Zw7aSqDQVSrBvc+VGu91JZh-foFpuCNqJt5_Q@mail.gmail.com>
Subject: Re: [PATCH v2 28/29] blame: emit a better error on 'git blame directory'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 7:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change an early check for non-blobs in verify_working_tree_path() to
> let any such objects pass, and instead die shortly thereafter in the
> fake_working_tree_commit() caller's type check.
>
> Now e.g. doing "git blame t" in git.git emits:
>
>     fatal: unsupported file type t
>
> Instead of:
>
>     fatal: no such path 't' in HEAD
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  blame.c                         |  8 ++------
>  t/t8004-blame-with-conflicts.sh | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/blame.c b/blame.c
> index 9e0543e13d4..7da162cd582 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -100,12 +100,8 @@ static void verify_working_tree_path(struct reposito=
ry *r,
>
>         for (parents =3D work_tree->parents; parents; parents =3D parents=
->next) {
>                 const struct object_id *commit_oid =3D &parents->item->ob=
ject.oid;
> -               struct object_id blob_oid;
> -               unsigned short mode;
> -               int ret =3D get_tree_entry_mode(r, commit_oid, path, &blo=
b_oid,
> -                                             &mode);
> -
> -               if (!ret && oid_object_info(r, &blob_oid, NULL) =3D=3D OB=
J_BLOB)
> +               struct object_id oid;
> +               if (!get_tree_entry_path(r, commit_oid, path, &oid))
>                         return;
>         }
>
> diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflic=
ts.sh
> index 35414a53363..6caa504a0ea 100755
> --- a/t/t8004-blame-with-conflicts.sh
> +++ b/t/t8004-blame-with-conflicts.sh
> @@ -73,4 +73,24 @@ test_expect_success 'blame does not crash with conflic=
ted file in stages 1,3' '
>         git blame file1
>  '
>
> +test_expect_success 'setup second case' '
> +       git merge --abort
> +'
> +
> +test_expect_success 'blame on directory/file conflict' '
> +       mkdir d &&
> +       test_commit second &&
> +       test_commit d/file &&
> +       test_must_fail git blame d 2>expected &&
> +
> +       git reset --hard second &&
> +       >d &&
> +       git add d &&
> +       git commit -m"a not-a-dir" &&
> +       test_must_fail git merge d/file &&
> +
> +       test_must_fail git blame d 2>actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done

Given that the commit message says the change was about modifying the
error message shown, why does the new test not check for the error
message?
