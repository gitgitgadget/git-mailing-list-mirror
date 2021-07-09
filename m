Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A968C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 08:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265B6613C8
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhGIIEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhGIIEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 04:04:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070FC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 01:02:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o5so14611790ejy.7
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KER+4JIf9gIY2cMC4oOEDjUhiJLINXJm55esjUq2fNY=;
        b=nK4cUVLdF+ooM7qF5KhBLaft/PDKaHS7I9rIaQ2FXog6emmTjul/S9R8JfYjCmkMJR
         BfEW6T4/aujG94V8aEPRWst63Em1oGy5ct5BjaMLozgwL5HoYRuZIucmy8jIP3S+lfi6
         XNyVqywZDUBhRA+S/wd92PnQoa15KZiLjST44mCKJOWz/Tzf9oBCIU7e8cj1lhNMnTuW
         AJnjhnj3h7kwQCfgjE29xZPsXuDHDBxhL5mxELgyHiVRbVl2tsMSluYzZT9FfGm/SiIl
         fG0KlXrWZNphxqRug0w17XeZUFhyKTDXC4pUtbsGTBSPPSd1ID5GBkftP+Ls8bixl4kJ
         zXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KER+4JIf9gIY2cMC4oOEDjUhiJLINXJm55esjUq2fNY=;
        b=f9U6MVaqQ9/EbrPkd/a8Nt6X9PMURe/TdQzAUrGkAr+D+cRUboSyUTJAvB/H569xXR
         se92GbD2tNKvuNO9nv9buZDaqxQ8PBD1+P3LWCVx2hbzDRoF3GOElykFsBG/8n/4wrIV
         mn8/7sKB19k2hrFi8TsWhgpMliPW942CXQ0MSSDx92U4uAbCXzrgYxLc+QQM44DSPn3F
         VW1A6X99vc7k/4UxUc+NJT3BNfVuxL7TXRpvWhmoCimiV6RDLof4pDA875kSE7zJOdUr
         20/JrwBakqJvZ6+5Ad4ooDB4jalv3r3CyejmzbcXnHA8spoBdBRRwzDJDviANDOoDRlL
         /zvg==
X-Gm-Message-State: AOAM531mgkmLn9W1K6WK51XDZvGoAtyG9X3LlZ5oF5B6CRjcAibKWPnu
        uldd/eBXBlaYeYLKtXj9i+Vz2ByQZxeeG8Y8QQU=
X-Google-Smtp-Source: ABdhPJwXLD5cm+TXfiestXAm3bmRnxBHr2x/rvINXj+9EyHLRhNwWhAVubWHstoqPvmIqYqiWqGQgHnUsOXdD+d5LNo=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr36037881ejy.341.1625817718436;
 Fri, 09 Jul 2021 01:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
In-Reply-To: <20210706224321.14371-1-sandals@crustytoothpaste.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Jul 2021 10:01:46 +0200
Message-ID: <CAP8UFD0t0=us1MWHTtEvVhNhWB1P6Q5gp-6v5XVGLBVeZ5RYKg@mail.gmail.com>
Subject: Re: [PATCH] rev-list: add option for --pretty without header
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 7, 2021 at 12:47 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In general, we encourage users to use plumbing commands, like git
> rev-list, over porcelain commands, like git log, when scripting.
> However, git rev-list has one glaring problem that prevents it from
> being used in certain cases: when --pretty is used, it always prints out
> a line containing "commit" and the object ID.

You say always, but it looks like it doesn't do it when
--pretty=3Doneline is used.

By the way this makes me think that the doc could be improved, because
it describes the format this way:

      =E2=80=A2   online

              <hash> <title line>

      =E2=80=A2   short

              commit <hash>
              Author: <author>

              <title line>

      =E2=80=A2   reference

              <abbrev hash> (<title line>, <short author date>)

      =E2=80=A2   email

              From <hash> <date>
              From: <author>
              Date: <author date>
              Subject: [PATCH] <title line>

              <full commit message>

while when --pretty=3Dreference or --pretty=3Demail is used the 'commit
<hash>' line is still printed despite not being shown in the doc.

> This makes it unsuitable
> for many scripting needs, and forces users to use git log instead.

I agree that it's annoying when using --pretty=3Dformat:'...'

> While we can't change this behavior for backwards compatibility, we can
> add an option to suppress this behavior, so let's do so, and call it
> "--no-commit-header".  Additionally, add the corresponding positive
> option to switch it back on.

It's not clear if this new option will remove the 'commit <hash>' line
when a builtin format like --pretty=3Dshort, --pretty=3Dmedium,
--pretty=3Dreference or --pretty=3Demail is used.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> This has come up a lot on the list and I'm sure most of the regulars
> have run into it before.

Yeah, I did run into it before. Thanks for doing something about it!

> It came up at $DAYJOB and I said I intended to
> send a patch, so here it is.
>
> I chose --no-commit-header because --header is already taken.

Yeah, that looks like the most obvious option name.

>  --header::
>         Print the contents of the commit in raw-format; each record is
>         separated with a NUL character.
> +
> +--no-commit-header::
> +       Suppress the header line containing "commit" and the object ID pr=
inted before
> +       the specified format.

This might want to tell what happens with builtin formats.

> +--commit-header::
> +       Overrides a previous `--no-commit-header`.
>  endif::git-rev-list[]
>
>  --parents::

[...]

> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index 35a2f62392..e68bf9f21c 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -54,9 +54,15 @@ test_expect_success 'setup' '
>
>  # usage: test_format name format_string [failure] <expected_output
>  test_format () {
> +       local header_arg=3D
> +       if test "$1" =3D "--no-commit-header"
> +       then
> +               header_arg=3D"--no-commit-header"
> +               shift
> +       fi
>         cat >expect.$1
>         test_expect_${3:-success} "format $1" "
> -               git rev-list --pretty=3Dformat:'$2' main >output.$1 &&
> +               git rev-list $header_arg --pretty=3Dformat:'$2' main >out=
put.$1 &&
>                 test_cmp expect.$1 output.$1
>         "
>  }

It looks like the tests only check what happens in case
--pretty=3Dformat:'...' is used, but I wonder what the code does if a
builtin format is used.
