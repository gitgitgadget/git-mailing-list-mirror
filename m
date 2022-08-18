Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378EC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiHRHLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiHRHLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:11:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB9895C6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:11:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g21so517817qka.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yIMQUbULcTf0RsXIaMy00p/EyBB+v8KqBSo4jMkuNO8=;
        b=hWPKhKX0rgI7Pvzgj/z9EE3qZTUU0BFIVBnc2U3OJzlu8pM+9fO8V0q5H72cC4Q6my
         ywncbnXXf6vrAX8nhNHjk1BmTmoMNMkuK44dY1AjnIIZ8bCwDRMQeo0C/YeSQuCxqtNS
         u5ZIb9fpNhUn3kjgKMpaMrXpOTxzuDUuqpsI2UCPEHUf6JeEa8QSpwNrYPnKr8FDz1pP
         V0ETrw4oAr6HMGKQ0OGQAsmOOOqXjBLM6u072RxvtrwllsBfUW9UNkENUl5bwuhk0I2e
         fWVZV7aHiIcoHnzdSfKmJAPdkONhXqKBE/NP7L6JcqiPNFXKERGLMaumhGJfvsyHLXC6
         hAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yIMQUbULcTf0RsXIaMy00p/EyBB+v8KqBSo4jMkuNO8=;
        b=On66RVG9W0UAIEVB8dcBrCptuBJlfa4w7bI8akL+VlRQzBuun0+YimSmbMmf2a3qkY
         ega4QfZ2twrVjvXxEyl6tBH6KI30/Pmz4lStP2BvNCta2Z7j5ck83bwFkIq99J5l5AW6
         MQ2K/Lvmj+YGcmmOcIuotas2qgn0bCmn/Jg/8YkdkpQrHux12mtWxcDTJ0t7fMX6uOhc
         VQ7J7yQvc/fKelRWOi/OdBZgBa/9Lxm1C8dFAMSlsYe7iQm3LeEQ+pFc0MBwYLmp2HY8
         r/eR5Kf9kZc2GOu6GeYzh8aUnF4bDnZ08yYRTfeXEw21i40Y7XYYrYuPq4gzo8pE3RxT
         ciCA==
X-Gm-Message-State: ACgBeo3qxcl6qzNW4XBqDVsYRfhn+HaOgFIEWBvrHiTcbkhmptebHIxW
        D5jYLtq7ZBjvSG3u1dFNWGc+LEP4JU24iS2SSWU=
X-Google-Smtp-Source: AA6agR65KQBPILW3dRnaXhIq9ssbExW80Opf33lW61L51OvCFMCZcPpQOEz7/j3OpZ/TCAhdstipz/lcw61JvvDwgAg=
X-Received: by 2002:a05:620a:444b:b0:6bb:238a:2454 with SMTP id
 w11-20020a05620a444b00b006bb238a2454mr1113273qkp.183.1660806676377; Thu, 18
 Aug 2022 00:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com> <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 00:11:05 -0700
Message-ID: <CABPp-BGdaG99S9oyeSYD9NMa1sq_8zHnnh7hvCRp5v=8myP46g@mail.gmail.com>
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2022 at 8:14 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Separate out calculating the merge base between onto and head from the
> check for whether we can fast-forward or not. This means we can skip
> the fast-forward checks when the rebase is forced and avoid
> calculating the merge-base twice when --keep-base is given.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Note the unnecessary braces around "if (keep_base)" are added here
> reduce the churn on the next commit.
> ---
>  builtin/rebase.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6cf9c95f4e1..86ea731ca3a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>         struct commit_list *merge_bases = NULL;
>         int res = 0;
>
> -       merge_bases = get_merge_bases(onto, head);
> -       if (!merge_bases || merge_bases->next) {
> -               oidcpy(merge_base, null_oid());
> +       if (is_null_oid(merge_base))
>                 goto done;
> -       }
>
> -       oidcpy(merge_base, &merge_bases->item->object.oid);
>         if (!oideq(merge_base, &onto->object.oid))
>                 goto done;
>
> @@ -902,6 +898,20 @@ done:
>         return res && is_linear_history(onto, head);
>  }
>
> +static void fill_merge_base(struct rebase_options *options,
> +                           struct object_id *merge_base)
> +{
> +       struct commit_list *merge_bases = NULL;
> +
> +       merge_bases = get_merge_bases(options->onto, options->orig_head);
> +       if (!merge_bases || merge_bases->next)
> +               oidcpy(merge_base, null_oid());
> +       else
> +               oidcpy(merge_base, &merge_bases->item->object.oid);
> +
> +       free_commit_list(merge_bases);
> +}
> +
>  static int parse_opt_am(const struct option *opt, const char *arg, int unset)
>  {
>         struct rebase_options *opts = opt->value;
> @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                         die(_("Does not point to a valid commit '%s'"),
>                                 options.onto_name);
>         }
> -
> +       if (keep_base) {
> +               oidcpy(&merge_base, &options.onto->object.oid);
> +       } else {
> +               fill_merge_base(&options, &merge_base);
> +       }
>         if (options.fork_point > 0)
>                 options.restrict_revision =
>                         get_fork_point(options.upstream_name, options.orig_head);
> @@ -1697,13 +1711,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>          * Check if we are already based on onto with linear history,
>          * in which case we could fast-forward without replacing the commits
>          * with new commits recreated by replaying their changes.
> -        *
> -        * Note that can_fast_forward() initializes merge_base, so we have to
> -        * call it before checking allow_preemptive_ff.
>          */
> -       if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
> -                   options.orig_head, &merge_base) &&
> -           allow_preemptive_ff) {
> +       if (allow_preemptive_ff &&
> +           can_fast_forward(options.onto, options.upstream, options.restrict_revision,
> +                            options.orig_head, &merge_base)) {

I didn't catch anything new in my review of this patch, but I just
really wanted to say how happy this final hunk makes me.  I hated that
can_fast_forward() had to be called first; thanks for fixing that.


>                 int flag;
>
>                 if (!(options.flags & REBASE_FORCE)) {
> --
> gitgitgadget
