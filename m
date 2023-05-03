Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E4C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 02:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjECCPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjECCPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 22:15:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207A1FF6
        for <git@vger.kernel.org>; Tue,  2 May 2023 19:15:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso250758e87.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683080114; x=1685672114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3GvHcoMB2/6rhvuKleMRFjRjqwccK/K26TrcV0kBQo=;
        b=MdAAJta14AWfANFVfrzAAFm/oQ8do7SWtoS5H3V24VcQJL9tzhaU3eovjZTSS5G63P
         q/pkHn70a2q7YadZVuGselVyD+uQWmAsnINspdoNig83JHOR8m079E59SxvNgMfTqw3Q
         4l9bFSMiMuQ/Ek+XtSwE+Cbw05bLguYWOF+OOwHQIpuCMXq2XpcS7mc0J5Qb073scsJF
         EML3jt1NfZW2FPuOh7CfsiWK2RVM8GINcIpjeSEFsRG/C0FQ0ug1kf35FiOLEF4rgPhL
         OKtzar7c4JC6d1ccCwf9fz/U1ibR787QuF5Y2D1lGk1WraP+ih06x1H21KFUloT4rJw9
         +VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683080114; x=1685672114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3GvHcoMB2/6rhvuKleMRFjRjqwccK/K26TrcV0kBQo=;
        b=a0W+hpKOStN56kMhabaAUSfiPOLKEpp/XDk+FHvkxQoEzuGmP0VBOWSlY49IG13Xsi
         GlFjIXifB1c7ACW8iZ8i8Ivpt/mq8bYyCPhxhFXFyCPJFGyewFjmFA4WzWt6GrKJkf+J
         JC4r6le6BEwfJjwCgHNlf4rqgLcL5bUuiRzgqBNJPJ6Wcl3dYB3xiLC1k4D+uLTCm6KP
         kP6djbI0WYrLwWMaYf087HS3DekWbqO2jPY1XBJudbZKLBJXLyMd5vSy+VEpoFgpdXI4
         e5C/U56BqTmBPFmeg6enLwouZxXpJ/RdezGThxtTNZ1Mn+YIoo4Ul8+LV5WEp38wN3BL
         MFXw==
X-Gm-Message-State: AC+VfDxQLFr7rBVhB3D6J8o4CkQMTSYqp+QVK7DA2wJaM1hYSQzY9+NF
        lIq7ZO+n3fvGEmFeEfd19AAWTHpwSZQL8p681EKyEHGV
X-Google-Smtp-Source: ACHHUZ733sgxQGX/gxmyZNKJnkBwj5npLNFyI+gv+aLm5dOZ0Ynt5DfZ/2OA7NDXyMkgYdqRTlYjsN90UkoMT3KDgvo=
X-Received: by 2002:ac2:548f:0:b0:4d8:75f8:6963 with SMTP id
 t15-20020ac2548f000000b004d875f86963mr454350lfk.38.1683080113981; Tue, 02 May
 2023 19:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com> <20230502211454.1673000-7-calvinwan@google.com>
In-Reply-To: <20230502211454.1673000-7-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 19:15:00 -0700
Message-ID: <CABPp-BGgP50TV7Gc8bpu1vvR-6-EKKC8eM_j=o4imz7Y-55pMw@mail.gmail.com>
Subject: Re: [PATCH 6/6] strbuf: remove environment variables
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 2:15=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
>
> As a lower level library, strbuf should not directly access environment
> variables within its functions. Therefore, add an additional variable to
> function signatures for functions that use an environment variable and
> refactor callers to pass in the environment variable.

Yaay!  I hate the pervasive implicit use of globals throughout the
codebase, and like seeing changes that at least make them less hidden.

I might have split this patch into three, one for each of the
functions you are changing.  The reason is just that it makes review
so much easier; a simple --color-words view then becomes easy
to rapidly scan through on each patch.  When one patch includes all
three, reviewers have to double check the position of the added
parameter in the argument list against the name of the function.  But
that's a really minor point, and some might prefer as you have it here
with the three squashed together.

[...]
> diff --git a/strbuf.h b/strbuf.h
> index b6d53c1cbe..f90da8859f 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -283,7 +283,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos, siz=
e_t len,
>   * by a comment character and a blank.
>   */
>  void strbuf_add_commented_lines(struct strbuf *out,
> -                               const char *buf, size_t size);
> +                               const char *buf, size_t size,
> +                               char comment_line_char);
>
>
>  /**
> @@ -412,8 +413,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, =
...);
>   * Add a formatted string prepended by a comment character and a
>   * blank to the buffer.
>   */
> -__attribute__((format (printf, 2, 3)))
> -void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
> +__attribute__((format (printf, 3, 4)))
> +void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, co=
nst char *fmt, ...);
>
>  __attribute__((format (printf,2,0)))
>  void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
> @@ -538,7 +539,7 @@ int strbuf_normalize_path(struct strbuf *sb);
>   * Strip whitespace from a buffer. The second parameter controls if
>   * comments are considered contents to be removed or not.

Should this documentation string be updated, given that it previously
documented all arguments to the function?

>   */
> -void strbuf_stripspace(struct strbuf *buf, int skip_comments);
> +void strbuf_stripspace(struct strbuf *buf, int skip_comments, char comme=
nt_line_char);
>
>  static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suf=
fix)
>  {
[...]

The rest looks good to me.
