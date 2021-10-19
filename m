Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55CCC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9302E61378
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 07:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJSHj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJSHj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 03:39:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FADC061745
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 00:37:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g36so5471726lfv.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YCdD3i6214oK2HQQwHVNitW+mjtfDPzoFwX25yY4ZkI=;
        b=RuzT4yyG9cDt+PkaZgXRHlGYAzGe675ZYfDoEzjFUDnHEu5+vfqHD7/Z9YUbjt69dl
         vZRnNDmuItYJL7OuHqUjiPyeYKXtn46MQ0TScZ4qI8gINvhctBGMO20zv5I74jUWWWsg
         SP6ldbjnQ4DKCQlthfnDorH24fKR+wKS12rRgiig4f8YbSwi5HXSwG+xvBpE0y19OY3R
         pO9qXNzrMT7GnO4VVWABJ0GyOCphy8ZYvBUn2Rvr+B7DmmeI89Vu0nW3uWaiokx375Rs
         eCQc3AFg4QYxPk3O9YfyrJ/lKZsT04a4sHwm0EKnGkJ+QLYqn7M8e0q/aX0ugQSYDXEV
         MVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YCdD3i6214oK2HQQwHVNitW+mjtfDPzoFwX25yY4ZkI=;
        b=CXiRb+6Gc9MVRVxsSuq6ykZ2t1jDsi7jVhJU1m1cybAKmB+Tsk4Own4HNb1cmbz/5E
         UajnTP80CNDiCMVdlfh6ouARsJUWuSME0MFy782i1RumT//PuD5ToaYkR/cVV2Xen3om
         HlqMTMs2TJfFVSN3ps+Una/6skb+cNeIcVjY57HAOPKBjaWhtH4r9AJMBlwZz6pTBT2h
         pK9TEFSikEDHiikTkLZHZFtJnvD0y8DcUYkfbMQCkiXfiPSTV1u70+a8KllcNe7o57c5
         qWBkBaYorwvrucKwsXNaI/X5kF1ON/O4Cymygsgd+qb3VuFITZ4fWQ0CmQZpoNg/u/Uj
         NAQg==
X-Gm-Message-State: AOAM531IRcp0SE7182zsbjIhnupowYmTkwErzF05m7mbVZrrdWEfh1ka
        ajEQRXMAexRldLzg6lCOUv/LxhNC514MnOE4Zl061OStxh5yAg==
X-Google-Smtp-Source: ABdhPJwlhfINdTLgz4DGBf5iNNfyBfENXMQ/upr1k66/9879Eus8iV2Q8h0FM71rPWRYY8CGZFILeREQSkk30ldPe6s=
X-Received: by 2002:a05:6512:1322:: with SMTP id x34mr4500893lfu.366.1634629062014;
 Tue, 19 Oct 2021 00:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 19 Oct 2021 15:37:30 +0800
Message-ID: <CAO0brD2J1zEP5=A1uuwvLsFMGZ9X6WaZuhEYZt7AHhzzKoJX5Q@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: unpack large object in stream
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any suggestions?

