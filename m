Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D2C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhLGGqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhLGGqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 01:46:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62DC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 22:42:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k2so25569842lji.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 22:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/X9/EVVyEZcXL4AAKeeiecWtNNLNZMOlFIx0Jpex8xU=;
        b=GQPS66cjzuYonH7z+ZsxcGHafNK7UBKYHaJawlNU0CJhwyXa8YucLpGPe3f8/O646e
         CUDaaWeyw6rh5L3I2u7h0mq1PIhUM7cHtBSxP7ACm614ZSnezr3Sw1YzFXPcRfU/aNnP
         B/DxtsyG2PMirDIO4zh2rnjwzaan/szH879oLwvr+j5eADHwCOmRyKxvIyIoQkOArRSD
         8P9vO7nol4xrPhsimeXeTJeAHN6XD/kkv/E0MLUgKo68raJYsjnUUjkgJKiVm9IAnpxu
         ugH71xjPim8kp4QgIggqi/pjJuYJDusgT29msGYI/XAmxeOEh4McEChsiYSlA1WhJlYc
         Hd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/X9/EVVyEZcXL4AAKeeiecWtNNLNZMOlFIx0Jpex8xU=;
        b=wNiiEzcfZ6mofwdC2ML16I1PrdwFZRKr/TSH2r1FNIn5VWmujaWna8CjuHCYLGNG07
         2P6ATqDoJa71VmryDe9/2+fK3WFzHaAxENf4oIM8paobj+Kq50vks8JE6nLS05gRaF09
         IZo2c40vYtwMwyRWMnvR822Dk2H6n5sWBGx0ZRgVrjK47Gfj7OFfRVJEy45lGYMb7XEG
         UaKaab8VFv/X3LTbolAsjIcBrR39nYCcrRqOFwjNNqLtvnEUNWOQhdYoKOLrYh5IpOQy
         MJ1IRSHJG8OLL0GlPikV16lkfLbiqrrgnQxSoXSo/txZEKPUeW6JOfFdWz9tUU7ZunlR
         2oGQ==
X-Gm-Message-State: AOAM533KhTtn1MOAQ8fjysDLt4H1gsXRjelq/xjgkVtjwJ60mUh3mat7
        r77ibyc5PlFOph0yTMVMTqyvk0A8O8jwVHrBEQk=
X-Google-Smtp-Source: ABdhPJzywq+W74ish+iAFUsngtJ/l8n6BsMPv4jgtHocAWDRHNNhtQT47PJLZ8qLcoDzyhZQYurqnaoBxw7r1VDT9us=
X-Received: by 2002:a2e:9b17:: with SMTP id u23mr41116700lji.258.1638859354375;
 Mon, 06 Dec 2021 22:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-6-chiyutianyi@gmail.com>
 <211203.86zgphsu5a.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86zgphsu5a.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 7 Dec 2021 14:42:23 +0800
Message-ID: <CAO0brD2AYAw9KaKLdMgQURh0RkdcvuGZJTNrhF6ZnpUvhk3d=g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 9:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> > entire contents of a blob object, no matter how big it is. This
> > implementation may consume all the memory and cause OOM.
> >
> > By implementing a zstream version of input_stream interface, we can use
> > a small fixed buffer for "unpack_non_delta_entry()".
> >
> > However, unpack non-delta objects from a stream instead of from an entr=
ie
> > buffer will have 10% performance penalty. Therefore, only unpack object
> > larger than the "big_file_threshold" in zstream. See the following
> > benchmarks:
> >
> >     hyperfine \
> >       --setup \
> >       'if ! test -d scalar.git; then git clone --bare https://github.co=
m/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
> >       --prepare 'rm -rf dest.git && git init --bare dest.git' \
> >       -n 'old' 'git -C dest.git unpack-objects <small.pack' \
> >       -n 'new' 'new/git -C dest.git unpack-objects <small.pack' \
> >       -n 'new (small threshold)' \
> >       'new/git -c core.bigfilethreshold=3D16k -C dest.git unpack-object=
s <small.pack'
> >     Benchmark 1: old
> >       Time (mean =C2=B1 =CF=83):      6.075 s =C2=B1  0.069 s    [User:=
 5.047 s, System: 0.991 s]
> >       Range (min =E2=80=A6 max):    6.018 s =E2=80=A6  6.189 s    10 ru=
ns
> >
> >     Benchmark 2: new
> >       Time (mean =C2=B1 =CF=83):      6.090 s =C2=B1  0.033 s    [User:=
 5.075 s, System: 0.976 s]
> >       Range (min =E2=80=A6 max):    6.030 s =E2=80=A6  6.142 s    10 ru=
ns
> >
> >     Benchmark 3: new (small threshold)
> >       Time (mean =C2=B1 =CF=83):      6.755 s =C2=B1  0.029 s    [User:=
 5.150 s, System: 1.560 s]
