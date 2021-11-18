Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7927AC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D926135E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbhKRHSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKRHSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:18:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B2C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:15:02 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t11so5202054qtw.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dwuS7bKikd69dGMhagfxRqVdQoo3I37wk6LNGhvwds=;
        b=NgweYrT1ZCyzYrWRx7CRcfhNjKciD7bWR6G0JQRrsPptloiboQbuws0qQmbprjxTHO
         kE8nB3FsviKbREsqr2Q4gh2sOfyGjatN9RBfBsieAwkT/YsvsFNC4JLRJ+KdT+Lg/l8N
         SFqIOzF+Vnwt8asRXqgcwFIYK3/+nzOkwpk6G81uXAqqLC6MFwLlA+ag+3RYREUQWG2p
         RhUJgIhEglv35Y6mVmOYhND9pG8z+xRw7qogYi4b89Kmb+jKOeLJ1VCfw4xAQV0iKtai
         UBzz8ESDgBBWjK8uQa0figTmTBhgKLPgyfNINMbvSTXUYK/Qfhkrm2mFE72hpQi6ixOb
         +e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dwuS7bKikd69dGMhagfxRqVdQoo3I37wk6LNGhvwds=;
        b=eSX5d1BXjTA8OkVGC/8jL7OK7qL8gUm3+l+AlC1kxXCbItKsuvhIaAZuh4IqK6uZrP
         RPEw44zzbjxgOCake3qlvZ20HVpC6sFAAqDEHtxUjXILlOeb869ITNccTBvfp4HAKPOZ
         SRZw1u5jR3h2h6oCL5G/bdzqvea6syqB+DsGym04/07vr2ZjGxd2NKKHYdlvx1QWAsom
         GEocZwOq0rLcs89B4SLyH7N/QBqrXFqb2mxl/p5c0nxIjjMm8aqjcLaYxpu7SqS6sead
         5XZE1neukObXb1k+UGEpSSLudXE40jAk9PkKM0UDNkGGCEXDEfIedPIutoRnoGVl6JpU
         E0dw==
X-Gm-Message-State: AOAM532uDdoVNdU2+7BO97FmWu80HTOCjzU/O6u4criVkkwE6nq2XQdb
        N2OMrFv7rT0Q40LupWol1uPfBed9pXkDcG42Tpc=
X-Google-Smtp-Source: ABdhPJxO+dcHU4sl/joMHh2QP61bLi4ydeZZumVHoAjyQKn5eDgaLy2gYu/LXcuqr8dzdHeuWv+Awnpfy/qpCEuyp5E=
X-Received: by 2002:ac8:18c:: with SMTP id x12mr22336410qtf.378.1637219701311;
 Wed, 17 Nov 2021 23:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211112094010.73468-6-chiyutianyi@gmail.com>
In-Reply-To: <20211112094010.73468-6-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 15:14:50 +0800
Message-ID: <CANYiYbHMoH=pEhpx36ev-KWa7AXQtXpSiyjYObP1=XEx=Y8UNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] unpack-objects: unpack large object in stream
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 12, 2021 at 5:42 PM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When calling "unpack_non_delta_entry()", will allocate full memory for
> the whole size of the unpacked object and write the buffer to loose file
> on disk. This may lead to OOM for the git-unpack-objects process when
> unpacking a very large object.
>
> In function "unpack_delta_entry()", will also allocate full memory to
> buffer the whole delta, but since there will be no delta for an object
> larger than "core.bigFileThreshold", this issue is moderate.
>
> To resolve the OOM issue in "git-unpack-objects", we can unpack large
> object to file in stream, and use "core.bigFileThreshold" to avoid OOM
> limits when called "get_data()".
>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c          | 76 ++++++++++++++++++++++++-
>  t/t5590-receive-unpack-objects.sh | 92 +++++++++++++++++++++++++++++++
>  2 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5590-receive-unpack-objects.sh
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..6c757d823b 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -320,11 +320,85 @@ static void added_object(unsigned nr, enum object_type type,
>         }
>  }
>
> +struct input_data_from_zstream {
> +       git_zstream *zstream;
> +       unsigned char buf[4096];
> +       int status;
> +};
> +
> +static const char *read_inflate_in_stream(void *data, unsigned long *readlen)
> +{
> +       struct input_data_from_zstream *input = data;
> +       git_zstream *zstream = input->zstream;
> +       void *in = fill(1);
> +
> +       if (!len || input->status == Z_STREAM_END) {
> +               *readlen = 0;
> +               return NULL;
> +       }
> +
> +       zstream->next_out = input->buf;
> +       zstream->avail_out = sizeof(input->buf);
> +       zstream->next_in = in;
> +       zstream->avail_in = len;
> +
> +       input->status = git_inflate(zstream, 0);
> +       use(len - zstream->avail_in);
> +       *readlen = sizeof(input->buf) - zstream->avail_out;
> +
> +       return (const char *)input->buf;
> +}
> +
> +static void write_stream_blob(unsigned nr, unsigned long size)
> +{
> +       char hdr[32];
> +       int hdrlen;
> +       git_zstream zstream;
> +       struct input_data_from_zstream data;
> +       struct input_stream in_stream = {
> +               .read = read_inflate_in_stream,
> +               .data = &data,
> +       };
> +       struct object_id *oid = &obj_list[nr].oid;
> +       int ret;
> +
> +       memset(&zstream, 0, sizeof(zstream));
> +       memset(&data, 0, sizeof(data));
> +       data.zstream = &zstream;
> +       git_inflate_init(&zstream);
> +
> +       /* Generate the header */
> +       hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
> +
> +       if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, dry_run, 0, 0)))
> +               die(_("failed to write object in stream %d"), ret);
> +
> +       if (zstream.total_out != size || data.status != Z_STREAM_END)
> +               die(_("inflate returned %d"), data.status);
> +       git_inflate_end(&zstream);
> +
> +       if (strict && !dry_run) {
> +               struct blob *blob = lookup_blob(the_repository, oid);
> +               if (blob)
> +                       blob->object.flags |= FLAG_WRITTEN;
> +               else
> +                       die("invalid blob object from stream");
> +       }
> +       obj_list[nr].obj = NULL;
> +}
> +
>  static void unpack_non_delta_entry(enum object_type type, unsigned long size,
>                                    unsigned nr)
>  {
> -       void *buf = get_data(size);
> +       void *buf;
> +
> +       /* Write large blob in stream without allocating full buffer. */
> +       if (type == OBJ_BLOB && size > big_file_threshold) {

Default size of big_file_threshold is 512m.  Can we use
"write_stream_blob" for all objects?  Can we get a more suitable
threshold through some benchmark data?

> +               write_stream_blob(nr, size);
> +               return;
> +       }

--
Jiang Xin
