Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B17C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC67206E9
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyfDSp8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCMRad (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:30:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45757 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMRad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:30:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id e18so11419754ljn.12
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=R7MGmWFPaoj/bPR7zj6/h9M+g/TfgcClM0lt38r4u2w=;
        b=WyfDSp8cKynO7uOJOIGqS83lr3uTbNN0rgtdNqBOl6e29J7XInWsvGPUKVCFkMVUgj
         Cuuu+XN1m7OiOItUVW5ZnAwoef9pO7mGd7hbtTtgID8GEgpGkFG5PgJbRIC+ahihbS48
         TIhKfzmCZdLpZHlZX6lu+WKoRR3JAZsAyfXHfoIC09Me/XswHPN6OBY0a7LM41DlZmX2
         +9fOVS7pbHI/TsB8Hv5KgHE1amIl2M6n63On0rSg49EKO0F2b+ef/SURi5YwnhTKnXCi
         7warvTnXRR3r4se0HdWCHMleronZkuSuXi5/3uaTxzCHab4Y3ciChFqZrvs9zTUZ2K4M
         QZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=R7MGmWFPaoj/bPR7zj6/h9M+g/TfgcClM0lt38r4u2w=;
        b=BDWgGHX/kTAZRrsUs28CZcVdTNfhA/j9x0wnTInNSg3go1d33WssVpGngMKzjxQgk2
         nZmKymLF4B5xcZX2jlqrwn4EiOX99AHGiQM8DOnMscc2qIa6ZBZlKi1JB7slIin9lgm0
         311615AR2zqa+nGTZ4WVLQKOqhD1vwNBzJWPQ/ZPrlejbsV7RefRi2onaZ4oX2qRwQeB
         VmwuB9Qpos9k1z/bpip840l7hOp3uReZZS7u0rounZQZhBirkQ3j2tzFJhWshWRTsuKZ
         6FGp7DcjoJGDXziy0pa5EQCTbS3lb6XIZGtHBFhHIzUJwHsuBvxxvE+g9GJKCAxaYuUT
         GQFw==
X-Gm-Message-State: ANhLgQ0nb+YSZ33IJ9avE+mIoZ8aYcOdGRRzJ5Gg4rK9kR9bah/V//3j
        BVAJ1F/8qIn8WZPCJZ0lzZ27m9KKv0ELHc84cZpJgLq8
X-Google-Smtp-Source: ADFU+vt82gALVyI8EeMuB+V59gMsGex4/GYog8CRPbgA5RkB2uzs/ZuYOK8rt4HXqzy2kaxa/Djrq4MH5c3kDDWz77k=
X-Received: by 2002:a2e:88d9:: with SMTP id a25mr8226610ljk.267.1584120631441;
 Fri, 13 Mar 2020 10:30:31 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Fri, 13 Mar 2020 23:00:00 +0530
Message-ID: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
To:     erlend-a@innova.no
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If rev-parse is called with both -q and an --is-* option, the result is
> provided as the return code of the command, iso. printed to stdout.
>
> This simplifies using these queries in shell scripts:
> git rev-parse --is-bare-repository && do_stuff
> git rev-parse --is-shallow-repository && do_stuff
>
> Signed-off-by: Erlend E. Aasland <erlend.aasland@innova.no>
> ---
> builtin/rev-parse.c | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 7a00da8203..5a8b404ec7 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -874,24 +874,31 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                 continue;
>             }
>             if (!strcmp(arg, "--is-inside-git-dir")) {
> -                printf("%s\n", is_inside_git_dir() ? "true"
> -                        : "false");
> +                int is_set = is_inside_git_dir();

Avoid declaration after statement. Move is_set to the beginning of
cmd_rev_parse().

Also, be more specific than "is_set". A variable like "is_inside" would
be more appropriate.

> +                if (quiet)
> +                    return is_set ? 0 : 1;

Returning prematurely might be a bad idea. If there are more options after
"--is-inside-git-dir", they will be not executed. You can maybe rewrite this as:

```
             if (!strcmp(arg, "--is-inside-git-dir")) {
                is_set = is_inside_git_dir();
                if (!quiet)
                        printf("%s\n", is_set ? "true"
                            : "false");
                 continue;
             }
```
And then return the value at the end of function, replacing '0' with !is_set.

Same comment for other blocks.


>             if (!strcmp(arg, "--is-inside-work-tree")) {
> -                printf("%s\n", is_inside_work_tree() ? "true"
> -                        : "false");
> +                int is_set = is_inside_work_tree();
> +                if (quiet)
> +                    return is_set ? 0 : 1;
> +                printf("%s\n", is_set ? "true" : "false");
>                 continue;
>             }
>             if (!strcmp(arg, "--is-bare-repository")) {
> -                printf("%s\n", is_bare_repository() ? "true"
> -                        : "false");
> +                int is_set = is_bare_repository();
> +                if (quiet)
> +                    return is_set ? 0 : 1;
> +                printf("%s\n", is_set ? "true" : "false");
>                 continue;
>             }
>             if (!strcmp(arg, "--is-shallow-repository")) {
> -                printf("%s\n",
> -                        is_repository_shallow(the_repository) ? "true"
> -                        : "false");
> +                int is_set = is_repository_shallow(the_repository);
> +                if (quiet)
> +                    return is_set ? 0 : 1;
> +                printf("%s\n", is_set ? "true" : "false");
>                 continue;
>            }
>            if (!strcmp(arg, "--shared-index-path")) {
> --
> 2.25.1

I am wondering if we should stop the script from running if both quiet
and --is-* options are passed.

Regards
Abhishek
