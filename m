Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36375C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FEA60F51
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhH3Ad7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhH3Ad6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:33:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C309C061756
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:33:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm15so19087844edb.10
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bs9Q7O14rAZAZQMDkzue9hS0i+X+jDJG+2r0yT8PQaI=;
        b=CRvu+45AorIHlWhiYEAQbZjhk0QXxC6w2r6lxmrB91uXi7GTeAQJsERKszXbHmwo+i
         nSNGfKQS6kLeF3FHmdDyV6T/4yO98fox3WYbsa9BzxEJTqAZB2QNzb9Gt5X+7COG1LbM
         QHV0sDunzLOm7ZhRYWZeQg/2/KGJrAbQQe/CQ4UGtxn5tBN5xGfrdcwoNxovwbomu0Mu
         NG0amL4HC6Fjh2UDl9TqFRXnJBxJWT0r8SH7Rfpaw4ftjvh2mkeUq4mluRqoxPI/B1m+
         RSVnSef3kEfvIHJaN57uKYYkPDIb2iiAlPubIlckvVANY5o0lTEQY0YtsjCbx0PmtSbp
         1YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bs9Q7O14rAZAZQMDkzue9hS0i+X+jDJG+2r0yT8PQaI=;
        b=qWtmBz8sarEhSr9LFfdUnJhMlbhcbGgXSprTgxk1dIeABI8wbBeRoUHVLWYpv8E74B
         j+eDwq0GVq9aU6xBawSP3PrNGF10CFkPNf5L7z5laA2Umd27334S1VvyyhsWP+uxXVBq
         JjUtVfNN4QAEb3U3L8gKjRpI0UYkdqkiCJE0Oxhtl+wOkdwuChSItX8LrnJ19RKkIWjS
         exauck+KFwN8Q8cT0/pZlAOGZ68H+fRso9Wz0W3SW5j/jMRC/lm6wNZD4uq8fRlPUdPD
         jw4ItPbEYOVOC5QfIdAMtblVcH6QTT+ZEDL4EAJLtyY7GwGXYc8Sv0Bbrs85wKOox6wh
         f9Lw==
X-Gm-Message-State: AOAM532EvjIYTrPlMDy+LDvSSPxOUxJ4QQlPcyto362aTJAb75mHIAIn
        i8ssxgza2kWjqyC49K+wxGXCqsIjnsE0zX8bRKY=
X-Google-Smtp-Source: ABdhPJz9JtAZ2rnpnTHIEiT0LbaQkR1NG0mHEMTv/bNqdjXIepXGU5aATvAn/amMqVopOCs8vCHYkPJt3u3qPt2kcKg=
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr21328950eds.380.1630283584557;
 Sun, 29 Aug 2021 17:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <176caa21-0232-9f21-7a8d-af136754e354@blotz.org> <YN0N6tUeSJM1EBHD@danh.dev>
In-Reply-To: <YN0N6tUeSJM1EBHD@danh.dev>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 29 Aug 2021 17:32:28 -0700
Message-ID: <CAJDDKr6Z9E6MbQReTXtF3k9V8YJ-mv9swgsazdD0eeAA35UY0A@mail.gmail.com>
Subject: Re: git difftool: No such file or directory
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Alan Blotz <work@blotz.org>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 5:38 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2021-06-30 11:38:21+0200, Alan Blotz <work@blotz.org> wrote:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > mkdir broken-diff
> > cd broken-diff
> > git init
> > mkdir dir1
> > mkdir dir2
> > touch dir1/orig
> > cd dir2/
> > ln -s ../dir1/orig sym
> > cd ..
> > git add dir*
> > git ci -m "init"
> > git checkout -b b
> > git rm dir2/sym
> > git ci -m "remove"
> > git difftool -d master HEAD
> >
> > What did you expect to happen? (Expected behavior)
> >
> > git difftool shall compare both branches.
> >
> > What happened instead? (Actual behavior)
> >
> > git difftool prints an error:
> >
> > fatal: could not open '/tmp/git-difftool.l4UM7e/left/dir2/sym' for writ=
ing: No such file or directory
>
> It looks like this behaviour was there from the time difftool was
> re-written in C in 03831ef7b5, (difftool: implement the functionality
> in the builtin, 2017-01-19). The perl version didn't have this
> problem.
>
> The perl version create a file in place of that symlink and write the
> symlink's target into that file. The C version tries to write (and
> follow?) the symlink.
>
> This hack can fix the problem but I'm not sure it's correct:
> ----8<---
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 2115e548a5..737ebb5b1a 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -492,12 +492,14 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
>                 if (*entry->left) {
>                         add_path(&ldir, ldir_len, entry->path);
>                         ensure_leading_directories(ldir.buf);
> -                       write_file(ldir.buf, "%s", entry->left);
> +                       unlink(ldir.buf);
> +                       write_file_buf(ldir.buf, entry->left, strlen(entr=
y->left));
>                 }
>                 if (*entry->right) {
>                         add_path(&rdir, rdir_len, entry->path);
>                         ensure_leading_directories(rdir.buf);
> -                       write_file(rdir.buf, "%s", entry->right);
> +                       unlink(rdir.buf);
> +                       write_file_buf(rdir.buf, entry->right, strlen(ent=
ry->right));
>                 }
>         }
> ---->8-----
>
> +Cc: Dscho, who wrote the C version.

Thank you for tracking this down!

I re-read the original perl version and this indeed looks like it
should do the trick since it's doing the same thing we did in perl.

I'm a little ashamed that we didn't have a test case to cover this use
case but the reproduction recipe you included looks like a great
start. We already have a few tests that use the SYMLINKS test prereq
so this would slot in well there.
--=20
David
