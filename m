Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A1C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 04:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiFIEKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiFIEKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 00:10:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C7CFE35
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 21:10:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h23so36102071lfe.4
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9UcBqFBHAy0lwD8IUdOc5vyoiStU/4FzbeBoGKl0lOk=;
        b=CvmQQyxhwcag6eFSBFuRyMcSzjXtW5uz5IT/NUoBB7raR+gaZKrPtZohJ1DGvPWw2G
         zlRU6eWETWkGz3hZfe9wmMpi/gT+nwJ7zEdIXRGBJDIgwJqV6pTLhoep2fkbyMfxgJWd
         Wh9/LHjZeJplqTByWo3QHwlDG9YqxQUC4zVi6OwtV+R7Gf0jUFErCrjM5rER1Tlu799N
         Chfc/k8q8BRx0HDob0P2dnVja6GH19CX1gYj5i78YPWc4IJd5/sXHS5uKtEu8USw8Qab
         CphFTzebRRhxFjTY0hF1S18KYWD3jLM6eD72Eq51jkup1zCBG/6qDP5aKywWAsFcvCCZ
         HWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9UcBqFBHAy0lwD8IUdOc5vyoiStU/4FzbeBoGKl0lOk=;
        b=o7Bjmsi+9Oej3yM3EMtaFIDfL5LeyKLMGbheuHI5W2ReREKhL9C3ABKTdbqLGShzOf
         YYvsPo23q6/SPjN7QPBXtAdz8Q3T2BR8r7jkmCmMHKi9Xff5AaKAyReeixypk3ROk6Eh
         96kAQ++r90/3ht7SE6nVNM+h1vfS8YS+k1KOFGsoosr8IUMwsXDxzS7SIVYH54yCqFX6
         nXz3RpJUzLnCBrVlsCT03zUKndPca7Jlsn79ls3M1ELbtwRiRopwcJPBOcxW6Sru34Ag
         cZWqUkrK2ag3rEiXRhok6QqF7+trbY8YNzyOz46bWZu3WO7hWKB107sJ5Ad5OogqWs2X
         v35A==
X-Gm-Message-State: AOAM531uZmJQlRdJifo+PUXMiQb5gfajOIVTcD8QC/pNTLIg2NflURoi
        eP78Lc6B6fNmG/cxR1wa5wbtM7oLPjStedPNeJ8=
X-Google-Smtp-Source: ABdhPJzgXaFkZafO3M/+NtVq6nG62VXV/IquDx1tQns4dXNQschjNLg4Wf/YO7JJoQejGRQ2jsSAAOvFo2YBObjcdLo=
X-Received: by 2002:a05:6512:39c8:b0:478:fc07:b4b0 with SMTP id
 k8-20020a05651239c800b00478fc07b4b0mr27553441lfu.585.1654747820855; Wed, 08
 Jun 2022 21:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com> <xmqqpmjl7i7y.fsf@gitster.g>
