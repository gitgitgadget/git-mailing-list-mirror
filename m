Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6981FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbdC1SXX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:23:23 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36668 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754891AbdC1SXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:23:22 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so79501858pge.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ft2NZRZCf5YZt0wLz3lVIbUvgHUIu3JB/exdG2SjvPk=;
        b=bUK5KeD2YJxrEAvv5mqNwluDkxWfGgLC8f1106D/442IyswfK6mjrZgeWcx+RdCFh/
         l+LUfKp63PRQYWQrQINK4DNDcJAj2LlbAN6eh1vlslNXTCyeyzHjqNVW43em4Ab8xqDR
         BQwAtLdCMDYazRn60zcVQnuoSEcAhr992YnZMK7eODBmgmm/RXaawdO/WUmz/nvlDuQJ
         B8pUUU1qN6g32qr/1XFkI1XyCU8bQDf03y7FpjBvxWhoDZX8Ib7/Hqrc3ZjaYk0JWdmL
         F2kMwjjc4beZ++OUinYGaAl/r92YDntbMidMSG3D6p7tXKCZ0roIaG6nF+kTz9Gima21
         NefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ft2NZRZCf5YZt0wLz3lVIbUvgHUIu3JB/exdG2SjvPk=;
        b=SfeHsfHmE1zAr3WPmJ7IvaWoKisUDgI+HPonEYVZhWLipldObjace/soignGFVhdda
         ZY/HTG291vruUpNcv7+SLjJso952qET46NaYzx7/fJljVLuu3eyKhxC8o9XUDfuHw5sV
         HjfZpFmaOOKLpi7i3LZ+LAj29uAa6z7sg45hdUsZFxJDberaNbkUAmtThuvN0Zt0tASn
         MgW5EOmlSrZoJH3jWMedIxwEhW/QaSUiCTCrn6CgXUEYS2Pi3DfEZxQ7fSx+d9r5sCtY
         bkNB4/9DR+ERm7sVem+52Ii+mVj0v6zMW4pFPzdzyyKz5/mz8YRVU/iIdUv52NR797NL
         RLKQ==
X-Gm-Message-State: AFeK/H1Z/0uXYhmr6QGGYtnY7RGKnvL9Fr0qu9dV7v/eriU1/CnkVNMI46whslV0oxHRyCOl9vlnPLjQaqfP+XTU
X-Received: by 10.84.231.196 with SMTP id g4mr22092114pln.12.1490725395818;
 Tue, 28 Mar 2017 11:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 11:23:15 -0700 (PDT)
In-Reply-To: <1490665185-11809-1-git-send-email-robert.stanca7@gmail.com>
References: <1490665185-11809-1-git-send-email-robert.stanca7@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 11:23:15 -0700
Message-ID: <CAGZ79kbtXEBKBaw75-tLay4LO1F3i3nDz6CU8FgTkJ7iwEY5QQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] get_non_kept_pack_filenames(): reimplement using iterators
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 6:39 PM, Robert Stanca <robert.stanca7@gmail.com> wrote:
> Replaces recursive traversing of opendir with dir_iterator.
>
> Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
> ---
>  builtin/repack.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 677bc7c..27a5597 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -7,6 +7,8 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "argv-array.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>
>  static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
> @@ -86,26 +88,21 @@ static void remove_pack_on_signal(int signo)
>   */
>  static void get_non_kept_pack_filenames(struct string_list *fname_list)
>  {
> -       DIR *dir;
> -       struct dirent *e;
> +       struct dir_iterator *diter = dir_iterator_begin(packdir);
>         char *fname;
>
> -       if (!(dir = opendir(packdir)))
> -               return;
> -
> -       while ((e = readdir(dir)) != NULL) {
> +       while (dir_iterator_advance(diter) == ITER_OK) {
>                 size_t len;
> -               if (!strip_suffix(e->d_name, ".pack", &len))
> +               if (!strip_suffix(diter->relative_path, ".pack", &len))
>                         continue;
>
> -               fname = xmemdupz(e->d_name, len);
> +               fname = xmemdupz(diter->relative_path, len);
>
>                 if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
>                         string_list_append_nodup(fname_list, fname);
>                 else
>                         free(fname);
>         }
> -       closedir(dir);
>  }
>
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
> --
> 2.7.4
>
>
>
>
> Hi , this is my first patch submission for Git Gsoc. I ran full tests and local tests with
> prove --timer --jobs 15 ./t*pack*.sh .
>
> Have a great day,
>              Robert.

Hi and welcome to the Git community!

The patch looks like a faithful conversion with no side effects to me.
Reviewed-by: Stefan Beller <sbeller@google.com>

Note: mail readers usually collapse long signatures (e.g. everything
after "--\n2.7.4"  in this email. So I did not know or even read your
comments on how you tested this patch before hitting reply.
You can also put these lines after the "---" after the sign off,
right before the diff stat.  A good example is
https://public-inbox.org/git/20170324231013.23346-1-avarab@gmail.com/
as the patch is also long enough, such that people may not scroll to the
bottom.  Once you're used to it, it is very easy to spot the chatter
that will not be part of the commit message, though.

Thanks,
Stefan