Han Xin <chiyutianyi@gmail.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=884:21=E5=86=99=E9=81=93=EF=BC=9A
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
> object to file in stream, and use the setting of "core.bigFileThreshold" =
as
> the threshold for large object.
>
> Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c          |  41 +++++++-
>  object-file.c                     | 149 +++++++++++++++++++++++++++---
>  object-store.h                    |   9 ++
>  t/t5590-receive-unpack-objects.sh |  92 ++++++++++++++++++
>  4 files changed, 279 insertions(+), 12 deletions(-)
>  create mode 100755 t/t5590-receive-unpack-objects.sh
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..8ac77e60a8 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -320,11 +320,50 @@ static void added_object(unsigned nr, enum object_t=
ype type,
>         }
>  }
>
> +static void fill_stream(struct git_zstream *stream)
> +{
> +       stream->next_in =3D fill(1);
> +       stream->avail_in =3D len;
> +}
> +
> +static void use_stream(struct git_zstream *stream)
> +{
> +       use(len - stream->avail_in);
> +}
> +
> +static void write_stream_blob(unsigned nr, unsigned long size)
> +{
> +       struct git_zstream_reader reader;
> +       struct object_id *oid =3D &obj_list[nr].oid;
> +
> +       reader.fill =3D &fill_stream;
> +       reader.use =3D &use_stream;
> +
> +       if (write_stream_object_file(&reader, size, type_name(OBJ_BLOB),
> +                                    oid, dry_run))
> +               die("failed to write object in stream");
> +       if (strict && !dry_run) {
> +               struct blob *blob =3D lookup_blob(the_repository, oid);
> +               if (blob)
> +                       blob->object.flags |=3D FLAG_WRITTEN;
> +               else
> +                       die("invalid blob object from stream");
> +       }
> +       obj_list[nr].obj =3D NULL;
> +}
> +
>  static void unpack_non_delta_entry(enum object_type type, unsigned long =
size,
>                                    unsigned nr)
>  {
> -       void *buf =3D get_data(size);
> +       void *buf;
> +
> +       /* Write large blob in stream without allocating full buffer. */
> +       if (type =3D=3D OBJ_BLOB && size > big_file_threshold) {
> +               write_stream_blob(nr, size);
> +               return;
> +       }
>
> +       buf =3D get_data(size);
>         if (!dry_run && buf)
>                 write_object(nr, type, buf, size);
>         else
> diff --git a/object-file.c b/object-file.c
> index a8be899481..06c1693675 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1913,6 +1913,28 @@ static int create_tmpfile(struct strbuf *tmp, cons=
t char *filename)
>         return fd;
>  }
>
> +static int write_object_buffer(struct git_zstream *stream, git_hash_ctx =
*c,
> +                              int fd, unsigned char *compressed,
> +                              int compressed_len, const void *buf,
> +                              size_t len, int flush)
> +{
> +       int ret;
> +
> +       stream->next_in =3D (void *)buf;
> +       stream->avail_in =3D len;
> +       do {
> +               unsigned char *in0 =3D stream->next_in;
> +               ret =3D git_deflate(stream, flush);
> +               the_hash_algo->update_fn(c, in0, stream->next_in - in0);
> +               if (write_buffer(fd, compressed, stream->next_out - compr=
essed) < 0)
> +                       die(_("unable to write loose object file"));
> +               stream->next_out =3D compressed;
> +               stream->avail_out =3D compressed_len;
> +       } while (ret =3D=3D Z_OK);
> +
> +       return ret;
> +}
> +
>  static int write_loose_object(const struct object_id *oid, char *hdr,
>                               int hdrlen, const void *buf, unsigned long =
len,
>                               time_t mtime)
> @@ -1949,17 +1971,9 @@ static int write_loose_object(const struct object_=
id *oid, char *hdr,
>         the_hash_algo->update_fn(&c, hdr, hdrlen);
>
>         /* Then the data itself.. */
> -       stream.next_in =3D (void *)buf;
> -       stream.avail_in =3D len;
> -       do {
> -               unsigned char *in0 =3D stream.next_in;
> -               ret =3D git_deflate(&stream, Z_FINISH);
> -               the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
> -               if (write_buffer(fd, compressed, stream.next_out - compre=
ssed) < 0)
> -                       die(_("unable to write loose object file"));
> -               stream.next_out =3D compressed;
> -               stream.avail_out =3D sizeof(compressed);
> -       } while (ret =3D=3D Z_OK);
> +       ret =3D write_object_buffer(&stream, &c, fd, compressed,
> +                                 sizeof(compressed), buf, len,
> +                                 Z_FINISH);
>
>         if (ret !=3D Z_STREAM_END)
>                 die(_("unable to deflate new object %s (%d)"), oid_to_hex=
(oid),
> @@ -2020,6 +2034,119 @@ int write_object_file(const void *buf, unsigned l=
ong len, const char *type,
>         return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
>  }
>
> +int write_stream_object_file(struct git_zstream_reader *reader,
> +                            unsigned long len, const char *type,
> +                            struct object_id *oid,
> +                            int dry_run)
> +{
> +       git_zstream istream, ostream;
> +       unsigned char buf[8192], compressed[4096];
> +       char hdr[MAX_HEADER_LEN];
> +       int istatus, ostatus, fd =3D 0, hdrlen, dirlen, flush =3D 0;
> +       int ret =3D 0;
> +       git_hash_ctx c;
> +       struct strbuf tmp_file =3D STRBUF_INIT;
> +       struct strbuf filename =3D STRBUF_INIT;
> +
> +       /* Write tmpfile in objects dir, because oid is unknown */
> +       if (!dry_run) {
> +               strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
> +               strbuf_addch(&filename, '/');
> +               fd =3D create_tmpfile(&tmp_file, filename.buf);
> +               if (fd < 0) {
> +                       if (errno =3D=3D EACCES)
> +                               ret =3D error(_("insufficient permission =
for adding an object to repository database %s"),
> +                                       get_object_directory());
> +                       else
> +                               ret =3D error_errno(_("unable to create t=
emporary file"));
> +                       goto cleanup;
> +               }
> +       }
> +
> +       memset(&istream, 0, sizeof(istream));
> +       istream.next_out =3D buf;
> +       istream.avail_out =3D sizeof(buf);
> +       git_inflate_init(&istream);
> +
> +       if (!dry_run) {
> +               /* Set it up */
> +               git_deflate_init(&ostream, zlib_compression_level);
> +               ostream.next_out =3D compressed;
> +               ostream.avail_out =3D sizeof(compressed);
> +               the_hash_algo->init_fn(&c);
> +
> +               /* First header */
> +               hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX, ty=
pe,
> +                               (uintmax_t)len) + 1;
> +               ostream.next_in =3D (unsigned char *)hdr;
> +               ostream.avail_in =3D hdrlen;
> +               while (git_deflate(&ostream, 0) =3D=3D Z_OK)
> +                       ; /* nothing */
> +               the_hash_algo->update_fn(&c, hdr, hdrlen);
> +       }
> +
> +       /* Then the data itself */
> +       do {
> +               unsigned char *last_out =3D istream.next_out;
> +               reader->fill(&istream);
> +               istatus =3D git_inflate(&istream, 0);
> +               if (istatus =3D=3D Z_STREAM_END)
> +                       flush =3D Z_FINISH;
> +               reader->use(&istream);
> +               if (!dry_run)
> +                       ostatus =3D write_object_buffer(&ostream, &c, fd,=
 compressed,
> +                                                     sizeof(compressed),=
 last_out,
> +                                                     istream.next_out - =
last_out,
> +                                                     flush);
> +               istream.next_out =3D buf;
> +               istream.avail_out =3D sizeof(buf);
> +       } while (istatus =3D=3D Z_OK);
> +
> +       if (istream.total_out !=3D len || istatus !=3D Z_STREAM_END)
> +               die( _("inflate returned %d"), istatus);
> +       git_inflate_end(&istream);
> +
> +       if (dry_run)
> +               goto cleanup;
> +
> +       if (ostatus !=3D Z_STREAM_END)
> +               die(_("unable to deflate new object (%d)"), ostatus);
> +       ostatus =3D git_deflate_end_gently(&ostream);
> +       if (ostatus !=3D Z_OK)
> +               die(_("deflateEnd on object failed (%d)"), ostatus);
> +       the_hash_algo->final_fn(oid->hash, &c);
> +       close_loose_object(fd);
> +
> +       /* We get the oid now */
> +       loose_object_path(the_repository, &filename, oid);
> +
> +       dirlen =3D directory_size(filename.buf);
> +       if (dirlen) {
> +               struct strbuf dir =3D STRBUF_INIT;
> +               /*
> +                * Make sure the directory exists; note that the contents
> +                * of the buffer are undefined after mkstemp returns an
> +                * error, so we have to rewrite the whole buffer from
> +                * scratch.
> +                */
> +               strbuf_add(&dir, filename.buf, dirlen - 1);
> +               if (mkdir(dir.buf, 0777) && errno !=3D EEXIST) {
> +                       unlink_or_warn(tmp_file.buf);
> +                       strbuf_release(&dir);
> +                       ret =3D -1;
> +                       goto cleanup;
> +               }
> +               strbuf_release(&dir);
> +       }
> +
> +       ret =3D finalize_object_file(tmp_file.buf, filename.buf);
> +
> +cleanup:
> +       strbuf_release(&tmp_file);
> +       strbuf_release(&filename);
> +       return ret;
> +}
> +
>  int hash_object_file_literally(const void *buf, unsigned long len,
>                                const char *type, struct object_id *oid,
>                                unsigned flags)
> diff --git a/object-store.h b/object-store.h
> index d24915ced1..12b113ef93 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -33,6 +33,11 @@ struct object_directory {
>         char *path;
>  };
>
> +struct git_zstream_reader {
> +       void (*fill)(struct git_zstream *);
> +       void (*use)(struct git_zstream *);
> +};
> +
>  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>         struct object_directory *, 1, fspathhash, fspatheq)
>
> @@ -225,6 +230,10 @@ int hash_object_file(const struct git_hash_algo *alg=
o, const void *buf,
>  int write_object_file(const void *buf, unsigned long len,
>                       const char *type, struct object_id *oid);
>
> +int write_stream_object_file(struct git_zstream_reader *reader,
> +                            unsigned long len, const char *type,
> +                            struct object_id *oid, int dry_run);
> +
>  int hash_object_file_literally(const void *buf, unsigned long len,
>                                const char *type, struct object_id *oid,
>                                unsigned flags);
> diff --git a/t/t5590-receive-unpack-objects.sh b/t/t5590-receive-unpack-o=
bjects.sh
> new file mode 100755
> index 0000000000..7e63dfc0db
> --- /dev/null
> +++ b/t/t5590-receive-unpack-objects.sh
> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Han Xin
> +#
> +
> +test_description=3D'Test unpack-objects when receive pack'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success "create commit with big blobs (1.5 MB)" '
> +       test-tool genrandom foo 1500000 >big-blob &&
> +       test_commit --append foo big-blob &&
> +       test-tool genrandom bar 1500000 >big-blob &&
> +       test_commit --append bar big-blob &&
> +       (
> +               cd .git &&
> +               find objects/?? -type f | sort
> +       ) >expect &&
> +       git repack -ad
> +'
> +
> +test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
> +       GIT_ALLOC_LIMIT=3D1m &&
> +       export GIT_ALLOC_LIMIT
> +'
> +
> +test_expect_success 'prepare dest repository' '
> +       git init --bare dest.git &&
> +       git -C dest.git config core.bigFileThreshold 2m &&
> +       git -C dest.git config receive.unpacklimit 100
> +'
> +
> +test_expect_success 'fail to push: cannot allocate' '
> +       test_must_fail git push dest.git HEAD 2>err &&
> +       test_i18ngrep "remote: fatal: attempting to allocate" err &&
> +       (
> +               cd dest.git &&
> +               find objects/?? -type f | sort
> +       ) >actual &&
> +       ! test_cmp expect actual
> +'
> +
> +test_expect_success 'set a lower bigfile threshold' '
> +       git -C dest.git config core.bigFileThreshold 1m
> +'
> +
> +test_expect_success 'unpack big object in stream' '
> +       git push dest.git HEAD &&
> +       git -C dest.git fsck &&
> +       (
> +               cd dest.git &&
> +               find objects/?? -type f | sort
> +       ) >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'setup for unpack-objects dry-run test' '
> +       PACK=3D$(echo main | git pack-objects --progress --revs test) &&
> +       unset GIT_ALLOC_LIMIT &&
> +       git init --bare unpack-test.git
> +'
> +
> +test_expect_success 'unpack-objects dry-run with large threshold' '
> +       (
> +               cd unpack-test.git &&
> +               git config core.bigFileThreshold 2m &&
> +               git unpack-objects -n <../test-$PACK.pack
> +       ) &&
> +       (
> +               cd unpack-test.git &&
> +               find objects/ -type f
> +       ) >actual &&
> +       test_must_be_empty actual
> +'
> +
> +test_expect_success 'unpack-objects dry-run with small threshold' '
> +       (
> +               cd unpack-test.git &&
> +               git config core.bigFileThreshold 1m &&
> +               git unpack-objects -n <../test-$PACK.pack
> +       ) &&
> +       (
> +               cd unpack-test.git &&
> +               find objects/ -type f
> +       ) >actual &&
> +       test_must_be_empty actual
> +'
> +
> +test_done
> --
> 2.33.0.1.g09a6bb964f.dirty
>
