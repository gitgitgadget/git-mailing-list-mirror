Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAA860FED
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJUDpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhJUDpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:45:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E8C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:42:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so702214lfu.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hcsH2RILL7yJMkzUUAi7S4YdwiU7bw7FSJ9fxXni2y0=;
        b=q7JCsx5IpoplZ0QDAsSyjK8SUNrrf5lQYW6iwAKQtOyDZeoh0uAnW6rJ3gBGuMKMEi
         oNe7wbtuo6LOOGDPSubKA2SfWMby7wMkAR1oJ2R4RslTUFzDFhnq7IZfKm1Roamz0kiv
         ex1Eoce9HDEEYrHUZ5u8i3JExMIOElXe4b7F8HOY1m7kv+0GVCK+mvjI+jyOV29KWBL0
         b2rFxt6pFhtaIwzKHI9I4gN2FfIXAfhRCgREuclYom0azB2QgeuE7UX+nCGUsO2Z4aRA
         DU0fXERilSt0QcgFtl7FJseuWHv0RD5yhahGX2xXd56xThze1EyHiwezqaCK+K3YqLGY
         4txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcsH2RILL7yJMkzUUAi7S4YdwiU7bw7FSJ9fxXni2y0=;
        b=nv/rBr5szPsfodJTwZN9F5SyQVXHiccDaa/1dusuGD3aKpMoXgDHPirSPvvdjHj8ij
         mPtIYOctDH2I/GdKv5CNNiByXlkVeGpXaOwpPZJ50FBy+cm70ZuY/1G1/6pwInhRKMPl
         2Uaw516gGlLuJNR+4vKDLnaKUAmIIZ+2AhLPNrhzGZLtvJkScqvXL2bUaTKsePP3CCv0
         1joQlyzGM7imkXNos0/XT/IR8kVir52jkfWRbCSqTVBxgG8bUUwtFdM0ch8EVJcxbiJh
         gAsqhj6Ph4VPbhyhYUySW1bzleyzx2y4pi2SbGJP5FSjEfgwvR9JEh9z1p2FgUqokUJ0
         pWrQ==
X-Gm-Message-State: AOAM532pVmdH1Pg6vdzVYlpuY81jqMdYtmhN3F3zN98EJATP9rhhRw19
        CWy2tVMKXWrdGWw9ThAR644VamMkuOiG7xJguVk=
X-Google-Smtp-Source: ABdhPJzJAtE0eQLNbR1R6nv1t48uiyxoArmQ8PLOlYQr+HE0zKtujM8tczv6ZtfOYg6jqYLgaza83Bnx39QYp3cgyLc=
X-Received: by 2002:a05:6512:a8d:: with SMTP id m13mr3250217lfu.305.1634787777622;
 Wed, 20 Oct 2021 20:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <aeb1c7cb-7e01-8a21-5f7a-d27bd43d7604@iee.email>
In-Reply-To: <aeb1c7cb-7e01-8a21-5f7a-d27bd43d7604@iee.email>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Thu, 21 Oct 2021 11:42:46 +0800
Message-ID: <CAO0brD1CXhuAwQe5mmjWcD1dF-cdRdk4o1rm0wyygbhEjRR84g@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: unpack large object in stream
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> =E4=BA=8E2021=E5=B9=B410=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:43=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 09/10/2021 09:20, Han Xin wrote:
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > When calling "unpack_non_delta_entry()", will allocate full memory for
> > the whole size of the unpacked object and write the buffer to loose fil=
e
> > on disk. This may lead to OOM for the git-unpack-objects process when
> > unpacking a very large object.
> >
> > In function "unpack_delta_entry()", will also allocate full memory to
> > buffer the whole delta, but since there will be no delta for an object
> > larger than "core.bigFileThreshold", this issue is moderate.
> >
> > To resolve the OOM issue in "git-unpack-objects", we can unpack large
> > object to file in stream, and use the setting of "core.bigFileThreshold=
" as
> > the threshold for large object.
> >
> > Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  builtin/unpack-objects.c          |  41 +++++++-
> >  object-file.c                     | 149 +++++++++++++++++++++++++++---
> >  object-store.h                    |   9 ++
> >  t/t5590-receive-unpack-objects.sh |  92 ++++++++++++++++++
> >  4 files changed, 279 insertions(+), 12 deletions(-)
> >  create mode 100755 t/t5590-receive-unpack-objects.sh
> >
> > diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> > index 4a9466295b..8ac77e60a8 100644
> > --- a/builtin/unpack-objects.c
> > +++ b/builtin/unpack-objects.c
> > @@ -320,11 +320,50 @@ static void added_object(unsigned nr, enum object=
_type type,
> >       }
> >  }
> >
> > +static void fill_stream(struct git_zstream *stream)
> > +{
> > +     stream->next_in =3D fill(1);
> > +     stream->avail_in =3D len;
> > +}
> > +
> > +static void use_stream(struct git_zstream *stream)
> > +{
> > +     use(len - stream->avail_in);
> > +}
> > +
> > +static void write_stream_blob(unsigned nr, unsigned long size)
>
> Can we use size_t for the `size`, and possibly `nr`, to improve
> compatibility with Windows systems where unsigned long is only 32 bits?
>
> There has been some work in the past on providing large file support on
> Windows, which requires numerous long -> size_t changes.
>
> Philip

