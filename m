Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A73FC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhKVSO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhKVSOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:14:22 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5BC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:11:15 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 207so5732675ljf.10
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7/N5dIkyD7ASa084GM0DE5dUANcSvZwmIifwtJzqJ0=;
        b=MilMc14moIco2ECc7LBS7YPyo0wUtArhUMuNH+dPA2Io5pdpdLbwCBnXEJ1lX5+hsC
         21jyj7rLqOtgb1PXTplQHCsOwcKL+xs3qUmkqRWX3zttkAY6SUyl0Wqg18IQkb81eId6
         90AHIHVLen0OilO7pcbJ9+RvtR3WTa67U8lXkJ0ZdxTgRFBrTDKp0pI1bZ30cqBY/BqY
         CYpXaQ7VTSd4YFcHy1dGXHvwNcNAoPZx2RbhIBuMNU8TmhQGzKW8V51YK5ekbwtOgzhb
         kWLgxDRA0jw5NuUiQOd3mO+Eo7LwxQ/01pq8PdFmmUt7aBHX+GA6YN6g24nbzmZyGEXr
         asVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7/N5dIkyD7ASa084GM0DE5dUANcSvZwmIifwtJzqJ0=;
        b=o0JmPMT4G7XLJQbw6E3kRNRey3wuc+29O4wEP8QomTQ25yLvIf7EpfVUor6hsfYpED
         R6QcxPHjz7HSpPEPpYT3ZORlQnuN8QvcAe41DK8mchcztpmt/CPM0PjigzTY0JZ9N4lS
         OpwqG8CyArVtyIkw6DS6kbfmLOf4v8CUDVOYrDTEdcQkSbWZQkvTkxP7lIpH/f0C4RH7
         T6XOVODrKh/V16r/k6Sc/yndiDS+vAiFH20oyq7LdBCdRAF8R47xNN7iWUiGyY/p2m6K
         FdEaopQlJoZBR9/slNZVBOxJPzy0+q4VUbRwi7H4ZXDuVEI1siNgyHdkKquhHmtHM7+9
         UbzQ==
X-Gm-Message-State: AOAM532ekKksWDUzHW84N+1aNYvGqvHK/WK0zHqPJSVeUnoLwVx2Rf0p
        INKORl4x+eBVk3zJYVFLvXDvAUzoFV+TdpqtaBA=
X-Google-Smtp-Source: ABdhPJw1DJjwshuW5cuXUxzIM29Pt4jDxp677bMn/gMwmUWMao/s/6XH7uXXjTDpXLP5VePCQk/wWupZ+C8D3+CizL0=
X-Received: by 2002:a2e:b7d4:: with SMTP id p20mr53085696ljo.248.1637604672045;
 Mon, 22 Nov 2021 10:11:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637567328.git.dyroneteng@gmail.com> <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
In-Reply-To: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
From:   Peter Baumann <peter.baumann@gmail.com>
Date:   Mon, 22 Nov 2021 19:11:01 +0100
Message-ID: <CAJm9OHd_MDjFqXok663O8bQmvdPCjrQeEHumPLDpxqVC4i4=1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree"
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        congdanhqx@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Sorry if you receive this mail twice, it seems like it didn't get
through the first time. ]

