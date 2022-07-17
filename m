Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCEC43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 16:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGQQ2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQ2V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 12:28:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF1B13D5C
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:28:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n7so7590961ioo.7
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i4edDoUAANz+egCqUmrYxLtN+4O1mpLr/Kaq+04mtmU=;
        b=XFDX217pNVZiBf82prWCsyGiw6kymVyOalEaVXo6+YUAiyobW08nL9REBAhV77r+rj
         1TbKvDysLN4PcH5mMI9bfm57eb/yUqqk424oGgMNfYO6TIjKgmc1Zo/H/ekbuPhvjq1p
         K5ofArqJwu2CAzPH0nMfgQzlyRQfp0UKssQ0vkfgKyc4AOKG8Kk6kaB1DXRvsWCrZERi
         vO+8ZSWt3kpEPvzuWotix9HxxIg7jvjx4kQmxNi9PwQAZ1ZhuQ/3OSI49m4k94cNRys6
         VIcPqfByS5Byp9M9sK7pDKpcaSvPEgkLEdhJd6G9CgGdQgoyUdn6sdJux/yPobKLyTrt
         yAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i4edDoUAANz+egCqUmrYxLtN+4O1mpLr/Kaq+04mtmU=;
        b=Yowdpi5w9Lx5YYnVsdNygPVGWKX/zwx/PSJXg/qCYRFSoSagtw0sVANviKlZKFscYC
         mfL0jckvjbZZAixWE5VYJ/1MLBj8zEoJVZbkDSKSt8iSjY6LteN8x3eb7tcFo4L9wo22
         t2sSYBifZQ/BaNT27Wup0jPVkoJopn6Po8G0ybO4MaPpneZGGo2sMexJs42ANbqvk9zH
         6QavAMdPP9FRXnXfTc1INZqRwY40hgolnk4GjpUfGo4BwNuKVlGIqgbyAHLIuecXKPLA
         6MSXeGwfJbyqz4tIOuQ6H3LjREf/bXIXm2qrIMz++X0Zt5ZNh020j2EIUT3ot01nwem+
         Ny/A==
X-Gm-Message-State: AJIora+XiyqJp6FPNIcn7trG8zaVqhjSgA27jWsJSyk30HBVFLyFVDhR
        5IPuRo7pRNLKguXJ+APlgRausG+GF2JiiY2UWX8kb4yQ8O+Iqw==
X-Google-Smtp-Source: AGRyM1uvzQSo9D2X0HBalGNxTbLgHZuo3VCfOOX3G7XKRhmXxT2cbNra9yPalodtkLRfI/AEiJsRXBVRTd44qpzFq04=
X-Received: by 2002:a6b:c34c:0:b0:67c:11c7:86aa with SMTP id
 t73-20020a6bc34c000000b0067c11c786aamr619933iof.126.1658075297550; Sun, 17
 Jul 2022 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 18 Jul 2022 00:28:06 +0800
Message-ID: <CAOLTT8THesUrMtov0L=pHKNfdABYvHeue6OzHre-sQD36=2e=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] merge: fix save_state() to work when there are
 racy-dirty files
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> When there are racy-dirty files, but no files are modified,
> `git stash create` exits with unsuccessful status.  This causes merge
> to fail.  Refresh the index first to avoid this problem.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 00de224a2da..8ce4336dd3f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
>         int len;
>         struct child_process cp =3D CHILD_PROCESS_INIT;
>         struct strbuf buffer =3D STRBUF_INIT;
> +       struct lock_file lock_file =3D LOCK_INIT;
> +       int fd;
>         int rc =3D -1;
>
> +       fd =3D repo_hold_locked_index(the_repository, &lock_file, 0);
> +       refresh_cache(REFRESH_QUIET);
> +       if (0 <=3D fd)
> +               repo_update_index_if_able(the_repository, &lock_file);
> +       rollback_lock_file(&lock_file);
> +
>         strvec_pushl(&cp.args, "stash", "create", NULL);
>         cp.out =3D -1;
>         cp.git_cmd =3D 1;
> --
> gitgitgadget
>

I just want to show what sence will meet this errors:

1. touch file
2. git add file
3. git stash push (user may do it before git merge)
4. touch file (update file but not update its content)
5. git merge (call git stash create and return 1)

So I have knew about what's the meaning of this patch:

If user do the git stash manually and update file timestamp
before git merge, it may make next git stash failed. And
refresh index can make index entry sync with the work tree
file status.

Thanks.

ZheNing Hu
