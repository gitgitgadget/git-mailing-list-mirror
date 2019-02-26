Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703B720248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfBZMcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:32:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52746 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfBZMcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:32:33 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so3549287itc.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kd27XxUG0Rd+BUmrmVlL3jarLX+mg7BwAQtmt4wMWfo=;
        b=nG3lSb45ZVPamsq9YwlYKKFc+SF/SHOiZ7xoXXmg+gnTReP9BwGDIzcXY73cp9R6a4
         zyzLo+eN2fKZMvQfSlozaGHtiXTgSLICW4lKW+R9TlndRxdUcamChMfY+zKLqEUdi8Qb
         PbhCuQy1SC9/TbYnpDFs9yQMfnmY98cJFaHJpvb0oRNnqFuX9kly3pFmWxJ/fHRLdJF7
         G3EyUp/B9uyQdItMcII2ACgWV0a1YdErMUTFJiYvryTB+V0VwFb5xKcnawnAShck2qkf
         CAadEolsJONi5ilNHTwkdlZxmBB4SBuJH00CUAf4l5zXtE8jLYnPvkeV6K5DMZ9EpUo1
         mrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kd27XxUG0Rd+BUmrmVlL3jarLX+mg7BwAQtmt4wMWfo=;
        b=AwVvt+jpq5U6EcAgXQQPMAbgoOSfdTtHdHjSp5a5f7vZZqGXi2HNyR0gVfB8NuFznj
         KDdNKHMbwhdUUxbu8EE+BQMsINzdZYxv1hjiSgtXtoyQn62CZ/Lf0Z0Y8ESt9ak15sjp
         UGgqqdgfEQU//TgvlaIYDipmjZv4tDh5xDgtjH/uDqjcQDrY0pi2ImgpHmYfMqC/QITb
         3KsOiAG0Bbt/lT/aj72cosPF8vMQ9Qj1P1STxzpLXFC9D9PuirYh2Lhnvxmm/EICArl8
         Tk4xd7tdRFd19hglNFP0rjAte4RYnhlUMycgv65Xo71KqZ1/J/dr6DSkZDcxd8x3zrQh
         pwOQ==
X-Gm-Message-State: AHQUAuZD4RQ+G9vN7Q9FWlhZcDSQIG6sA0Vpy+ZEHhQknp8wa7JTMe1K
        1R803lB7HKdWnS2VflTlEVzXoc7lFGAXoSiXh8I=
X-Google-Smtp-Source: AHgI3IadZpWSkHxqrN9Z/CygnrV/tvYwjanZdxvkxk/I0up8Ur1CZCyZLRAHhGqR803Zu/pO8SZMht0TA5H+WOBJt5c=
X-Received: by 2002:a02:7e87:: with SMTP id g7mr12307739jae.92.1551184351590;
 Tue, 26 Feb 2019 04:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-6-matheus.bernardino@usp.br>
In-Reply-To: <20190226051804.10631-6-matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 19:32:05 +0700
Message-ID: <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit
 dir traversal
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API. This simplifies the code and avoid recursive calls to
> copy_or_link_directory.
>
> This process also makes copy_or_link_directory call die() in case of an
> error on readdir or stat, inside dir_iterator_advance. Previously it
> would just print a warning for errors on stat and ignore errors on
> readdir, which isn't nice because a local git clone would end up
> successfully even though the .git/objects copy didn't fully succeeded.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> I can also make the change described in the last paragraph in a separate
> patch before this one, but I would have to undo it in this patch because
> dir-iterator already implements it. So, IMHO, it would be just noise
> and not worthy.
>
>  builtin/clone.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fd580fa98d..b23ba64c94 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -23,6 +23,8 @@
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
> +#include "dir-iterator.h"
> +#include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
>  #include "remote.h"
> @@ -411,42 +413,37 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
>  }
>
>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> -                                  const char *src_repo, int src_baselen)
> +                                  const char *src_repo)
>  {
> -       struct dirent *de;
> -       struct stat buf;
>         int src_len, dest_len;
> -       DIR *dir;
> -
> -       dir = opendir(src->buf);
> -       if (!dir)
> -               die_errno(_("failed to open '%s'"), src->buf);
> +       struct dir_iterator *iter;
> +       int iter_status;
> +       struct stat st;
> +       unsigned flags;
>
>         mkdir_if_missing(dest->buf, 0777);
>
> +       flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
> +       iter = dir_iterator_begin(src->buf, flags);
> +
>         strbuf_addch(src, '/');
>         src_len = src->len;
>         strbuf_addch(dest, '/');
>         dest_len = dest->len;
>
> -       while ((de = readdir(dir)) != NULL) {
> +       while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
>                 strbuf_setlen(src, src_len);
> -               strbuf_addstr(src, de->d_name);
> +               strbuf_addstr(src, iter->relative_path);
>                 strbuf_setlen(dest, dest_len);
> -               strbuf_addstr(dest, de->d_name);
> -               if (stat(src->buf, &buf)) {
> -                       warning (_("failed to stat %s\n"), src->buf);
> -                       continue;
> -               }
> -               if (S_ISDIR(buf.st_mode)) {
> -                       if (!is_dot_or_dotdot(de->d_name))
> -                               copy_or_link_directory(src, dest,
> -                                                      src_repo, src_baselen);
> +               strbuf_addstr(dest, iter->relative_path);
> +
> +               if (S_ISDIR(iter->st.st_mode)) {
> +                       mkdir_if_missing(dest->buf, 0777);

I wonder if this mkdir_if_missing is sufficient. What if you have to
create multiple directories?

Let's say the first advance, we hit "a". The the second advance we hit
directory "b/b/b/b", we would need to mkdir recursively and something
like safe_create_leading_directories() would be a better fit.

I'm not sure if it can happen though. I haven't re-read dir-iterator
code carefully.

>                         continue;
>                 }
>
>                 /* Files that cannot be copied bit-for-bit... */
> -               if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> +               if (!strcmp(iter->relative_path, "info/alternates")) {

While we're here, this should be fspathcmp to be friendlier to
case-insensitive filesystems. You probably should fix it in a separate
patch though.

>                         copy_alternates(src, dest, src_repo);
>                         continue;
>                 }
> @@ -463,7 +460,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>                 if (copy_file_with_time(dest->buf, src->buf, 0666))
>                         die_errno(_("failed to copy file to '%s'"), dest->buf);
>         }
> -       closedir(dir);
> +
> +       if (iter_status != ITER_DONE) {
> +               strbuf_setlen(src, src_len);
> +               die(_("failed to iterate over '%s'"), src->buf);
> +       }

I think you need to abort the iterator even when it returns ITER_DONE.
At least that's how the first caller in files-backend.c does it.

>  }
>
>  static void clone_local(const char *src_repo, const char *dest_repo)
> @@ -481,7 +482,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>                 get_common_dir(&dest, dest_repo);
>                 strbuf_addstr(&src, "/objects");
>                 strbuf_addstr(&dest, "/objects");
> -               copy_or_link_directory(&src, &dest, src_repo, src.len);
> +               copy_or_link_directory(&src, &dest, src_repo);
>                 strbuf_release(&src);
>                 strbuf_release(&dest);
>         }
> --
> 2.20.1
>


-- 
Duy