On Mon, Nov 22, 2021 at 9:50 AM Teng Long <dyroneteng@gmail.com> wrote:
>
> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practical.
>
> This commit supply an option names `--oid-only` to let `git ls-tree`
> only print out the OID of the object. `--oid-only` and `--name-only`
> are mutually exclusive in use.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-ls-tree.txt |  8 +++++--
>  builtin/ls-tree.c             | 27 ++++++++++++++++-------
>  t/t3104-ls-tree-oid.sh        | 40 +++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 10 deletions(-)
>  create mode 100755 t/t3104-ls-tree-oid.sh
>
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index db02d6d79a..bc711dc00a 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -           [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
> +           [--name-only] [--name-status] [--oid-only]
> +           [--full-name] [--full-tree] [--abbrev[=<n>]]
>             <tree-ish> [<path>...]
>

Shouldn't the synopsis also indicate that the options are exclusive, e.g.
  [--name-only | --oid-only]  ?

Besides adding the new --oid-only mode, you also add one letter acronyms for
  [-n | --name-only]
  [-s | --name-status ]
and one letter abbreviation
  [-o | --oid-only ]
which are all undocumented in the help page. If we want the short one
letter version,
they should be documented. For me, it is at least questionable why we
introduce them
and more so in a commit adding --oid-only.


>  DESCRIPTION
> @@ -59,7 +60,10 @@ OPTIONS
>  --name-only::
>  --name-status::
>         List only filenames (instead of the "long" output), one per line.
> -
> +       Cannot be used with `--oid-only` together.
> +--oid-only::
> +       List only OIDs of the objects, one per line. Cannot be used with
> +       `--name-only` or `--name-status` together.
>  --abbrev[=<n>]::
>         Instead of showing the full 40-byte hexadecimal object
>         lines, show the shortest prefix that is at least '<n>'
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c7..1e4a82e669 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -18,19 +18,26 @@ static int line_termination = '\n';
>  #define LS_RECURSIVE 1
>  #define LS_TREE_ONLY 2
>  #define LS_SHOW_TREES 4
> -#define LS_NAME_ONLY 8
> -#define LS_SHOW_SIZE 16
> +#define LS_SHOW_SIZE 8
>  static int abbrev;
>  static int ls_options;
>  static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
>
> -static const  char * const ls_tree_usage[] = {
> +static const char * const ls_tree_usage[] = {
>         N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>         NULL
>  };
>
> +enum {
> +       MODE_UNSPECIFIED = 0,
> +       MODE_NAME_ONLY,
> +       MODE_OID_ONLY
> +};
> +
> +static int cmdmode = MODE_UNSPECIFIED;
> +
>  static int show_recursive(const char *base, int baselen, const char *pathname)
>  {
>         int i;
> @@ -90,7 +97,12 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>         else if (ls_options & LS_TREE_ONLY)
>                 return 0;
>
> -       if (!(ls_options & LS_NAME_ONLY)) {
> +       if (cmdmode == 2) {
> +               printf("%s\n", find_unique_abbrev(oid, abbrev));
> +               return 0;
> +       }
> +
> +       if (cmdmode == 0) {
>                 if (ls_options & LS_SHOW_SIZE) {
>                         char size_text[24];
>                         if (!strcmp(type, blob_type)) {
> @@ -135,10 +147,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>                             N_("terminate entries with NUL byte"), 0),
>                 OPT_BIT('l', "long", &ls_options, N_("include object size"),
>                         LS_SHOW_SIZE),
> -               OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
> -                       LS_NAME_ONLY),
> -               OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
> -                       LS_NAME_ONLY),
> +               OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
> +               OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
> +               OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_ONLY),
>                 OPT_SET_INT(0, "full-name", &chomp_prefix,
>                             N_("use full path names"), 0),
>                 OPT_BOOL(0, "full-tree", &full_tree,
> diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
> new file mode 100755
> index 0000000000..4c02cdd3c3
> --- /dev/null
> +++ b/t/t3104-ls-tree-oid.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +
> +test_description='git ls-tree oids handling.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       echo 111 >1.txt &&
> +       echo 222 >2.txt &&
> +       mkdir -p path0/a/b/c &&
> +       echo 333 >path0/a/b/c/3.txt &&
> +       find *.txt path* \( -type f -o -type l \) -print |

I don't see the test using any symbolic links. Why are we searching for
symbolic links with "-type l" here?

-Peter

> +       xargs git update-index --add &&
> +       tree=$(git write-tree) &&
> +       echo $tree
> +'

> +
> +test_expect_success 'usage: --oid-only' '
> +       git ls-tree --oid-only $tree >current &&
> +       git ls-tree $tree | awk "{print \$3}" >expected &&
> +       test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with -r' '
> +       git ls-tree --oid-only -r $tree >current &&
> +       git ls-tree -r $tree | awk "{print \$3}" >expected &&
> +       test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with --abbrev' '
> +       git ls-tree --oid-only --abbrev=6 $tree >current &&
> +       git ls-tree --abbrev=6 $tree | awk "{print \$3}" > expected &&
> +       test_cmp current expected
> +'
> +
> +test_expect_failure 'usage: incompatible options: --name-only with --oid-only' '
> +       test_incompatible_usage git ls-tree --oid-only --name-only
> +'
> +
> +test_done
> --
> 2.33.1.10.g438dd9044d.dirty
>
