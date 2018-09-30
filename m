Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843791F453
	for <e@80x24.org>; Sun, 30 Sep 2018 04:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeI3LEa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Sep 2018 07:04:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37203 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeI3LEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:04:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id n6-v6so10790617qtl.4
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 21:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMB64mrRRDVshdSY2SCsXa/pbjslrD6U3zNC8l5VWLQ=;
        b=EPoXCzLrh7f5RdOM0OsUgQORQGPxtEFY2XFBsIfOLFa6FhQs3QlJI1OPPSZoqIj7Lp
         ylTqx59DfbztQqInLFDRv0FHFs9dWl94lf/+LgGhttVV0IJWJwrJxtd3gCOzBS+Kc2DD
         d2rbLy/+dEz4M1Ho1aBPQSzi9cerM81Uh68JrWbyi1XsaOJA4VD0u1mDKKz1mlU8qS1p
         9DaKQVkmbuj903Qk31g2KvzMbn99Ivtj9ZQfYyty8BH2hIZjjk4bhT//ifiGgS4qpKf6
         qqZI0h1lysMtSneRPCP48TcogSp4u6UbSeqsmyhHgw84EwajHRpSfuBqLEUB7tf7eB1K
         aD8Q==
X-Gm-Message-State: ABuFfogDCeIB0s2zoWpT54L5vLhxjkPhDP2j1lQ96KiDrvYCIWkUM4pf
        mS7E+Is60W3H/962ZnwAbagCeUgpDbmO8dQX2BQ=
X-Google-Smtp-Source: ACcGV61f12hmK/pvO6w8Jap0QJoD29BnmY+U+M272eCxAOZQHhZzaeJZ45+jm367q3E0fjNZ/zXnu48Dd8ZARdA05Fc=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr4114982qvm.6.1538281986972;
 Sat, 29 Sep 2018 21:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-3-pclouds@gmail.com>
In-Reply-To: <20180929153005.10599-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 00:32:55 -0400
Message-ID: <CAPig+cSv4P99ZJ=CtCC7HctfSg5W6sadiknhk9yXSaBDZ81ctw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: add per-worktree config files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 11:30 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> A new repo extension is added, worktreeConfig. When it is present:
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -2,8 +2,9 @@ CONFIGURATION FILE
>  The Git configuration file contains a number of variables that affect
> +the Git commands' behavior. The files `.git/config` and optionally
> +`config.worktree` (see `extensions.worktreeConfig` below) in each
> +repository is used to store the configuration for that repository, and

s/is used/are/used/

>  `$HOME/.gitconfig` is used to store a per-user configuration as
>  fallback values for the `.git/config` file. The file `/etc/gitconfig`
>  can be used to store a system-wide default configuration.
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -204,6 +204,36 @@ working trees, it can be used to identify worktrees. For example if
> +CONFIGURATION FILE
> +------------------
> +In this mode, specific configuration stays in the path pointed by `git
> +rev-parse --git-path config.worktree`. You can add or update
> +configuration in this file with `git config --worktree`. Older Git
> +versions may will refuse to access repositories with this extension.

s/may will/will/

> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> @@ -275,6 +280,9 @@ worktrees/<id>/locked::
> +worktrees/<id>/config.worktree::
> +       Working directory specific configuration file.

I wonder if this deserves a quick mention in
Documentation/git-worktree.txt since other worktree-related files,
such as "worktrees/<id>/locked", are mentioned there.

> diff --git a/builtin/config.c b/builtin/config.c
> @@ -645,7 +649,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> +       else if (use_worktree_config) {
> +               struct worktree **worktrees = get_worktrees(0);
> +               if (repository_format_worktree_config)
> +                       given_config_source.file = git_pathdup("config.worktree");
> +               else if (worktrees[0] && worktrees[1])
> +                       die(_("--worktree cannot be used with multiple "
> +                             "working trees unless the config\n"
> +                             "extension worktreeConfig is enabled. "
> +                             "Please read \"CONFIGURATION FILE\"\n"
> +                             "section in \"git help worktree\" for details"));
> +               else
> +                       given_config_source.file = git_pathdup("config");

I'm not sure I understand the purpose of allowing --worktree when only
a single worktree is present and extensions.worktreeConfig is not set.
Can you talk about it a bit more?