In-Reply-To: <xmqqpmjl7i7y.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Thu, 9 Jun 2022 12:10:09 +0800
Message-ID: <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 7, 2022 at 2:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > As the name implies, "get_data(size)" will allocate and return a given
> > amount of memory. Allocating memory for a large blob object may cause t=
he
> > system to run out of memory. Before preparing to replace calling of
> > "get_data()" to unpack large blob objects in latter commits, refactor
> > "get_data()" to reduce memory footprint for dry_run mode.
> >
> > Because in dry_run mode, "get_data()" is only used to check the
> > integrity of data, and the returned buffer is not used at all, we can
> > allocate a smaller buffer and reuse it as zstream output. Therefore,
>
> "reuse" -> "use"
>
> > in dry_run mode, "get_data()" will release the allocated buffer and
> > return NULL instead of returning garbage data.
>
> It makes it sound as if we used to return garbage data, but I do not
> think that is what happened in reality.  Perhaps rewrite the last
> sentence like
>
>         Make the function return NULL in the dry-run mode, as no
>         callers use the returned buffer.
>
> or something?
>
> The overall logic sounds quite sensible.
>
> > The "find [...]objects/?? -type f | wc -l" test idiom being used here
> > is adapted from the same "find" use added to another test in
> > d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).
>
>
> > +/*
> > + * Decompress zstream from stdin and return specific size of data.
>
> "specific size"?  The caller specifies the size of data (because it
> knows a-priori how many bytes the zstream should inflate to), so
>
>     Decompress zstream from the standard input into a newly
>     allocated buffer of specified size and return the buffer.
>
> or something, perhaps.  In any case, it needs to say that the caller
> is responsible for giving the "right" size.
>
> > + * The caller is responsible to free the returned buffer.
> > + *
> > + * But for dry_run mode, "get_data()" is only used to check the
> > + * integrity of data, and the returned buffer is not used at all.
> > + * Therefore, in dry_run mode, "get_data()" will release the small
> > + * allocated buffer which is reused to hold temporary zstream output
> > + * and return NULL instead of returning garbage data.
> > + */
> >  static void *get_data(unsigned long size)
> >  {
> >       git_zstream stream;
> > -     void *buf =3D xmallocz(size);
> > +     unsigned long bufsize =3D dry_run && size > 8192 ? 8192 : size;
> > +     void *buf =3D xmallocz(bufsize);
>
> OK.
>
> >       memset(&stream, 0, sizeof(stream));
> >
> >       stream.next_out =3D buf;
> > -     stream.avail_out =3D size;
> > +     stream.avail_out =3D bufsize;
> >       stream.next_in =3D fill(1);
> >       stream.avail_in =3D len;
> >       git_inflate_init(&stream);
> > @@ -125,8 +136,15 @@ static void *get_data(unsigned long size)
>
> What's hidden in the pre-context is this bit:
>
>                 int ret =3D git_inflate(&stream, 0);
>                 use(len - stream.avail_in);
>                 if (stream.total_out =3D=3D size && ret =3D=3D Z_STREAM_E=
ND)
>                         break;
>                 if (ret !=3D Z_OK) {
>                         error("inflate returned %d", ret);
>                         FREE_AND_NULL(buf);
>                         if (!recover)
>                                 exit(1);
>                         has_errors =3D 1;
>                         break;
>                 }
>
> and it is correct to use "size", not "bufsize", for this check.
> Unless we receive exactly the caller-specified "size" bytes from the
> inflated zstream with Z_STREAM_END, we want to detect an error and
> bail out.
>
> I am not sure if this is not loosening the error checking in the
> dry-run case, though.  In the original code, we set the avail_out
> to the total expected size so
>
>  (1) if the caller gives too small a size, git_inflate() would stop
>      at stream.total_out with ret that is not STREAM_END nor OK,
>      bypassing the "break", and we catch the error.
>
>  (2) if the caller gives too large a size, git_inflate() would stop
>      at the true size of inflated zstream, with STREAM_END and would
>      not hit this "break", and we catch the error.
>
> With the new code, since we keep refreshing avail_out (see below),
> git_inflate() does not even learn how many bytes we are _expecting_
> to see.  Is the error checking in the loop, with the updated code,
> catch the mismatch between expected and actual size (plausibly
> caused by a corrupted zstream) the same way as we do in the
> non dry-run code path?
>

Unlike the original implementation, if we get a corrupted zstream, we
won't break at Z_BUFFER_ERROR, maybe until we've read all the
input. I think it can still catch the mismatch between expected and
actual size when "fill(1)" gets an EOF, if it's not too late.

Thanks.
-Han Xin

> >               }
> >               stream.next_in =3D fill(1);
> >               stream.avail_in =3D len;
> > +             if (dry_run) {
> > +                     /* reuse the buffer in dry_run mode */
> > +                     stream.next_out =3D buf;
> > +                     stream.avail_out =3D bufsize;
> > +             }
> >       }
> >       git_inflate_end(&stream);
> > +     if (dry_run)
> > +             FREE_AND_NULL(buf);
> >       return buf;
> >  }