Thanks for your review. I'm not sure if I should do this change in this pat=
ch,
it will also change the type defined in `unpack_one()`,`unpack_non_delta_en=
try`,
`write_object()` and many others.

> > +{
> > +     struct git_zstream_reader reader;
> > +     struct object_id *oid =3D &obj_list[nr].oid;
> > +
> > +     reader.fill =3D &fill_stream;
> > +     reader.use =3D &use_stream;
> > +
> > +     if (write_stream_object_file(&reader, size, type_name(OBJ_BLOB),
> > +                                  oid, dry_run))
> > +             die("failed to write object in stream");
> > +     if (strict && !dry_run) {
> > +             struct blob *blob =3D lookup_blob(the_repository, oid);
> > +             if (blob)
> > +                     blob->object.flags |=3D FLAG_WRITTEN;
> > +             else
> > +                     die("invalid blob object from stream");
> > +     }
> > +     obj_list[nr].obj =3D NULL;
> > +}
> > +
> >  static void unpack_non_delta_entry(enum object_type type, unsigned lon=
g size,
> >                                  unsigned nr)
> >  {
> > -     void *buf =3D get_data(size);
> > +     void *buf;
> > +
> > +     /* Write large blob in stream without allocating full buffer. */
> > +     if (type =3D=3D OBJ_BLOB && size > big_file_threshold) {
> > +             write_stream_blob(nr, size);
> > +             return;
> > +     }
> >
> > +     buf =3D get_data(size);
> >       if (!dry_run && buf)
> >               write_object(nr, type, buf, size);
> >       else
> > diff --git a/object-file.c b/object-file.c
> > index a8be899481..06c1693675 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1913,6 +1913,28 @@ static int create_tmpfile(struct strbuf *tmp, co=
nst char *filename)
> >       return fd;
> >  }
> >
> > +static int write_object_buffer(struct git_zstream *stream, git_hash_ct=
x *c,
> > +                            int fd, unsigned char *compressed,
> > +                            int compressed_len, const void *buf,
> > +                            size_t len, int flush)
> > +{
> > +     int ret;
> > +
> > +     stream->next_in =3D (void *)buf;
> > +     stream->avail_in =3D len;
> > +     do {
> > +             unsigned char *in0 =3D stream->next_in;
> > +             ret =3D git_deflate(stream, flush);
> > +             the_hash_algo->update_fn(c, in0, stream->next_in - in0);
> > +             if (write_buffer(fd, compressed, stream->next_out - compr=
essed) < 0)
> > +                     die(_("unable to write loose object file"));
> > +             stream->next_out =3D compressed;
> > +             stream->avail_out =3D compressed_len;
> > +     } while (ret =3D=3D Z_OK);
> > +
> > +     return ret;
> > +}
> > +
> >  static int write_loose_object(const struct object_id *oid, char *hdr,
> >                             int hdrlen, const void *buf, unsigned long =
len,
> >                             time_t mtime)
> > @@ -1949,17 +1971,9 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
> >       the_hash_algo->update_fn(&c, hdr, hdrlen);
> >
> >       /* Then the data itself.. */
> > -     stream.next_in =3D (void *)buf;
> > -     stream.avail_in =3D len;
> > -     do {
> > -             unsigned char *in0 =3D stream.next_in;
> > -             ret =3D git_deflate(&stream, Z_FINISH);
> > -             the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
> > -             if (write_buffer(fd, compressed, stream.next_out - compre=
ssed) < 0)
> > -                     die(_("unable to write loose object file"));
> > -             stream.next_out =3D compressed;
> > -             stream.avail_out =3D sizeof(compressed);
> > -     } while (ret =3D=3D Z_OK);
> > +     ret =3D write_object_buffer(&stream, &c, fd, compressed,
> > +                               sizeof(compressed), buf, len,
> > +                               Z_FINISH);
> >
> >       if (ret !=3D Z_STREAM_END)
> >               die(_("unable to deflate new object %s (%d)"), oid_to_hex=
(oid),
> > @@ -2020,6 +2034,119 @@ int write_object_file(const void *buf, unsigned=
 long len, const char *type,
> >       return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
> >  }
> >
> > +int write_stream_object_file(struct git_zstream_reader *reader,
> > +                          unsigned long len, const char *type,
> > +                          struct object_id *oid,
> > +                          int dry_run)
> > +{
> > +     git_zstream istream, ostream;
> > +     unsigned char buf[8192], compressed[4096];
> > +     char hdr[MAX_HEADER_LEN];
> > +     int istatus, ostatus, fd =3D 0, hdrlen, dirlen, flush =3D 0;
> > +     int ret =3D 0;
> > +     git_hash_ctx c;
> > +     struct strbuf tmp_file =3D STRBUF_INIT;
> > +     struct strbuf filename =3D STRBUF_INIT;
> > +
> > +     /* Write tmpfile in objects dir, because oid is unknown */
> > +     if (!dry_run) {
> > +             strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
> > +             strbuf_addch(&filename, '/');
> > +             fd =3D create_tmpfile(&tmp_file, filename.buf);
> > +             if (fd < 0) {
> > +                     if (errno =3D=3D EACCES)
> > +                             ret =3D error(_("insufficient permission =
for adding an object to repository database %s"),
> > +                                     get_object_directory());
> > +                     else
> > +                             ret =3D error_errno(_("unable to create t=
emporary file"));
> > +                     goto cleanup;
> > +             }
> > +     }
> > +
> > +     memset(&istream, 0, sizeof(istream));
> > +     istream.next_out =3D buf;
> > +     istream.avail_out =3D sizeof(buf);
> > +     git_inflate_init(&istream);
> > +
> > +     if (!dry_run) {
> > +             /* Set it up */
> > +             git_deflate_init(&ostream, zlib_compression_level);
> > +             ostream.next_out =3D compressed;
> > +             ostream.avail_out =3D sizeof(compressed);
> > +             the_hash_algo->init_fn(&c);
> > +
> > +             /* First header */
> > +             hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX, ty=
pe,
> > +                             (uintmax_t)len) + 1;
> > +             ostream.next_in =3D (unsigned char *)hdr;
> > +             ostream.avail_in =3D hdrlen;
> > +             while (git_deflate(&ostream, 0) =3D=3D Z_OK)
> > +                     ; /* nothing */
> > +             the_hash_algo->update_fn(&c, hdr, hdrlen);
> > +     }
> > +
> > +     /* Then the data itself */
> > +     do {
> > +             unsigned char *last_out =3D istream.next_out;
> > +             reader->fill(&istream);
> > +             istatus =3D git_inflate(&istream, 0);
> > +             if (istatus =3D=3D Z_STREAM_END)
> > +                     flush =3D Z_FINISH;
> > +             reader->use(&istream);
> > +             if (!dry_run)
> > +                     ostatus =3D write_object_buffer(&ostream, &c, fd,=
 compressed,
> > +                                                   sizeof(compressed),=
 last_out,
> > +                                                   istream.next_out - =
last_out,
> > +                                                   flush);
> > +             istream.next_out =3D buf;
> > +             istream.avail_out =3D sizeof(buf);
> > +     } while (istatus =3D=3D Z_OK);
> > +
> > +     if (istream.total_out !=3D len || istatus !=3D Z_STREAM_END)
> > +             die( _("inflate returned %d"), istatus);
> > +     git_inflate_end(&istream);
> > +
> > +     if (dry_run)
> > +             goto cleanup;
> > +
> > +     if (ostatus !=3D Z_STREAM_END)
> > +             die(_("unable to deflate new object (%d)"), ostatus);
> > +     ostatus =3D git_deflate_end_gently(&ostream);
> > +     if (ostatus !=3D Z_OK)
> > +             die(_("deflateEnd on object failed (%d)"), ostatus);
> > +     the_hash_algo->final_fn(oid->hash, &c);
> > +     close_loose_object(fd);
> > +
> > +     /* We get the oid now */
> > +     loose_object_path(the_repository, &filename, oid);
> > +
> > +     dirlen =3D directory_size(filename.buf);
> > +     if (dirlen) {
> > +             struct strbuf dir =3D STRBUF_INIT;
> > +             /*
> > +              * Make sure the directory exists; note that the contents
> > +              * of the buffer are undefined after mkstemp returns an
> > +              * error, so we have to rewrite the whole buffer from
> > +              * scratch.
> > +              */
> > +             strbuf_add(&dir, filename.buf, dirlen - 1);
> > +             if (mkdir(dir.buf, 0777) && errno !=3D EEXIST) {
> > +                     unlink_or_warn(tmp_file.buf);
> > +                     strbuf_release(&dir);
> > +                     ret =3D -1;
> > +                     goto cleanup;
> > +             }
> > +             strbuf_release(&dir);
> > +     }
> > +
> > +     ret =3D finalize_object_file(tmp_file.buf, filename.buf);
> > +
> > +cleanup:
> > +     strbuf_release(&tmp_file);
> > +     strbuf_release(&filename);
> > +     return ret;
> > +}
> > +
> >  int hash_object_file_literally(const void *buf, unsigned long len,
> >                              const char *type, struct object_id *oid,
> >                              unsigned flags)
> > diff --git a/object-store.h b/object-store.h
> > index d24915ced1..12b113ef93 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -33,6 +33,11 @@ struct object_directory {
> >       char *path;
> >  };
> >
> > +struct git_zstream_reader {
> > +     void (*fill)(struct git_zstream *);
> > +     void (*use)(struct git_zstream *);
> > +};
> > +
> >  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> >       struct object_directory *, 1, fspathhash, fspatheq)
> >
> > @@ -225,6 +230,10 @@ int hash_object_file(const struct git_hash_algo *a=
lgo, const void *buf,
> >  int write_object_file(const void *buf, unsigned long len,
> >                     const char *type, struct object_id *oid);
> >
> > +int write_stream_object_file(struct git_zstream_reader *reader,
> > +                          unsigned long len, const char *type,
> > +                          struct object_id *oid, int dry_run);
> > +
> >  int hash_object_file_literally(const void *buf, unsigned long len,
> >                              const char *type, struct object_id *oid,
> >                              unsigned flags);
> > diff --git a/t/t5590-receive-unpack-objects.sh b/t/t5590-receive-unpack=
-objects.sh
> > new file mode 100755
> > index 0000000000..7e63dfc0db
> > --- /dev/null
> > +++ b/t/t5590-receive-unpack-objects.sh
> > @@ -0,0 +1,92 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2021 Han Xin
> > +#
> > +
> > +test_description=3D'Test unpack-objects when receive pack'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success "create commit with big blobs (1.5 MB)" '
> > +     test-tool genrandom foo 1500000 >big-blob &&
> > +     test_commit --append foo big-blob &&
> > +     test-tool genrandom bar 1500000 >big-blob &&
> > +     test_commit --append bar big-blob &&
> > +     (
> > +             cd .git &&
> > +             find objects/?? -type f | sort
> > +     ) >expect &&
> > +     git repack -ad
> > +'
> > +
> > +test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
> > +     GIT_ALLOC_LIMIT=3D1m &&
> > +     export GIT_ALLOC_LIMIT
> > +'
> > +
> > +test_expect_success 'prepare dest repository' '
> > +     git init --bare dest.git &&
> > +     git -C dest.git config core.bigFileThreshold 2m &&
> > +     git -C dest.git config receive.unpacklimit 100
> > +'
> > +
> > +test_expect_success 'fail to push: cannot allocate' '
> > +     test_must_fail git push dest.git HEAD 2>err &&
> > +     test_i18ngrep "remote: fatal: attempting to allocate" err &&
> > +     (
> > +             cd dest.git &&
> > +             find objects/?? -type f | sort
> > +     ) >actual &&
> > +     ! test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'set a lower bigfile threshold' '
> > +     git -C dest.git config core.bigFileThreshold 1m
> > +'
> > +
> > +test_expect_success 'unpack big object in stream' '
> > +     git push dest.git HEAD &&
> > +     git -C dest.git fsck &&
> > +     (
> > +             cd dest.git &&
> > +             find objects/?? -type f | sort
> > +     ) >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'setup for unpack-objects dry-run test' '
> > +     PACK=3D$(echo main | git pack-objects --progress --revs test) &&
> > +     unset GIT_ALLOC_LIMIT &&
> > +     git init --bare unpack-test.git
> > +'
> > +
> > +test_expect_success 'unpack-objects dry-run with large threshold' '
> > +     (
> > +             cd unpack-test.git &&
> > +             git config core.bigFileThreshold 2m &&
> > +             git unpack-objects -n <../test-$PACK.pack
> > +     ) &&
> > +     (
> > +             cd unpack-test.git &&
> > +             find objects/ -type f
> > +     ) >actual &&
> > +     test_must_be_empty actual
> > +'
> > +
> > +test_expect_success 'unpack-objects dry-run with small threshold' '
> > +     (
> > +             cd unpack-test.git &&
> > +             git config core.bigFileThreshold 1m &&
> > +             git unpack-objects -n <../test-$PACK.pack
> > +     ) &&
> > +     (
> > +             cd unpack-test.git &&
> > +             find objects/ -type f
> > +     ) >actual &&
> > +     test_must_be_empty actual
> > +'
> > +
> > +test_done
>
