Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89BC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5D61038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbhIXN2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346189AbhIXN2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 09:28:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F6C0D943B
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:05:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x7so21277828edd.6
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=73XR2FClo7S84vCGMUICnodzmfBCHb8gwbNHEsBeam0=;
        b=bf6TzjYjJJXKFlpDH/kzwI0jMzZPq6EkBcE4OjeAZQfRpHMLRnqU7xs+NZhMrMYM6z
         a2aSnIhoLbbfZlu91LISG1WYJyAnPvmacEC9woqD1Zw0oP3vkrqFrWXEQsmxClFSX/7z
         FEU01egjrCo5Bu1QQpQ5p0a9FJNYhhMImdrhepqR0yc7pgD1TCgk4sRWzGcHSlbXLCx4
         dIQGO/K/lP0eKf23Fo3nlbSjUjaqnc2pXE6NbmA7YCfXJedyLSi/XGVr4dyJ6Q64k0UK
         P829/wWdHJj3xfHWkb8VU0sq8pf6dkaAemCAmIHijNvDV+hgWpJoEDMTnIYKW7HCakqv
         7dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=73XR2FClo7S84vCGMUICnodzmfBCHb8gwbNHEsBeam0=;
        b=Q0IL6BiIIPjwgeZGcD1qKgoK0rJK/6HQQF39KaLrtxOuY9gOzLrpsZkK9M0HIhYjHB
         Yux16QpHxJSqGmrpiBI5lrhz861CaqGeEK2xU/L728wzHuy4jmCfj+9Fe1IGovwD2vDU
         HlyQHpREa0l2l/Uiw1E0uvDIduSD5ljidMsehiV90qNrrAe7LvU8921aVzrBeDA0bA6L
         0nzWSXNcwnDGXN9Dry3dRiDQXazLpWBtXwknNLii6riaVftLDQ4CgQKbjBTOYPP1zHF1
         iH1NQoWO+hles5Lrvm0GfqIQPrRttVA36Dfpz1vR+A4HRTUjerPRuxiL43YZ2xysXzJC
         rirw==
X-Gm-Message-State: AOAM5316qCp88KEg0TLzuCt+VrKdXXnCIwMR7YVWvUo7hgfu2fMGHLvW
        T+n24XpbYAldjRGo6PTpi4NF5z3zJ/LpOg==
X-Google-Smtp-Source: ABdhPJzqmExwB05Pq2Tzj4MqNnM8fQ/LTuai1kCSkXHVpVyit7FxMkCBZ2JdBkNHI9YFiV76l5U/Xg==
X-Received: by 2002:a17:906:32c9:: with SMTP id k9mr11373650ejk.218.1632488748490;
        Fri, 24 Sep 2021 06:05:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w13sm4830018ejc.100.2021.09.24.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:05:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Is "make check-docs" useful anymore?
Date:   Fri, 24 Sep 2021 15:00:42 +0200
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
 <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
 <bc9a4534f5bc6756ab2df869b55e390183c4ff30.1631626038.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <bc9a4534f5bc6756ab2df869b55e390183c4ff30.1631626038.git.gitgitgadget@gmail.com>
Message-ID: <87o88i2keu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Matthias A=C3=9Fhauer via GitGitGadget wrote:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> While 'git version' is probably the least complex git command,
> it is a non-experimental user-facing builtin command. As such
> it should have a help page.
>
> Both `git help` and `git version` can be called as options
> (`--help`/`--version`) that internally get converted to the
> corresponding command. Add a small paragraph to
> Documentation/git.txt describing how these two options
> interact with each other and link to this help page for the
> sub-options that `--version` can take. Well, currently there
> is only one sub-option, but that could potentially increase
> in future versions of Git.
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  Documentation/git-version.txt | 28 ++++++++++++++++++++++++++++
>  Documentation/git.txt         |  4 ++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/git-version.txt
>
> diff --git a/Documentation/git-version.txt b/Documentation/git-version.txt
> new file mode 100644
> index 00000000000..80fa7754a6d
> --- /dev/null
> +++ b/Documentation/git-version.txt
> @@ -0,0 +1,28 @@
> +git-version(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-version - Display version information about Git
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git version' [--build-options]
> +
> +DESCRIPTION
> +-----------
> +With no options given, the version of 'git' is printed on the standard o=
utput.
> +
> +Note that `git --version` is identical to `git version` because the
> +former is internally converted into the latter.
> +
> +OPTIONS
> +-------
> +--build-options::
> +	Include additional information about how git was built for diagnostic
> +	purposes.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6dd241ef838..95fe6f31b4f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -41,6 +41,10 @@ OPTIONS
>  -------
>  --version::
>  	Prints the Git suite version that the 'git' program came from.
> ++
> +This option is internaly converted to `git version ...` and accepts
> +the same options as the linkgit:git-version[1] command. If `--help` is
> +also given, it takes precedence over `--version`.
>=20=20
>  --help::
>  	Prints the synopsis and a list of the most commonly used

I didn't notice until after it hit master that this caused a regression
in "make check-docs":

    $ make -s check-docs
    removed but documented: git-version

The "fix" is rather easy, i.e. adding "git-version" to the whitelist.

But I wondered about $subject, i.e. we want to run the "lint" part, but
do we really need something reminding us that there isn't a mapping
between Documentation/*.txt and *.o files present at the top-level?

That whole part seems to have been some "reminder to document" addition
in 8c989ec5288 (Makefile: $(MAKE) check-docs, 2006-04-13).

If we're going to keep it in pretty much its current form then the CI
integration added in b98712b9aa9 (travis-ci: build documentation,
2016-05-04) seems rather useless when it comes to this, i.e. we should
either adjust it to exit non-zero, or check if we've got output under
"make -s" and fail the check then.
