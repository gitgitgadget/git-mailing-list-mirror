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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF4C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 08:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D01360E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 08:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYHra (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhGYHra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 03:47:30 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB356C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 01:27:59 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id p13so3540661vsg.2
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PkzN4xUqkEIsZRn4ZbuUqQLptDu/wlgD8kxpp1Hk9e8=;
        b=Bb7ZUBbpMwjPcL4UvJhvXJ+FGP+or0B2zYPfr03eltpK1GHKyTSPl1tbYgmGiEUujG
         8kGz4x168og3mrgZe0UPGJ/a55Ffq/CqCNBTg+wXlgbKF7xv69LiX4UeNgL3nvEqb8RB
         pcux2cpQ1o1EfZeTsi8gJ7Vzc9AayaLwMhlNTozCCPdihLCHVoxQuLMwQMlDXFQJWN/e
         sjtGQHOKB4XHuyWAZ4BJhNADkO5+ZDQy0yUXacU60k5Ds9zTpP+/WvUF4orgGclGCDvZ
         YKI4fokr35y92VlodkSzE00Se1n8qR87Cj2IoEdak9KhqauuHa5ozk01aubxVOXWVNdO
         N1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PkzN4xUqkEIsZRn4ZbuUqQLptDu/wlgD8kxpp1Hk9e8=;
        b=P6eIPsxh8jFzYqOz5sL6fiC5c19dxA4Cb26W7BUmEZsazWbpgKo2D5hie/4+G4v3EO
         3aV5zeCYYIenxmC4WSS0wXK9vkN60gQfJsPQGoDd0NbM5oSNn7hpdvhjAbmj2qqYKalU
         yZ3//ZL1Fv9z1ronRc5THAgF/ZOb9GW1I81ro4cnGSHIH5oTNoMoOrO1w28OyaaUu6az
         gsi+zwYPt8a9Tclq8lk1CeBKW8aKYN+28z4jWT1dlx4Sxz5gjV9koAVgXPk0MY2o6L6i
         MsNdsBxRcZWijXSfFbGc6cNCCa3yQzPZUtUDwlQdOdJ1Fo8iilc01BUYMWg/RJ7GOLi6
         jiPg==
X-Gm-Message-State: AOAM5315SMoV2nWMOga5XIznX6fsG5kFO4sOIAI9u9AO6UlFSq8gb6iz
        Bee69JtjvpRyYHAHPkFjqWodCis9NQU6d3tz7Js=
X-Google-Smtp-Source: ABdhPJzS1jjUS9hnoTVN+v0rwbL5AhmMfkrh6MJPRsAR0ROqBCQd8X5GFkz+9TK3AtRU4VG98aHk0vCk9XVeYsJDwP0=
X-Received: by 2002:a67:f90c:: with SMTP id t12mr9526719vsq.27.1627201678999;
 Sun, 25 Jul 2021 01:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
 <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com> <ac5d98647dad31ebe165daa7cbf84f2b7e5fbe80.1627136062.git.gitgitgadget@gmail.com>
In-Reply-To: <ac5d98647dad31ebe165daa7cbf84f2b7e5fbe80.1627136062.git.gitgitgadget@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Jul 2021 01:27:48 -0700
Message-ID: <CA+P7+xqYMt1TvDY-GO--Aw5n9L7_06e-TExszcsS5oWWtFUxsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] [GSOC] ref-filter: --format=%(raw) re-support --perl
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 24, 2021 at 7:14 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Because the perl language can handle binary data correctly,
> add the function perl_quote_buf_with_len(), which can specify
> the length of the data and prevent the data from being truncated
> at '\0' to help `--format=3D"%(raw)"` re-support `--perl`.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

I presume that we used to support raw with perl before in cat-file? It
did read a bit weird to see "Re-support" in the title, because the
previous patch which introduced the raw atom when in ref-filter code
never supported perl. Still, I think it's fairly clear either way and
that change wouldn't deserve a reroll on its own.

Makes sense. Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

