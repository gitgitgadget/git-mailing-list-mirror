Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAE0C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 02:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAZC0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 21:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 21:26:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A81A943
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:26:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y19so493066ljq.7
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAtVvpB2aQuD1XitVpCSn+R23H3WLKoPPCHK4yn6sV4=;
        b=DvEuWCWm4mNdLcbEe+36kCaoAGmR1RhJ7L5uRwIeVoK1/I4I/TOcWOTaspKS8XTKs4
         mogPptjpdOtCNYmz16/xV8YdtZ8o/mTZAsB2DiiJUuvN4E+lh83dgIs/URlS0CUMoshH
         2RGrnYMt8h3idFqxNekunF9N2xzG79rXLfZhy8RFPwFehoDjBhr90IlaDU5AjTF5mFK3
         ZXXYF5nIxKdqKf6C5sc5L0glpTE+xlTbG1hfShMbkOjgVKNYW/7o6qKyKfLx96nJhexl
         RdTNd4dAbNUkztXr9oxpH2p00nMUvam4J6zwW1UaeZ4xA2LzRDTp7Dcad5SVgvXXvkoe
         /Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAtVvpB2aQuD1XitVpCSn+R23H3WLKoPPCHK4yn6sV4=;
        b=uGB2WS2SYsn9ibkhA0sOhQY6bUTQZpLj+UJnJORW0mmYm7OhgC6wUQopa039EpycRX
         2i4q2cErKB1MLgx29xbmKcWzA64n946WsSzPqebpejGiarhk1NsPamAhq/2b6LDAD4+i
         54Ky9XkNQsJH/DKHbJmgCgWS35esfNzmhivhsiK8cSLprGj9LTBk/XDbAv0XCBgIzhJW
         ByDQSgGVnq5a5IgN8tV1g+UBWJPwJWvn3B0M581fUfyhj/S4vTGpIzGImsTgZkmr8fK6
         c+PCGSdgZEaepgwDuHD1lyXsA1j3b3jhnZB+1ZAnNPsFgQTL09UDdh5189g1VHJtOJzW
         7aRg==
X-Gm-Message-State: AFqh2kr8b8NjRRdp/Of1ioERu0VPqibTLdOX3P5SvvT+tdwkxF8gywiq
        mZdxIxKkL3lPnWgAfLw20RreeROcZh1CFVB7L5s=
X-Google-Smtp-Source: AMrXdXtb5dYgBEAluHaVmDImqX3icahK46M79lrX9Fg32oUv+SVvD2LPZU9wR4+OL+LUuAWOHIYaHW+dBH2Xy0xNbrQ=
X-Received: by 2002:a2e:87ce:0:b0:28b:8405:1be4 with SMTP id
 v14-20020a2e87ce000000b0028b84051be4mr1427351ljj.178.1674699997177; Wed, 25
 Jan 2023 18:26:37 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-16.19-10959760dfc-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-16.19-10959760dfc-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 18:26:00 -0800
Message-ID: <CABPp-BGucUNYP8TK_aDs4AEPWg2NwaqDXbnqzNX9OZ5aFc4daQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/19] grep.c: refactor free_grep_patterns()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 5:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Refactor the free_grep_patterns() function to split out the freeing of
> the "struct grep_pat" it contains, right now we're only freeing the
> "pattern_list", but we should be freeing another member of the same
> type, which we'll do in the subsequent commit.

s/contains, right/contains. Right/

> Let's also replace the "return" if we don't have an
> "opt->pattern_expression" with a conditional call of
> free_pattern_expr().
>
> Before db84376f981 (grep.c: remove "extended" in favor of
> "pattern_expression", fix segfault, 2022-10-11) the pattern here was:
>
>         if (!x)
>                 return;
>         free(y);
>
> But after the cleanup in db84376f981 (which was a narrow segfault fix,
> and thus avoided refactoring this) we ended up with:

For most of your commits, I like the extended history, but in this
case I think it's just a distraction.  I think I'd replace the above
block with just five words:

    While at it, instead of:

>         if (!x)
>                 return;
>         free(x);
>
> Let's instead do:
>
>         if (x)
>                 free(x);

This is slightly confusing, because "if(x) free(x)" can be compressed
to "free(x)".  I think you meant "free_pattern_expr" rather than
"free", which cannot (currently) be similarly compressed.

> This doesn't matter for the subsequent change, but as we're
> refactoring this function let's make it easier to reason about, and to
> extend in the future, i.e. if we start to free free() members that
> come after "pattern_expression" in the "struct grep_opt".

Perhaps just simplify this paragraph to:

This will make it easier to free additional members from
free_grep_patterns() in the future.


>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 06eed694936..a4450df4559 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
>         free(x);
>  }
>
> -void free_grep_patterns(struct grep_opt *opt)
> +static void free_grep_pat(struct grep_pat *pattern)
>  {
>         struct grep_pat *p, *n;
>
> -       for (p =3D opt->pattern_list; p; p =3D n) {
> +       for (p =3D pattern; p; p =3D n) {
>                 n =3D p->next;
>                 switch (p->token) {
>                 case GREP_PATTERN: /* atom */
> @@ -790,10 +790,14 @@ void free_grep_patterns(struct grep_opt *opt)
>                 }
>                 free(p);
>         }
> +}
>
> -       if (!opt->pattern_expression)
> -               return;
> -       free_pattern_expr(opt->pattern_expression);
> +void free_grep_patterns(struct grep_opt *opt)
> +{
> +       free_grep_pat(opt->pattern_list);
> +
> +       if (opt->pattern_expression)
> +               free_pattern_expr(opt->pattern_expression);
>  }

I think this last function would read even better as:

+void free_grep_patterns(struct grep_opt *opt)
+{
+       free_grep_pat(opt->pattern_list);
+       free_pattern_expr(opt->pattern_expression);
 }

after modifying free_pattern_expr() to return early if passed a NULL argume=
nt.
