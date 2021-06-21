Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD71A60230
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFUUg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:36:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF023C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:34:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id d19so21306141oic.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKRYa42lWh6D2HY6qJdPrU5s5Xsb++lsk5yrPiaWLgo=;
        b=Yev0gCPjjgJfD06JFEIDFin9lWoKOiQgs7n1cU9z7RzlrHgCWUThEUE17ZiOKcrVDG
         4Kw96qzYuvTRafBWr0SnoisyfE+6vCiFJAMPLCPBsRmC8EmXFPYpmuB1UuGU8OwWHSJM
         MZ7l/KJetAgtnBEuSberEYKtoMwK/50IszTAOrD1/z6VK4GkWdNz4dzZzF5egPix01qE
         hSA9mi90suRt7zRmv5KXxAmLjXc+4ZyayXEC8Khi3vCUxfzLBbN5iKEk5AxzmhGH5MOi
         swbN/iRsoxTYR4dbDHGIvd7LKyNfk9Jdp4NPAVKflHjSt6uD5CUMRuBZsioqHQjP7tWY
         Ruwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKRYa42lWh6D2HY6qJdPrU5s5Xsb++lsk5yrPiaWLgo=;
        b=OfyfxHv4xInh/RkQPyHc+uty+S1/ujkCSdVulO9w5bjvxr5tZNOhxp3A20M0w7k1EA
         brtfw0mY+ws10fdV1VibzSXpBeS1rJsGHHG77Xabs/Z6JK7ZSGdryat+1rTsUAxijUfk
         X0NteL/Ria50HUanXyKSupQgV+DJZIFfWBj0xMqSu62Xpl2M7EIRcgHjPa/a8H8nBYl0
         Ys21gQURoXo43ClowmygaWohpfN8A/wCxIiysGllTp++UgVKi9CUZLf594k3USjc8WLF
         ZajGwnH/hs0LIOqKAEYaFVjyjZbBBE0KIwv4SVfl8qyXy1UmewyFobjFspvacBwtxqxl
         uVxw==
X-Gm-Message-State: AOAM531LuM+yJLoWsbQy70buov/lejvNoo6ZRLgEF5BtUhncsQ3Qeerr
        jcxPnOWmd3eIOC0adZmaMiCJgns4/dONBLYrQ2oZyAX4deg=
X-Google-Smtp-Source: ABdhPJxJ9sAdmE+JmwrgQ3MgwKMnvGC0WoDLgRtk64d5fIpae/cZEMTDU7EWriRt2n4SgdTvQ09A02EXHDSBZ5C1b50=
X-Received: by 2002:aca:f482:: with SMTP id s124mr182864oih.167.1624307681263;
 Mon, 21 Jun 2021 13:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-2-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-2-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 13:34:30 -0700
