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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD814C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790586157E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCIRE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCIREU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:04:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D7C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:04:20 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z5so6907713plg.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPAqXhIn6aT8RnGTihVy2F7PwxYFNm/bGfTtSzj/97g=;
        b=EuCF+8JwqOuC00gfkUqQBvOetgJ656VO9yQeMMyj8WjwiM86OcP0TyTeGua37CqBEq
         xLqVTW9KS+UlNZBOjdl1XF/tRiBVk1xAgRW0w/mfTZjVjbHLIbg+5GX8BiyqDuHZOHvz
         HXhpKJ6OtCnSWHy5JJnFSsSlxuuVzN1Cg3yhNVwMjroKX9g3zVkNUpGNBB11pdbVKH9j
         PVj/PdRI5kUNRLmftXxXh6iKoa+a3fZCCR43rrhrZKAxib5nrvfVnBsXg3J511Msq+4n
         AXGYU+v23P3T7msjzfqrC1inBqOOkmxAkM7C1EefPWWp3wGQ36e225ZF0ghwFg3YKwCv
         vmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPAqXhIn6aT8RnGTihVy2F7PwxYFNm/bGfTtSzj/97g=;
        b=FVDuaJ2NsIRKRDYhh9P0JlCNB+WX8jD1mIUdbOIS3j1jA2wT1Rl8BLoOq8HAWtoIgE
         WcNE/OktC6eBp6NSMrFFx6wv7AprZRWGnXzh3FKBPHr9OV3UYpzrbuKRyLdGB4nmBI0g
         AA+1wUUsxeHZ7K4mcdXaRq3vkO8DCNB2sOiQr4d9vOSOpX7tdVeSZSiRlcWGRzwEQbMj
         4uJ//c0x+P3+nOaExU1K9fp10pWCHIF5vj/3fwpyomlTsiKfSLQvhfhfiII+x3U7tiSJ
         8teJiN5mUALKWxfmybjyvP8B4bD+nCA6cJ0aSqM518MGuUauHJ8yQsRW4oR+vohzgYSr
         jPhg==
X-Gm-Message-State: AOAM533JM7NT83tFL4hoqhMxcUEL7MuAfugwtccYt0bEGvU08zmhO0mC
        b+xyIncnSBUpJm0X3mXX0LseEqHH+AMxz/TwIpbV+Kf8ixw=
X-Google-Smtp-Source: ABdhPJwAiWiNR0f9Wg0oC06od8Dsx08jv2hWZqkrrXcKiotaZ02gfuoxyLEMBJhR50rBpZnVRUrKiHJerfzUcZ30UxU=
X-Received: by 2002:a17:90b:1044:: with SMTP id gq4mr5532660pjb.232.1615309459923;
 Tue, 09 Mar 2021 09:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-10-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-10-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:04:08 -0800
Message-ID: <CABPp-BF7X5pqNYJXyQYs6BSC_QN4T_mTNmJ_v9=D9rOXnwyy3A@mail.gmail.com>
Subject: Re: [PATCH 09/30] tree.h users: format argument lists in archive.c
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Re-indent and re-flow the argument lists archive.c has downstream of
> its read_tree_recursive() call to make subsequent commits easier to
> read, as I only expect to be modifying the "stage" and "mode" lines.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index db69a8acadb..e245c0d5a54 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -140,7 +140,8 @@ static int check_attr_export_subst(const struct attr_=
check *check)
>  static int write_archive_entry(const struct object_id *oid, const char *=
base,
>                                int baselen, const char *filename,
>                                unsigned mode,
> -                              int stage, void *context)
> +                              int stage,
> +                              void *context)

You just barely changed this function signature in the previous patch
to split long lines, but left stage & context on the same line.  It
seems like this change should be squashed into the previous patch.

>  {
>         static struct strbuf path =3D STRBUF_INIT;
>         struct archiver_context *c =3D context;
> @@ -197,8 +198,10 @@ static int write_archive_entry(const struct object_i=
d *oid, const char *base,
>  }
>
>  static void queue_directory(const unsigned char *sha1,
> -               struct strbuf *base, const char *filename,
> -               unsigned mode, int stage, struct archiver_context *c)
> +                           struct strbuf *base, const char *filename,
> +                           unsigned mode,
> +                           int stage,
> +                           struct archiver_context *c)
>  {
>         struct directory *d;
>         size_t len =3D st_add4(base->len, 1, strlen(filename), 1);
> @@ -224,8 +227,10 @@ static int write_directory(struct archiver_context *=
c)
>         ret =3D
>                 write_directory(c) ||
>                 write_archive_entry(&d->oid, d->path, d->baselen,
> -                                   d->path + d->baselen, d->mode,
> -                                   d->stage, c) !=3D READ_TREE_RECURSIVE=
;
> +                                   d->path + d->baselen,
> +                                   d->mode,
> +                                   d->stage,
> +                                   c) !=3D READ_TREE_RECURSIVE;
>         free(d);
>         return ret ? -1 : 0;
>  }
> @@ -259,14 +264,18 @@ static int queue_or_write_archive_entry(const struc=
t object_id *oid,
>                 if (check_attr_export_ignore(check))
>                         return 0;
>                 queue_directory(oid->hash, base, filename,
> -                               mode, stage, c);
> +                               mode,
> +                               stage,
> +                               c);
>                 return READ_TREE_RECURSIVE;
>         }
>
>         if (write_directory(c))
>                 return -1;
> -       return write_archive_entry(oid, base->buf, base->len, filename, m=
ode,
> -                                  stage, context);
> +       return write_archive_entry(oid, base->buf, base->len, filename,
> +                                  mode,
> +                                  stage,
> +                                  context);
>  }
>
>  struct extra_file_info {
> --
> 2.31.0.rc0.126.g04f22c5b82
>
