Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B7C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13B2173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 09:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h0zs1w+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfLLJlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:41:42 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45146 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfLLJlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:42 -0500
Received: by mail-vk1-f195.google.com with SMTP id g7so211631vkl.12
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 01:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nel4NsKIGkZcbhddee3Lp2zRGt+l4VR/U8fowCNydwc=;
        b=h0zs1w+zkEXrcinw61VviWcFwR3e0TVLHSWUFbH0q1IIo6d2mewrMA9U6cSP2BqHyi
         ICsqy6Wquz6nMSU6SC8Xr/6NSFtHqCL4XtnNfezj3rFWeltfTNi8meRyxWsZH4RM7+bn
         u4+uzwqYTd39U47IBBNErs0h4u3Hfb3jlAcZVSIeHALce9V39lqcpGlnSEW9G7ob3ye+
         ltROx455Ge+MwzucKF+xmPKPzZspm78j3QTn5k9zqGiSe/k1BI+oGiD6cDftGOTsz+jY
         sAe4TXU6RWDQntz4GKs7oyaXcJIsBuIGhNIKH0rfiYKJviuPoV6rQ0gNK5wUwG9jHKDz
         JokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nel4NsKIGkZcbhddee3Lp2zRGt+l4VR/U8fowCNydwc=;
        b=ReCNF6GnD+0uf7CVs1dBgxQ+TiAXMNKZagD4ZKbwo8y3TeK4FNi7/tR9VJfJkyc61F
         kfFKNj8AQ6ApV3f07e92CmYXhWDexxTyZ0M1CDGRXPzp8D3HeD03N7bkkESWcdMVc1oL
         PcKHnmlyDyiNcMthGPStbrauo/FxVxinCFebUrrmUjT8m6xwmFMQiYdTmoEXIqIVJaSH
         5ZSMdyDOuFW2xO4MXMXDNQ1tN/ix7XwYXoiT6gOzDGhhMnIbpoIPPkve2tN/Pz4ay5/5
         5LGv2M/yDNbO9Rcathk/0JMqy8JqhyjpwDRHcAThgTUvAdasbl+o2fYsnE/rZ2G/Y8T4
         q9vg==
X-Gm-Message-State: APjAAAUGyS/HWVZzcuC9YQy4ZiTWgdK2J18p4NbPI3AbnI+Kmip854oq
        Qb8mjQnJBcjOQzBjOAPW/y7EuldM2nTe0TBH0TywSQ==
X-Google-Smtp-Source: APXvYqyVs0xrMr3dJ0kGCtuMbe939qI0wiQrulqH6jlCm1mewqaLYTNbHJmBWbUAefOMs+ykIWO5TJN3QG/A8uYbbFM=
X-Received: by 2002:ac5:cdcd:: with SMTP id u13mr7903413vkn.0.1576143700634;
 Thu, 12 Dec 2019 01:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com> <20191210023335.49987-2-emilyshaffer@google.com>
In-Reply-To: <20191210023335.49987-2-emilyshaffer@google.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Dec 2019 10:41:28 +0100
Message-ID: <CAKPyHN19uDdredXyGv63sHJKKeUue0t9nM6e31RVPYNYfd=XmQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] hook: scaffolding for git-hook subcommand
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 3:34 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Introduce infrastructure for a new subcommand, git-hook, which will be
> used to ease config-based hook management. This command will handle
> parsing configs to compose a list of hooks to run for a given event, as
> well as adding or modifying hook configs in an interactive fashion.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .gitignore                    |  1 +
>  Documentation/git-hook.txt    | 19 +++++++++++++++++++
>  Makefile                      |  1 +
>  builtin.h                     |  1 +
>  builtin/hook.c                | 21 +++++++++++++++++++++
>  git.c                         |  1 +

how about adding also completion support here?

Bert

>  t/t1360-config-based-hooks.sh | 11 +++++++++++
>  7 files changed, 55 insertions(+)
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 builtin/hook.c
>  create mode 100755 t/t1360-config-based-hooks.sh
>
> diff --git a/.gitignore b/.gitignore
> index 89b3b79c1a..9ef59b9baa 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -74,6 +74,7 @@
>  /git-grep
>  /git-hash-object
>  /git-help
> +/git-hook
>  /git-http-backend
>  /git-http-fetch
>  /git-http-push
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> new file mode 100644
> index 0000000000..2d50c414cc
> --- /dev/null
> +++ b/Documentation/git-hook.txt
> @@ -0,0 +1,19 @@
> +git-hook(1)
> +===========
> +
> +NAME
> +----
> +git-hook - Manage configured hooks
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git hook'
> +
> +DESCRIPTION
> +-----------
> +You can list, add, and modify hooks with this command.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 58b92af54b..83263505c0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1074,6 +1074,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
>  BUILTIN_OBJS += builtin/grep.o
>  BUILTIN_OBJS += builtin/hash-object.o
>  BUILTIN_OBJS += builtin/help.o
> +BUILTIN_OBJS += builtin/hook.o
>  BUILTIN_OBJS += builtin/index-pack.o
>  BUILTIN_OBJS += builtin/init-db.o
>  BUILTIN_OBJS += builtin/interpret-trailers.o
> diff --git a/builtin.h b/builtin.h
> index 5cf5df69f7..d4ca2ac9a5 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -173,6 +173,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
>  int cmd_grep(int argc, const char **argv, const char *prefix);
>  int cmd_hash_object(int argc, const char **argv, const char *prefix);
>  int cmd_help(int argc, const char **argv, const char *prefix);
> +int cmd_hook(int argc, const char **argv, const char *prefix);
>  int cmd_index_pack(int argc, const char **argv, const char *prefix);
>  int cmd_init_db(int argc, const char **argv, const char *prefix);
>  int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/hook.c b/builtin/hook.c
> new file mode 100644
> index 0000000000..b2bbc84d4d
> --- /dev/null
> +++ b/builtin/hook.c
> @@ -0,0 +1,21 @@
> +#include "cache.h"
> +
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +static const char * const builtin_hook_usage[] = {
> +       N_("git hook"),
> +       NULL
> +};
> +
> +int cmd_hook(int argc, const char **argv, const char *prefix)
> +{
> +       struct option builtin_hook_options[] = {
> +               OPT_END(),
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, builtin_hook_options,
> +                            builtin_hook_usage, 0);
> +
> +       return 0;
> +}
> diff --git a/git.c b/git.c
> index ce6ab0ece2..c8344b9ab7 100644
> --- a/git.c
> +++ b/git.c
> @@ -513,6 +513,7 @@ static struct cmd_struct commands[] = {
>         { "grep", cmd_grep, RUN_SETUP_GENTLY },
>         { "hash-object", cmd_hash_object },
>         { "help", cmd_help },
> +       { "hook", cmd_hook, RUN_SETUP },
>         { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>         { "init", cmd_init_db },
>         { "init-db", cmd_init_db },
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> new file mode 100755
> index 0000000000..34b0df5216
> --- /dev/null
> +++ b/t/t1360-config-based-hooks.sh
> @@ -0,0 +1,11 @@
> +#!/bin/bash
> +
> +test_description='config-managed multihooks, including git-hook command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git hook command does not crash' '
> +       git hook
> +'
> +
> +test_done
> --
> 2.24.0.393.g34dc348eaf-goog
>
