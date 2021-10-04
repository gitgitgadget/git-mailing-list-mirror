Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863EFC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7086561213
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhJDN4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbhJDN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA854C0617A6
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id on6so718833pjb.5
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8XAk0Ld+F/Ebelgex5XV0/Bea/T5sxe7HoNOlVgr0I=;
        b=AAPkHyHnoVrEhqqBgoecosHuyazplXqGx7+eyT4RbuvJmrtCmLAbOBaX0q2iB5TgJr
         99ndTroVUd2sJMXbia1wUT1VJTr2AiOMF99rhLDqyyYTbgNIOVWqm9h4ywcBMFpGBdE0
         4jms5WZoXA+6bt5jK29sK7LrPGZcyYNy0g/uiD607NDQ5GbRNdw3ryLHzzGO+yydHfXo
         5hOOGPeor4NlvsV4S51Slzl2RU9D3B27KFnVvFSSlPmqsyd8XlQ69SGgW42/sFYiQXXC
         elZDRCNN3YWjI/OfyIxFBUEsVibnWtwUfs8ailxnZr1ldReeO5MMqJ955VdJnb6Miz+q
         vUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8XAk0Ld+F/Ebelgex5XV0/Bea/T5sxe7HoNOlVgr0I=;
        b=VhbcPirkzRiI/1RNgFQD8QA+CcQw17X1wt3fsvkzCu6sBV4h4Vmb+H4E7ovMFhPjiM
         bVrGOFKx9gv9+2IjJy/Yg9N7FxBOGrCpQxMxqjd/KdZEolhuq+YxJtliP2WM54Z1uf/B
         9HXYEiI8ykArUUP47Uf1dFURxGXoJxDwtXJtyDOphWElHm1lgQq73vEfkYYYtVuHDW44
         8RV/iSJQceeNKDz9sg4fdFFdAQQHP3dREbXfQNAfeOYP3s/+IFcJYJvoWCMVqI0A2fMu
         QCPy3cIxmdtLSibjSwNU14lzKnPguw1Py++1YbyhGN88a4Q1FMNX5139Mbp98GuaZIyB
         DUmA==
X-Gm-Message-State: AOAM532wgFBUPWKbMklN7MyjowyKdfsQrmWi2mE5QQ/pqksV1aPt4Owr
        9oA8Y5PU3ea01X7V76+EN8UuqqY+ykIWyRQQYpB8gP0+QkA=
X-Google-Smtp-Source: ABdhPJwB+5YxSbea5f2L17u4O9ZT6C0tWFWuRlrAljiyj0TNjkcxB4KD7Ct9dRmIy3QDx1aXh6RM4GfwO9u25D4wk7U=
X-Received: by 2002:a17:90b:1258:: with SMTP id gx24mr10424287pjb.78.1633355123170;
 Mon, 04 Oct 2021 06:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-08.10-32acc5e5c9e-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-08.10-32acc5e5c9e-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BE=gnjQ1=Z1KwM5+QqMDMTgJ7aPd=cv1VTy3GkpOL+vPQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] unpack-trees: don't leak memory in verify_clean_subdirectory()
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

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
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
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  unpack-trees.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index bea598c9ece..260e7ec5bb4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2138,9 +2138,10 @@ static int verify_clean_subdirectory(const struct =
cache_entry *ce,
>
>         d.exclude_per_dir =3D o->dir.exclude_per_dir;
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
> 2.33.0.1404.g83021034c5d

Good catches, and nicely explained.