>  Documentation/git-for-each-ref.txt |  4 ++--
>  quote.c                            | 17 +++++++++++++++++
>  quote.h                            |  1 +
>  ref-filter.c                       | 15 +++++++++++----
>  t/t6300-for-each-ref.sh            | 19 +++++++++++++++++--
>  5 files changed, 48 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-e=
ach-ref.txt
> index cbb6f87d13f..6da899c6296 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -241,8 +241,8 @@ raw:size::
>         The raw data size of the object.
>
>  Note that `--format=3D%(raw)` can not be used with `--python`, `--shell`=
, `--tcl`,
> -`--perl` because such language may not support arbitrary binary data in =
their
> -string variable type.
> +because such language may not support arbitrary binary data in their str=
ing
> +variable type.
>
>  The message in a commit or a tag object is `contents`, from which
>  `contents:<part>` can be used to extract various parts out of:
> diff --git a/quote.c b/quote.c
> index 8a3a5e39eb1..26719d21d1e 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -471,6 +471,23 @@ void perl_quote_buf(struct strbuf *sb, const char *s=
rc)
>         strbuf_addch(sb, sq);
>  }
>
> +void perl_quote_buf_with_len(struct strbuf *sb, const char *src, size_t =
len)
> +{
> +       const char sq =3D '\'';
> +       const char bq =3D '\\';
> +       const char *c =3D src;
> +       const char *end =3D src + len;
> +
> +       strbuf_addch(sb, sq);
> +       while (c !=3D end) {
> +               if (*c =3D=3D sq || *c =3D=3D bq)
> +                       strbuf_addch(sb, bq);
> +               strbuf_addch(sb, *c);
> +               c++;
> +       }
> +       strbuf_addch(sb, sq);
> +}
> +
>  void python_quote_buf(struct strbuf *sb, const char *src)
>  {
>         const char sq =3D '\'';
> diff --git a/quote.h b/quote.h
> index 768cc6338e2..0fe69e264b0 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -94,6 +94,7 @@ char *quote_path(const char *in, const char *prefix, st=
ruct strbuf *out, unsigne
>
>  /* quoting as a string literal for other languages */
>  void perl_quote_buf(struct strbuf *sb, const char *src);
> +void perl_quote_buf_with_len(struct strbuf *sb, const char *src, size_t =
len);
>  void python_quote_buf(struct strbuf *sb, const char *src);
>  void tcl_quote_buf(struct strbuf *sb, const char *src);
>  void basic_regex_quote_buf(struct strbuf *sb, const char *src);
> diff --git a/ref-filter.c b/ref-filter.c
> index 01545618101..597354c941d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -746,7 +746,10 @@ static void quote_formatting(struct strbuf *s, const=
 char *str, size_t len, int
>                 sq_quote_buf(s, str);
>                 break;
>         case QUOTE_PERL:
> -               perl_quote_buf(s, str);
> +               if (len !=3D -1)
> +                       perl_quote_buf_with_len(s, str, len);
> +               else
> +                       perl_quote_buf(s, str);
>                 break;
>         case QUOTE_PYTHON:
>                 python_quote_buf(s, str);
> @@ -1010,10 +1013,14 @@ int verify_ref_format(struct ref_format *format)
>                 at =3D parse_ref_filter_atom(format, sp + 2, ep, &err);
>                 if (at < 0)
>                         die("%s", err.buf);
> -               if (format->quote_style && used_atom[at].atom_type =3D=3D=
 ATOM_RAW &&
> -                   used_atom[at].u.raw_data.option =3D=3D RAW_BARE)
> +
> +               if ((format->quote_style =3D=3D QUOTE_PYTHON ||
> +                    format->quote_style =3D=3D QUOTE_SHELL ||
> +                    format->quote_style =3D=3D QUOTE_TCL) &&
> +                    used_atom[at].atom_type =3D=3D ATOM_RAW &&
> +                    used_atom[at].u.raw_data.option =3D=3D RAW_BARE)
>                         die(_("--format=3D%.*s cannot be used with"
> -                             "--python, --shell, --tcl, --perl"), (int)(=
ep - sp - 2), sp + 2);
> +                             "--python, --shell, --tcl"), (int)(ep - sp =
- 2), sp + 2);
>                 cp =3D ep + 1;
>

Right, so now we have to check all of the format quote styles instead
of just checking that its set to any of them, since we want to
continue in the case of perl.

Ok.

>                 if (skip_prefix(used_atom[at].name, "color:", &color))
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 18554f62d94..3d15d0a5360 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -915,8 +915,23 @@ test_expect_success '%(raw) with --tcl must fail' '
>         test_must_fail git for-each-ref --format=3D"%(raw)" --tcl
>  '
>
> -test_expect_success '%(raw) with --perl must fail' '
> -       test_must_fail git for-each-ref --format=3D"%(raw)" --perl
> +test_expect_success '%(raw) with --perl' '
> +       git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob1 --perl | perl >actual &&
> +       cmp blob1 actual &&
> +       git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob3 --perl | perl >actual &&
> +       cmp blob3 actual &&
> +       git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob8 --perl | perl >actual &&
> +       cmp blob8 actual &&
> +       git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/first --perl | perl >actual &&
> +       cmp one actual &&
> +       git cat-file tree refs/mytrees/first > expected &&
> +       git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/mytrees/first --perl | perl >actual &&
> +       cmp expected actual
>  '
>
>  test_expect_success '%(raw) with --shell must fail' '
> --
> gitgitgadget
>
