Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F4C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071A461A3A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhKRFCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhKRFCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:02:16 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E4C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 20:59:16 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id i13so3744101qvm.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 20:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkJM9wSgdjsya1uBSZEp5+9C01McaXidP6Y9GTS6iB4=;
        b=I6WFim7RA+nXQ5P0lo2+LyVdHOqhyIXE/BCi5UwXHZWAe4AIvBoOPapkF3SZmFGsqM
         rSU+vtW6K4LxaQDOD+RrQ/sYb3Qjy8QW8WEt3xBgB5nJSZLIwKHUoQy2aMaSitH22kMe
         omzpboyzo3eXKibtzdjd5wdCEcFaC8AHuBwqBp1eC5Ct9gLbHgjSoJHaTVpv6jgZGCz0
         LJhxTrWeImu839js3l0M084jfrWR8G/vptjO8IcRc5Ph7s82Ue0BymIp7iNSywbQXqCD
         eIe6GEUbyPnPg6KgZxZKihhmp/6Wu6QfuMMHzrYNiEZldul0JNOPNBHgSp9yTqea0exl
         clsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkJM9wSgdjsya1uBSZEp5+9C01McaXidP6Y9GTS6iB4=;
        b=btyefWHHzf16YeGj10rG9hU28LLu5igCCe/z6kqBn4D9MO09bLEjJ66WXZGGNOsYbj
         CdvaAXOMk//QIYugx0RBu4/oVzh5qIAcN2/jdv8/mk+WKVvHE3zPRbxl3gZvY2l8mKEz
         dYAa2JIfA6bc0JjfYpx8k6qVPUs6RtQz3P19q8N6bafNh+dkB/9SRStvEcuotvxpeO+N
         PmKp1SnC3V6LPdswwksvVRlpQqLstgY/5o8oi1oUZR52EQvNVXjOfh5i8uLiiwJILYjW
         WufYYWLT3UKEJYPIfSWqUG7yDJaHrXLoJ0tRVUVxyu5RZGElOqPrNGgxxZ6rIdvax/S0
         dljQ==
X-Gm-Message-State: AOAM533X1GGqrMaOmm+gLrEq2mLscrjvMOXdFVkK8LX2VBQluOllavqF
        c05F4UrqbtgAPLKV29SPPceKsMTN1AnR4cr0hUDwLkgHxMTKtA==
X-Google-Smtp-Source: ABdhPJwTaG1RHGl2AKaIFYcHcKYhqpezpmKpfYqEWPIAbg9PqCdeC67v878DwpjPUzA2AY6d3LRUzCjdjExOF0sF65w=
X-Received: by 2002:a05:6214:2b0f:: with SMTP id jx15mr62432926qvb.62.1637211555920;
 Wed, 17 Nov 2021 20:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211112094010.73468-1-chiyutianyi@gmail.com>
In-Reply-To: <20211112094010.73468-1-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 12:59:04 +0800
Message-ID: <CANYiYbHiTnhpzyWLakVZ6tfmG0pKO=qHdZsgaocX6eJ=PN_06g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] object-file: refactor write_loose_object() to
 support inputstream
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

On Fri, Nov 12, 2021 at 5:43 PM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>

It would be better to provide a cover letter describing changes in v2, such as:

* Make "write_loose_object()" a public method, so we can
   reuse it in "unpack_non_delta_entry()".
   (But I doubt we can use "write_object_file_flags()" public
     function, without make this change.)

* Add an new interface "input_stream" as an argument for
   "write_loose_object()", so that we can feed data to
   "write_loose_object()" from buffer or from zlib stream.

> Refactor write_loose_object() to support inputstream, in the same way
> that zlib reading is chunked.

In the beginning of your commit log, you should describe the problem, such as:

We used to read the full content of a blob into buffer in
"unpack_non_delta_entry()" by calling:

    void *buf = get_data(size);

This will consume lots of memory for a very big blob object.

> Using "in_stream" instead of "void *buf", we needn't to allocate enough
> memory in advance, and only part of the contents will be read when
> called "in_stream.read()".
>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  object-store.h |  5 +++++
>  2 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 02b7970274..1ad2cb579c 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
>         return fd;
>  }
>
> +struct input_data_from_buffer {
> +       const char *buf;
> +       unsigned long len;
> +};
> +
> +static const char *read_input_stream_from_buffer(void *data, unsigned long *len)

