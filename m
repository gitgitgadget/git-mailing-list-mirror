Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFDC20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdCNXGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:06:48 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34783 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdCNXGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:06:47 -0400
Received: by mail-pf0-f176.google.com with SMTP id v190so381048pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JepfqlFdBLuHu3RNixVMBsHYeaIo9vsWGUDQ/18kQGo=;
        b=ovKSFdtkN1YoMXRGol5+ufWSrOFdRwVEqGg3xuaRK9iZernjWAWpoktIVm4rlIAii0
         7YYWurjBKbXn+6pI5ctAFAEB94dVLPlilzb1cWG1JoC4kfaWecrGRDey5Nywhht9y1Wr
         3n9+23d6WMYdU5tc6TSx4kukUW7m4qRcaImoGOBZ7r5JjQpomtKnN8JInWt5LNlZwUPI
         HhcDr8XKIbYkgtcJnZRD2M8Pz6wqdk3Rx0ltHP0QKqXragdIeXqiVqDokoefqAjbJOhA
         Icrf9XcKyzE5hoj35l1zFQf8aUWXaoG9CWMEAOOqmU82Kg6VHwbjcmoEenype8N5VXqY
         WwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JepfqlFdBLuHu3RNixVMBsHYeaIo9vsWGUDQ/18kQGo=;
        b=IMFUsts+ZdCKprHYQAue00uVpuumNVVaZLObQXhvGoIRWvZyYttP8mw1y+D9PLvKzf
         gGnQwc1JAvXiCBugUYOOhlKEbhSItRggHKwLqeEV79oL/uIZ9XkRGu4P+XkDv8MzT/E+
         zrGkFnjZV2mXaRH8Fm0N3IVq9kOI9qQWiNCk5UVisp/cAa4rfEvYuNGlEazExS76Zoaf
         qyqAb3hCSQJ6frfJ9+Z6OUutqF8Jj+TcGAzwWxegzmBOYhwdr8Q53ELFDaL9m81t24Ht
         NfK+Lt2D6ZP4LKAuiPk5D/TyST1VWpZB/6UWwIlS5s7mM6rek7j78iCfR1t2itNoBBlC
         87gg==
X-Gm-Message-State: AFeK/H0aGOhFdx4Se0wAKZsc4jGjP8qr2uZIVhPcoWQWxVR6ejtX84FrXYK3kU6iJm+/T+w7S9ztxPznADLbeMp2
X-Received: by 10.98.48.66 with SMTP id w63mr161736pfw.179.1489532805737; Tue,
 14 Mar 2017 16:06:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 14 Mar 2017 16:06:45 -0700 (PDT)
In-Reply-To: <20170314221100.24856-5-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com> <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-5-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Mar 2017 16:06:45 -0700
Message-ID: <CAGZ79kaRP0Gbw+zwot_vYo7E=7GMwU7chJsJ7TL8g4TJwivC5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ls-files: fix bug when recursing with relative pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 3:11 PM, Brandon Williams <bmwill@google.com> wrote:
> When using the --recurse-submodules flag with a relative pathspec which
> includes "..", an error is produced inside the child process spawned for a
> submodule.  When creating the pathspec struct in the child, the ".." is
> interpreted to mean "go up a directory" which causes an error stating that the
> path ".." is outside of the repository.
>
> While it is true that ".." is outside the scope of the submodule, it is
> confusing to a user who originally invoked the command where ".." was indeed
> still inside the scope of the superproject.  Since the child process launched
> for the submodule has some context that it is operating underneath a
> superproject, this error could be avoided.
>
> This patch fixes the bug by passing the 'prefix' to the child process.  Now
> each child process that works on a submodule has two points of reference to the
> superproject: (1) the 'super_prefix' which is the path from the root of the
> superproject down to root of the submodule and (2) the 'prefix' which is the
> path from the root of the superproject down to the directory where the user
> invoked the git command.
>
> With these two pieces of information a child process can correctly interpret
> the pathspecs provided by the user as well as being able to properly format its
> output relative to the directory the user invoked the original command from.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-files.c                     | 41 +++++++++++++++++-----------------
>  t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 1c0f057d0..d449e46db 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -30,7 +30,7 @@ static int line_terminator = '\n';
>  static int debug_mode;
>  static int show_eol;
>  static int recurse_submodules;
> -static struct argv_array submodules_options = ARGV_ARRAY_INIT;
> +static struct argv_array submodule_options = ARGV_ARRAY_INIT;
>
>  static const char *prefix;
>  static const char *super_prefix;
> @@ -172,20 +172,27 @@ static void show_killed_files(struct dir_struct *dir)
>  /*
>   * Compile an argv_array with all of the options supported by --recurse_submodules
>   */
> -static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
> +static void compile_submodule_options(const char **argv,
> +                                     const struct dir_struct *dir,
> +                                     int show_tag)
>  {
>         if (line_terminator == '\0')
> -               argv_array_push(&submodules_options, "-z");
> +               argv_array_push(&submodule_options, "-z");
>         if (show_tag)
> -               argv_array_push(&submodules_options, "-t");
> +               argv_array_push(&submodule_options, "-t");
>         if (show_valid_bit)
> -               argv_array_push(&submodules_options, "-v");
> +               argv_array_push(&submodule_options, "-v");
>         if (show_cached)
> -               argv_array_push(&submodules_options, "--cached");
> +               argv_array_push(&submodule_options, "--cached");
>         if (show_eol)
> -               argv_array_push(&submodules_options, "--eol");
> +               argv_array_push(&submodule_options, "--eol");
>         if (debug_mode)
> -               argv_array_push(&submodules_options, "--debug");
> +               argv_array_push(&submodule_options, "--debug");

Up to here we only rename a variable? If you want to help reviewers,
please separate this into two patches. One refactoring, stating it doesn't
change behavior; and the other adding the behavioral changes.

> +
> +       /* Add Pathspecs */
> +       argv_array_push(&submodule_options, "--");
> +       for (; *argv; argv++)
> +               argv_array_push(&submodule_options, *argv);
>  }