Message-ID: <CABPp-BH_35UkaXhaBeo_SVPcyRk=OuENpGr+L3Jkycz6RNh1LQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] fmt-merge-msg: free newly allocated temporary
 strings when done
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> origin starts off pointing to somewhere within line, which is owned by
> the caller. Later we might allocate a new string using xmemdupz() or
> xstrfmt(). To avoid leaking these new strings, we introduce a to_free
> pointer - which allows us to safely free the newly allocated string when
> we're done (we cannot just free origin directly as it might still be
> pointing to line).
>
> LSAN output from t0090:
>
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>     #1 0xa71f49 in do_xmalloc wrapper.c:41:8
>     #2 0xa720b0 in do_xmallocz wrapper.c:75:8
>     #3 0xa720b0 in xmallocz wrapper.c:83:9
>     #4 0xa720b0 in xmemdupz wrapper.c:99:16
>     #5 0x8092ba in handle_line fmt-merge-msg.c:187:23
>     #6 0x8092ba in fmt_merge_msg fmt-merge-msg.c:666:7
>     #7 0x5ce2e6 in prepare_merge_message builtin/merge.c:1119:2
>     #8 0x5ce2e6 in collect_parents builtin/merge.c:1215:3
>     #9 0x5c9c1e in cmd_merge builtin/merge.c:1454:16
>     #10 0x4ce83e in run_builtin git.c:475:11
>     #11 0x4ccafe in handle_builtin git.c:729:3
>     #12 0x4cb01c in run_argv git.c:818:4
>     #13 0x4cb01c in cmd_main git.c:949:19
>     #14 0x6b3fad in main common-main.c:52:11
>     #15 0x7fb929620349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 8 byte(s) leaked in 1 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  fmt-merge-msg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 0f66818e0f..b969dc6ebb 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -105,90 +105,92 @@ static void add_merge_parent(struct merge_parents *table,
>  static int handle_line(char *line, struct merge_parents *merge_parents)
>  {
>         int i, len = strlen(line);
>         struct origin_data *origin_data;
>         char *src;
>         const char *origin, *tag_name;
> +       char *to_free = NULL;
>         struct src_data *src_data;
>         struct string_list_item *item;
>         int pulling_head = 0;
>         struct object_id oid;
>         const unsigned hexsz = the_hash_algo->hexsz;
>
>         if (len < hexsz + 3 || line[hexsz] != '\t')
>                 return 1;
>
>         if (starts_with(line + hexsz + 1, "not-for-merge"))
>                 return 0;
>
>         if (line[hexsz + 1] != '\t')
>                 return 2;
>
>         i = get_oid_hex(line, &oid);
>         if (i)
>                 return 3;
>
>         if (!find_merge_parent(merge_parents, &oid, NULL))
>                 return 0; /* subsumed by other parents */
>
>         CALLOC_ARRAY(origin_data, 1);
>         oidcpy(&origin_data->oid, &oid);
>
>         if (line[len - 1] == '\n')
>                 line[len - 1] = 0;
>         line += hexsz + 2;
>
>         /*
>          * At this point, line points at the beginning of comment e.g.
>          * "branch 'frotz' of git://that/repository.git".
>          * Find the repository name and point it with src.
>          */
>         src = strstr(line, " of ");
>         if (src) {
>                 *src = 0;
>                 src += 4;
>                 pulling_head = 0;
>         } else {
>                 src = line;
>                 pulling_head = 1;
>         }
>
>         item = unsorted_string_list_lookup(&srcs, src);
>         if (!item) {
>                 item = string_list_append(&srcs, src);
>                 item->util = xcalloc(1, sizeof(struct src_data));
>                 init_src_data(item->util);
>         }
>         src_data = item->util;
>
>         if (pulling_head) {
>                 origin = src;
>                 src_data->head_status |= 1;
>         } else if (skip_prefix(line, "branch ", &origin)) {
>                 origin_data->is_local_branch = 1;
>                 string_list_append(&src_data->branch, origin);
>                 src_data->head_status |= 2;
>         } else if (skip_prefix(line, "tag ", &tag_name)) {
>                 origin = line;
>                 string_list_append(&src_data->tag, tag_name);
>                 src_data->head_status |= 2;
>         } else if (skip_prefix(line, "remote-tracking branch ", &origin)) {
>                 string_list_append(&src_data->r_branch, origin);
>                 src_data->head_status |= 2;
>         } else {
>                 origin = src;
>                 string_list_append(&src_data->generic, line);
>                 src_data->head_status |= 2;
>         }
>
>         if (!strcmp(".", src) || !strcmp(src, origin)) {
>                 int len = strlen(origin);
>                 if (origin[0] == '\'' && origin[len - 1] == '\'')
> -                       origin = xmemdupz(origin + 1, len - 2);
> +                       origin = to_free = xmemdupz(origin + 1, len - 2);
>         } else
> -               origin = xstrfmt("%s of %s", origin, src);
> +               origin = to_free = xstrfmt("%s of %s", origin, src);
>         if (strcmp(".", src))
>                 origin_data->is_local_branch = 0;
>         string_list_append(&origins, origin)->util = origin_data;
> +       free(to_free);
>         return 0;
>  }
>
> --
> 2.26.2

Makes sense.  The extended diff context makes this patch easier to
read and verify too; thanks.