> >       Range (min =E2=80=A6 max):    6.711 s =E2=80=A6  6.809 s    10 ru=
ns
> >
> >     Summary
> >       'old' ran
> >         1.00 =C2=B1 0.01 times faster than 'new'
> >         1.11 =C2=B1 0.01 times faster than 'new (small threshold)'
>
> So before we wrote used core.bigfilethreshold for two things (or more?):
> Whether we show a diff for it (we mark it "binary") and whether it's
> split into a loose object.
>
> Now it's three things, we've added a "this is a threshold when we'll
> stream the object" to that.
>
> Might it make sense to squash something like this in, so we can have our
> cake & eat it too?
>
> With this I get, where HEAD~0 is this change:
>
>     Summary
>       './git -C dest.git -c core.bigfilethreshold=3D512m unpack-objects <=
small.pack' in 'HEAD~0' ran
>         1.00 =C2=B1 0.01 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'HEAD~1'
>         1.00 =C2=B1 0.01 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'origin/master'
>         1.01 =C2=B1 0.01 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~0'
>         1.06 =C2=B1 0.14 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'origin/master'
>         1.20 =C2=B1 0.01 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~1'
>
> I.e. it's 5% slower, not 20% (haven't looked into why), but we'll not
> stream out 16k..128MB objects (maybe the repo has even bigger ones?)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
> index c04f62a54a1..601b7a2418f 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -424,6 +424,17 @@ be delta compressed, but larger binary media files w=
on't be.
>  +
>  Common unit suffixes of 'k', 'm', or 'g' are supported.
>
> +core.bigFileStreamingThreshold::
> +       Files larger than this will be streamed out to a temporary
> +       object file while being hashed, which will when be renamed
> +       in-place to a loose object, particularly if the
> +       `core.bigFileThreshold' setting dictates that they're always
> +       written out as loose objects.
> ++
> +Default is 128 MiB on all platforms.
> ++
> +Common unit suffixes of 'k', 'm', or 'g' are supported.
> +
>  core.excludesFile::
>         Specifies the pathname to the file that contains patterns to
>         describe paths that are not meant to be tracked, in addition
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index bedc494e2db..94ce275c807 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -400,7 +400,7 @@ static void unpack_non_delta_entry(enum object_type t=
ype, unsigned long size,
>         void *buf;
>
>         /* Write large blob in stream without allocating full buffer. */
> -       if (!dry_run && type =3D=3D OBJ_BLOB && size > big_file_threshold=
) {
> +       if (!dry_run && type =3D=3D OBJ_BLOB && size > big_file_streaming=
_threshold) {
>                 write_stream_blob(nr, size);
>                 return;
>         }
> diff --git a/cache.h b/cache.h
> index eba12487b99..4037c7fd849 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -964,6 +964,7 @@ extern size_t packed_git_window_size;
>  extern size_t packed_git_limit;
>  extern size_t delta_base_cache_limit;
>  extern unsigned long big_file_threshold;
> +extern unsigned long big_file_streaming_threshold;
>  extern unsigned long pack_size_limit_cfg;
>
>  /*
> diff --git a/config.c b/config.c
> index c5873f3a706..7b122a142a8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1408,6 +1408,11 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "core.bigfilestreamingthreshold")) {
> +               big_file_streaming_threshold =3D git_config_ulong(var, va=
lue);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "core.packedgitlimit")) {
>                 packed_git_limit =3D git_config_ulong(var, value);
>                 return 0;
> diff --git a/environment.c b/environment.c
> index 9da7f3c1a19..4fcc3de7417 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -46,6 +46,7 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WI=
NDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
>  unsigned long big_file_threshold =3D 512 * 1024 * 1024;
> +unsigned long big_file_streaming_threshold =3D 128 * 1024 * 1024;
>  int pager_use_color =3D 1;
>  const char *editor_program;
>  const char *askpass_program;

I'm not sure if we need an additional "core.bigFileStreamingThreshold"
here, because "core.bigFileThreshold" has been widely used in
"index-pack", "read_object" and so on.

In the test case which uses "core.bigFileStreamingThreshold" instead of
"core.bigFileThreshold", I found the test case execution failed because
of "fsck", who tried to allocate 15MB of memory.
In the process of "fsck_loose()", "read_loose_object()" will be called,
which contains the following content:

  if (*oi->typep =3D=3D OBJ_BLOB && *size> big_file_threshold) {
    if (check_stream_oid(&stream, hdr, *size, path, expected_oid) <0)
    goto out;
  } else {
    /* this will allocate 15MB of memory */
    *contents =3D unpack_loose_rest(&stream, hdr, *size, expected_oid);
    ...
  }

The same case can be found in "unpack_entry_data()":

  static char fixed_buf[8192];
  ...
  if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
    buf =3D fixed_buf;
  else
    buf =3D xmallocz(size);
 ...

Although I know that setting a "core.bigfilethreshold" smaller than the
default value on the server side does not help me prevent users from
creating large delta objects on the client side, it can still
effectively help me reduce the Memory allocation in "receive-pack".

If this is not the correct way to use "core.bigfilethreshold", maybe
you can share some better solutions to me, if you want.

Thanks.
-Han Xin
