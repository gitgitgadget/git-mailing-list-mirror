Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC88C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09A861076
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhJFQAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFQAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:00:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE19C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 08:58:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so11579975edc.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UrrodMsqw5qaXZieFFAut0nBJMyeHj5kamInnvkT0Cg=;
        b=IxVqfgpYGp6xy0P13937Z2tMIw5uFrkippoTFx0m9gWsZ5MszVUMMME7R30rMlQtyu
         B2xHCMJUa/CqeAl5ZCKdlWEht8Q1xtragqBMxYNbT3ojKQYdAbv2HvE6Izos5KgaeXa6
         Hw9qB2jhL2PvMldSDmtOk5+LyQkKDr4gMHLc0dwh3/7a/ooS0HQVxMrrNo6b/0L5fvHh
         k36LUGD6sL5rpFWCLVbCkOAaMmnBNkRZBy6+qsn3GBTWzEfFBQD3683Vfs/N6sMyoZ5W
         uJcw/q8MWT1gWEAYlUABRXO62VW/+7wwpxtxxRZETE2FPZT8Pb78uHJ0wdTTEo4pVAf3
         mAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UrrodMsqw5qaXZieFFAut0nBJMyeHj5kamInnvkT0Cg=;
        b=k1s8csK9/LwZCyzXU2Y7I90GJ1rMCSNiZupfZdoZgs9vi5sbYFv8MJMXgwFFUhD453
         FwrrUid9HbZFI1yC3Rdw/sAmTdU1mbA58NSWIeQc7nablfevR4yMlCkJBm9kOo2XUmvi
         GRQCVqlhsSnSwu+xQgiWMfdASGUiVlRIw/RJEiQ8Kvh4Vua/rNvagwTRtkhZj9t7613x
         K1TCDJqGGJOAfGgdb7lm2KrlK5LzIk2Pm2vsRewUKeR7lcSnXM8yTVHYAtjgIDCrgU30
         wbYPHPb2r+PRGOuTO5JFeLnfW7pYblXSk1YG8T5CTL83IUVhPREK/VYZG0R1HjfbFnYM
         /txw==
X-Gm-Message-State: AOAM5321Vq8gl60Grjr4DghXQkMaJI1Qu4HeKtDuuG8OBNCFVGTGaZ+x
        9El0PJrArA2ZIL0w7qnFLSI0P/WdOsEEL8/TVQSlRjzZbIg=
X-Google-Smtp-Source: ABdhPJwsSo9CYpxsWPwXr4EfDcnI9lzfdkbnmUApQn02xyuaIG0zmtvtsTEB/hk9TeSrmFBHO79z6butooSqYDBiy9c=
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr10534722edy.62.1633535936122;
 Wed, 06 Oct 2021 08:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <patch-1.2-e5ef1be2aa9-20211006T093405Z-avarab@gmail.com>
In-Reply-To: <patch-1.2-e5ef1be2aa9-20211006T093405Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 08:58:44 -0700
Message-ID: <CABPp-BH0ca=kx85kfqh7GGRqEzUpzd4dUr58M5WrUmYXQs0e4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] unpack-trees: don't leak memory in verify_clean_subdirectory()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 2:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Fix two different but related memory leaks in
> verify_clean_subdirectory(). We leaked both the "pathbuf" if
> read_directory() returned non-zero, and we never cleaned up our own
> "struct dir_struct" either.
>
>  * "pathbuf": When the read_directory() call followed by the
>    free(pathbuf) was added in c81935348be (Fix switching to a branch
>    with D/F when current branch has file D., 2007-03-15) we didn't
>    bother to free() before we called die().
>
>    But when this code was later libified in 203a2fe1170 (Allow callers
>    of unpack_trees() to handle failure, 2008-02-07) we started to leak
>    as we returned data to the caller. This fixes that memory leak,
>    which can be observed under SANITIZE=3Dleak with e.g. the
>    "t1001-read-tree-m-2way.sh" test.
>
>  * "struct dir_struct": We've leaked the dir_struct ever since this
>    code was added back in c81935348be.
>
>    When that commit was written there wasn't an equivalent of
>    dir_clear(). Since it was added in 270be816049 (dir.c: provide
>    clear_directory() for reclaiming dir_struct memory, 2013-01-06)
>    we've omitted freeing the memory allocated here.
>
>    This memory leak could also be observed under SANITIZE=3Dleak and the
>    "t1001-read-tree-m-2way.sh" test.
>
> This makes all the test in "t1001-read-tree-m-2way.sh" pass under
> "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue", we'd previously die in tests
> 25, 26 & 28.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t1001-read-tree-m-2way.sh | 2 ++
>  unpack-trees.c              | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> index 1057a96b249..d1115528cb9 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -20,6 +20,8 @@ In the test, these paths are used:
>         rezrov  - in H, deleted in M
>         yomin   - not in H or M
>  '
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-read-tree.sh
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index a7e1712d236..89ca95ce90b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2156,9 +2156,10 @@ static int verify_clean_subdirectory(const struct =
cache_entry *ce,
>         if (o->dir)
>                 d.exclude_per_dir =3D o->dir->exclude_per_dir;
>         i =3D read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
> +       dir_clear(&d);
> +       free(pathbuf);
>         if (i)
>                 return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->n=
ame);
> -       free(pathbuf);
>         return cnt;
>  }
>
> --
> 2.33.0.1441.gbbcdb4c3c66

Nicely explained; and nice clean patch.