Use "const void *" for the type of return variable, just like input
argument for write_loose_object()?

> +{
> +       struct input_data_from_buffer *input = (struct input_data_from_buffer *)data;
> +
> +       if (input->len == 0) {
> +               *len = 0;
> +               return NULL;
> +       }
> +       *len = input->len;
> +       input->len = 0;
> +       return input->buf;
> +}
> +
>  static int write_loose_object(const struct object_id *oid, char *hdr,
> -                             int hdrlen, const void *buf, unsigned long len,
> +                             int hdrlen, struct input_stream *in_stream,
>                               time_t mtime, unsigned flags)
>  {
>         int fd, ret;
> @@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>         struct object_id parano_oid;
>         static struct strbuf tmp_file = STRBUF_INIT;
>         static struct strbuf filename = STRBUF_INIT;
> +       const char *buf;

Can we use the same prototype as the original:  "const void *buf" ?

> +       unsigned long len;
>
>         loose_object_path(the_repository, &filename, oid);
>
> @@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>         the_hash_algo->update_fn(&c, hdr, hdrlen);
>
>         /* Then the data itself.. */
> +       buf = in_stream->read(in_stream->data, &len);
>         stream.next_in = (void *)buf;
>         stream.avail_in = len;
>         do {
> @@ -1960,6 +1981,13 @@ int write_object_file_flags(const void *buf, unsigned long len,
>  {
>         char hdr[MAX_HEADER_LEN];
>         int hdrlen = sizeof(hdr);
> +       struct input_stream in_stream = {
> +               .read = read_input_stream_from_buffer,
> +               .data = (void *)&(struct input_data_from_buffer) {
> +                       .buf = buf,
> +                       .len = len,
> +               },
> +       };
>
>         /* Normally if we have it in the pack then we do not bother writing
>          * it out into .git/objects/??/?{38} file.
> @@ -1968,7 +1996,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
>                                   &hdrlen);
>         if (freshen_packed_object(oid) || freshen_loose_object(oid))
>                 return 0;
> -       return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
> +       return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
>  }
>
>  int hash_object_file_literally(const void *buf, unsigned long len,
> @@ -1977,6 +2005,13 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  {
>         char *header;
>         int hdrlen, status = 0;
> +       struct input_stream in_stream = {
> +               .read = read_input_stream_from_buffer,
> +               .data = (void *)&(struct input_data_from_buffer) {
> +                       .buf = buf,
> +                       .len = len,
> +               },
> +       };
>
>         /* type string, SP, %lu of the length plus NUL must fit this */
>         hdrlen = strlen(type) + MAX_HEADER_LEN;
> @@ -1988,7 +2023,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>                 goto cleanup;
>         if (freshen_packed_object(oid) || freshen_loose_object(oid))
>                 goto cleanup;
> -       status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
> +       status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
>
>  cleanup:
>         free(header);
> @@ -2003,14 +2038,21 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
>         char hdr[MAX_HEADER_LEN];
>         int hdrlen;
>         int ret;
> +       struct input_data_from_buffer data;
> +       struct input_stream in_stream = {
> +               .read = read_input_stream_from_buffer,
> +               .data = &data,
> +       };
>
>         if (has_loose_object(oid))
>                 return 0;
>         buf = read_object(the_repository, oid, &type, &len);
>         if (!buf)
>                 return error(_("cannot read object for %s"), oid_to_hex(oid));
> +       data.buf = buf;
> +       data.len = len;
>         hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
> -       ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
> +       ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
>         free(buf);
>
>         return ret;
> diff --git a/object-store.h b/object-store.h
> index 952efb6a4b..f1b67e9100 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -34,6 +34,11 @@ struct object_directory {
>         char *path;
>  };
>
> +struct input_stream {
> +       const char *(*read)(void* data, unsigned long *len);
> +       void *data;
> +};
> +
>  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>         struct object_directory *, 1, fspathhash, fspatheq)
>
> --
> 2.33.1.44.g9344627884.agit.6.5.4
>
