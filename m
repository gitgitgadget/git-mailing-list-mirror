Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8F7200B9
	for <e@80x24.org>; Mon,  7 May 2018 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeEGSsy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 14:48:54 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37975 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 14:48:53 -0400
Received: by mail-yb0-f196.google.com with SMTP id w14-v6so10284639ybm.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UK6I9tSZwxWd/iF3s2ZzKnip+9L0pZnqjjiz06slHY=;
        b=IDINlNqL9qSSH1dsG/yYFUXDF7m10FVIjWSOmLJLfaC2zpsOj1g6fzzE1GjCtQPVhq
         Baak5rHe7YvvCgrRhjhihC81xtY0fmIZIo+TrBQ1eeix2m8my1bVrM9iIz84/zSjIATg
         yM7aOnHaALJPhTWzy4BIx8APITHm96fyjlxX/TMLStUkAbX/PYNJC98dJD+DMyhDuf0u
         7hB8NJc3f/2/ZSB88/1Z0Lz1K2V5UY2ATeKD+Mn3sxqlKLuSsRV5pXYXc2SftICBVFNM
         mL18mLTXm9gzGtvkUjEIuQf0GxAZl+ZmPxdaXzNcBkDlKTA7eMh6pyItS2O1+0EadmNU
         5yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UK6I9tSZwxWd/iF3s2ZzKnip+9L0pZnqjjiz06slHY=;
        b=o1osyp0kBYQkOCt54J2Uz5nnJGpSBp8bNqlTA2tMcCDezRQR/xKVdrPQCB5e4jFITO
         v5/q6b2KDtCxxm3R7tP5+yxpVDsJfXgHQ5KBwlP7tC5lHvX5bSDTmHlWXLN8bIFYMpC1
         3KrhAMFS29GY0/D094YELL9dIjY7ebUs8ykgmDuC+xojXnxE1hBMbHC+l7YRY0TSBfcC
         uDrUa4V/VS7hR4zQxvKgU9Rp1rioxKshvrPuuGfpYLnjvC833ApQDecbcU51Rm2ORnBr
         qywirSYUz5nG8eo0AvqpbHkMhZHyLRz7ltXPP0uHmXQPLUbfU8g7FdAinU/BLaq86gLF
         YTig==
X-Gm-Message-State: ALKqPwdr07j5do1dBDS9Ae8pkMtkV4YFuhnYNFuLItb9vErWSYlWWS7e
        OxGW7w2tJAXXz3iVWXiEZAHPg/Qk2kH5k+rHRPnE9xJL
X-Google-Smtp-Source: AB8JxZrRmlfD8d3TLF8nUdUq2lNfDN0vf1FN1ZH9iwQlkcpR1vjWuwAYOBsDVOWiAytZk5oK6M35aauGS+ibZ8FDBo4=
X-Received: by 2002:a25:6910:: with SMTP id e16-v6mr4604662ybc.247.1525718932315;
 Mon, 07 May 2018 11:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 11:48:51 -0700 (PDT)
In-Reply-To: <20180506141031.30204-3-martin.agren@gmail.com>
References: <20180506141031.30204-3-martin.agren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 11:48:51 -0700
Message-ID: <CAGZ79kZ=7uv3-2mr97uS4Y=1AS5u=koYfH=fMSWfu4L8ajNoKA@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs.c: do not die if locking fails in `write_pseudoref()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Michael, who did extensive work in the refs.c code.

On Sun, May 6, 2018 at 7:10 AM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> If we could not take the lock, we add an error to the `strbuf err` and
> return. However, this code is dead. The reason is that we take the lock
> using `LOCK_DIE_ON_ERROR`. Drop the flag to allow our more gentle
> error-handling to actually kick in.
>
> We could instead just drop the dead code and die here. But everything is
> prepared for gently propagating the error, so let's do that instead.

This looks good to me.

> There is similar dead code in `delete_pseudoref()`, but let's save that
> for the next patch.
>
> While at it, make the lock non-static.

We seem to have a lot of static lockfiles in the code base. IIRC that
was due to some technicality of the lockfiles, as they would also
be cleaned up atexit() and for that it had to be static(?)

Maybe mention why it was static and why we can drop the static
now? Given that you found these answers in a reply below, this is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  refs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 8b7a77fe5e..8c50b8b139 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -644,7 +644,7 @@ static int write_pseudoref(const char *pseudoref, con=
st struct object_id *oid,
>  {
>         const char *filename;
>         int fd;
> -       static struct lock_file lock;
> +       struct lock_file lock =3D LOCK_INIT;
>         struct strbuf buf =3D STRBUF_INIT;
>         int ret =3D -1;
>
> @@ -654,8 +654,7 @@ static int write_pseudoref(const char *pseudoref, con=
st struct object_id *oid,
>         strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
>
>         filename =3D git_path("%s", pseudoref);
> -       fd =3D hold_lock_file_for_update_timeout(&lock, filename,
> -                                              LOCK_DIE_ON_ERROR,
> +       fd =3D hold_lock_file_for_update_timeout(&lock, filename, 0,
>                                                get_files_ref_lock_timeout=
_ms());
>         if (fd < 0) {
>                 strbuf_addf(err, "could not open '%s' for writing: %s",
> --
> 2.17.0.411.g9fd64c8e46
>
