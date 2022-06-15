Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0BC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiFOUZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbiFOUZq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:25:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A750B38
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:25:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s12so25459634ejx.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cCXZJo1n46eTNRqzY4KhuwI4LbBJASYjZjRz262Uf1c=;
        b=fHcop8O/LSNZa2fmVii6wOrdjbCo42e9UqopemBMEJI4OmubRb3Y9InCDgYdVzK9XO
         AQoc0BHBWKWUJkCuQxv3nfhebPj/bMUBIfAKSXA8+6ceFjdR3p4VpYoJSv6oenyOHHzy
         MjfWlfZPjg32meQMIciHSDh580vRe5IUfP+9YoNEXGPe6A0c7uX/m2Qtbmny/p0JkoW6
         E1Fap6mr8lQqtCjL2Ntr5iyeeYsnVpGSeMHo3QcMFOii3PMDuwI7TOxflcEe+UWnuCT6
         Z247o96qbLzBSQE7Xb20jaudossSRmkyxtaQwgFra+6M5AmKGlgev3R+duV9e4LU71vB
         DNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cCXZJo1n46eTNRqzY4KhuwI4LbBJASYjZjRz262Uf1c=;
        b=bwReSZXIA5LhZeu3i0OPbl4nGk8wlqi3n4nZbONV5c/deT7xuC2xmYuBjMQSHDRrne
         Ra/jF2Zxba86TyY+U+du2Ywk3Lk/bpyqIlkv2CDBSoRvQ1YutIdxByMTr5tnLj4y2XZM
         Bhjqf63KpmJTesOT6v4c2mdLI4NZ/KdVWgect7yHcQOtF9pJF/T+DirCw13poksKNw4V
         VkVqqzbUJek5S3r1cG0D22qJiTp71lqMEpm9qY5EB7Z8eMArSseqDJHTHfQxW1EnLN5G
         rBXHmHH8ufO2MWfJTS0Gz1nWP2Lyy7jHiJVvYOSm7iYBxTTJJDtinhnPwrNKEf+3YOLA
         BRVA==
X-Gm-Message-State: AJIora+2wIoQRN4M/ROv/CaP48Uxvkujd4C+63SD5JfZQ5V71fpCISy+
        g/kpoXuOuqgIpaYgh5byknwDW2YaZ6JLqQ==
X-Google-Smtp-Source: AGRyM1s1YyqIaFC6x//CwTqwcJvG2WJO8NnsFQCg1kpzJ9pZSbchX1bpKFCV3kXK8+P3u9lvvBkMRw==
X-Received: by 2002:a17:906:8454:b0:711:c970:227a with SMTP id e20-20020a170906845400b00711c970227amr1459140ejy.4.1655324743466;
        Wed, 15 Jun 2022 13:25:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b0042617ba63c2sm106334edb.76.2022.06.15.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:25:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1ZaA-000tVW-55;
        Wed, 15 Jun 2022 22:25:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] ls-files: introduce "--object-only" option
Date:   Wed, 15 Jun 2022 22:15:45 +0200
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <81ae1280e8eb471c7a11dceb0aa7a8915948b2ce.1655300752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <81ae1280e8eb471c7a11dceb0aa7a8915948b2ce.1655300752.git.gitgitgadget@gmail.com>
Message-ID: <220615.865yl1y8qh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> --object-only is an alias for --format=%(objectname),
> which output objectname of index entries, taking
> inspiration from the option with the same name in
> the `git ls-tree` command.
>
> --object-only cannot be used with --format, and -s, -o,
> -k, --resolve-undo, --deduplicate, --debug.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-ls-files.txt |  8 +++++++-
>  builtin/ls-files.c             | 36 +++++++++++++++++++++++++++++++++-
>  t/t3013-ls-files-format.sh     | 34 ++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index b22860ec8c0..c3f46bb821b 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
>  		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
>  		[--directory [--no-empty-directory]] [--eol]
> -		[--deduplicate]
> +		[--deduplicate] [--object-only]
>  		[-x <pattern>|--exclude=<pattern>]
>  		[-X <file>|--exclude-from=<file>]
>  		[--exclude-per-directory=<file>]
> @@ -199,6 +199,12 @@ followed by the  ("attr/<eolattr>").
>  	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
>  	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`,
>  	`--debug`.
> +
> +--object-only::
> +	List only names of the objects, one per line. This is equivalent
> +	to specifying `--format='%(objectname)'`. Cannot be combined with
> +	`--format=<format>`.
> +
>  \--::
>  	Do not interpret any more arguments as options.
>  
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 9dd6c55eeb9..4ac8f34baac 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -60,6 +60,27 @@ static const char *tag_modified = "";
>  static const char *tag_skip_worktree = "";
>  static const char *tag_resolve_undo = "";
>  
> +static enum ls_files_cmdmode {
> +	MODE_DEFAULT = 0,
> +	MODE_OBJECT_ONLY,
> +} ls_files_cmdmode;
> +
> +struct ls_files_cmdmodee_to_fmt {
> +	enum ls_files_cmdmode mode;
> +	const char *const fmt;
> +};
> +
> +static struct ls_files_cmdmodee_to_fmt ls_files_cmdmode_format[] = {
> +	{
> +		.mode = MODE_DEFAULT,
> +		.fmt = NULL,
> +	},
> +	{
> +		.mode = MODE_OBJECT_ONLY,
> +		.fmt = "%(objectname)",
> +	},
> +};
[...snip...]

This code all looks OK from skimming it, and is substantially copied
from builtin/ls-tree.c (which is good).

But I wonder as in that case whether having such an alias is worth it at
all, especially since in the case of ls-files (unlike ls-tree) we don't
start out with various --just-the-X-field type options, this is the
first one.

So I *really* like that you took my suggestion of "why not a --format"
from a previous round, but given the above for ls-files in particular is
it really worth it to have this extra code just to type:

    --object-only

Instead of:

    --format="%(objectname)"

So, maybe, and I'm not set against it, but I think it's worth
re-evaluating in this case.

In particular because the part of ls-tree's code is missing here where
we "format optimize", i.e. we take a form like:

    --format="%(objectname)"

And dispatch it to the more optimized special function, instead of the
generic strbuf_expand(), whereas in this case it's the other way around,
the option is just an alias for --format.
