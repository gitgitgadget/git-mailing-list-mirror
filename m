Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C91C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E7420B80
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgLCFxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgLCFxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 00:53:33 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401EC061A4F
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 21:52:47 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z24so730378oto.6
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 21:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1JyhKYw/tYzwv+xvUH1CgPKtzThUx/orT+PiF/IArU=;
        b=Z1H8GlYJ7gWy3Z3epkku1MqgNKmpeO7aC7ABuLO20qR7K7BaJUlA+m+1KjWPHFwhSH
         ti9VJLEjwzrYxYZo5iGjRT7Hi/xBZSIxp+gnIIY9THIRQQAjHlHvSLc53Q7/Q2tmf6N0
         8m9SePCsBPSu8qnk1LJfeB8jkb/UNtuDW+szhhJAGbWuSh2Gs7uSnKnttJDVKTL7qpKZ
         o5msatklH/sCXTD6BKX3QY1ttBQ3wnkkkhqXp9rf3yyqLuqv2ai0dB8bPjK61NQGzaHT
         GCG2/9hQK6nB1FcQennsS73fnD0r5bXJTVuZcVGHHEPdieOUMMnsjxuVCw0DQDH8YrOW
         ADng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1JyhKYw/tYzwv+xvUH1CgPKtzThUx/orT+PiF/IArU=;
        b=kaL14P20bZAgBCU2AHVM5Og8yjWQH7ombDDkDuOwlgh7EQ1L9HRp7FMFdSxo1q0BzA
         +VMVzKvGMwvMuLLZT7PunvqJDrLqyCUBL9K59xcA2HMS+9YdpyaOll+Cu4OkqfGIgZnD
         atajkYYvkWvtj+6f4eIQ1A2R5gc5HjvC0kmQmRs8JLAVOni+aKGcrkfFscuJF5hGX3QT
         vePuijUdHOmDLxnRRddoqgvWLe5r8w1Ib4gS4T8VozMivDp8VdNoCmqhCsmO6iVpDcU0
         RiGhIOi2Q1iS3GBIY4fReQ//LlBJMEn2zCq9KH/9xvgb3bQnJ8brVO5XYsYXMCKG5Vj8
         Okxg==
X-Gm-Message-State: AOAM531dC6byTgaAtSH/AG+h7Ifm6W3LeYjq1kmixzSRL8jBGNPK/BRb
        vu/f3q8Auz0t4XMCSqPGesV5SXDmKMESxc1Z1T8=
X-Google-Smtp-Source: ABdhPJwQGpphKFu8Vg7QYrXirW1kmYeJ+iRHKBd05YmRhH9pDLVMeAMiO2Q1zHfmmkUc8fpmOBX6f2aqZOEzEUV1oCE=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr1033292otp.316.1606974767066;
 Wed, 02 Dec 2020 21:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201101193330.24775-11-sorganov@gmail.com>
In-Reply-To: <20201101193330.24775-11-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Dec 2020 21:52:36 -0800
Message-ID: <CABPp-BGH0+M_6gYYfYsp54X9DjKM4mv8Vssoo3uZtDAY1_Zb1A@mail.gmail.com>
Subject: Re: [PATCH 10/26] diff-merges: new function diff_merges_suppress()
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 1, 2020 at 11:36 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> This function sets all the relevant flags to disabled state, so that
> no code that checks only one of them get it wrong.
>
> Then we call this new function everywhere where diff merges output
> suppression is needed.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/merge.c |  3 ++-
>  diff-merges.c   | 18 ++++++++++++++----
>  diff-merges.h   |  2 ++
>  fmt-merge-msg.c |  3 ++-
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 9d5359edc2f7..1f7b69982b40 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -14,6 +14,7 @@
>  #include "lockfile.h"
>  #include "run-command.h"
>  #include "diff.h"
> +#include "diff-merges.h"
>  #include "refs.h"
>  #include "refspec.h"
>  #include "commit.h"
> @@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>         printf(_("Squash commit -- not updating HEAD\n"));
>
>         repo_init_revisions(the_repository, &rev, NULL);
> -       rev.ignore_merges = 1;
> +       diff_merges_suppress(&rev);
>         rev.commit_format = CMIT_FMT_MEDIUM;
>
>         commit->object.flags |= UNINTERESTING;
> diff --git a/diff-merges.c b/diff-merges.c
> index 8536941e0b56..25bd9b12e667 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -2,6 +2,13 @@
>
>  #include "revision.h"
>
> +static void suppress(struct rev_info *revs) {
> +       revs->ignore_merges = 1;
> +       revs->first_parent_merges = 0;
> +       revs->combine_merges = 0;
> +       revs->dense_combined_merges = 0;
> +}

The function name is not so helpful; why not put all this code
directly in diff_merges_suppress()?

> +
>  /*
>   * Public functions. They are in the order they are called.
>   */
> @@ -29,16 +36,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>                 revs->combine_merges = 1;
>         } else if (!strcmp(arg, "--cc")) {
>                 revs->diff = 1;
> -               revs->dense_combined_merges = 1;
> -               revs->combine_merges = 1;
> +               set_dense_combined(revs);
>         } else if (!strcmp(arg, "--no-diff-merges")) {
> -               revs->ignore_merges = 1;
> +               suppress(revs);
>         } else if (!strcmp(arg, "--combined-all-paths")) {
>                 revs->diff = 1;
>                 revs->combined_all_paths = 1;
>         } else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>                 if (!strcmp(optarg, "off")) {
> -                       revs->ignore_merges = 1;
> +                       suppress(revs);
>                 } else {
>                         die(_("unknown value for --diff-merges: %s"), optarg);
>                 }
> @@ -48,6 +54,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>         return 1;
>  }
>
> +void diff_merges_suppress(struct rev_info *revs) {
> +       suppress(revs);
> +}

...especially since all this function does is call suppress()?


> +
>  void diff_merges_default_to_first_parent(struct rev_info *revs) {
>         if (revs->ignore_merges < 0)            /* No -m */
>                 revs->ignore_merges = 0;
> diff --git a/diff-merges.h b/diff-merges.h
> index 4b023c385d00..32720bc9b40f 100644
> --- a/diff-merges.h
> +++ b/diff-merges.h
> @@ -7,6 +7,8 @@ void diff_merges_init_revs(struct rev_info *revs);
>
>  int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
>
> +void diff_merges_suppress(struct rev_info *revs);
> +
>  void diff_merges_default_to_first_parent(struct rev_info *revs);
>
>  void diff_merges_default_to_dense_combined(struct rev_info *revs);
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index bd22e1ea8865..abc3403fb820 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -2,6 +2,7 @@
>  #include "refs.h"
>  #include "object-store.h"
>  #include "diff.h"
> +#include "diff-merges.h"
>  #include "revision.h"
>  #include "tag.h"
>  #include "string-list.h"
> @@ -668,7 +669,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
>                 head = lookup_commit_or_die(&head_oid, "HEAD");
>                 repo_init_revisions(the_repository, &rev, NULL);
>                 rev.commit_format = CMIT_FMT_ONELINE;
> -               rev.ignore_merges = 1;
> +               diff_merges_suppress(&rev);
>                 rev.limited = 1;
>
>                 strbuf_complete_line(out);
> --
> 2.25.1
>
