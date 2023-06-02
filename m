Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF9C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjFBSvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjFBSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 14:51:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D7E55
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 11:50:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f81ffc9065so28451cf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685731851; x=1688323851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEgSLjoM+kGN+tS9ZzzGV60baEPLMPyNBtlxAZp5jGA=;
        b=YHtwPpc2ymeqDdI0Ag6gUhDRDMQwL5KjwiGGxyaGdva82QcLsAYtqe1KWDpbfzf8Vv
         VHI5EyLP1vfwutZzTY0znVcWohib/tzyEEbzAN5zZYtFvm8GKORskQxgYZSL5zChdQWZ
         EJxwGStA1mYbxeh/YDlcpZP7mRsAagGht+4KLrmjgWoH/dOI8Lynv+RUX4AW8PGsfv6s
         qqW06XMPmTn7E6AU4YKt2v5iFCDuDvj+Hv+9ue4z0VMA1chmkso3u1n87Dv/Yff7D+Cv
         WpZTEabqRvNzlHAdjYLxP1VD8kcw/MN/hvm8U7JrWWVtMkAjWctxaNuewxpBzQYSbdIq
         kB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731851; x=1688323851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEgSLjoM+kGN+tS9ZzzGV60baEPLMPyNBtlxAZp5jGA=;
        b=dkYBVQSydkw+G2POdtQ06mHbfsz2xwodsZ0+0PwZ937cISqoHoZfPmLf4qCH0Uq1vc
         l7lLI6vk+rdHOeRrC+uyzTxtmviVMIJ3o4f5G3yz3ZoLPTRT6lBPEM4ccWVfi2mbo184
         +B9C8oRoY/DPn7fxX/dfmAfm0gquE50CR9MDxs4xbxHXdy3A865yHsSw2SJ/ZSTsV5ag
         qLQeetMMdP5BxnKECpo0uSHTVXdhyFZpePvKn3xlkZ40BvxYtzOUh/mXRhUY1oZrJDAK
         kScHC+W+FhJLB7eDDRthFHc7tPnQYo/c8oNrXv7TEAJxMzPmXICQqYMzU+VXP/u6hZFi
         UErw==
X-Gm-Message-State: AC+VfDx/VFL9amncgQHR3lKq7aN6aOFlPuL+JMU/+BEVkeDDbeU6ER6V
        rWAj4rZ423kgmv+WovaqpYBOAkI8hVJrNQW7lspvpdwe40kDwp2Xk5U=
X-Google-Smtp-Source: ACHHUZ61AbOjQyYI4hrv0GUhqOIcE9fR3MTIDYH/aUcoEMcPSN6izQS5fozn/ujx9Oa4qh20skWlVpLQXgW8LpAkai8=
X-Received: by 2002:ac8:58cf:0:b0:3f8:5b2:aeee with SMTP id
 u15-20020ac858cf000000b003f805b2aeeemr268686qta.22.1685731851409; Fri, 02 Jun
 2023 11:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230602184557.1445044-1-asedeno@google.com>
In-Reply-To: <20230602184557.1445044-1-asedeno@google.com>
From:   =?UTF-8?Q?Alejandro_Sede=C3=B1o?= <asedeno@google.com>
Date:   Fri, 2 Jun 2023 14:50:40 -0400
Message-ID: <CALVMLfJt7n_KxMY7x6d8VMtYY83ai24cwJPTEbeJwH+up17woA@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And today is the day I notice I misspelled my name in my git sendmail
config at work. Cool. (Fixed.)

-Alejandro


On Fri, Jun 2, 2023 at 2:46=E2=80=AFPM Aleajndro R Sede=C3=B1o <asedeno@goo=
gle.com> wrote:
>
> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> These definitions are used in cache.h, which can't include dir.h
> without causing name-info.cc to have two definitions of
> `struct dir_entry`.
>
> Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> place for these definitions.
>
> This change fixes a broken build issue on old SunOS.
>
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
> ---
>  dir.h      | 14 --------------
>  statinfo.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/dir.h b/dir.h
> index 79b85a01ee..d65a40126c 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -641,18 +641,4 @@ static inline int starts_with_dot_dot_slash_native(c=
onst char *const path)
>         return path_match_flags(path, what | PATH_MATCH_NATIVE);
>  }
>
> -#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> -#define DTYPE(de)      ((de)->d_type)
> -#else
> -#undef DT_UNKNOWN
> -#undef DT_DIR
> -#undef DT_REG
> -#undef DT_LNK
> -#define DT_UNKNOWN     0
> -#define DT_DIR         1
> -#define DT_REG         2
> -#define DT_LNK         3
> -#define DTYPE(de)      DT_UNKNOWN
> -#endif
> -
>  #endif
> diff --git a/statinfo.h b/statinfo.h
> index e49e3054ea..fe8df633a4 100644
> --- a/statinfo.h
> +++ b/statinfo.h
> @@ -21,4 +21,18 @@ struct stat_data {
>         unsigned int sd_size;
>  };
>
> +#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> +#define DTYPE(de)      ((de)->d_type)
> +#else
> +#undef DT_UNKNOWN
> +#undef DT_DIR
> +#undef DT_REG
> +#undef DT_LNK
> +#define DT_UNKNOWN     0
> +#define DT_DIR         1
> +#define DT_REG         2
> +#define DT_LNK         3
> +#define DTYPE(de)      DT_UNKNOWN
> +#endif
> +
>  #endif
> --
> 2.41.0.rc2.161.g9c6817b8e7-goog
>
